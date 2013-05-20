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

function varargout = change_release(varargin)
% CHANGE_RELEASE MATLAB code for change_release.fig
%      CHANGE_RELEASE, by itself, creates a new CHANGE_RELEASE or raises the existing
%      singleton*.
%
%      H = CHANGE_RELEASE returns the handle to a new CHANGE_RELEASE or the handle to
%      the existing singleton*.
%
%      CHANGE_RELEASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHANGE_RELEASE.M with the given input arguments.
%
%      CHANGE_RELEASE('Property','Value',...) creates a new CHANGE_RELEASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before change_release_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to change_release_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help change_release

% Last Modified by GUIDE v2.5 26-Apr-2013 08:57:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @change_release_OpeningFcn, ...
                   'gui_OutputFcn',  @change_release_OutputFcn, ...
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


% --- Executes just before change_release is made visible.
function change_release_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to change_release (see VARARGIN)

    % Choose default command line output for change_release
    handles.output = hObject;

    %When you want to edit shared data you must get the handle
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    %get SharedData and save it to a local variable called SomeDataShared
    SomeDataShared=getappdata(HandleMainGUI,'SharedData');
    
    s = size(SomeDataShared);
    
    for i=1:s(1)
        data{i,1} = SomeDataShared{i,1};
        if SomeDataShared{i,2}
            data{i,2}= true;
        else
            data{i,2}= false;
        end
    end

    set(handles.uitable1, 'Data', data);
    %str{1}= 'Zone ID';    
    %str{2} ='Contam. Zone';%SomeDataShared{1,3};
    %set(handles.uitable1, 'ColumnName', str);
% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = change_release_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)

data=get(handles.uitable1, 'Data');

HandleMainGUI=getappdata(0,'HandleMainGUI');
setappdata(HandleMainGUI,'SharedData', data);
close

% --- Executes on button press in cancel.
function cancel_Callback(hObject, eventdata, handles)

close


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)


% --- Executes on button press in selectAll.
function selectAll_Callback(hObject, eventdata, handles)
% hObject    handle to selectAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of selectAll

    
    HandleMainGUI=getappdata(0,'HandleMainGUI');    
    data=getappdata(HandleMainGUI,'SharedData');
    
    s = size(data);
    check=get(handles.selectAll,'Value');
       
    if check
        for i=1:s(1)
            data2{i,1} = data{i,1};
            data2{i,2}= true;
        end
    else
        for i=1:s(1)
            data2{i,1} = data{i,1};
            data2{i,2}= false;
        end
    end

    set(handles.uitable1, 'Data', data2);

guidata(hObject, handles);
