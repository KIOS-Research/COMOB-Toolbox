function varargout = change_sensor(varargin)
% CHANGE_SENSOR MATLAB code for change_sensor.fig
%      CHANGE_SENSOR, by itself, creates a new CHANGE_SENSOR or raises the existing
%      singleton*.
%
%      H = CHANGE_SENSOR returns the handle to a new CHANGE_SENSOR or the handle to
%      the existing singleton*.
%
%      CHANGE_SENSOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHANGE_SENSOR.M with the given input arguments.
%
%      CHANGE_SENSOR('Property','Value',...) creates a new CHANGE_SENSOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before change_sensor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to change_sensor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help change_sensor

% Last Modified by GUIDE v2.5 27-Apr-2013 09:24:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @change_sensor_OpeningFcn, ...
                   'gui_OutputFcn',  @change_sensor_OutputFcn, ...
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


% --- Executes just before change_sensor is made visible.
function change_sensor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to change_sensor (see VARARGIN)

    % Choose default command line output for change_sensor
    handles.output = hObject;

    %When you want to edit shared data you must get the handle
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    %get SharedData and save it to a local variable called SomeDataShared
    SomeDataShared=getappdata(HandleMainGUI,'SharedData');
    
    handles.C = SomeDataShared{1};
    set(handles.NoiseBound, 'String', SomeDataShared{2});
    handles.ZonesName = SomeDataShared{3};
    [row, col] = find(handles.C);
    
   
    k = 0;
    for i=1:length(handles.ZonesName)
        data{i,1} = handles.ZonesName{i};
        if find(col==i)
            data{i,2}= true;
            k = k+1;
        else
            data{i,2}= false;
        end
    end
    if k == length(handles.ZonesName)
        set(handles.selectAll,'Value',1);
    end
        
    set(handles.uitable1, 'Data', data);
%     str{1}= 'Zone Name';    
%     str{2} = SomeDataShared{1,3};
%     set(handles.uitable1, 'ColumnName', str);
% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = change_sensor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)

    data=get(handles.uitable1, 'Data');
    k = 0;
    for i=1:length(handles.ZonesName)        
        if data{i,2} == true
           k = k + 1; 
           C(k,:)= zeros(1,length(handles.ZonesName));
           C(k,i)=1;
        end
    end
    if k~=0
        data{1} = C;
    else
        data{1} = 0;
    end
    
    if  isempty(str2num(get(handles.NoiseBound, 'String')))
        msgbox('     Give A Valid Number', 'Error', 'error')
        return
    end
    
    data{2} = str2double(get(handles.NoiseBound, 'String'));
    
    if (data{2}<0)|| (data{2}>1)
        msgbox('Noise Bound must be 0-1', 'Error', 'error')
        return
    end
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    setappdata(HandleMainGUI,'SharedData', data);
close

% --- Executes on button press in cancel.
function cancel_Callback(hObject, eventdata, handles)

close


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
    data=get(handles.uitable1, 'Data');
    k=0;
    for i=1:length(handles.ZonesName)        
        if data{i,2} == true
           k = k + 1; 
        end
    end
    
    if k == length(handles.ZonesName)
        set(handles.selectAll,'Value',1);
    else
        set(handles.selectAll,'Value',0);  
    end
guidata(hObject, handles);

% --- Executes on button press in selectAll.
function selectAll_Callback(hObject, eventdata, handles)
% hObject    handle to selectAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of selectAll

    
    
    
    check=get(handles.selectAll,'Value');

    if check
        for i=1:length(handles.ZonesName)
            data{i,1}= handles.ZonesName{i};
            data{i,2}= true;
        end
    else
        for i=1:length(handles.ZonesName)
            data{i,1}= handles.ZonesName{i};
            data{i,2}= false;
        end
    end

    set(handles.uitable1, 'Data', data);

guidata(hObject, handles);



function NoiseBound_Callback(hObject, eventdata, handles)
% hObject    handle to NoiseBound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NoiseBound as text
%        str2double(get(hObject,'String')) returns contents of NoiseBound as a double


% --- Executes during object creation, after setting all properties.
function NoiseBound_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NoiseBound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

