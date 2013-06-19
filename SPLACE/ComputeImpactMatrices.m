%{
 Copyright 2013 KIOS Research Center for Intelligent Systems and Networks, University of Cyprus (www.kios.org.cy)

 Licensed under the EUPL, Version 1.1 or – as soon they will be approved by the European Commission - subsequent versions of the EUPL (the "Licence");
 You may not use this work except in compliance with theLicence.
 You may obtain a copy of the Licence at:

 http://ec.europa.eu/idabc/eupl

 Unless required by applicable law or agreed to in writing, software distributed under the Licence is distributed on an "AS IS" basis,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the Licence for the specific language governing permissions and limitations under the Licence.
%}

function ComputeImpactMatrices(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if isstruct(varargin{1}) 
        file0=varargin{1}.file0;
        W.SensorThreshold=varargin{1}.SensorThreshold1;  
        W.InhalationRate=varargin{1}.InhalationRate1; 
        W.ZoneOccupancy=varargin{1}.ZoneOccupancy; 
        load([pwd,'\SPLACE\RESULTS\','pathname.File'],'pathname','-mat');
    else
        file0=varargin{1};
        %IMPACT CALCULATION
        W.ZoneOccupancy=[0.5, 0.1, 0.2, 4, 4, 0.2, 0.5, 1 ,...
            1, 0.1 , 0.1, 0.1, 0.2, 1];   
        W.InhalationRate=0.5;  
        W.SensorThreshold=0.75;  
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    load([pathname,file0,'.0'],'-mat')
%     load([pathname,file0,'.c0'],'-mat')
%     load([pathname,'Simulate.Method'],'SimulateMethod','-mat');
    
    disp('Compute Impact Matrix')
    U1=W.SensorThreshold;
    Dt=P.TimeStep;
    KMAX=P.SimulationTime;
    h=W.InhalationRate;
    pop=W.ZoneOccupancy;
    T=inf*ones(size(P.ScenariosFlowIndex,1)*size(P.ScenariosContamIndex,1),B.nZones);
    l=1;pp=1;
    for i=1:size(P.ScenariosFlowIndex,1)
        %tmpfile=[Cfile,num2str(i)];
        %disp(tmpfile)
        %load(tmpfile,'-mat');
        load([pathname,file0,'.c',num2str(i)],'-mat')
        for k=1:size(P.ScenariosContamIndex,1)
            %c=single(C.x{k})/1000;
            c=(C.x{k});
            for j=B.Zones
                if sum(c(:,j))==0
                else
                    if isempty(find(c(:,j)>=U1, 1 ))
                    else
                        T(l,j)=P.t(find(c(:,j)>=U1, 1 ));
                    end
                end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if isstruct(varargin{1}) 
                    if mod(pp,100)==1
                        nload=pp/(B.nZones*size(P.ScenariosFlowIndex,1)*size(P.ScenariosContamIndex,1)); 
                        varargin{1}.color=char('red');
                        progressbar(varargin{1},nload)
                    end
                    pp=pp+1;
                end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                   
                
            end
            Tindex=T(l,:)/Dt+1;
            Tindex(find(Tindex==Inf))=KMAX/Dt+1;
            Tindex=floor(Tindex);
            for j=1:B.nZones
                W.w(l,j)=(trapz(P.t(1:Tindex(1,j)),c(1:Tindex(1,j),:))*pop')/h;
            end 
            l=l+1;
        end
    end
    save([pathname,file0,'.w'],'W','-mat');
end