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
function varargout = DisplayAirflowsGUI(varargin)
% DISPLAYAIRFLOWSGUI MATLAB code for DisplayAirflowsGUI.fig
%      DISPLAYAIRFLOWSGUI, by itself, creates a new DISPLAYAIRFLOWSGUI or raises the existing
%      singleton*.
%
%      H = DISPLAYAIRFLOWSGUI returns the handle to a new DISPLAYAIRFLOWSGUI or the handle to
%      the existing singleton*.
%
%      DISPLAYAIRFLOWSGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISPLAYAIRFLOWSGUI.M with the given input arguments.
%
%      DISPLAYAIRFLOWSGUI('Property','Value',...) creates a new DISPLAYAIRFLOWSGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DisplayAirflowsGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DisplayAirflowsGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DisplayAirflowsGUI

% Last Modified by GUIDE v2.5 05-Nov-2014 15:30:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DisplayAirflowsGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @DisplayAirflowsGUI_OutputFcn, ...
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


% --- Executes just before DisplayAirflowsGUI is made visible.
function DisplayAirflowsGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DisplayAirflowsGUI (see VARARGIN)

% Choose default command line output for DisplayAirflowsGUI
handles.output = hObject;

handles.B = varargin{1}.B;
handles.Flows = varargin{1}.Flows;

for i=3:(length(handles.B.X.AirflowPaths)-1)
    out = textscan(handles.B.X.AirflowPaths{i},'%s','delimiter',' ','multipleDelimsAsOne',1);
    pzn(i-2)=str2double(out{1}{3});
    pzm(i-2)=str2double(out{1}{4});
end

for i=1:handles.B.nPaths
    data{i,1}=handles.B.opn{i,1}; 
    if pzn(i)==-1
        data{i,2} =['Ambient  ---> ', num2str(pzm(i)),'.',handles.B.ZoneName{pzm(i)}];
    elseif pzm(i)==-1
        data{i,2} =[num2str(pzn(i)),'.',handles.B.ZoneName{pzn(i)}, '--->  Ambient'];
    else
        data{i,2} = [num2str(pzn(i)),'.',handles.B.ZoneName{pzn(i)}, '  --->  ',num2str(pzm(i)),'.', handles.B.ZoneName{pzm(i)}];
    end
    data{i,3}=handles.Flows(i);
end

set(handles.uitable1, 'Data', data);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DisplayAirflowsGUI wait for user response (see UIRESUME)
% uiwait(handles.DisplayAirflowsGUI);
uiwait

% --- Outputs from this function are returned to the command line.
function varargout = DisplayAirflowsGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
delete(hObject)


% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume

% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=get(handles.uitable1, 'Data');
uisave('data', 'Airflows')

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


% --- Executes when user attempts to close DisplayAirflowsGUI.
function DisplayAirflowsGUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to DisplayAirflowsGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
uiresume
