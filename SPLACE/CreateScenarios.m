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
    
    FlowScenarioSets={};
    ContamScenarioSets={};
    
    %compute scenarios affecting flows
    for i=1:length(P.FlowParameters)
        P.FlowParamScenarios{i}=linspaceNDim((P.FlowValues{i}-(P.FlowPrc{i}/100).*P.FlowValues{i})', (P.FlowValues{i}+(P.FlowPrc{i}/100).*P.FlowValues{i})', P.FlowSamples{i});
        if find(strcmp({'ZonesVolume', 'ZoneTemperature','PathOpenings'},P.FlowParameters{i}))
            P.FlowParamScenarios{i}=P.FlowParamScenarios{i}';
        elseif find(strcmp({'WindDirection'},P.FlowParameters{i}))
            P.FlowParamScenarios{i}=int16(P.FlowParamScenarios{i});
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
    for i=1:P.SourcesMax
        tmp=combnk(1:B.nZones,i);
        for j=1:size(tmp,1)
            T(k)={tmp(j,:)};
            k=k+1;
        end
    end
    P.SourceLocationScenarios=T;
    ContamScenarioSets{length(P.SourceParameters)+1}=1:size(P.SourceLocationScenarios,2);

    switch P.Method
        case 'grid'
        P.ScenariosFlowIndex=cartesianProduct(FlowScenarioSets);
        P.ScenariosContamIndex=cartesianProduct(ContamScenarioSets);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     if ~isstruct(varargin{1})
%         file0='test';
%         save([file0,'.0'],'P','B','-mat');
%     end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
