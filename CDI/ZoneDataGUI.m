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
function varargout = ZoneDataGUI(varargin)
% ZONEDATAGUI MATLAB code for ZoneDataGUI.fig
%      ZONEDATAGUI, by itself, creates a new ZONEDATAGUI or raises the existing
%      singleton*.
%
%      H = ZONEDATAGUI returns the handle to a new ZONEDATAGUI or the handle to
%      the existing singleton*.
%
%      ZONEDATAGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ZONEDATAGUI.M with the given input arguments.
%
%      ZONEDATAGUI('Property','Value',...) creates a new ZONEDATAGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ZoneDataGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ZoneDataGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ZoneDataGUI

% Last Modified by GUIDE v2.5 16-Jun-2014 18:33:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ZoneDataGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ZoneDataGUI_OutputFcn, ...
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


% --- Executes just before ZoneDataGUI is made visible.
function ZoneDataGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ZoneDataGUI (see VARARGIN)

% Choose default command line output for ZoneDataGUI
handles.output = hObject;
handles.B = varargin{1};
B = handles.B;

for i=1:B.nZones
    data{i,1} = B.ZoneName{i};
    data{i,2} = B.v(i);
    data{i,3} = B.Temp(i);
    data{i,4}=B.x0(i);
end

set(handles.uitable1, 'Data', data);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ZoneDataGUI wait for user response (see UIRESUME)
% uiwait(handles.ZoneDataGUI);
uiwait

% --- Outputs from this function are returned to the command line.
function varargout = ZoneDataGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
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


for i=1:B.nZones
    B.ZoneName{i}= data{i,1} ;
    B.v(i) = data{i,2} ;
    B.Temp(i) = data{i,3};
    B.x0(i)= data{i,4} ;
end

B.V=diag(B.v); % create a diagonal matrix with the zone volumes

% To find the inverse matrix of zone volumes
b1= zeros(B.nZones);
for i=1:B.nZones
  if B.V(i,i)~=0;
    b1(i,i)= 1/B.V(i,i);
  else
    b1(i,i)= B.V(i,i);
  end
end
B.B=b1; % inverse matrix of zone volumes B-matrix

handles.B = B;

% Update handles structure
guidata(hObject, handles);

uiresume

% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiresume

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


% --- Executes when user attempts to close ZoneDataGUI.
function ZoneDataGUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to ZoneDataGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
uiresume
