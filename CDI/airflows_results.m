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

function varargout = airflows_results(varargin)
% AIRFLOWS_RESULTS MATLAB code for airflows_results.fig
%      AIRFLOWS_RESULTS, by itself, creates a new AIRFLOWS_RESULTS or raises the existing
%      singleton*.
%
%      H = AIRFLOWS_RESULTS returns the handle to a new AIRFLOWS_RESULTS or the handle to
%      the existing singleton*.
%
%      AIRFLOWS_RESULTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AIRFLOWS_RESULTS.M with the given input arguments.
%
%      AIRFLOWS_RESULTS('Property','Value',...) creates a new AIRFLOWS_RESULTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before airflows_results_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to airflows_results_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help airflows_results

% Last Modified by GUIDE v2.5 03-May-2013 17:55:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @airflows_results_OpeningFcn, ...
                   'gui_OutputFcn',  @airflows_results_OutputFcn, ...
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


% --- Executes just before airflows_results is made visible.
function airflows_results_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to airflows_results (see VARARGIN)

% Choose default command line output for airflows_results
handles.output = hObject;
%When you want to edit shared data you must get the handle
HandleMainGUI=getappdata(0,'HandleMainGUI');
%get SharedData and save it to a local variable called SomeDataShared
SomeDataShared=getappdata(HandleMainGUI,'SharedData');

set(handles.uitable1, 'Data', SomeDataShared);
% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = airflows_results_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)

close

% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
