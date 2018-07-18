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
function varargout = SelectZones(varargin)
% SELECTZONES MATLAB code for SelectZones.fig
%      SELECTZONES, by itself, creates a new SELECTZONES or raises the existing
%      singleton*.
%
%      H = SELECTZONES returns the handle to a new SELECTZONES or the handle to
%      the existing singleton*.
%
%      SELECTZONES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SELECTZONES.M with the given input arguments.
%
%      SELECTZONES('Property','Value',...) creates a new SELECTZONES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SelectZones_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SelectZones_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SelectZones

% Last Modified by GUIDE v2.5 05-Nov-2014 13:12:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SelectZones_OpeningFcn, ...
                   'gui_OutputFcn',  @SelectZones_OutputFcn, ...
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


% --- Executes just before SelectZones is made visible.
function SelectZones_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SelectZones (see VARARGIN)
if strcmp(hObject.Visible,'off')
    hObject.Visible='on';
end
% Choose default command line output for SelectZones
handles.output = hObject;

if isfield(varargin{1}, 'Subsystems')
    set(handles.SelectZones, 'Name', 'Select Subsystems');
end

handles.ZoneName = varargin{1}.ZoneName;
handles.chooseZone = varargin{1}.chooseZone;

    
for i=1:length(handles.ZoneName)
    data{i,1} = handles.ZoneName{i};
    if handles.chooseZone(i)
        data{i,2}= true;
    else
        data{i,2}= false;
    end
end

if length(find(handles.chooseZone)) == length(handles.chooseZone)
    set(handles.SelectAllCheck, 'Value', 1);
end

set(handles.uitable1, 'Data', data);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SelectZones wait for user response (see UIRESUME)
% uiwait(handles.SelectZones);
uiwait


% --- Outputs from this function are returned to the command line.
function varargout = SelectZones_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
varargout{2}.chooseZone = handles.chooseZone;
delete(hObject);


% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=get(handles.uitable1, 'Data');

for i=1:length(handles.ZoneName)
    handles.chooseZone(i)=data{i,2} ;
end
guidata(hObject, handles);

uiresume


% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume

% --- Executes on button press in SelectAllCheck.
function SelectAllCheck_Callback(hObject, eventdata, handles)
% hObject    handle to SelectAllCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SelectAllCheck

%     s = size(data);
    check=get(handles.SelectAllCheck,'Value');
       
    if check
        for i=1:length(handles.ZoneName)
            data{i,1} = handles.ZoneName{i};
            data{i,2}= true;
        end
    else
        for i=1:length(handles.ZoneName)
            data{i,1} = handles.ZoneName{i};
            data{i,2}= false;
        end
    end

    set(handles.uitable1, 'Data', data);

guidata(hObject, handles);


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

data=get(handles.uitable1, 'Data');
for i=1:length(handles.ZoneName)
    handles.chooseZone(i)=data{i,2} ;
end


if length(find(handles.chooseZone)) == length(handles.chooseZone)
    set(handles.SelectAllCheck, 'Value', 1);
else
    set(handles.SelectAllCheck, 'Value', 0);
end


% --- Executes when user attempts to close SelectZones.
function SelectZones_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to SelectZones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
uiresume
