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

function P=CreateScenarios(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if isstruct(varargin{1})
        P=GetGuiParameters(varargin{1});
        B=varargin{1}.B;
    else
        P=DefaultParameters(varargin{1});
        B=varargin{1};
        B=B{1};
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % When Create Scenarios Button is PRESSED
    P.t=0:P.TimeStep:P.SimulationTime;
    
    switch P.Method
        case 'grid'
            FlowScenarioSets={};
            ContamScenarioSets={};

            %compute scenarios affecting flows
            for i=1:length(P.FlowParameters)
                P.FlowParamScenarios{i}=linspaceNDim((P.FlowValues{i}-(P.FlowPrc{i}/100).*P.FlowValues{i})', (P.FlowValues{i}+(P.FlowPrc{i}/100).*P.FlowValues{i})', P.FlowSamples{i});
                if find(strcmp({'ZonesVolume', 'ZoneTemperature','PathOpenings'},P.FlowParameters{i}))
                    P.FlowParamScenarios{i}=P.FlowParamScenarios{i}';
                elseif find(strcmp({'WindDirection'},P.FlowParameters{i}))
                    P.FlowParamScenarios{i}=int16(P.FlowParamScenarios{i});
                    P.FlowParamScenarios{i}(find(P.FlowParamScenarios{i}<0))= P.FlowParamScenarios{i}(find(P.FlowParamScenarios{i}<0)) + 360;
                end
                FlowScenarioSets{i}=1:size(P.FlowParamScenarios{i},1);
            end
            
            %compute scenarios affecting contamination sources
            for i=1:length(P.SourceParameters)
                P.SourceParamScenarios{i}=linspaceNDim((P.SourceValues{i}-(P.SourcePrc{i}/100).*P.SourceValues{i})', (P.SourceValues{i}+(P.SourcePrc{i}/100).*P.SourceValues{i})', P.SourceSamples{i});
                ContamScenarioSets{i}=1:size(P.SourceParamScenarios{i},1);
            end
            
            %compute all source locations
            k=1;
%             for i=1:P.SourcesMax%%% old
            for i=P.SourcesMax    
                tmp=combnk(P.SourceZones,i);
                for j=1:size(tmp,1)
                    T(k)={tmp(j,:)};
                    k=k+1;
                end
            end
            P.SourceLocationScenarios=T;
            ContamScenarioSets{length(P.SourceParameters)+1}=1:size(P.SourceLocationScenarios,2);

            P.ScenariosFlowIndex=cartesianProduct(FlowScenarioSets);
            P.ScenariosContamIndex=cartesianProduct(ContamScenarioSets);
        case 'random'
            
%             %compute scenarios affecting flows
%             for i=1:length(P.FlowParameters)
%                 Tol = (P.FlowPrc{i}/100).*P.FlowValues{i};
%                 switch P.FlowParameters{i}
%                     case {'ZonesVolume', 'ZoneTemperature','PathOpenings'}
%                     case 'WindDirection'
%                     case {'WindSpeed','AmbientTemperature'}
%                 end
%                 for j=1:length(P.RandomSamples)
%                     
%                     
%                 end                
%             end           
            ContamScenarioSets={};
                        
            P.ScenariosFlowIndex = [];   
            %compute scenarios affecting flows
            for i=1:length(P.FlowParameters)
                Tol = (P.FlowPrc{i}/100).*P.FlowValues{i};
                switch P.FlowParameters{i}
                    case {'ZonesVolume', 'ZoneTemperature','PathOpenings'}
                        P.FlowParamScenarios{i} = [];
                        for j = 1:length(P.FlowValues{i})                            
                            if Tol(j) ~= 0
                                P.FlowParamScenarios{i}= [P.FlowParamScenarios{i}, P.FlowValues{i}(j) + unifrnd(-Tol(j),Tol(j),P.RandomSamples,1)];                                
                            else
                                P.FlowParamScenarios{i}(1,j)= P.FlowValues{i}(j);                                
                            end                            
                        end
                        if Tol(1) ~= 0
                           P.ScenariosFlowIndex = [P.ScenariosFlowIndex, (1:P.RandomSamples)']; 
                        else
                           P.ScenariosFlowIndex = [P.ScenariosFlowIndex, ones(P.RandomSamples,1)];
                        end
                    case 'WindDirection'
                        if Tol ~= 0
                            P.FlowParamScenarios{i}= P.FlowValues{i} + unifrnd(-Tol,Tol,P.RandomSamples,1);
                            P.FlowParamScenarios{i}(find(P.FlowParamScenarios{i}<0))= P.FlowParamScenarios{i}(find(P.FlowParamScenarios{i}<0)) + 360;
                            P.FlowParamScenarios{i}=int16(P.FlowParamScenarios{i});
                            P.ScenariosFlowIndex = [P.ScenariosFlowIndex, (1:P.RandomSamples)'];
                        else
                            P.FlowParamScenarios{i}= P.FlowValues{i};
                            P.ScenariosFlowIndex = [P.ScenariosFlowIndex, ones(P.RandomSamples,1)];
                        end
                    case {'WindSpeed','AmbientTemperature'}
                        if Tol ~= 0
                            P.FlowParamScenarios{i}= P.FlowValues{i} + unifrnd(-Tol,Tol,P.RandomSamples,1);
                            P.ScenariosFlowIndex = [P.ScenariosFlowIndex, (1:P.RandomSamples)'];
                        else
                            P.FlowParamScenarios{i}= P.FlowValues{i};
                            P.ScenariosFlowIndex = [P.ScenariosFlowIndex, ones(P.RandomSamples,1)];
                        end
                end
            end
            
            P.ScenariosContamIndex = [];
            %compute scenarios affecting contamination sources
            for i=1:length(P.SourceParameters)
                Tol = (P.SourcePrc{i}/100).*P.SourceValues{i};
%                 ContamScenarioSets{i} = [];
                if Tol ~= 0
                    P.SourceParamScenarios{i}= P.SourceValues{i} + unifrnd(-Tol,Tol,P.RandomSamples,1);
%                     ContamScenarioSets{i} = [ContamScenarioSets{i}, (1:P.RandomSamples)'];
                    P.ScenariosContamIndex = [P.ScenariosContamIndex, (1:P.RandomSamples)'];
                else
                    P.SourceParamScenarios{i}= P.SourceValues{i};
                    P.ScenariosContamIndex = [P.ScenariosContamIndex, ones(P.RandomSamples,1)];
%                     ContamScenarioSets{i} = [ContamScenarioSets{i}, ones(P.RandomSamples,1)];
                end               
            end
            
            %compute all source locations
            for k=1:P.RandomSamples
                    random_source_number=P.SourcesMax(randperm(length(P.SourcesMax),1));
                    T(k) = {P.SourceZones(randperm(length(P.SourceZones),random_source_number))};  
            end
            P.SourceLocationScenarios= T;
            
%             P.SourceLocationScenarios=randi(B.nZones,P.RandomSamples,P.SourcesMax);
%             ContamScenarioSets{length(P.SourceParameters)+1}=1:size(P.SourceLocationScenarios,2);
            
            P.ScenariosContamIndex = [P.ScenariosContamIndex, (1:P.RandomSamples)'];
%             P.ScenariosContamIndex=cartesianProduct(ContamScenarioSets); 
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     if ~isstruct(varargin{1})
%         file0='test';
%         save([file0,'.0'],'P','B','-mat');
%     end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
