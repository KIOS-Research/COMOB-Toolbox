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
function varargout = SetSubsystemsGUI(varargin)
% SETSUBSYSTEMSGUI MATLAB code for SetSubsystemsGUI.fig
%      SETSUBSYSTEMSGUI, by itself, creates a new SETSUBSYSTEMSGUI or raises the existing
%      singleton*.
%
%      H = SETSUBSYSTEMSGUI returns the handle to a new SETSUBSYSTEMSGUI or the handle to
%      the existing singleton*.
%
%      SETSUBSYSTEMSGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETSUBSYSTEMSGUI.M with the given input arguments.
%
%      SETSUBSYSTEMSGUI('Property','Value',...) creates a new SETSUBSYSTEMSGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SetSubsystemsGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SetSubsystemsGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SetSubsystemsGUI

% Last Modified by GUIDE v2.5 08-Nov-2014 17:27:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SetSubsystemsGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @SetSubsystemsGUI_OutputFcn, ...
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


% --- Executes just before SetSubsystemsGUI is made visible.
function SetSubsystemsGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SetSubsystemsGUI (see VARARGIN)

% Choose default command line output for SetSubsystemsGUI
handles.output = hObject;

handles.CDI = varargin{1}.CDI;
handles.B = varargin{1}.B;

if ~isempty(handles.CDI.Subsystems{1})
    set(handles.NumberSystemsEdit,'String',num2str(handles.CDI.nSub))
    for i = 1:handles.CDI.nSub
        data{i,1} = i;
        data{i,2} = mat2str(handles.CDI.Subsystems{i});         
    end
    set(handles.uitable1, 'Data', data);
else
    set(handles.NumberSystemsEdit,'String',num2str(2))
    handles.CDI.nSub = 2;
    for i = 1:handles.CDI.nSub
        data{i,1} = i;
        data{i,2} = '';         
    end
    set(handles.uitable1, 'Data', data);
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SetSubsystemsGUI wait for user response (see UIRESUME)
% uiwait(handles.SetSubsystemsGUI);
uiwait

% --- Outputs from this function are returned to the command line.
function varargout = SetSubsystemsGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
varargout{2} = handles.CDI;
delete(hObject);



function NumberSystemsEdit_Callback(hObject, eventdata, handles)
% hObject    handle to NumberSystemsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumberSystemsEdit as text
%        str2double(get(hObject,'String')) returns contents of NumberSystemsEdit as a double
str = get(handles.NumberSystemsEdit,'String');
 if all(ismember(str,'0123456789'))
     if str2double(str)<=handles.B.nZones && str2double(str)>= 2
         handles.CDI.nSub = str2double(str);
         for i = 1:handles.CDI.nSub
             data{i,1} = i;
             data{i,2} = '';             
         end
         set(handles.uitable1, 'Data', data);
     else
         set(handles.NumberSystemsEdit,'String','');
         msgbox('Give a Number greater than 2 and less than number of Zones', 'Error', 'error')
         return
     end
 else
     set(handles.NumberSystemsEdit,'String','');
     msgbox('Give a valid number', 'Error', 'error')
     return
 end

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function NumberSystemsEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumberSystemsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = get(handles.uitable1, 'Data');

for i = 1:length(data)
    if isempty(str2num(data{i,2}))
        msgbox(sprintf('Specify the Zones for Subsystem %d',i), 'Error', 'error')
        return       
    end   
end

checkZones = [];
for i = 1:length(data)
    Zones = str2num(data{i,2});
    for j = 1:length(Zones)
        handles.CDI.Subsystems{i}(1,j) = Zones(j);
    end
    checkZones = [checkZones handles.CDI.Subsystems{i}(1,:)];
end

if ~(length(checkZones)==length(unique(checkZones)))
    msgbox('A Zone must be unique in a Subsystem', 'Error', 'error')
    return   
end

if ~(length(checkZones)==handles.B.nZones)
   msgbox('Each Zone should correspond to a Subsystem', 'Error', 'error')
   return     
end

% Update handles structure
guidata(hObject, handles);

uiresume

% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.CDI.Subsystems{1})
    handles.CDI.nSub = 0;
end
% Update handles structure
guidata(hObject, handles);
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
data0 = get(handles.uitable1, 'Data');
data = get(handles.uitable1, 'Data');

for i = 1:length(data)
    if isempty(str2num(data{i,2}))
        data{i,2}='';        
    end   
end

for i = 1:length(data)
    if ~isempty(str2num(data{i,2}))
        if min(~mod(str2num(data{i,2}),1)) && min(str2num(data{i,2})>0) 
        else
            data{i,2}='';
            set(handles.uitable1, 'Data', data);
            msgbox('Give a positive integer number', 'Error', 'error')
            return
        end        
    else
        if ~isempty(data0{i,2})
            set(handles.uitable1, 'Data', data);
            msgbox('Give a valid number', 'Error', 'error')
            return
        end
    end   
end


% --- Executes when user attempts to close SetSubsystemsGUI.
function SetSubsystemsGUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to SetSubsystemsGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

if isempty(handles.CDI.Subsystems{1})
    handles.CDI.nSub = 0;
end
% Update handles structure
guidata(hObject, handles);

uiresume
