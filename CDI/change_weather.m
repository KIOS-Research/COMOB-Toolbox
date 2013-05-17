function varargout = change_weather(varargin)
% CHANGE_WEATHER MATLAB code for change_weather.fig
%      CHANGE_WEATHER, by itself, creates a new CHANGE_WEATHER or raises the existing
%      singleton*.
%
%      H = CHANGE_WEATHER returns the handle to a new CHANGE_WEATHER or the handle to
%      the existing singleton*.
%
%      CHANGE_WEATHER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHANGE_WEATHER.M with the given input arguments.
%
%      CHANGE_WEATHER('Property','Value',...) creates a new CHANGE_WEATHER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before change_weather_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to change_weather_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help change_weather

% Last Modified by GUIDE v2.5 19-Apr-2013 12:34:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @change_weather_OpeningFcn, ...
                   'gui_OutputFcn',  @change_weather_OutputFcn, ...
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


% --- Executes just before change_weather is made visible.
function change_weather_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to change_weather (see VARARGIN)

% Choose default command line output for change_weather
handles.output = hObject;

%When you want to edit shared data you must get the handle
HandleMainGUI=getappdata(0,'HandleMainGUI');
%get SharedData and save it to a local variable called SomeDataShared
SomeDataShared=getappdata(HandleMainGUI,'SharedData'); 
set(handles.edit1, 'String', num2str(SomeDataShared(3)) );
set(handles.edit2, 'String', num2str(SomeDataShared(2)) );
set(handles.edit3, 'String', num2str(SomeDataShared(1)) );
set(handles.edit4, 'String', num2str(SomeDataShared(4)) );
set(handles.edit5, 'String', num2str(SomeDataShared(5)) );
% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = change_weather_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)

% Msg Error 
if  isempty(get(handles.edit3, 'String'))
    msgbox('Give Ampient Temperature', 'Error', 'error')
    return
end

if  isempty(get(handles.edit1, 'String'))
    msgbox('Give Absolute Presure', 'Error', 'error')
    return
end

if  isempty(get(handles.edit2, 'String'))
    msgbox('Give Wind Direction', 'Error', 'error')
    return
end

if  isempty(get(handles.edit4, 'String'))
    msgbox('Give Wind Speed', 'Error', 'error')
    return
end

if  isempty(get(handles.edit5, 'String'))
    msgbox('Give Ambient Contaminant', 'Error', 'error')
    return
end

if (str2double(get(handles.edit2, 'String'))<0)|| (str2double(get(handles.edit2, 'String'))>360)
    msgbox('Wind Direction must be 0-360 deg', 'Error', 'error')
    return
end

if (str2double(get(handles.edit4, 'String'))<0)
    msgbox('Wind Speed must be Positive', 'Error', 'error')
    return
end

if (str2double(get(handles.edit4, 'String'))<0)
    msgbox('Ambient Contaminant must be Positive', 'Error', 'error')
    return
end

data(1)=str2num(get(handles.edit3, 'String'));
data(2)=str2num(get(handles.edit2, 'String'));
data(3)=str2num(get(handles.edit1, 'String'));
data(4)=str2num(get(handles.edit4, 'String'));
data(5)=str2num(get(handles.edit5, 'String'));

HandleMainGUI=getappdata(0,'HandleMainGUI');
setappdata(HandleMainGUI,'SharedData', data);
close

% --- Executes on button press in cancel.
function cancel_Callback(hObject, eventdata, handles)

close


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)

delete(hObject);



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
