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

function varargout = change_FDIparameters(varargin)
% CHANGE_FDIPARAMETERS MATLAB code for change_FDIparameters.fig
%      CHANGE_FDIPARAMETERS, by itself, creates a new CHANGE_FDIPARAMETERS or raises the existing
%      singleton*.
%
%      H = CHANGE_FDIPARAMETERS returns the handle to a new CHANGE_FDIPARAMETERS or the handle to
%      the existing singleton*.
%
%      CHANGE_FDIPARAMETERS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHANGE_FDIPARAMETERS.M with the given input arguments.
%
%      CHANGE_FDIPARAMETERS('Property','Value',...) creates a new CHANGE_FDIPARAMETERS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before change_FDIparameters_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to change_FDIparameters_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help change_FDIparameters

% Last Modified by GUIDE v2.5 27-Apr-2013 22:10:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @change_FDIparameters_OpeningFcn, ...
                   'gui_OutputFcn',  @change_FDIparameters_OutputFcn, ...
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


% --- Executes just before change_FDIparameters is made visible.
function change_FDIparameters_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to change_FDIparameters (see VARARGIN)

% Choose default command line output for change_FDIparameters
    handles.output = hObject;
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    SomeDataShared=getappdata(HandleMainGUI,'SharedData');
         
    handles.F = SomeDataShared{1};
    handles.B = SomeDataShared{2};
    [Amat Qext Flows] = computeAmatrix(handles.B, handles.B.WindDirection, handles.B.WindSpeed, handles.B.AmbientTemperature, handles.B.AmbientPressure, handles.B.v, handles.B.Temp, handles.B.Openings);
    handles.Amat = Amat;
    
    set(handles.edit1, 'String', num2str(handles.F.DA));
    set(handles.edit2, 'String', num2str(handles.F.Tolerances.Wd));
    set(handles.edit3, 'String', num2str(handles.F.Tolerances.Ws));
    set(handles.edit4, 'String', num2str(handles.F.Tolerances.Ztemp));
    set(handles.edit5, 'String', num2str(handles.F.Tolerances.PathsOpenings));
    set(handles.edit6, 'String', num2str(handles.F.Tolerances.Iterations));
    set(handles.edit7, 'String', handles.F.MatricesFile);
    set(handles.edit8, 'String', num2str(handles.F.Calc));
    set(handles.edit9, 'String', num2str(handles.F.Ex0));
    set(handles.edit10, 'String', num2str(handles.F.Ez0));
    set(handles.edit11, 'String', sprintf('%3.3e',handles.F.LearningRate));
    set(handles.edit12, 'String', num2str(handles.F.Theta));
    set(handles.edit13, 'String', num2str(handles.F.InitialSourceEstimation));
    set(handles.edit14, 'String', num2str(handles.F.NoiseBound));
    set(handles.edit15, 'String', handles.F.NominalFile);
    
    switch handles.F.choice
        case 1
            set(handles.Constant, 'Value',1);
            set(handles.Tolerances, 'Value',0);
            set(handles.File, 'Value',0);
            set(handles.edit1, 'Enable', 'on');
            set(handles.edit2, 'Enable', 'off');
            set(handles.edit3, 'Enable', 'off');    
            set(handles.edit4, 'Enable', 'off');
            set(handles.edit5, 'Enable', 'off');
            set(handles.edit6, 'Enable', 'off');
            set(handles.edit7, 'Enable', 'off');
            set(handles.edit8, 'Enable', 'off');
            set(handles.Browse, 'Enable', 'off');
            set(handles.Caclulate, 'Enable', 'off');
        case 2
            set(handles.Tolerances, 'Value',1);
            set(handles.Constant, 'Value',0);
            set(handles.File, 'Value',0);
            set(handles.edit1, 'Enable', 'off');
            set(handles.edit2, 'Enable', 'on');
            set(handles.edit3, 'Enable', 'on');
            set(handles.edit4, 'Enable', 'on');
            set(handles.edit5, 'Enable', 'on');
            set(handles.edit6, 'Enable', 'on');
            set(handles.edit7, 'Enable', 'off');
            set(handles.edit8, 'Enable', 'inactive','BackgroundColor','white');
            set(handles.Browse, 'Enable', 'off');
            set(handles.Caclulate, 'Enable', 'on');
        case 3
            set(handles.Constant, 'Value',0);
            set(handles.Tolerances, 'Value',0);
            set(handles.File, 'Value',1);
            set(handles.edit1, 'Enable', 'off');
            set(handles.edit2, 'Enable', 'off');
            set(handles.edit3, 'Enable', 'off');    
            set(handles.edit4, 'Enable', 'off');
            set(handles.edit5, 'Enable', 'off');
            set(handles.edit6, 'Enable', 'off');
            set(handles.edit7, 'Enable', 'on');
            set(handles.edit8, 'BackgroundColor','white');
            set(handles.Browse, 'Enable', 'on');
            set(handles.Caclulate, 'Enable', 'on');
    end
    
    switch handles.F.NominalChoice
        case 1
            set(handles.Current, 'Value',1);
            handles.F.Nominal = handles.Amat;
            set(handles.Load, 'Value',0);
            set(handles.edit15, 'Enable', 'off');
            set(handles.LoadFile, 'Enable', 'off');            
        case 2
            set(handles.Current, 'Value',0);
            set(handles.Load, 'Value',1);
            set(handles.edit15, 'Enable', 'on');
            set(handles.LoadFile, 'Enable', 'on');
            if exist(get(handles.edit15, 'String'))
               vars = whos('-file', get(handles.edit15, 'String'));
               MAT = load(get(handles.edit15, 'String'));
               [s1 s2 s3]= size(MAT.(vars.name));

               if (s1 ~= handles.B.nZones)||(s2 ~= handles.B.nZones)
                   msgbox('Dimension of Mat File is incorrect', 'Error', 'error')
                   return
               end
               handles.F.Nominal = MAT.(vars.name);
            end
    end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes change_FDIparameters wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% set(handles.Constant, 'Value',1);

% --- Outputs from this function are returned to the command line.
function varargout = change_FDIparameters_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    switch handles.F.choice
            case 1
                if  isempty(get(handles.edit1, 'String'))
                    msgbox('Give Uncertainties Bound', 'Error', 'error')
                    return
                end
                
                if  isempty(str2num(get(handles.edit1, 'String')))
                    msgbox('     Give A Valid Number', 'Error', 'error')
                    return
                end
                
                handles.F.UncertaintiesBound = str2double(get(handles.edit1, 'String'));
            case 2
                if  isempty(get(handles.edit8, 'String'))
                    msgbox('Caclulate Uncertainties Bound', 'Error', 'error')
                    return
                end
                handles.F.Tolerances.Wd = str2double(get(handles.edit2, 'String'));
                handles.F.Tolerances.Ws = str2double(get(handles.edit3, 'String'));
                handles.F.Tolerances.Ztemp = str2double(get(handles.edit4, 'String'));
                handles.F.Tolerances.PathsOpenings = str2double(get(handles.edit5, 'String'));
                handles.F.Tolerances.Iterations = str2double(get(handles.edit6, 'String'));
                handles.F.UncertaintiesBound = str2double(get(handles.edit8, 'String'));
                
            case 3
                if  isempty(get(handles.edit8, 'String'))
                    msgbox('Calculate Uncertainties Bound', 'Error', 'error')
                    return
                end
                handles.F.UncertaintiesBound = str2double(get(handles.edit8, 'String'));
    end
                   
    if  isempty(get(handles.edit9, 'String'))
        msgbox('Give Initial Detection Threshold', 'Error', 'error')
        return
    end
    
    if  isempty(str2num(get(handles.edit9, 'String')))
                    msgbox('     Give A Valid Number', 'Error', 'error')
                    return
    end
                
                
    if (str2double(get(handles.edit9, 'String'))<0)
        msgbox('Initial Detection Threshold must be positive', 'Error', 'error')
        return
    end
    
    if  isempty(get(handles.edit10, 'String'))
        msgbox('Give Initial Isolation Threshold', 'Error', 'error')
        return
    end
    
    if  isempty(str2num(get(handles.edit10, 'String')))
                    msgbox('     Give A Valid Number', 'Error', 'error')
                    return
    end                
                
    if (str2double(get(handles.edit10, 'String'))<0)
        msgbox('Initial Isolation Threshold must be positive', 'Error', 'error')
        return
    end
    
    if  isempty(get(handles.edit11, 'String'))
        msgbox('Give Learning Rate', 'Error', 'error')
        return
    end
    
    if  isempty(str2num(get(handles.edit11, 'String')))
        msgbox('     Give A Valid Number', 'Error', 'error')
        return
    end
                
                
    if (str2double(get(handles.edit11, 'String'))<0)
        msgbox('Learning Rate must be positive', 'Error', 'error')
        return
    end
    
    if  isempty(get(handles.edit12, 'String'))
        msgbox('Give Theta Bound', 'Error', 'error')
        return
    end
    
    if  isempty(str2num(get(handles.edit12, 'String')))
        msgbox('     Give A Valid Number', 'Error', 'error')
        return
    end
                
                
    if (str2double(get(handles.edit12, 'String'))<0)
        msgbox('Theta must be positive', 'Error', 'error')
        return
    end
    
    if  isempty(get(handles.edit13, 'String'))
        msgbox('Give Initial Source Estimation', 'Error', 'error')
        return
    end
    
    if  isempty(str2num(get(handles.edit13, 'String')))
        msgbox('     Give A Valid Number', 'Error', 'error')
        return
    end
                
                
    if (str2double(get(handles.edit13, 'String'))<0.0001)
        msgbox('Initial Source Estimation must be greater than 0.0001', 'Error', 'error')
        return
    end
    
    if  isempty(get(handles.edit14, 'String'))
        msgbox('Give Noise Bound', 'Error', 'error')
        return
    end
    
    if  isempty(str2num(get(handles.edit14, 'String')))
        msgbox('     Give A Valid Number', 'Error', 'error')
        return
    end
                
                
    if (str2double(get(handles.edit14, 'String'))<0)
        msgbox('Noise Bound must be positive', 'Error', 'error')
        return
    end
    
    switch handles.F.NominalChoice
        case 1
            set(handles.Current, 'Value',1);
            handles.F.Nominal = handles.Amat;
            set(handles.Load, 'Value',0);
            set(handles.edit15, 'Enable', 'off');
            set(handles.LoadFile, 'Enable', 'off');            
        case 2
            set(handles.Current, 'Value',0);
            set(handles.Load, 'Value',1);
            set(handles.edit15, 'Enable', 'on');
            set(handles.LoadFile, 'Enable', 'on');
            handles.F.NominalFile = get(handles.edit15, 'String');
            if exist(handles.F.NominalFile)
               vars = whos('-file', get(handles.edit15, 'String'));
               MAT = load(get(handles.edit15, 'String'));
               [s1 s2 s3]= size(MAT.(vars.name));

               if (s1 ~= handles.B.nZones)||(s2 ~= handles.B.nZones)
                   msgbox('Dimension of Mat File is incorrect', 'Error', 'error')
                   return
               end
               handles.F.Nominal = MAT.(vars.name);
            else
                msgbox('       File No Exist', 'Error', 'error')
                return
            end
        
    end
    
    handles.F.Ex0 = str2double(get(handles.edit9, 'String'));
    handles.F.Ez0 = str2double(get(handles.edit10, 'String'));
    handles.F.LearningRate = str2double(get(handles.edit11, 'String'));
    handles.F.Theta = str2double(get(handles.edit12, 'String'));
    handles.F.InitialSourceEstimation = str2double(get(handles.edit13, 'String'));
    handles.F.NoiseBound = str2double(get(handles.edit14, 'String'));
    handles.F.DA = str2double(get(handles.edit1, 'String'));
    handles.F.Calc = str2double(get(handles.edit8, 'String'));       
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    setappdata(HandleMainGUI,'SharedData', handles.F); 

    guidata(hObject, handles);
close


% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close


% --- Executes on button press in Constant.
function Constant_Callback(hObject, eventdata, handles)
% hObject    handle to Constant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Constant
    handles.F.choice = 1;
    set(handles.Tolerances, 'Value',0);
    set(handles.File, 'Value',0);
    set(handles.edit1, 'Enable', 'on');
    set(handles.edit2, 'Enable', 'off');
    set(handles.edit3, 'Enable', 'off');   
    set(handles.edit4, 'Enable', 'off');
    set(handles.edit5, 'Enable', 'off');
    set(handles.edit6, 'Enable', 'off');
    set(handles.edit7, 'Enable', 'off');
    set(handles.edit8, 'Enable', 'off');
    set(handles.Browse, 'Enable', 'off');
    set(handles.Caclulate, 'Enable', 'off');
    handles.F.DA = str2double(get(handles.edit1, 'String'));
    guidata(hObject, handles);
    
% --- Executes on button press in Tolerances.
function Tolerances_Callback(hObject, eventdata, handles)
% hObject    handle to Tolerances (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Tolerances
    handles.F.choice = 2;

    set(handles.Constant, 'Value',0);
    set(handles.File, 'Value',0);
    set(handles.edit1, 'Enable', 'off');
    set(handles.edit2, 'Enable', 'on');
    set(handles.edit3, 'Enable', 'on');
    set(handles.edit4, 'Enable', 'on');
    set(handles.edit5, 'Enable', 'on');
    set(handles.edit6, 'Enable', 'on');
    set(handles.edit7, 'Enable', 'off');
    set(handles.edit8, 'Enable', 'inactive','BackgroundColor','white');
    set(handles.Browse, 'Enable', 'off');
    set(handles.Caclulate, 'Enable', 'on');
    guidata(hObject, handles);

    
% --- Executes on button press in File.
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of File

    handles.F.choice = 3;
    
    set(handles.Constant, 'Value',0);
    set(handles.Tolerances, 'Value',0);
    set(handles.edit1, 'Enable', 'off')
    set(handles.edit2, 'Enable', 'off')
    set(handles.edit3, 'Enable', 'off')    
    set(handles.edit4, 'Enable', 'off')
    set(handles.edit5, 'Enable', 'off')
    set(handles.edit6, 'Enable', 'off')
    set(handles.edit7, 'Enable', 'on')
    set(handles.edit8, 'Enable', 'inactive','BackgroundColor','white')
    set(handles.Browse, 'Enable', 'on')
    set(handles.Caclulate, 'Enable', 'on')
    guidata(hObject, handles);
    
% --- Executes on button press in Browse.
function Browse_Callback(hObject, eventdata, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%     [filename, pathname] = uigetfile('*.mat', 'Pick a Mat-file');
    % write the direction of prj to edit1
%     set(handles.edit7,'String', [pathname,filename]);
%     vars = whos('-file', [pathname,filename]);
%     MAT = load([pathname,filename]);
%     handles.Amatrices = MAT.(vars.name);
%     guidata(hObject, handles);
    
    
    [filename, pathname] = uigetfile('*.mat', 'Pick a Mat-file');
    
    if filename ~= 0 
        if exist([pathname,filename])
            % write the direction of prj to edit1
            set(handles.edit7,'String', [pathname,filename]);
            handles.F.MatricesFile = [pathname,filename];

        end
    end
guidata(hObject, handles);
% --- Executes on button press in Caclulate.
function Caclulate_Callback(hObject, eventdata, handles)
% hObject    handle to Caclulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    switch handles.F.choice
           
        case 2
            if  isempty(get(handles.edit2, 'String'))
                msgbox('Give Wind Direction Tolerance', 'Error', 'error')
                return
            end
            
            if (str2double(get(handles.edit2, 'String'))<0)|| (str2double(get(handles.edit2, 'String'))>360)
                msgbox('Wind Direction must be 0-360 deg', 'Error', 'error')
                return
            end
            
            if  isempty(get(handles.edit3, 'String'))
                msgbox('Give Wind Speed Tolerance', 'Error', 'error')
                return
            end
            
            if (str2double(get(handles.edit3, 'String'))<0)
                msgbox('Wind Speed must be Positive', 'Error', 'error')
                return
            end
            
            if  isempty(get(handles.edit4, 'String'))
                msgbox('Give Zones Temperature Tolerance', 'Error', 'error')
                return
            end
            
            if (str2double(get(handles.edit4, 'String'))<0)
                msgbox('Zones Temperature must be Positive', 'Error', 'error')
                return
            end
            
            if  isempty(get(handles.edit5, 'String'))
                msgbox('Give Paths openings Tolerance', 'Error', 'error')
                return
            end
            
            if (str2double(get(handles.edit5, 'String'))<0)|| (str2double(get(handles.edit5, 'String'))>100)
                msgbox('Wind Direction must be 0-100 %', 'Error', 'error')
                return
            end
            
            if  isempty(get(handles.edit6, 'String'))
                msgbox('Give Max Iterations', 'Error', 'error')
                return
            end
            
            if (str2double(get(handles.edit6, 'String'))<0)
                msgbox('Max Iterations must be Positive', 'Error', 'error')
                return
            end
            handles.F.Tolerances.Wd = str2double(get(handles.edit2, 'String'));
            handles.F.Tolerances.Ws = str2double(get(handles.edit3, 'String'));
            handles.F.Tolerances.Ztemp = str2double(get(handles.edit4, 'String'));
            handles.F.Tolerances.PathsOpenings = str2double(get(handles.edit5, 'String'));
            handles.F.Tolerances.Iterations = str2double(get(handles.edit6, 'String'));
            
            handles.F.Amatrices = zeros(handles.B.nZones,handles.B.nZones,handles.F.Tolerances.Iterations);
            for i=1:handles.F.Tolerances.Iterations
                
                Openings = handles.B.Openings;
                for j=1:handles.B.Paths
                    Openings(j) = 1 + unifrnd(-handles.F.Tolerances.PathsOpenings,handles.F.Tolerances.PathsOpenings)/100;
                end
                ZoneTemperature = handles.B.Temp + unifrnd(-handles.F.Tolerances.Ztemp,handles.F.Tolerances.Ztemp,1,handles.B.nZones);
                WindDirection = handles.B.WindDirection + unifrnd(-handles.F.Tolerances.Wd,handles.F.Tolerances.Wd);
                if WindDirection < 0
                    WindDirection = 360 + WindDirection;
                end
                WindSpeed = handles.B.WindSpeed + unifrnd(-handles.F.Tolerances.Ws,handles.F.Tolerances.Ws);
                pause(0.8)
                [Amat Qext Flows] = computeAmatrix(handles.B,WindDirection, WindSpeed, handles.B.AmbientTemperature, handles.B.AmbientPressure, handles.B.v, ZoneTemperature, Openings);

                DA(i) = norm(handles.F.Nominal - Amat);                
                handles.F.Amatrices(:,:,i) = Amat;
            end
            
            
            handles.F.UncertaintiesBound = max(DA);
            handles.F.Calc = max(DA);
            set(handles.edit8, 'String', num2str(handles.F.UncertaintiesBound));
%             isa(str2mat(get(handles.edit6, 'String')),'integer')
%             h = str2double(get(handles.edit6, 'String'))
%             if ~isinteger(h)
%                 msgbox('Iterations must be integer', 'Error', 'error')
%                 return
%             end            
        case 3
           
           if  isempty(get(handles.edit7, 'String'))
                msgbox('Give mat file', 'Error', 'error')
                return
           end 
           
           if ~exist(handles.F.MatricesFile,'file')
               msgbox('      File No Exist', 'Error', 'error')
               return
           end
           
           
           vars = whos('-file', handles.F.MatricesFile);
           MAT = load(handles.F.MatricesFile);
           handles.Amatrices = MAT.(vars.name);
           
           [s1 s2 s3]= size(handles.Amatrices);
           
           if (s1 ~= handles.B.nZones)||(s2 ~= handles.B.nZones)
               msgbox('Dimension of Mat File is incorrect')
               return
           end
           
           for i = 1:s3
                DA(i) = norm(handles.F.Nominal - handles.Amatrices(:,:,i));
           end
           handles.F.UncertaintiesBound = max(DA);
           handles.F.Calc = max(DA);
           set(handles.edit8, 'String', num2str(handles.F.UncertaintiesBound));
    end
    
    guidata(hObject, handles);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
    handles.F.DA = str2double(get(handles.edit1, 'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
    handles.F.MatricesFile = get(handles.edit7, 'String');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

    HandleMainGUI=getappdata(0,'HandleMainGUI');
    setappdata(HandleMainGUI,'SharedData', handles.F);
delete(hObject);



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Current.
function Current_Callback(hObject, eventdata, handles)
% hObject    handle to Current (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Current
    handles.F.NominalChoice = 1;
    handles.F.Nominal = handles.Amat;
    set(handles.Load, 'Value',0);
    set(handles.edit15, 'Enable', 'off');
    set(handles.LoadFile, 'Enable', 'off');
    guidata(hObject, handles);

% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Load
    handles.F.NominalChoice = 2;
    set(handles.Current, 'Value',0);
    set(handles.edit15, 'Enable', 'on');
    set(handles.LoadFile, 'Enable', 'on');
    handles.F.NominalFile = get(handles.edit15, 'String');

guidata(hObject, handles);

% --- Executes on button press in LoadFile.
function LoadFile_Callback(hObject, eventdata, handles)
% hObject    handle to LoadFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    [filename, pathname] = uigetfile('*.mat', 'Pick a Mat-file');
    
    if filename ~= 0 
        if exist([pathname,filename])
            % write the direction of prj to edit1
            set(handles.edit15,'String', [pathname,filename]);
            handles.F.NominalFile = [pathname,filename];

        end
    end
    
guidata(hObject, handles);
