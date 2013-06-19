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

function varargout = CreateScenariosGui(varargin)
% CREATESCENARIOSGUI MATLAB code for CreateScenariosGui.fig
%      CREATESCENARIOSGUI, by itself, creates a new CREATESCENARIOSGUI or raises the existing
%      singleton*.
%
%      H = CREATESCENARIOSGUI returns the handle to a new CREATESCENARIOSGUI or the handle to
%      the existing singleton*.
%
%      CREATESCENARIOSGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CREATESCENARIOSGUI.M with the given input arguments.
%
%      CREATESCENARIOSGUI('Property','Value',...) creates a new CREATESCENARIOSGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CreateScenariosGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CreateScenariosGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CreateScenariosGui

% Last Modified by GUIDE v2.5 30-Apr-2013 05:18:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @CreateScenariosGui_OpeningFcn, ...
    'gui_OutputFcn',  @CreateScenariosGui_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before CreateScenariosGui is made visible.
function CreateScenariosGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CreateScenariosGui (see VARARGIN)

% Choose default command line output for CreateScenariosGui
    handles.output = hObject;

    % UIWAIT makes CreateScenariosGui wait for user response (see UIRESUME)
    % uiwait(handles.figure1);

    set(handles.figure1,'name','Create Scenarios');
%     set(handles.figure1,'Position',[75 15 164.5 39]);

    handles.B=varargin{1};
    % Update handles structure
    guidata(hObject, handles);

    P=DefaultParameters(handles);

    handles.P=P;

    % Update handles structure
    guidata(hObject, handles);

    SetGuiParameters(P,handles.B,handles);

% --- Outputs from this function are returned to the command line.
function varargout = CreateScenariosGui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function SetGuiParameters(P,B,handles)
    % Time Parameters
    set(handles.SimulationTime,'String',P.SimulationTime);
    set(handles.TimeStep,'String',P.TimeStep);

    % Contaminant
    set(handles.SourceGenerationRate,'String',P.SourceGenerationRate);
    set(handles.SourceDuration,'String',P.SourceDuration);
    set(handles.SourceGenerationRatePrc,'String',P.SourcePrc(1));
    set(handles.SourceGenerationRateSamples,'String',P.SourceSamples(1));
    set(handles.SourceDurationPrc,'String',P.SourcePrc(2));
    set(handles.SourceDurationSamples,'String',P.SourceSamples(2));

    % Affecting flows
    % Wind Direction
    set(handles.WindDirection,'String',P.WindDirection);
    set(handles.WindDirectionPrc,'String',P.FlowPrc(1));
    set(handles.WindDirectionSamples,'String',P.FlowSamples(1));

    % Wind Speed
    set(handles.WindSpeed,'String',P.WindSpeed);
    set(handles.WindSpeedPrc,'String',P.FlowPrc(2));
    set(handles.WindSpeedSamples,'String',P.FlowSamples(2));

    % Ambient Temperature
    set(handles.AmbientTemperature,'String',P.AmbientTemperature);
    set(handles.AmbientTemperaturePrc,'String',P.FlowPrc(3));
    set(handles.AmbientTemperatureSamples,'String',P.FlowSamples(3));

    % Path Openings
    % set(handles.PathOpenings,'String',P.PathOpenings);
    set(handles.PathOpeningsPrc,'String',P.FlowPrc(6));
    set(handles.PathOpeningsSamples,'String',P.FlowSamples(6));
    P.PathOpenings=P.PathOpen.*B.Openings; 
    set(handles.PathOpenings,'String',P.PathOpen);

    % Source Max
    set(handles.SourcesMax,'String',1:B.nZones); %maximum number of simultaneous sources (including 1,2)
    set(handles.SourcesMax,'Value',P.SourcesMax);
    
    % Zones
    ZoneTableColumnName(1,1)={'%'};
    ZoneTableColumnName(1,2)={'Samples'};
    ZoneTableColumnName(1,3:B.nZones+2)=B.ZoneName;
    set(handles.ZoneTable, 'ColumnName', ZoneTableColumnName);
    set(handles.ZoneTable,'RowName',{'Volume','Temperature'});

    % Column Edit Table
    ColumnEditable='true ';
    for i=1:B.nZones+2
        ColumnEditable = strcat({ColumnEditable},' true');
        ColumnEditable = ColumnEditable{1,1};
    end
    set(handles.ZoneTable,'ColumnEditable',str2num(ColumnEditable));

    % Zones Volume
    ZoneTable=zeros(2,B.nZones+2);
    ZoneTable(1,1)= P.FlowPrc{4};
    ZoneTable(1,2)= P.FlowSamples{4};
    ZoneTable(1,3:end)=P.ZonesVolume;
    % Zones Temperature
    ZoneTable(2,1)= P.FlowPrc{5};
    ZoneTable(2,2)= P.FlowSamples{5};
    ZoneTable(2,3:end)=P.ZoneTemperature;
    set(handles.ZoneTable,'data',ZoneTable);

    % Methods
    Methodgrid=0;
    Methodrandom=0;
    switch lower(P.Method)
        case 'grid'
            Methodgrid=1;
        case 'random'
            Methodrandom=1;
    end
    set(handles.Methodgrid,'Value',Methodgrid);
    set(handles.Methodrandom,'Value',Methodrandom);


function SourceGenerationRate_Callback(hObject, eventdata, handles)
% hObject    handle to SourceGenerationRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SourceGenerationRate as text
%        str2double(get(hObject,'String')) returns contents of SourceGenerationRate as a double


% --- Executes during object creation, after setting all properties.
function SourceGenerationRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SourceGenerationRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SourceDuration_Callback(hObject, eventdata, handles)
% hObject    handle to SourceDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SourceDuration as text
%        str2double(get(hObject,'String')) returns contents of SourceDuration as a double


% --- Executes during object creation, after setting all properties.
function SourceDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SourceDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SourceGenerationRatePrc_Callback(hObject, eventdata, handles)
% hObject    handle to SourceGenerationRatePrc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SourceGenerationRatePrc as text
%        str2double(get(hObject,'String')) returns contents of SourceGenerationRatePrc as a double


% --- Executes during object creation, after setting all properties.
function SourceGenerationRatePrc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SourceGenerationRatePrc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SourceGenerationRateSamples_Callback(hObject, eventdata, handles)
% hObject    handle to SourceGenerationRateSamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SourceGenerationRateSamples as text
%        str2double(get(hObject,'String')) returns contents of SourceGenerationRateSamples as a double


% --- Executes during object creation, after setting all properties.
function SourceGenerationRateSamples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SourceGenerationRateSamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function SimulationTime_Callback(hObject, eventdata, handles)
% hObject    handle to SimulationTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SimulationTime as text
%        str2double(get(hObject,'String')) returns contents of SimulationTime as a double


% --- Executes during object creation, after setting all properties.
function SimulationTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SimulationTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TimeStep_Callback(hObject, eventdata, handles)
% hObject    handle to TimeStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TimeStep as text
%        str2double(get(hObject,'String')) returns contents of TimeStep as a double


% --- Executes during object creation, after setting all properties.
function TimeStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TimeStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Methodgrid.
function Methodgrid_Callback(hObject, eventdata, handles)
% hObject    handle to Methodgrid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Methodgrid


% --- Executes on button press in Methodrandom.
function Methodrandom_Callback(hObject, eventdata, handles)
% hObject    handle to Methodrandom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Methodrandom



function SourceDurationSamples_Callback(hObject, eventdata, handles)
% hObject    handle to SourceDurationSamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SourceDurationSamples as text
%        str2double(get(hObject,'String')) returns contents of SourceDurationSamples as a double


% --- Executes during object creation, after setting all properties.
function SourceDurationSamples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SourceDurationSamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SourceDurationPrc_Callback(hObject, eventdata, handles)
% hObject    handle to SourceDurationPrc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SourceDurationPrc as text
%        str2double(get(hObject,'String')) returns contents of SourceDurationPrc as a double


% --- Executes during object creation, after setting all properties.
function SourceDurationPrc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SourceDurationPrc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WindDirectionSamples_Callback(hObject, eventdata, handles)
% hObject    handle to WindDirectionSamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WindDirectionSamples as text
%        str2double(get(hObject,'String')) returns contents of WindDirectionSamples as a double


% --- Executes during object creation, after setting all properties.
function WindDirectionSamples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WindDirectionSamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WindDirection_Callback(hObject, eventdata, handles)
% hObject    handle to WindDirection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WindDirection as text
%        str2double(get(hObject,'String')) returns contents of WindDirection as a double


% --- Executes during object creation, after setting all properties.
function WindDirection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WindDirection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Create.
function Create_Callback(hObject, eventdata, handles)
% hObject    handle to Create (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    errorCode = CheckForError(handles);
    if errorCode
        return;
    end

    P=CreateScenarios(handles);
    B=handles.B;

    [file0,pathname] = uiputfile([pwd,'\SPLACE\RESULTS\','*.0']);
    if isnumeric(file0)
        file0=[];
    end
    if ~isempty((file0))
        % Update handles structure
        guidata(hObject, handles);

        save([pathname,file0],'P','B','-mat');
        save([pwd,'\SPLACE\RESULTS\','File0.File'],'file0','-mat');
        save([pwd,'\SPLACE\RESULTS\','pathname.File'],'pathname','-mat');
        if exist([file0(1:end-2),'.w'],'file')==2
            delete([file0(1:end-2),'.w']);
        end
        set(handles.figure1,'Visible','off');
        msg=['Created Scenarios File: "',file0,'"'];
        msgbox(msg);
    end

function errorCode = CheckForError(handles)
    errorCode=0;

    TimeStep=str2num(get(handles.TimeStep, 'String'));
    if ~length(TimeStep) || TimeStep<0
        msgbox('           Give Time Step', 'Error', 'modal')
        errorCode=1;
        return
    end

    % contaminant
    SourceGenerationRate=str2num(get(handles.SourceGenerationRate, 'String'));
    if ~length(SourceGenerationRate) || SourceGenerationRate<0
        msgbox('Give Source Generation Rate', 'Error', 'modal')
        errorCode=1;
        return
    end

    SourceDuration=str2num(get(handles.SourceDuration,'String'));
    if ~length(SourceDuration) || SourceDuration<0
        msgbox('       Give Source Duration', 'Error', 'modal')
        errorCode=1;
        return
    end
    
    SimulationTime=str2num(get(handles.SimulationTime, 'String'));
    if  ~length(SimulationTime) || SimulationTime<0 || SimulationTime-SourceDuration<=0
        msgbox('        Give Simulation Time', 'Error', 'modal')
        errorCode=1;
        return
    end
    
    PathOpenings=str2num(get(handles.PathOpenings, 'String'));
    if  ~length(PathOpenings) || PathOpenings<0 || PathOpenings>100
        msgbox('         Give Path Openings', 'Error', 'modal')
        errorCode=1;
        return
    end

    % variance
    SourceGenerationRatePrc=(str2double(get(handles.SourceGenerationRatePrc,'String')));
    if isnan(SourceGenerationRatePrc) || SourceGenerationRatePrc<0
        msgbox('Give variance of Generation Rate', 'Error', 'modal')
        errorCode=1;
        return
    end

    WindDirectionPrc=(str2double(get(handles.WindDirectionPrc,'String')));
    if isnan(WindDirectionPrc) || WindDirectionPrc<0
        msgbox('Give variance of Wind Direction', 'Error', 'modal')
        errorCode=1;
        return
    end

    WindSpeedPrc=(str2double(get(handles.WindSpeedPrc,'String')));
    if isnan(WindSpeedPrc) || WindSpeedPrc<0
        msgbox('Give variance of Wind Speed', 'Error', 'modal')
        errorCode=1;
        return
    end
    
    PathOpeningsPrc=(str2double(get(handles.PathOpeningsPrc,'String')));
    if isnan(PathOpeningsPrc) || PathOpeningsPrc<0
        msgbox('Give variance of Path Openings', 'Error', 'modal')
        errorCode=1;
        return
    end
    
    SourceDurationPrc=(str2double(get(handles.SourceDurationPrc,'String')));
    if isnan(SourceDurationPrc) || SourceDurationPrc<0
        msgbox('   Give variance of Duration', 'Error', 'modal')
        errorCode=1;
        return
    end

    AmbientTemperaturePrc=(str2double(get(handles.AmbientTemperaturePrc,'String')));
    if isnan(AmbientTemperaturePrc) || AmbientTemperaturePrc<0
        msgbox('Give variance of Ambient Temperature', 'Error', 'modal')
        errorCode=1;
        return
    end

    % affecting flows
    WindDirection=(str2double(get(handles.WindDirection, 'String')));
    if isnan(WindDirection) || WindDirection<0 || WindDirection>360
        msgbox('        Give Wind Direction', 'Error', 'modal')
        errorCode=1;
        return
    end

    WindSpeed=(str2double(get(handles.WindSpeed, 'String')));
    if isnan(WindSpeed) || WindSpeed<0
        msgbox('         Give Wind Speed', 'Error', 'modal')
        errorCode=1;
        return
    end

    AmbientTemperature=(str2double(get(handles.AmbientTemperature, 'String')));
    if isnan(AmbientTemperature) || AmbientTemperature<0
        msgbox('   Give Ambient Temperature', 'Error', 'modal')
        errorCode=1;
        return
    end

    % samples
    AmbientTemperatureSamples=str2num(char(get(handles.AmbientTemperatureSamples, 'String')));
    if ~length(AmbientTemperatureSamples) || AmbientTemperatureSamples<0
        msgbox('Give Samples of Ambient Temperature', 'Error', 'modal')
        errorCode=1;
        return
    end
    
    PathOpeningsSamples=str2num(char(get(handles.PathOpeningsSamples, 'String')));
    if ~length(PathOpeningsSamples) || PathOpeningsSamples<0
        msgbox('Give Samples of Path Openings', 'Error', 'modal')
        errorCode=1;
        return
    end 
    
    SourceGenerationRateSamples=str2num(char(get(handles.SourceGenerationRateSamples, 'String')));
    if ~length(SourceGenerationRateSamples) || SourceGenerationRateSamples<0
        msgbox('Give Samples of Generation Rate', 'Error', 'modal')
        errorCode=1;
        return
    end

    SourceDurationSamples=str2num(char(get(handles.SourceDurationSamples, 'String')));
    if ~length(SourceDurationSamples) || SourceDurationSamples<0
        msgbox('    Give Samples of Duration', 'Error', 'modal')
        errorCode=1;
        return
    end

    WindDirectionSamples=str2num(char(get(handles.WindDirectionSamples, 'String')));
    if ~length(WindDirectionSamples) || WindDirectionSamples<0
        msgbox('Give Samples of Wind Direction', 'Error', 'modal')
        errorCode=1;
        return
    end

    WindSpeedSamples=str2num(char(get(handles.WindSpeedSamples, 'String')));
    if ~length(WindSpeedSamples) || WindSpeedSamples<0
        msgbox('Give Samples of Wind Speed', 'Error', 'modal')
        errorCode=1;
        return
    end

    % methods
    grid=get(handles.Methodgrid, 'Value');
    random=get(handles.Methodrandom, 'Value');
    if  grid && random || ~grid && ~random
        msgbox('          Select one Method', 'Error', 'modal')
        errorCode=1;
        return
    end


% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    load([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');

    [file0,pathname] = uigetfile([pathname,'*.0'],'Select the MATLAB *.0 file');
    
    if isnumeric(file0)
        file0=[];
    end
    if ~isempty((file0))
        load(file0,'-mat');

        if strcmp(handles.B.filename,B.filename)
            SetGuiParameters(P,B,handles);
        else
            msgbox('  Scenarios are not on this project file','Error','modal');
        end
    end
    save([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');


% --- Executes when entered data in editable cell(s) in ZoneTable.
function ZoneTable_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to ZoneTable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

    ZoneTable = get(handles.ZoneTable,'data');

    row = eventdata.Indices(1);
    col = eventdata.Indices(2);
    edit = eventdata.EditData;
    previous = eventdata.PreviousData;
    new = eventdata.NewData;

    edit = str2num(edit);
    d = length(edit);

    % Column1 %
    if d==1 && col==1 && edit>-1
        ZoneTable(row,col)= new;
        set(handles.ZoneTable,'data',ZoneTable);
    elseif col==1
        ZoneTable(row,col)=previous;
        set(handles.ZoneTable,'data',ZoneTable);
    end

    % Column2 Samples
    if d==1 && col==2 && edit>0
        ZoneTable(row,col)= new;
        set(handles.ZoneTable,'data',ZoneTable);
    elseif col==2
        ZoneTable(row,col)=previous;
        set(handles.ZoneTable,'data',ZoneTable);
    end

    % Column3...ColumnN Zones
    if d==1 && col>2 && edit>-1
        ZoneTable(row,col)= new;
        set(handles.ZoneTable,'data',ZoneTable);
    elseif col>2
        ZoneTable(row,col)=previous;
        set(handles.ZoneTable,'data',ZoneTable);
    end


% --- Executes on selection change in SourcesMax.
function SourcesMax_Callback(hObject, eventdata, handles)
% hObject    handle to SourcesMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SourcesMax contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SourcesMax


% --- Executes during object creation, after setting all properties.
function SourcesMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SourcesMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in releaseLocation.
function releaseLocation_Callback(hObject, eventdata, handles)
% hObject    handle to releaseLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    for i=1:handles.B.CountNodes
        data{i,1} = handles.B.NodeNameID{i};
        data{i,2}= handles.release(i);
    end

    SomeDataShared=releaseLocation(handles.B,data);

    for i=1:handles.B.CountNodes
        handles.release(i)=SomeDataShared{i,2} ;
    end
    guidata(hObject, handles);



function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stop as text
%        str2double(get(hObject,'String')) returns contents of stop as a double


% --- Executes during object creation, after setting all properties.
function stop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of start as text
%        str2double(get(hObject,'String')) returns contents of start as a double


% --- Executes during object creation, after setting all properties.
function start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in defaultbutton.
function defaultbutton_Callback(hObject, eventdata, handles)
% hObject    handle to defaultbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    P=DefaultParameters(handles);
    handles.P=P;
    % Update handles structure
    guidata(hObject, handles);

    SetGuiParameters(P,handles.B,handles);


function WindDirectionPrc_Callback(hObject, eventdata, handles)
% hObject    handle to WindDirectionPrc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WindDirectionPrc as text
%        str2double(get(hObject,'String')) returns contents of WindDirectionPrc as a double


% --- Executes during object creation, after setting all properties.
function WindDirectionPrc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WindDirectionPrc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WindSpeed_Callback(hObject, eventdata, handles)
% hObject    handle to WindSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WindSpeed as text
%        str2double(get(hObject,'String')) returns contents of WindSpeed as a double


% --- Executes during object creation, after setting all properties.
function WindSpeed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WindSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WindSpeedSamples_Callback(hObject, eventdata, handles)
% hObject    handle to WindSpeedSamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WindSpeedSamples as text
%        str2double(get(hObject,'String')) returns contents of WindSpeedSamples as a double


% --- Executes during object creation, after setting all properties.
function WindSpeedSamples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WindSpeedSamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WindSpeedPrc_Callback(hObject, eventdata, handles)
% hObject    handle to WindSpeedPrc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WindSpeedPrc as text
%        str2double(get(hObject,'String')) returns contents of WindSpeedPrc as a double


% --- Executes during object creation, after setting all properties.
function WindSpeedPrc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WindSpeedPrc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AmbientTemperature_Callback(hObject, eventdata, handles)
% hObject    handle to AmbientTemperature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmbientTemperature as text
%        str2double(get(hObject,'String')) returns contents of AmbientTemperature as a double


% --- Executes during object creation, after setting all properties.
function AmbientTemperature_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmbientTemperature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AmbientTemperatureSamples_Callback(hObject, eventdata, handles)
% hObject    handle to AmbientTemperatureSamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmbientTemperatureSamples as text
%        str2double(get(hObject,'String')) returns contents of AmbientTemperatureSamples as a double


% --- Executes during object creation, after setting all properties.
function AmbientTemperatureSamples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmbientTemperatureSamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AmbientTemperaturePrc_Callback(hObject, eventdata, handles)
% hObject    handle to AmbientTemperaturePrc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmbientTemperaturePrc as text
%        str2double(get(hObject,'String')) returns contents of AmbientTemperaturePrc as a double


% --- Executes during object creation, after setting all properties.
function AmbientTemperaturePrc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmbientTemperaturePrc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PathOpenings_Callback(hObject, eventdata, handles)
% hObject    handle to PathOpenings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PathOpenings as text
%        str2double(get(hObject,'String')) returns contents of PathOpenings as a double


% --- Executes during object creation, after setting all properties.
function PathOpenings_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PathOpenings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PathOpeningsSamples_Callback(hObject, eventdata, handles)
% hObject    handle to PathOpeningsSamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PathOpeningsSamples as text
%        str2double(get(hObject,'String')) returns contents of PathOpeningsSamples as a double


% --- Executes during object creation, after setting all properties.
function PathOpeningsSamples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PathOpeningsSamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PathOpeningsPrc_Callback(hObject, eventdata, handles)
% hObject    handle to PathOpeningsPrc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PathOpeningsPrc as text
%        str2double(get(hObject,'String')) returns contents of PathOpeningsPrc as a double


% --- Executes during object creation, after setting all properties.
function PathOpeningsPrc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PathOpeningsPrc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
