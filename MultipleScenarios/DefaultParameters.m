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

function P=DefaultParameters(varargin)
    if isstruct(varargin{1})
        B=varargin{1}.B;
        if nargin>1
            P.ScenarioSelection=varargin{2};
        else
            P.ScenarioSelection='single';
        end
    else
        B=varargin{1};
        B=B{1};
        if nargin>1
            P.ScenarioSelection=varargin{2};
        else
            P.ScenarioSelection='single';
        end
    end
    %METHODS
    %P.Method='random';
    %P.MethodParameter=10000;%EDITABLE
    P.RandomSamples=100; %EDITABLE

    P.Method='grid';
    %P.MethodParameter=NaN;

    %TIMES
    P.TimeStep=0.0167; %EDITABLE     
    P.SimulationTime=24; %EDITABLE
    
    % Default Scenarios
    
    switch P.ScenarioSelection
        case 'single' %% Single Scenario Parameters
%             P.ScenarioSelection='single';

            %CONTAMINANT
            P.SourceGenerationRate=500;
            P.SourceDuration=1.5;
            P.StartTime = 1; 
            P.SourceParameters={'SourceGenerationRate','StartTime','SourceDuration'};
            P.SourceValues={P.SourceGenerationRate, P.StartTime, P.SourceDuration}; %EDITABLE
            P.SourcePrc={0, 0, 0}; %Non EDITABLE
            P.SourceSamples={1,1,1}; %Non EDITABLE
            P.SourcesMax=1; %EDITABLE maximum number of simultaneous sources (including 1,2..)
            P.SourceZones= 1:B.nZones; % EDITABLE zones to include for simultaneous sources 

            %AFFECTING FLOWS
            P.WindDirection=B.WindDirection;
            P.WindSpeed=B.WindSpeed;
            P.AmbientTemperature=B.AmbientTemperature;
            P.ZonesVolume=B.v;
            P.ZoneTemperature=B.Temp;
            P.PathOpen=1;
            P.PathOpenings=B.Openings.*P.PathOpen;
            P.FlowParameters={'WindDirection', 'WindSpeed','AmbientTemperature',...
                'ZonesVolume', 'ZoneTemperature','PathOpenings'};
            P.FlowValues={P.WindDirection, P.WindSpeed, P.AmbientTemperature,...
                P.ZonesVolume, P.ZoneTemperature, P.PathOpenings}; %EDITABLE
            P.FlowPrc={0,0,0,0,0,0}; %Non EDITABLE
            P.FlowSamples={1,1,1,1,1,1}; % Non EDITABLE   
        case 'multiple'
            P.ScenarioSelection='multiple';
            %CONTAMINANT
            P.SourceGenerationRate=500;
            P.SourceDuration=1.5;
            P.StartTime = 1; 
            P.SourceParameters={'SourceGenerationRate','StartTime','SourceDuration'};
            P.SourceValues={P.SourceGenerationRate, P.StartTime, P.SourceDuration}; %EDITABLE
            P.SourcePrc={5, 5, 5}; %EDITABLE
            P.SourceSamples={2,2,2}; %EDITABLE
            P.SourcesMax=1; %EDITABLE maximum number of simultaneous sources (including 1,2..)
            P.SourceZones= 1:B.nZones; % EDITABLE zones to include for simultaneous sources 

            %AFFECTING FLOWS
            P.WindDirection=B.WindDirection;
            P.WindSpeed=B.WindSpeed;
            P.AmbientTemperature=B.AmbientTemperature;
            P.ZonesVolume=B.v;
            P.ZoneTemperature=B.Temp;
            P.PathOpen=1;
            P.PathOpenings=B.Openings.*P.PathOpen;
            P.FlowParameters={'WindDirection', 'WindSpeed','AmbientTemperature',...
                'ZonesVolume', 'ZoneTemperature','PathOpenings'};
            P.FlowValues={P.WindDirection, P.WindSpeed, P.AmbientTemperature,...
                P.ZonesVolume, P.ZoneTemperature, P.PathOpenings}; %EDITABLE
            P.FlowPrc={10,10,0,0,0,0}; %EDITABLE
            P.FlowSamples={2,2,1,1,1,1}; %EDITABLE   
    end
    
end