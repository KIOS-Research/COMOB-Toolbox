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
function [errorflag]=ComputeImpactMatrices(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if isstruct(varargin{1}) 
        file0=varargin{1}.file0;
        W.SensorThreshold=varargin{1}.SensorThreshold1;  
        W.InhalationRate=varargin{1}.InhalationRate1; 
        W.ZoneOccupancy=varargin{1}.ZoneOccupancy; 
        load([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');
    else
        file0=varargin{1};
        %IMPACT CALCULATION
        W.ZoneOccupancy=[0.5, 0.1, 0.2, 4, 4, 0.2, 0.5, 1 ,...
            1, 0.1 , 0.1, 0.1, 0.2, 1];   
        W.InhalationRate=0.5;  
        W.SensorThreshold=0.75;  
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    errorflag=0;
    progressbar2('Compute Impact Matrices'); 



    load([pathname,file0,'.0'],'-mat')
    
    disp('Compute Impact Matrix')
    U1=W.SensorThreshold;
    Dt=P.TimeStep;
    KMAX=P.SimulationTime;
    h=W.InhalationRate;
    pop=W.ZoneOccupancy;
    T=inf*ones(size(P.ScenariosFlowIndex,1)*size(P.ScenariosContamIndex,1),B.nZones);
    l=1;
    for i=1:size(P.ScenariosFlowIndex,1)
        %tmpfile=[Cfile,num2str(i)];
        %disp(tmpfile)
        %load(tmpfile,'-mat');
%         load([pathname,file0,'.c',num2str(i)],'-mat')
        clear C        
        load([file0,'.c',num2str(i)],'-mat')
        if strcmp(P.Method,'random')
            ScenarioContaminant_Num=1;
        else
            ScenarioContaminant_Num=size(P.ScenariosContamIndex,1);
        end
        for k=1:ScenarioContaminant_Num
            %c=single(C.x{k})/1000;
            c=(C.x{k});
            
            %Check if all contaminant releases have been calculated and
            %notify accordingly.
            
            if size(c,2)~=size(C.A,1)
                msg=[];
                msg = 'A scenario with all contaminant sensor measurement needs to be created for the sensor placement problem !!'; 
                uiwait(errordlg(msg));
                progressbar2(1);
                errorflag=1;
                return
            end
            
            
            
            for j=B.Zones
                if sum(c(:,j))==0
                else
                    if isempty(find(c(:,j)>=U1, 1 ))
                    else
                        T(l,j)=P.t(find(c(:,j)>=U1, 1 ));
                    end
                end

            end
            Tindex=T(l,:)/Dt+1;
            Tindex(find(Tindex==Inf))=KMAX/Dt+1;
            Tindex=floor(Tindex);
            for j=1:B.nZones
                W.w(l,j)=(trapz(P.t(1:Tindex(1,j)),c(1:Tindex(1,j),:))*pop')/h;
            end
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% update status bar
            if isstruct(varargin{1}) 
%                     if mod(pp,100)==1
%                     nload=pp/(size(P.ScenariosFlowIndex,1)*size(P.ScenariosContamIndex,1)); 
%                     varargin{1}.color=char('red');
                    progressbar2(i/size(P.ScenariosFlowIndex,1))
%                     progressbar(varargin{1},nload)
%                     end
            end                
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            l=l+1;
        end
    end
    save([pwd,'\RESULTS\',file0,'.w'],'W','-mat');
end