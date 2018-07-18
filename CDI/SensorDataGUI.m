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
function varargout = SensorDataGUI(varargin)
% SENSORDATAGUI MATLAB code for SensorDataGUI.fig
%      SENSORDATAGUI, by itself, creates a new SENSORDATAGUI or raises the existing
%      singleton*.
%
%      H = SENSORDATAGUI returns the handle to a new SENSORDATAGUI or the handle to
%      the existing singleton*.
%
%      SENSORDATAGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SENSORDATAGUI.M with the given input arguments.
%
%      SENSORDATAGUI('Property','Value',...) creates a new SENSORDATAGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SensorDataGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SensorDataGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SensorDataGUI

% Last Modified by GUIDE v2.5 16-Jun-2014 18:52:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SensorDataGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @SensorDataGUI_OutputFcn, ...
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


% --- Executes just before SensorDataGUI is made visible.
function SensorDataGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SensorDataGUI (see VARARGIN)

% Choose default command line output for SensorDataGUI
handles.output = hObject;
handles.B = varargin{1};
handles.B0 = varargin{1};
B = handles.B;

% set(handles.NoiseBound, 'String', B.Noise);
[row, col] = find(B.C);

k = 0;
for i=1:B.nZones
    data{i,1} = B.ZoneName{i};
    if find(col==i)
        data{i,2}= true;
        k = k+1;
    else
        data{i,2}= false;
    end
end


if k == B.nZones
    set(handles.SelectAllcheck,'Value',1);
end

set(handles.uitable1, 'Data', data);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SensorDataGUI wait for user response (see UIRESUME)
 uiwait(handles.SensorDataGUI);
% uiwait


% --- Outputs from this function are returned to the command line.
function varargout = SensorDataGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = getappdata(hObject,'handles.output');
varargout{1} = handles.output;
varargout{2} = handles.B;
delete(hObject);


% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
B=handles.B;
data=get(handles.uitable1, 'Data');

k = 0;
for i=1:B.nZones       
    if data{i,2} == true
       k = k + 1; 
       C(k,:)= zeros(1,B.nZones);
       C(k,i)=1;
    end
end

if k~=0
    B.C = C;
else
    B.C = 0;
end

[row, col] = find(B.C);
B.nS = length(row); % number of sensors 
B.Sensors = col; % ID of zones that include sensor
B.D = zeros(B.nS,B.nZones); % set the D-matrix for state space

%%% Disable Noice Bound Sellection
% 
% if  isempty(str2num(get(handles.NoiseBound, 'String')))
%     uiwait(msgbox('     Give A Valid Number', 'Error', 'error'))
%     return
% end

% B.Noise = str2double(get(handles.NoiseBound, 'String'));
B.Noise =0;
% if (B.Noise<0)|| (B.Noise>1)
%     uiwait(msgbox('Noise Bound must be 0-1', 'Error', 'error'))
%     return
% end

handles.B = B;
guidata(hObject, handles);
uiresume

% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.B = handles.B0;
guidata(hObject, handles);
uiresume

% --- Executes on button press in SelectAllcheck.
function SelectAllcheck_Callback(hObject, eventdata, handles)
% hObject    handle to SelectAllcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SelectAllcheck
B=handles.B;
check=get(handles.SelectAllcheck,'Value');

if check
    for i=1:B.nZones
        data{i,1}= B.ZoneName{i};
        data{i,2}= true;
    end
else
    for i=1:B.nZones
        data{i,1}= B.ZoneName{i};
        data{i,2}= false;
    end
end

set(handles.uitable1, 'Data', data);

guidata(hObject, handles);


function NoiseBound_Callback(hObject, eventdata, handles)
% hObject    handle to NoiseBound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NoiseBound as text
%        str2double(get(hObject,'String')) returns contents of NoiseBound as a double


% --- Executes during object creation, after setting all properties.
function NoiseBound_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NoiseBound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
B = handles.B;
data=get(handles.uitable1, 'Data');

k=0;
for i=1:B.nZones        
    if data{i,2} == true
       k = k + 1; 
    end
end

if k == B.nZones
    set(handles.SelectAllcheck,'Value',1);
else
    set(handles.SelectAllcheck,'Value',0);  
end

guidata(hObject, handles);


% --- Executes when user attempts to close SensorDataGUI.
function SensorDataGUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to SensorDataGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
handles.B = handles.B0;
guidata(hObject, handles);
uiresume
% delete(hObject);
