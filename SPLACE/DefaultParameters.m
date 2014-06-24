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

function P=DefaultParameters(varargin)
    if isstruct(varargin{1})
        B=varargin{1}.B;
    else
        B=varargin{1};
        B=B{1};
    end
    %METHODS
    %P.Method='random';
    %P.MethodParameter=10000;%EDITABLE

    P.Method='grid';
    %P.MethodParameter=NaN;

    %TIMES
    P.TimeStep=0.0167; %EDITABLE
    P.SimulationTime=24; %EDITABLE

    %CONTAMINANT
    P.SourceGenerationRate=500;
    P.SourceDuration=1.5;
    P.SourceParameters={'SourceGenerationRate','SourceDuration'};
    P.SourceValues={P.SourceGenerationRate, P.SourceDuration}; %EDITABLE
    P.SourcePrc={5, 5}; %EDITABLE
    P.SourceSamples={2,2}; %EDITABLE
    P.SourcesMax=1; %EDITABLE maximum number of simultaneous sources (including 1,2..)

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