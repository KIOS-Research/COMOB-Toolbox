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

function P=GetGuiParameters(varargin)
    B=varargin{1}.B;

    % Methods
    Methodgrid = get(varargin{1}.Methodgrid,'Value');
    if Methodgrid
        P.Method='grid';
    end
    Methodrandom = get(varargin{1}.Methodrandom,'Value');
    if Methodrandom
        P.Method='random';
    end

    % Time Parameters
    P.SimulationTime = str2num(get(varargin{1}.SimulationTime,'String'));
    P.TimeStep = str2num(get(varargin{1}.TimeStep,'String'));

    % CONTAMINANT
    P.SourcePrc={};
    P.SourceSamples={};
    P.SourceGenerationRate = str2num(get(varargin{1}.SourceGenerationRate,'String'));
    P.SourceDuration = str2num(get(varargin{1}.SourceDuration,'String'));
    P.SourcePrc{1} = str2double(get(varargin{1}.SourceGenerationRatePrc,'String'));
    P.SourcePrc{2} = str2double(get(varargin{1}.SourceDurationPrc,'String'));
    P.SourceSamples{1} = str2double(get(varargin{1}.SourceGenerationRateSamples,'String'));
    P.SourceSamples{2} = str2double(get(varargin{1}.SourceDurationSamples,'String'));
    P.SourceParameters={'SourceGenerationRate','SourceDuration'};
    P.SourceValues={P.SourceGenerationRate, P.SourceDuration};
    P.SourcesMax=get(varargin{1}.SourcesMax,'Value'); %maximum number of simultaneous sources (including 1,2..)

    %AFFECTING FLOWS
    P.WindDirection = str2num(get(varargin{1}.WindDirection,'String'));
    P.WindSpeed = str2num(get(varargin{1}.WindSpeed,'String'));
    P.AmbientTemperature = str2double(get(varargin{1}.AmbientTemperature,'String'));
    
    P.PathOpen=str2num(get(varargin{1}.PathOpenings,'String'));
    P.PathOpenings=P.PathOpen.*B.Openings;

    P.FlowPrc{1} = str2double(get(varargin{1}.WindDirectionPrc,'String'));
    P.FlowPrc{2} = str2double(get(varargin{1}.WindSpeedPrc,'String'));
    P.FlowPrc{3} = str2double(get(varargin{1}.AmbientTemperaturePrc,'String'));
    P.FlowPrc{6} = str2double(get(varargin{1}.PathOpeningsPrc,'String'));
    P.FlowSamples{1} = str2double(get(varargin{1}.WindDirectionSamples,'String'));
    P.FlowSamples{2} = str2double(get(varargin{1}.WindSpeedSamples,'String'));
    P.FlowSamples{3} = str2double(get(varargin{1}.AmbientTemperatureSamples,'String'));
    P.FlowSamples{6} = str2double(get(varargin{1}.PathOpeningsSamples,'String'));

    % Zones
    % Volume
    ZoneTable=get(varargin{1}.ZoneTable,'data');
    P.FlowPrc{4}=ZoneTable(1,1);
    P.FlowSamples{4}=ZoneTable(1,2);
    P.ZonesVolume=ZoneTable(1,3:end);
    % Temperature
    P.FlowPrc{5}=ZoneTable(2,1);
    P.FlowSamples{5}=ZoneTable(2,2);
    P.ZoneTemperature=ZoneTable(2,3:end);

    P.FlowParameters={'WindDirection', 'WindSpeed','AmbientTemperature',...
        'ZonesVolume', 'ZoneTemperature','PathOpenings'};
    P.FlowValues={P.WindDirection, P.WindSpeed, P.AmbientTemperature,...
        P.ZonesVolume, P.ZoneTemperature, P.PathOpenings}; %EDITABLE

    P.nZones=B.nZones;
end