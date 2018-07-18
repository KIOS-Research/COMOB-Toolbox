function varargout = SimulationDataGUI(varargin)
% SIMULATIONDATAGUI MATLAB code for SimulationDataGUI.fig
%      SIMULATIONDATAGUI, by itself, creates a new SIMULATIONDATAGUI or raises the existing
%      singleton*.
%
%      H = SIMULATIONDATAGUI returns the handle to a new SIMULATIONDATAGUI or the handle to
%      the existing singleton*.
%
%      SIMULATIONDATAGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMULATIONDATAGUI.M with the given input arguments.
%
%      SIMULATIONDATAGUI('Property','Value',...) creates a new SIMULATIONDATAGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SimulationDataGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SimulationDataGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SimulationDataGUI

% Last Modified by GUIDE v2.5 11-Feb-2015 14:25:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SimulationDataGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @SimulationDataGUI_OutputFcn, ...
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


% --- Executes just before SimulationDataGUI is made visible.
function SimulationDataGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SimulationDataGUI (see VARARGIN)

% Choose default command line output for SimulationDataGUI
handles.output = hObject;
handles.Sim = varargin{1}.Sim;
handles.Sim0 = varargin{1}.Sim; % for Cancel button
handles.B = varargin{1}.B;

set(handles.SensorMeasurmentsCheck, 'Value', handles.Sim.Concentrations)

if handles.Sim.ResultsType == 2
    set(handles.ContaminantDetectionEstimatorCheck, 'enable', 'on',...
                                                    'value', handles.Sim.CDE);
    set(handles.ContaminantIsolationDecisionCheck, 'enable', 'on',...
                                                   'value', handles.Sim.CID); 
                                               
    if isfield(handles.Sim, 'Subsystems')
        set(handles.SelectSubsystems, 'enable', 'on')
    else
        set(handles.SelectSubsystems, 'enable', 'off')
    end
else
        
    set(handles.ContaminantDetectionEstimatorCheck, 'enable', 'off')
    set(handles.ContaminantIsolationDecisionCheck, 'enable', 'off')
    set(handles.SelectSubsystems, 'enable', 'off')                                                
    
end
 

% Update handles structure
guidata(hObject, handles);
uiwait
% UIWAIT makes SimulationDataGUI wait for user response (see UIRESUME)
% uiwait(handles.SimulationDataGUI);


% --- Outputs from this function are returned to the command line.
function varargout = SimulationDataGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
varargout{2}.Sim = handles.Sim;
delete(hObject)

% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume

% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Sim = handles.Sim0;

% Update handles structure
guidata(hObject, handles);

uiresume

% --- Executes on button press in SensorMeasurmentsCheck.
function SensorMeasurmentsCheck_Callback(hObject, eventdata, handles)
% hObject    handle to SensorMeasurmentsCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SensorMeasurmentsCheck

handles.Sim.Concentrations = get(handles.SensorMeasurmentsCheck, 'value');

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in ContaminantDetectionEstimatorCheck.
function ContaminantDetectionEstimatorCheck_Callback(hObject, eventdata, handles)
% hObject    handle to ContaminantDetectionEstimatorCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ContaminantDetectionEstimatorCheck

handles.Sim.CDE = get(handles.ContaminantDetectionEstimatorCheck, 'value');

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in ContaminantIsolationDecisionCheck.
function ContaminantIsolationDecisionCheck_Callback(hObject, eventdata, handles)
% hObject    handle to ContaminantIsolationDecisionCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ContaminantIsolationDecisionCheck

handles.Sim.CID = get(handles.ContaminantIsolationDecisionCheck, 'value');

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in SelectSensors.
function SelectSensors_Callback(hObject, eventdata, handles)
% hObject    handle to SelectSensors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

for i = 1:length(handles.B.Sensors)
    arguments.ZoneName{i} = handles.B.ZoneName{handles.B.Sensors(i)};
end

arguments.chooseZone  = handles.Sim.Sensors;

[A B]= SelectZones(arguments);

handles.Sim.Sensors = B.chooseZone;

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in SelectSubsystems.
function SelectSubsystems_Callback(hObject, eventdata, handles)
% hObject    handle to SelectSubsystems (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

for i = 1:length(handles.Sim.Subsystems)
    arguments.ZoneName{i} = ['Subsystem ', num2str(i)];
end

arguments.chooseZone  = handles.Sim.Subsystems;
arguments.Subsystems = 1;

[A B]= SelectZones(arguments);

handles.Sim.Subsystems = B.chooseZone;

% Update handles structure
guidata(hObject, handles);

% --- Executes when user attempts to close SimulationDataGUI.
function SimulationDataGUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to SimulationDataGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

handles.Sim = handles.Sim0;

% Update handles structure
guidata(hObject, handles);

uiresume
