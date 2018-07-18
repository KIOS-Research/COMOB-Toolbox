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
function varargout = PathOpeningGUI(varargin)
% PATHOPENINGGUI MATLAB code for PathOpeningGUI.fig
%      PATHOPENINGGUI, by itself, creates a new PATHOPENINGGUI or raises the existing
%      singleton*.
%
%      H = PATHOPENINGGUI returns the handle to a new PATHOPENINGGUI or the handle to
%      the existing singleton*.
%
%      PATHOPENINGGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PATHOPENINGGUI.M with the given input arguments.
%
%      PATHOPENINGGUI('Property','Value',...) creates a new PATHOPENINGGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PathOpeningGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PathOpeningGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PathOpeningGUI

% Last Modified by GUIDE v2.5 15-Jun-2014 21:15:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PathOpeningGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @PathOpeningGUI_OutputFcn, ...
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


% --- Executes just before PathOpeningGUI is made visible.
function PathOpeningGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PathOpeningGUI (see VARARGIN)

% Choose default command line output for PathOpeningGUI
handles.output = hObject;
handles.B = varargin{1};
B = handles.B;

set(handles.uitable1, 'Data', B.opn);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PathOpeningGUI wait for user response (see UIRESUME)
% uiwait(handles.PathOpeningGUI);
uiwait


% --- Outputs from this function are returned to the command line.
function varargout = PathOpeningGUI_OutputFcn(hObject, eventdata, handles) 
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

B = handles.B;
data= get(handles.uitable1, 'Data');

for i=1:B.nPaths
    B.opn{i,2}=data{i,2};
   switch data{i,2}
       case 'Open'
         B.Openings(i)=1;
       case 'Half Open'
         B.Openings(i)=0.5;
       case 'Close'
         B.Openings(i)=0;
    end
end

handles.B = B;
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


% --- Executes during object deletion, before destroying properties.
function PathOpeningGUI_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to PathOpeningGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume


% --- Executes when user attempts to close PathOpeningGUI.
function PathOpeningGUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to PathOpeningGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

uiresume
% delete(hObject);
