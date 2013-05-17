function varargout = change_path(varargin)
% FIGURE MATLAB code for figure.fig
%      FIGURE, by itself, creates a new FIGURE or raises the existing
%      singleton*.
%
%      H = FIGURE returns the handle to a new FIGURE or the handle to
%      the existing singleton*.
%
%      FIGURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIGURE.M with the given input arguments.
%
%      FIGURE('Property','Value',...) creates a new FIGURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before change_path_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to change_path_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help figure

% Last Modified by GUIDE v2.5 17-Apr-2013 15:36:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @change_path_OpeningFcn, ...
                   'gui_OutputFcn',  @change_path_OutputFcn, ...
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


% --- Executes just before figure is made visible.
function change_path_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to figure (see VARARGIN)


% Choose default command line output for figure
handles.output = hObject;

%When you want to edit shared data you must get the handle
HandleMainGUI=getappdata(0,'HandleMainGUI');
%get SharedData and save it to a local variable called SomeDataShared
SomeDataShared=getappdata(HandleMainGUI,'SharedData'); 
set(handles.uitable1, 'Data', SomeDataShared);

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = change_path_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
 varargout{1} = handles.output;
% varargout{1} = handles.opn;


% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)

data= get(handles.uitable1, 'Data');
%When you want to edit shared data you must get the handle
HandleMainGUI=getappdata(0,'HandleMainGUI');
%write a local variable called MyData to SharedData, any type of data
setappdata(HandleMainGUI,'SharedData', data); 
close


% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)

close

% --- Executes when user attempts to close figure.
function figure_CloseRequestFcn(hObject, eventdata, handles)

delete(hObject)

% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
