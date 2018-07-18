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

function exitflag=runMultipleScenarios(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if isstruct(varargin{1}) 
        file0=varargin{1}.file0;
        P=varargin{1}.P;
        B=varargin{1}.B;
        load([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');
    else
        file0=varargin{1};
        pathname=[pwd,'\RESULTS\'];
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    exitflag=-1;
    load([pathname,file0,'.0'],'-mat');
    
    disp('Run Multiple Scenarios')
    %    P.FlowParameters={'WindDirection', 'WindSpeed','AmbientTemperature',...
    %    'ZonesVolume', 'ZoneTemperature','PathOpenings'};
    AP = B.AmbientPressure;
    progressbar2('Simulating Airflows','Simulating Contaminant Transport'); 
    for i=1:size(P.ScenariosFlowIndex,1)
        
        WD = P.FlowParamScenarios{1}(P.ScenariosFlowIndex(i,1));
        WS = P.FlowParamScenarios{2}(P.ScenariosFlowIndex(i,2));
        AT = P.FlowParamScenarios{3}(P.ScenariosFlowIndex(i,3));
        ZV = P.FlowParamScenarios{4}(P.ScenariosFlowIndex(i,4),:);
        ZT = P.FlowParamScenarios{5}(P.ScenariosFlowIndex(i,5),:);
        O =  P.FlowParamScenarios{6}(P.ScenariosFlowIndex(i,6),:);
        [Amat{i} Qext Flows{i}]=computeAmatrix(B,WD, WS, AT, AP, ZV, ZT, O);
        if isempty(findobj('Tag','ProgressBar'))
          exitflag=-1;
          return
        end
        progressbar2(i/size(P.ScenariosFlowIndex,1),[])
    end
    clc
        
    Dt=P.TimeStep;
%     St=P.StartTime; 
%     progressbar2('Simulate Airflows','Simulate Contaminant'); 
%     progressbar2(1,[])
    %Cfile= ['C', datestr(now,'-yyyy-mm-dd-HH-MM.')];
    switch P.Method
        case 'grid'
            k=1;
            for l=1:size(Amat,2)
                % Check if progress bar has been closed                
                C.A=Amat{l};
                C.Flows = Flows{l};
                for i=1:size(P.ScenariosContamIndex,1)
                    if isempty(findobj('Tag','ProgressBar'))
                      exitflag=-1;
                      return
                    end
                    sys=ss(Amat{l},B.B,B.C,B.D);
                    uint=zeros(B.nZones,length(P.t));
                    rate=P.SourceParamScenarios{1}(P.ScenariosContamIndex(i,1));
                    St=P.SourceParamScenarios{2}(P.ScenariosContamIndex(i,2));
                    dur=P.SourceParamScenarios{3}(P.ScenariosContamIndex(i,3));
                    loc=P.SourceLocationScenarios{P.ScenariosContamIndex(i,4)};
                    uint(loc',floor(St/Dt)+(1:floor(dur/Dt)))=rate;
                    u=uint;
                    xinit=B.x0'.*ones(B.nZones,1);
                    x = lsim(sys,u,P.t,xinit);
                    C.x{i}= x + 2*B.Noise*rand(size(x)) - B.Noise;

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    if isstruct(varargin{1}) 
%                         nload=k/(size(P.ScenariosContamIndex,1)*size(Amat,2)); 
                        varargin{1}.color=char('red');
                        progressbar2(1,(k-1)/(size(Amat,2)*size(P.ScenariosContamIndex,1)))
%                         progressbar(varargin{1},nload)
                        k=k+1;
                    end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                end
                save([pathname,file0,'.c',num2str(l)],'C', '-mat');
                clear C;
            end
        case 'random'
            k=1;
            for l=1:size(Amat,2)
                if isempty(findobj('Tag','ProgressBar'))
                  exitflag=-1;
                  return
                end
                C.A=Amat{l};
                C.Flows = Flows{l};
                
                sys=ss(Amat{l},B.B,B.C,B.D);
                uint=zeros(B.nZones,length(P.t));
                rate=P.SourceParamScenarios{1}(P.ScenariosContamIndex(l,1));
                St=P.SourceParamScenarios{2}(P.ScenariosContamIndex(l,2));
                dur=P.SourceParamScenarios{3}(P.ScenariosContamIndex(l,3));
                loc=P.SourceLocationScenarios{P.ScenariosContamIndex(l,4)};
                uint(loc',floor(St/Dt)+(1:floor(dur/Dt)))=rate;
                u=uint;
                xinit=B.x0'.*ones(B.nZones,1);
                x = lsim(sys,u,P.t,xinit);
                C.x{1}= x + 2*B.Noise*rand(size(x)) - B.Noise;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if isstruct(varargin{1}) 
                    nload=k/size(Amat,2); 
                    varargin{1}.color=char('red');
                    progressbar2(1,l/size(Amat,2))

%                     progressbar(varargin{1},nload)
%                     progressbar(nload,varargin{1}.runMultipleScenariosGui,varargin{1}.axes2)

                    k=k+1;
                end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                save([pathname,file0,'.c',num2str(l)],'C', '-mat');
                clear C;
            end
            
    end
    progressbar2(1,1);
    exitflag=1;
end

