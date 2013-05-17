function varargout = releaseLocation(varargin)
% RELEASELOCATION MATLAB code for releaseLocation.fig
%      RELEASELOCATION, by itself, creates a new RELEASELOCATION or raises the existing
%      singleton*.
%
%      H = RELEASELOCATION returns the handle to a new RELEASELOCATION or the handle to
%      the existing singleton*.
%
%      RELEASELOCATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RELEASELOCATION.M with the given input arguments.
%
%      RELEASELOCATION('Property','Value',...) creates a new RELEASELOCATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before releaseLocation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to releaseLocation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help releaseLocation

% Last Modified by GUIDE v2.5 23-Apr-2013 20:24:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @releaseLocation_OpeningFcn, ...
                   'gui_OutputFcn',  @releaseLocation_OutputFcn, ...
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


% --- Executes just before releaseLocation is made visible.
function releaseLocation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to releaseLocation (see VARARGIN)

% Choose default command line output for releaseLocation
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes releaseLocation wait for user response (see UIRESUME)
% uiwait(handles.figure1);

set(handles.figure1,'name','Release Location');
% set(handles.figure1,'Position',[75 15 124.6 33.54]);

%When you want to edit shared data you must get the handle
HandleMainGUI=getappdata(0,'HandleMainGUI');
%get SharedData and save it to a local variable called SomeDataShared
SomeDataShared=getappdata(HandleMainGUI,'SharedData');

for i=1:length(SomeDataShared)
    data{i,1} = SomeDataShared{i,1};
    if SomeDataShared{i,2}
        data{i,2}= true;
    else
        data{i,2}= false;
    end
end

set(handles.uitable1, 'Data', data);

if ~isempty(varargin)
    handles.B = varargin{1};
end
% Update handles structure
guidata(hObject, handles);


% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = releaseLocation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in okbutton.
function okbutton_Callback(hObject, eventdata, handles)
% hObject    handle to okbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=get(handles.uitable1, 'Data');

HandleMainGUI=getappdata(0,'HandleMainGUI');
setappdata(HandleMainGUI,'SharedData', data);
close

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close;

% --- Executes on button press in selectAll.
function selectAll_Callback(hObject, eventdata, handles)
% hObject    handle to selectAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of selectAll

check=get(handles.selectAll,'Value');

if check
    handles.release(1:handles.B.CountNodes)={true};
else
    handles.release(1:handles.B.CountNodes)={false};
end

for i=1:handles.B.CountNodes
    data{i,1} = handles.B.NodeNameID{i};
    data{i,2}= handles.release{i};
end
set(handles.uitable1, 'Data', data);
handles.data=data;
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in SelectNone.
function SelectNone_Callback(hObject, eventdata, handles)
% hObject    handle to SelectNone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SelectNone


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
