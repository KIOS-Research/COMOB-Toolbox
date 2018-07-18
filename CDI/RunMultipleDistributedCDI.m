%{
 Copyright (c) 2018 KIOS Research and Innovation Centre of Excellence
 (KIOS CoE), University of Cyprus (www.kios.org.cy)
 
 Licensed under the EUPL, Version 1.1 or – as soon they will be approved 
 by the European Commission - subsequent versions of the EUPL (the "Licence");
 You may not use this work except in compliance with theLicence.
 
 You may obtain a copy of the Licence at: https://joinup.ec.europa.eu/collection/eupl/eupl-text-11-12
 
 Unless required by applicable law or agreed to in writing, software distributed
 under the Licence is distributed on an "AS IS" basis,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the Licence for the specific language governing permissions and limitations under the Licence.
 
 Author(s)     : Marinos Christoloulou, Marios Kyriakou and Alexis Kyriacou
 
 Work address  : KIOS Research Center, University of Cyprus
 email         : akyria09@ucy.ac.cy (Alexis Kyriacou)
 Website       : http://www.kios.ucy.ac.cy
 
 Last revision : June 2018
%}
function exitflag=RunMultipleDistributedCDI(varargin)
exitflag=0;

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if isstruct(varargin{1}) 
        file0=varargin{1}.file0;
        P=varargin{1}.P;
        B=varargin{1}.B;
        CDI0 = varargin{1}.CDI0;
        load([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');
    else
        file0=varargin{1};
        pathname=[pwd,'\RESULTS\'];
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    load([pathname,file0,'.0'],'-mat');
    
    % ---------------------------------------
    % FOR MEMORY WE USE ONLY THE USEFUL FIELDS
    B0.nZones = B.nZones;
    B0.A = B.A;
    B0.B = B.B;
    B0.C=varargin{1}.B.C;
    B0.nS = B.nS;
    B0.Sensors = B.Sensors;
    
    P0.ScenariosContamIndex = P.ScenariosContamIndex;
    P0.ScenariosFlowIndex = P.ScenariosFlowIndex;
    P0.t = P.t;
    P0.SourceParamScenarios = P.SourceParamScenarios;
    P0.SourceLocationScenarios = P.SourceLocationScenarios;
    P0.StartTime = P.StartTime;
    
    clear B P
    
    B = B0;
    P = P0;
    
    clear B0 P0
    % ---------------------------------------
        
    disp('Run Multiple Distributed CDI')
    
    Abin =  B.A+B.A';
    Abin(find(Abin)) = 1;
    for i=1:CDI0.nSub
        Acls{i}.A = B.A(CDI0.Subsystems{1,i},CDI0.Subsystems{1,i});
        Bcls{i}.B = B.B(CDI0.Subsystems{1,i},CDI0.Subsystems{1,i});
        nS(i) = sum(ismember(CDI0.Subsystems{1,i},B.Sensors));
        [r b] = ismember(CDI0.Subsystems{1,i},B.Sensors);
        [r c idy{i}]=find(b);
        SensorsCls{i} = c; 
        Ccls{i}.C=zeros(nS(i),length(CDI0.Subsystems{1,i}));
        for j = 1:nS(i)
            Ccls{i}.C(j,SensorsCls{1,i}(j)) = 1;
        end

        indx = 1:B.nZones;
        indx(CDI0.Subsystems{1,i})=[];
        H = Abin(CDI0.Subsystems{1,i},indx);
        [r c] = find(H);
        IntCon{i}=indx(c);
        Hcls{i}.H = B.A(CDI0.Subsystems{1,i},IntCon{i});

        % check if the system is observable
        Ob = obsv(Acls{i}.A, Ccls{i}.C);
        if ((length(Acls{i}.A) - rank(Ob)) ~= 0) 
             sprintf(['The Subsystem ', num2str(i), ' is not Observable'])
%             matlabpool close
            errordlg(['The Subsystem, ', num2str(i), ' is not Observable'], 'Error');
            exitflag=-2;
            return
        end       
    end
    
    for i = 1:CDI0.nSub
        if CDI0.SubsystemsData{1,i}.UncertaintiesBound==0
            DA = 0.1;
        else
            DA = CDI0.SubsystemsData{1,i}.UncertaintiesBound;
        end
        Lcls{i}.L(1:length(CDI0.Subsystems{1,i}),1:nS(i)) =  Acls{1,i}.A(:,SensorsCls{i});%place(Acls{j}.A',Ccls{j}.C',PoleCls{j}.pole)';
        for j = 1:nS(i)
            Lcls{i}.L(SensorsCls{1,i}(j),j) = 2*DA;
        end
        A0cls{i}.A0 = Acls{i}.A - Lcls{i}.L*Ccls{i}.C;

        % find the coefficients for Thresholds
        clear p az
        for k=1:length(P.t)
            p(k)=norm(expm(A0cls{i}.A0*P.t(k)));
            for j = 1:nS(i)
                az(k,j)=norm(Ccls{i}.C(j,:)*expm(A0cls{i}.A0*P.t(k)));            
            end
        end

        data = fit(P.t', p', 'exp1');
        coefval = coeffvalues(data);
        Cofcls{i}.rho = coefval(1); 
        Cofcls{i}.ksi = -coefval(2);

        if ~(Cofcls{i}.ksi > Cofcls{i}.rho*CDI0.SubsystemsData{1,i}.UncertaintiesBound)
           sprintf(['The Subsystem ', num2str(i), ' is Unstable'])
%            matlabpool close
           errordlg(['The Subsystem ', num2str(i), ' is Unstable'], 'Error')
           exitflag=-2;
           return
        end

        for j = 1:nS(i)
            clear data
            data = fit(P.t', az(:,j), 'exp1');
            coefval = coeffvalues(data);
            Cofcls{i}.alpha(j) = coefval(1);
            Cofcls{i}.zita(j) = -coefval(2);
        end                
    end
    
    for i=1:CDI0.nSub
        DetectionDecision{i} = zeros(size(P.ScenariosFlowIndex,1),size(P.ScenariosContamIndex,1));
        IsolationDecision{i} = zeros(size(P.ScenariosFlowIndex,1),size(P.ScenariosContamIndex,1));
    end
    Matlab_version=version('-date');
    
    %Check Matlab version in order to activate the matlab pool
    if str2num(Matlab_version(end-4:end))<2014
        matlabpool open
    end
    % Open parallel pool and set as many workers as actual system cores
    p = gcp('nocreate'); % If no pool, do not create new one.
    if isempty(p)
        numcores = feature('numcores');
        parpool(numcores)
        % Set focus on main window
        figure(findobj('name','Contaminant Detection and Isolation'));
    end
    kk = 1;
    % Progressbar initialization
    progressbar2('Simulating CDI for Airflows Scenarios','Contaminant Detection Simulation','Contaminant Isolation Simulation'); 

    for jj = 1:size(P.ScenariosFlowIndex,1)
        progressbar2(jj/size(P.ScenariosFlowIndex,1),0,0)
        load([pathname,file0,'.c',num2str(jj)],'-mat');
        % Calculate by CDI algorithm
        for n = 1:size(P.ScenariosContamIndex,1)
            R{n}.DetectionThreshold = 0;
%             R{n}.DetectionResidual = 0;            
%             R{n}.DetectionTime = [];          
            
            for ii=1:CDI0.nSub
                R{n}.DetectionTime{ii} = [];
                R{n}.DetectionDelay{ii} = [];
                R{n}.DetectionRate{ii} = [];
                R{n}.DetectionResidual{ii} = [];
                R{n}.IsolationThreshold{ii} = [];
                R{n}.IsolationResidual{ii} = [];
                R{n}.IsolationDecision{ii} = [];
                R{n}.IsolationTime{ii} = [];
                R{n}.IsolationDelay{ii} = [];
                R{n}.IsolationRate{ii} = [];
                R{n}.IsolationTimeseries{ii} = [];
                R{n}.IsolationLogic{ii} = [];
                R{n}.SourceEstimation{ii} = [];
%                 for k = 1:length(CDI0.Subsystems{ii})
                    R{n}.AdaptiveSourceEstimation{ii} = [];  
%                 end
            end
        end
               

        y_helth = B.C*zeros(B.nZones,length(P.t));
        for k = 1:size(P.ScenariosContamIndex,1)    
            % sensor measurments
            y{k} = C.x{k}';
        end
        
        clear C
        s_prog_bar=size(P.ScenariosContamIndex,1);
        
        for k = 1:size(P.ScenariosContamIndex,1)     
            [t2 x_hat{k}] = ode15s(@(tm,x2) DetectionObserverD(tm, x2, Acls,...
                                                              Lcls, Hcls,...
                                                              Ccls,...
                                                              CDI0.Subsystems,...
                                                              B.Sensors,...                                                              
                                                              IntCon,...
                                                              CDI0.nSub,...
                                                              B.nZones, y{k}, ...
                                                              P.t), P.t, zeros(B.nZones,1));

            [t2 x_hat_helth{k}] = ode15s(@(tm,x2) DetectionObserverD(tm, x2, Acls,...
                                                              Lcls, Hcls,...
                                                              Ccls,...
                                                              CDI0.Subsystems,...
                                                              B.Sensors,...
                                                              IntCon,...
                                                              CDI0.nSub,...
                                                              B.nZones, y_helth, ...
                                                              P.t), P.t, zeros(B.nZones,1));                                              
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if isempty(findobj('Tag','ProgressBar'))
            exitflag=-1;
            return
        end
        progressbar2([],s_prog_bar/(3*s_prog_bar),[])
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        parfor k = 1:size(P.ScenariosContamIndex,1)
            [R{k}.DetectionThreshold Ex{k}] = DetectionThresholdD(CDI0.SubsystemsData, ...
                                                                  Lcls, Hcls, ...                                                              
                                                                  Cofcls, ...
                                                                  CDI0.Subsystems,...
                                                                  B.Sensors,...
                                                                  IntCon,...
                                                                  x_hat_helth{k}, ...
                                                                  P.t, CDI0.nSub, ...
                                                                  nS, y{k});
            for n = 1:CDI0.nSub
                % residual for detection
                R{k}.DetectionResidual{n} = abs(y{k}(idy{n},:) - Ccls{n}.C*x_hat{k}(:,CDI0.Subsystems{n})');
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if isempty(findobj('Tag','ProgressBar'))
            exitflag=-1;
            return
        end
        progressbar2([],s_prog_bar/(2*s_prog_bar),[])
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        clear r
        for k = 1:size(P.ScenariosContamIndex,1)
            for n = 1:CDI0.nSub
                % check if detect a contaminant source
                [c r{k}{n}] = find(R{k}.DetectionResidual{n} > R{k}.DetectionThreshold{n}',1);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if isempty(findobj('Tag','ProgressBar'))
                    exitflag=-1;
                    return
                end
                progressbar2([],k/size(P.ScenariosContamIndex,1),[])
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if isempty(findobj('Tag','ProgressBar'))
                exitflag=-1;
                return
            end
            progressbar2([],(s_prog_bar+k)/(2*s_prog_bar),[])
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
        
       nsour = 1;
        for k = 1:size(P.ScenariosContamIndex,1)
            id = P.ScenariosContamIndex(k,:);
            for i = 1:CDI0.nSub
                % active isolation scheme
                if ~isempty(r{k}{i})
                    idx = r{k}{i};
                    R{k}.DetectionTime{i} = P.t(idx(1));
                    
                    if (P.SourceParamScenarios{1}(id(1)) ~= 0) && (P.SourceParamScenarios{3}(id(3)) ~= 0) && max(ismember(CDI0.Subsystems{1,i},P.SourceLocationScenarios{id(4)}))
                        R{k}.DetectionRate{i} = 'True Alarm'; 
                        R{k}.DetectionDelay{i} = R{k}.DetectionTime{i} - P.SourceParamScenarios{2}(id(2));
                        DetectionDecision{i}(k) = 1;
                    else
                        R{k}.DetectionRate{i} = 'False Alarm';
                        DetectionDecision{i}(k) = 2;
                    end                                       
                    R{k}.IsolationTimeseries{i} = P.t(idx(1):end);
                    nZones = length(CDI0.Subsystems{i});
                    LearningRate = CDI0.SubsystemsData{i}.LearningRate;
                    InitialSourceEstimation = CDI0.SubsystemsData{i}.InitialSourceEstimation;
                    A = Acls{i}.A;
                    B2 = Bcls{i}.B;
                    L = Lcls{i}.L;
                    H = Hcls{i}.H;
                    C = Ccls{i}.C;
                    DA = CDI0.SubsystemsData{i}.UncertaintiesBound;
                    DH = CDI0.SubsystemsData{i}.UncertaintiesBound2;
                    d = CDI0.SubsystemsData{i}.NoiseBound;
                    Theta = CDI0.SubsystemsData{i}.Theta;
                    Ez0 = CDI0.SubsystemsData{i}.Ez0;
                    ysen = y{k}(idy{i},:);                
                    [rr bb] = ismember(IntCon{i},B.Sensors);
                    [rr cc idy2]=find(bb);
                    yInt = y{k}(idy2,:);
                    parfor j = 1:nZones
                        Fj = zeros(nZones,nsour);            
                        Fj(j,1)=1; 
                        Initial= zeros(nZones + nsour*nZones+nsour,1);
                        Initial(SensorsCls{i}) = ysen(:,idx(1));
                        for ii=1:nsour
                            Initial(nZones + ii*nZones+1)=InitialSourceEstimation;
                        end
                        [T x_hat_Iso{j}] = ode15s(@(tm,x2) IsolationObserverD(tm, x2,...
                                                                             A, ...
                                                                             L, ...
                                                                             C, ...
                                                                             H, ...
                                                                             nZones, ...
                                                                             ysen, ...
                                                                             yInt, ...
                                                                             P.t, ...
                                                                             LearningRate, ...
                                                                             B2, ...
                                                                             Fj , ...
                                                                             nsour), ...
                                                                             P.t(idx(1):end), ...
                                                                             Initial);
                        % Isolation Residuals
                        IsolationResidual{j} = abs(ysen(:,idx(1):end)- C*x_hat_Iso{j}(:,1:nZones)');

                        % Isolation Thresholds
                        [IsoThreshold{j} Exj{j}] = IsolationThresholdD(DA, DH, d, ...
                                                                      L, H, C,...
                                                                      Cofcls{i}, ...
                                                                      P.t(idx(1):end),...
                                                                      P.t(idx(1)), ...
                                                                      nS(i), ...
                                                                      nZones, ...
                                                                      nsour, ...                                                                  
                                                                      Theta, ...
                                                                      Ez0, ...
                                                                      x_hat_Iso{j},...
                                                                      yInt(:,idx(1):end)); 

                        % source estimation
                        SourceEstimation{j} = x_hat_Iso{j}(:,2*nZones+1);            
                        % check if isolation residual exceed threshold
                        [r2{j}{i} c] = find(IsolationResidual{j}' > IsoThreshold{j},1); 

                    end
                    for j = 1:nZones
                        IsolationLogic{j} = zeros(1,length(IsolationResidual{j}));
                        if ~isempty(r2{j}{i})
                            IsolationLogic{j}(1,r2{j}{i}:end) = 1;            
                            if isempty(R{k}.IsolationTime{i})
                                R{k}.IsolationTime{i} = R{k}.IsolationTimeseries{i}(r2{j}{i});
                                R{k}.IsolationDelay{i} = R{k}.IsolationTime{i} - P.SourceParamScenarios{2}(id(2));
                                R{k}.SourceEstimation{i} = SourceEstimation{j}(r2{j}{i});
                            else
                                if R{k}.IsolationTimeseries{i}(r2{j}{i}) > R{k}.IsolationTime{i}
                                    R{k}.IsolationTime{i} = R{k}.IsolationTimeseries{i}(r2{j}{i});
                                    R{k}.IsolationDelay{i} = R{k}.IsolationTime{i} - P.SourceParamScenarios{2}(id(2));
                                    R{k}.SourceEstimation{i} = SourceEstimation{j}(r2{j}{i});
                                end               
                            end
                        else
                            R{k}.IsolationDecision{i} = [R{k}.IsolationDecision{i}, j];
                        end 
                    end
                    
                    if ~isempty(R{k}.IsolationDecision{i})
                        if  isequal(R{k}.IsolationDecision{i}, find(ismember(CDI0.Subsystems{1,i},P.SourceLocationScenarios{id(4)})))
                            R{k}.IsolationRate{i} = 'True Positive';
                            IsolationDecision{i}(k) = 1;
                        else
                            if length(R{k}.IsolationDecision{i})==length(find(ismember(CDI0.Subsystems{1,i},P.SourceLocationScenarios{id(4)})))
                                R{k}.IsolationRate{i} = 'False Positive';
                                IsolationDecision{i}(k) = 2;
                            else
                                R{k}.IsolationRate{i} = 'False Negative';
                                IsolationDecision{i}(k) = 3;
                            end
                        end
                    else
                        if ~isempty(find(CDI0.Subsystems{1,i},P.SourceLocationScenarios{id(4)}))
                            R{k}.IsolationRate{i} = 'False Negative';
                            IsolationDecision{i}(k) = 3;
                        end
                    end
                    
                    % Isolation Residuals
                    R{k}.IsolationResidual{i} = IsolationResidual;

                    R{k}.IsolationThreshold{i} = IsoThreshold;

                    R{k}.AdaptiveSourceEstimation{i} = SourceEstimation;  

                    R{k}.IsolationLogic{i} = IsolationLogic;

                    clear r2 IsoThreshold IsolationResidual x_hat_Iso
                else
                    if ~isempty(P.SourceParamScenarios{3}(id(3)))
                        if (P.SourceParamScenarios{1}(id(1)) ~= 0) && (P.SourceParamScenarios{3}(id(3)) ~= 0) && max(ismember(CDI0.Subsystems{1,i},P.SourceLocationScenarios{id(4)}))
                            R{k}.DetectionRate{i} = 'Miss';
                            DetectionDecision{i}(k) = 3;
                        end
                    end
                end                            
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if isempty(findobj('Tag','ProgressBar'))
                exitflag=-1;
                return
            end
            progressbar2([],[],k/size(P.ScenariosContamIndex,1))
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
        
        clear CDI
        CDI.R = R;
        CDI.nSub = CDI0.nSub;
        CDI.SubsystemZones = CDI0.Subsystems;
        for i=1:CDI0.nSub
            CDI.Param.UncertaintiesBoundDA{i} = CDI0.SubsystemsData{i}.UncertaintiesBound;
            CDI.Param.UncertaintiesBoundDH{i} = CDI0.SubsystemsData{i}.UncertaintiesBound2;
            CDI.Param.NoiseBound{i} = CDI0.SubsystemsData{i}.NoiseBound;
            CDI.Param.Ex0{i} = CDI0.SubsystemsData{i}.Ex0;
            CDI.Param.Ez0{i} = CDI0.SubsystemsData{i}.Ez0;
            CDI.Param.LearningRate{i} = CDI0.SubsystemsData{i}.LearningRate;
            CDI.Param.Theta{i} = CDI0.SubsystemsData{i}.Theta;
            CDI.Param.InitialSourceEstimation{i} = CDI0.SubsystemsData{i}.InitialSourceEstimation;
        end
        save([pathname,file0,'_Distributed.cdi',num2str(jj)],'CDI', '-mat');
%         clear C R Cofcls CDI
        clear C R CDI

    end
     progressbar2(1,1,1);
    Decision.Detection =  DetectionDecision;
    Decision.Isolation =  IsolationDecision;
    
    save([pathname,file0,'_Distributed.dcs'],'Decision', '-mat');
    if str2num(Matlab_version(end-4:end))<2015
         matlabpool close
    end

end