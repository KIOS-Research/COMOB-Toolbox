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
function exitflag=RunMultipleCDI(varargin)
% profile on
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
    B.C=varargin{1}.B.C;
    
    disp('Run Multiple CDI')
    
    % check if the system is observable
    Ob = obsv(B.A, B.C);
    if ((length(B.A) - sprank(Ob)) ~= 0) 
        sprintf('The System is not Observable')
%         matlabpool close
        errordlg(['The System is not Observable'], 'Error');
        exitflag=-2;
        return
    end

    if CDI0.UncertaintiesBound==0
        DA = 0.0000001;
    else
        DA = CDI0.UncertaintiesBound;
    end

    CDI.L = [];
    % Gain Matrix L
    CDI.L(1:B.nZones,1:B.nS) =  B.A(:,B.Sensors);
    for j = 1:B.nS
        CDI.L(B.Sensors(j),j) = 2*DA;
    end

    CDI.A0 = [];
    % Matrix A0
    CDI.A0 = B.A - CDI.L*B.C;

    % find the coefficients for Thresholds
    az=zeros(length(P.t),B.nS);
    for i=1:length(P.t)
        p(i)=norm(expm(CDI.A0*P.t(i)));
        for j = 1:B.nS
            az(i,j)=norm(B.C(j,:)*expm(CDI.A0*P.t(i)));            
        end
    end

    data = fit(P.t', p', 'exp1');
    coefval = coeffvalues(data);
    Cofcls.rho = coefval(1); 
    Cofcls.ksi = -coefval(2);

    if ~(Cofcls.ksi > Cofcls.rho*DA)
       sprintf('The System is Unstable')
%        matlabpool close
       uiwait(msgbox('The System is Unstable', 'Error'))
       return
    end

    for j = 1:B.nS
        clear data
        data = fit(P.t', az(:,j), 'exp1');
        coefval = coeffvalues(data);
        Cofcls.alpha(j) = coefval(1);
        Cofcls.zita(j) = -coefval(2);
    end
    CDI.Cof = Cofcls;
    
    DetectionDecision = zeros(size(P.ScenariosFlowIndex,1),size(P.ScenariosContamIndex,1));
    IsolationDecision = zeros(size(P.ScenariosFlowIndex,1),size(P.ScenariosContamIndex,1));   
    
    %     matlabpool open
    % Open parallel pool and set as many workers as actual system cores
    p = gcp('nocreate'); % If no pool, do not create new one.
    if isempty(p)
        numcores = feature('numcores');
        parpool(numcores)
        % Set focus on main window
        figure(findobj('name','Contaminant Detection and Isolation'));
    end
    progressbar2('Simulating CDI for Airflows Scenarios','Contaminant Detection Simulation','Contaminant Isolation Simulation'); 
    kk = 1;
    for jj = 1:size(P.ScenariosFlowIndex,1)
        load([pathname,file0,'.c',num2str(jj)],'-mat');
        ScenariosContamIndex = size(C.x,2);
        % Calculate by CDI algorithm
        for i = 1:ScenariosContamIndex
            R{i}.DetectionThreshold = 0;
            R{i}.DetectionResidual = 0;
            R{i}.IsolationThreshold = [];
            R{i}.IsolationResidual = [];
            R{i}.DetectionTime = [];
            R{i}.DetectionDelay = [];
            R{i}.DetectionRate = [];
            R{i}.IsolationDecision = [];
            R{i}.IsolationTime = [];
            R{i}.IsolationDelay = [];
            R{i}.IsolationRate = [];
            R{i}.IsolationTimeseries = [];
            R{i}.IsolationLogic = [];
            R{i}.SourceEstimation = [];
            for j = 1:B.nZones
                R{i}.AdaptiveSourceEstimation{j} = [];  
            end
        end
                
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if isempty(findobj('Tag','ProgressBar'))
            exitflag=-1;
            return
        end
        progressbar2(jj/size(P.ScenariosFlowIndex,1),0,0)

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        y_helth = B.C*zeros(B.nZones,length(P.t));        
        for k = 1:ScenariosContamIndex   
            % sensor measurments
            y{k} = C.x{k}';
        end
        
        % Variable initialization for faster Parfor loop execution
        B_A=B.A;
        B_C=B.C;
        CDI_L=CDI.L;
        B_nZones=B.nZones;
        P_t=P.t;
         
        s_prog_bar=size(P.ScenariosContamIndex,1);

        
        parfor k = 1:ScenariosContamIndex
%             [t2 x_hat{k}] =
            [~,x_hat{k}] = ode15s(@(tm,x2) DetectionObserver(tm, x2, B_A,...
                                                              CDI_L, B_C,...
                                                              B_nZones, y{k}, ...
                                                              P_t), P.t, zeros(B_nZones,1));
%             [t2,x_hat_helth{k}] = 
            [~,x_hat_helth{k}] = ode15s(@(tm,x2) DetectionObserver(tm, x2, ...
                                                                    B_A, CDI_L,...
                                                                    B_C, B.nZones,...
                                                                    y_helth, P.t),...
                                                                    P.t, zeros(B.nZones,1));
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if isempty(findobj('Tag','ProgressBar'))
            exitflag=-1;
            return
        end
        progressbar2([],s_prog_bar/(3*s_prog_bar),[])

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Variable initialization for faster Parfor loop execution
        B_nS=B.nS;
        CDI_L=CDI.L;
        CDI0_NoiseBound=CDI0.NoiseBound;
        CDI0_Ex0=CDI0.Ex0;
        CDI0_UncertaintiesBound=CDI0.UncertaintiesBound;
        
        tic
        parfor k = 1:ScenariosContamIndex
%             [R{k}.DetectionThreshold Ex{k}] =
            [R{k}.DetectionThreshold,~] = DetectionThreshold(CDI0_UncertaintiesBound, ...
                                                                 CDI_L, ...
                                                                 CDI0_NoiseBound,...
                                                                 Cofcls, ...
                                                                 x_hat_helth{k}, ...
                                                                 P_t, B_nS, CDI0_Ex0);

            % residual for detection
            R{k}.DetectionResidual = abs(y{k} - B_C*x_hat{k}');
        end
        
        if isempty(findobj('Tag','ProgressBar'))
            exitflag=-1;
            return
        end
        progressbar2([],s_prog_bar/(2*s_prog_bar),[])
        
        parfor k = 1:ScenariosContamIndex    
            % check if detect a contaminant source
            [c r{k}] = find(R{k}.DetectionResidual > R{k}.DetectionThreshold',1);            
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if isempty(findobj('Tag','ProgressBar'))
            exitflag=-1;
            return
        end
        progressbar2([],2*s_prog_bar/(2*s_prog_bar),[])

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        nsour = 1;
        for k = 1:ScenariosContamIndex
            switch P.Method
                case 'grid'
                    id = P.ScenariosContamIndex(k,:);
                case 'random' 
                    id = P.ScenariosContamIndex(jj,:);
            end
                        
            % active isolation scheme
            if ~isempty(r{k})
                idx = r{k};
                R{k}.DetectionTime = P.t(idx(1));                
                if (P.SourceParamScenarios{1}(id(1)) ~= 0) && (P.SourceParamScenarios{3}(id(3)) ~= 0)
                    R{k}.DetectionRate = 'True Alarm';
%                     R{k}.DetectionDelay = R{k}.DetectionTime - P.StartTime;
                    R{k}.DetectionDelay = R{k}.DetectionTime - P.SourceParamScenarios{2}(id(2));
                    DetectionDecision(jj,k) = 1;
                else
                    R{k}.DetectionRate = 'False Alarm';
                    DetectionDecision(jj,k) = 2;
                end                               
                R{k}.IsolationTimeseries = P.t(idx(1):end);
                
                % Variable initialization for faster Parfor loop execution
                B_nZones=B.nZones;
                B_Sensors=B.Sensors;
                B_A=B.A;
                B_C=B.C;
                B_B=B.B;
                B_nS=B.nS;
                CDI0_InitialSourceEstimation=CDI0.InitialSourceEstimation;
                CDI0_LearningRate=CDI0.LearningRate;
                CDI0_UncertaintiesBound=CDI0.UncertaintiesBound;
                CDI_L=CDI.L; CDI0_Theta=CDI0.Theta; CDI0_Ez0=CDI0.Ez0;
                CDI0_NoiseBound=CDI0.NoiseBound;
                P_t=P.t;
                indx1=idx(1);
                y_k=y{k};
                R_k_DetectionTime=R{k}.DetectionTime;
                
                parfor j = 1:B_nZones
                    Fj = zeros(B_nZones,nsour);            
                    Fj(j,1)=1;       
                    Initial= zeros(B_nZones + nsour*B_nZones+nsour,1);
                    Initial(B_Sensors)=y_k(:,indx1);
                    for ii=1:nsour
                        Initial(B_nZones + ii*B_nZones+1)=CDI0_InitialSourceEstimation;
                    end
%                     [T x_hat_Iso{j}] =
                    [~,x_hat_Iso{j}] = ode15s(@(tm,x2) IsolationObserver(tm, x2,...
                                                                         B_A, ...
                                                                         CDI_L, ...
                                                                         B_C, ...
                                                                         B_nZones, ...
                                                                         y_k, P_t, ...
                                                                         CDI0_LearningRate, ...
                                                                         B_B, ...
                                                                         Fj , ...
                                                                         nsour), ...
                                                                         P_t(indx1:end), ...
                                                                         Initial);

                    % Isolation Residuals
                    IsolationResidual{j} = abs(y_k(:,indx1:end)-B_C*x_hat_Iso{j}(:,1:B_nZones)');
                    % Isolation Thresholds
%                     [IsoThreshold{j}, Exj{j}]=
                    [IsoThreshold{j},~] = IsolationThreshold(CDI0_UncertaintiesBound, ...
                                                                  CDI0_NoiseBound,...
                                                                  Cofcls, ...
                                                                  P_t(indx1:end),...
                                                                  R_k_DetectionTime, ...
                                                                  B_nS, ...
                                                                  B_nZones, ...
                                                                  nsour, ...
                                                                  B_C, ...
                                                                  CDI_L, ...
                                                                  CDI0_Theta, ...
                                                                  CDI0_Ez0, ...
                                                                  x_hat_Iso{j});              
                    % source estimation
                    SourceEstimation{j} = x_hat_Iso{j}(:,2*B_nZones+1);            
                    % check if isolation residual exceed threshold
%                     [r2{j} c] =
                    [r2{j},~] = find(IsolationResidual{j}' > IsoThreshold{j},1);            
                end        

                % Isolation Residuals
                R{k}.IsolationResidual = IsolationResidual;

                R{k}.IsolationThreshold = IsoThreshold;

                R{k}.AdaptiveSourceEstimation = SourceEstimation;

                for j = 1:B.nZones
                    R{k}.IsolationLogic{j} = zeros(1,length(IsolationResidual{j}));
                    if ~isempty(r2{j})
                        R{k}.IsolationLogic{j}(1,r2{j}:end) = 1;            
                        if isempty(R{k}.IsolationTime)
                            R{k}.IsolationTime = R{k}.IsolationTimeseries(r2{j});
                            R{k}.IsolationDelay = R{k}.IsolationTime - P.SourceParamScenarios{2}(id(2));
                            R{k}.SourceEstimation = SourceEstimation{j}(r2{j});
                        else
                            if R{k}.IsolationTimeseries(r2{j}) > R{k}.IsolationTime
                                R{k}.IsolationTime = R{k}.IsolationTimeseries(r2{j});
                                R{k}.IsolationDelay = R{k}.IsolationTime - P.SourceParamScenarios{2}(id(2));
                                R{k}.SourceEstimation = SourceEstimation{j}(r2{j});
                            end               
                        end
                    else
                        R{k}.IsolationDecision = [R{k}.IsolationDecision, j];
                    end 
                end
                
                if ~isempty(R{k}.IsolationDecision)
                    if  isequal(R{k}.IsolationDecision, P.SourceLocationScenarios{id(4)})
                        R{k}.IsolationRate = 'True Positive';
                        IsolationDecision(jj,k) = 1;
                    else
                        if length(R{k}.IsolationDecision)==length(P.SourceLocationScenarios{id(4)})
                            R{k}.IsolationRate = 'False Positive';
                            IsolationDecision(jj,k) = 2;
                        else
                            R{k}.IsolationRate = 'False Negative';
                            IsolationDecision(jj,k) = 3;
                        end
                    end
                else
                    if ~isempty(P.SourceLocationScenarios{id(4)})
                        R{k}.IsolationRate = 'False Negative';
                        IsolationDecision(jj,k) = 3;
                    end
                end
                clear r2 IsoThreshold IsolationResidual x_hat_Iso
            else
                if ~isempty(P.SourceParamScenarios{3}(id(3)))
                    if (P.SourceParamScenarios{1}(id(1)) ~= 0) && (P.SourceParamScenarios{3}(id(3)) ~= 0)
                        R{k}.DetectionRate = 'Miss';
                        DetectionDecision(jj,k) = 3;
                    end
                end
            end 
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if isempty(findobj('Tag','ProgressBar'))
                exitflag=-1;
                return
            end
            progressbar2([],[],k/size(P.ScenariosContamIndex,1))

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        end
        
        CDIB = CDI;
        clear CDI
        CDI.R = R;
        CDI.nSub = 0;
        CDI.Param.UncertaintiesBound = CDI0.UncertaintiesBound;
        CDI.Param.NoiseBound = CDI0.NoiseBound;
        CDI.Param.Ex0 = CDI0.Ex0;
        CDI.Param.Ez0 = CDI0.Ez0;
        CDI.Param.LearningRate = CDI0.LearningRate;
        CDI.Param.Theta = CDI0.Theta;
        CDI.Param.InitialSourceEstimation = CDI0.InitialSourceEstimation;
        
        save([pathname,file0,'_Centralized.cdi',num2str(jj)],'CDI', '-mat');
        clear C R CDI
        CDI = CDIB;
    end
    Decision.Detection =  DetectionDecision;
    Decision.Isolation =  IsolationDecision;
    
    save([pathname,file0,'_Centralized.dcs'],'Decision', '-mat');
    progressbar2(1,1,1)

%     matlabpool close
% profile off
end