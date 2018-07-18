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
function varargout = WeatherDataGUI(varargin)
% WEATHERDATAGUI MATLAB code for WeatherDataGUI.fig
%      WEATHERDATAGUI, by itself, creates a new WEATHERDATAGUI or raises the existing
%      singleton*.
%
%      H = WEATHERDATAGUI returns the handle to a new WEATHERDATAGUI or the handle to
%      the existing singleton*.
%
%      WEATHERDATAGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WEATHERDATAGUI.M with the given input arguments.
%
%      WEATHERDATAGUI('Property','Value',...) creates a new WEATHERDATAGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WeatherDataGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WeatherDataGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WeatherDataGUI

% Last Modified by GUIDE v2.5 16-Jun-2014 18:35:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WeatherDataGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @WeatherDataGUI_OutputFcn, ...
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


% --- Executes just before WeatherDataGUI is made visible.
function WeatherDataGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WeatherDataGUI (see VARARGIN)

% Choose default command line output for WeatherDataGUI
handles.output = hObject;
handles.B = varargin{1};
B = handles.B;
set(handles.AbsolutePresureEdit, 'String', num2str(B.AmbientPressure) );
set(handles.WindDirectionEdit, 'String', num2str(B.WindDirection) );
set(handles.AmbientTemperatureEdit, 'String', num2str(B.AmbientTemperature) );
set(handles.WindSpeedEdit, 'String', num2str(B.WindSpeed) );
set(handles.AmbientContaminantEdit, 'String', num2str(B.xext) );


% Update handles structure
guidata(hObject, handles);
uiwait
% UIWAIT makes WeatherDataGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% uiresume(gcbf)


% --- Outputs from this function are returned to the command line.
function varargout = WeatherDataGUI_OutputFcn(hObject, eventdata, handles) 
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

% Msg Error 
if  isempty(get(handles.AmbientTemperatureEdit, 'String'))
    msgbox('Give Ampient Temperature', 'Error', 'error')
    return
end

if  isempty(get(handles.AbsolutePresureEdit, 'String'))
    msgbox('Give Absolute Presure', 'Error', 'error')
    return
end

if  isempty(get(handles.WindDirectionEdit, 'String'))
    msgbox('Give Wind Direction', 'Error', 'error')
    return
end

if  isempty(get(handles.WindSpeedEdit, 'String'))
    msgbox('Give Wind Speed', 'Error', 'error')
    return
end

if  isempty(get(handles.AmbientContaminantEdit, 'String'))
    msgbox('Give Ambient Contaminant', 'Error', 'error')
    return
end

if (str2double(get(handles.WindDirectionEdit, 'String'))<0)|| (str2double(get(handles.WindDirectionEdit, 'String'))>360)
    msgbox('Wind Direction must be 0-360 deg', 'Error', 'error')
    return
end

if (str2double(get(handles.WindSpeedEdit, 'String'))<0)
    msgbox('Wind Speed must be Positive', 'Error', 'error')
    return
end

if (str2double(get(handles.AmbientContaminantEdit, 'String'))<0)
    msgbox('Ambient Contaminant must be Positive', 'Error', 'error')
    return
end

B.AmbientPressure=str2num(get(handles.AbsolutePresureEdit, 'String'));
B.WindDirection=str2num(get(handles.WindDirectionEdit, 'String'));
B.AmbientTemperature=str2num(get(handles.AmbientTemperatureEdit, 'String'));
B.WindSpeed=str2num(get(handles.WindSpeedEdit, 'String'));
B.xext=str2num(get(handles.AmbientContaminantEdit, 'String'));

handles.B = B;
guidata(hObject, handles);
uiresume


% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiresume



function AbsolutePresureEdit_Callback(hObject, eventdata, handles)
% hObject    handle to AbsolutePresureEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AbsolutePresureEdit as text
%        str2double(get(hObject,'String')) returns contents of AbsolutePresureEdit as a double

set(handles.AbsolutePresureEdit, 'Enable', 'off')
set(handles.AbsolutePresureEdit, 'Enable', 'on')

% --- Executes during object creation, after setting all properties.
function AbsolutePresureEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AbsolutePresureEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WindDirectionEdit_Callback(hObject, eventdata, handles)
% hObject    handle to WindDirectionEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WindDirectionEdit as text
%        str2double(get(hObject,'String')) returns contents of WindDirectionEdit as a double

set(handles.WindDirectionEdit, 'Enable', 'off')
set(handles.WindDirectionEdit, 'Enable', 'on')

% --- Executes during object creation, after setting all properties.
function WindDirectionEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WindDirectionEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AmbientTemperatureEdit_Callback(hObject, eventdata, handles)
% hObject    handle to AmbientTemperatureEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmbientTemperatureEdit as text
%        str2double(get(hObject,'String')) returns contents of AmbientTemperatureEdit as a double

set(handles.AmbientTemperatureEdit, 'Enable', 'off')
set(handles.AmbientTemperatureEdit, 'Enable', 'on')

% --- Executes during object creation, after setting all properties.
function AmbientTemperatureEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmbientTemperatureEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WindSpeedEdit_Callback(hObject, eventdata, handles)
% hObject    handle to WindSpeedEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WindSpeedEdit as text
%        str2double(get(hObject,'String')) returns contents of WindSpeedEdit as a double

set(handles.WindSpeedEdit, 'Enable', 'off')
set(handles.WindSpeedEdit, 'Enable', 'on')

% --- Executes during object creation, after setting all properties.
function WindSpeedEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WindSpeedEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AmbientContaminantEdit_Callback(hObject, eventdata, handles)
% hObject    handle to AmbientContaminantEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmbientContaminantEdit as text
%        str2double(get(hObject,'String')) returns contents of AmbientContaminantEdit as a double

set(handles.AmbientContaminantEdit, 'Enable', 'off')
set(handles.AmbientContaminantEdit, 'Enable', 'on')

% --- Executes during object creation, after setting all properties.
function AmbientContaminantEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmbientContaminantEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
uiresume
% delete(hObject);
