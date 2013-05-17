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