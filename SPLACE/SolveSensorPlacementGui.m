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

function varargout = SolveSensorPlacementGui(varargin)
% SOLVESENSORPLACEMENTGUI MATLAB code for SolveSensorPlacementGui.fig
%      SOLVESENSORPLACEMENTGUI, by itself, creates a new SOLVESENSORPLACEMENTGUI or raises the existing
%      singleton*.
%
%      H = SOLVESENSORPLACEMENTGUI returns the handle to a new SOLVESENSORPLACEMENTGUI or the handle to
%      the existing singleton*.
%
%      SOLVESENSORPLACEMENTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOLVESENSORPLACEMENTGUI.M with the given input arguments.
%
%      SOLVESENSORPLACEMENTGUI('Property','Value',...) creates a new SOLVESENSORPLACEMENTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SolveSensorPlacementGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SolveSensorPlacementGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SolveSensorPlacementGui

% Last Modified by GUIDE v2.5 22-Feb-2015 19:31:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SolveSensorPlacementGui_OpeningFcn, ...
                   'gui_OutputFcn',  @SolveSensorPlacementGui_OutputFcn, ...
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


% --- Executes just before SolveSensorPlacementGui is made visible.
function SolveSensorPlacementGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SolveSensorPlacementGui (see VARARGIN)

    % Choose default command line output for SolveSensorPlacementGui
    handles.output = hObject;

    % UIWAIT makes SolveSensorPlacementGui wait for user response (see UIRESUME)
    % uiwait(handles.SolveSensorPlacementGui);

    
    handles.file0 = varargin{1}.file0;
    handles.B = varargin{1}.B;
%     handles.MainGuiaxes1 = varargin{1}.axes1;
%     handles.ZoneID = varargin{1}.ZoneID;
%     handles.PathID = varargin{1}.PathID;
    
    set(handles.LoadImpactMatrix,'enable','off');
    set(handles.Solve,'enable','off');
    load([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');

    if exist([pathname,handles.file0,'.0'],'file')==2
        if ~isempty([handles.file0,'.0']) 
            load([pathname,handles.file0,'.0'],'-mat');
        else
            B.ProjectName=handles.B.ProjectName;
        end
    else
        B.ProjectName=[];
    end

    if ~strcmp(handles.B.ProjectName,B.ProjectName)
        set(handles.FileText0,'String','')
    else
        set(handles.FileText0,'String',[handles.file0,'.0'])
        if exist([pathname,handles.file0,'.w'],'file')==2
            set(handles.Solve,'enable','on');
            if exist([pathname,handles.file0,'.w'],'file')==2
                set(handles.FileTextW,'String',[handles.file0,'.w']);
            end
            set(handles.LoadImpactMatrix,'enable','on');
        else
            set(handles.LoadImpactMatrix,'enable','on');
        end
    end    
    
    handles.pp=DefaultSolveParameters(hObject,handles);
    
    handles.msg = '';
    
    % Update handles structure
    guidata(hObject, handles);
    
    uiwait;
    
function pp=DefaultSolveParameters(hObject,handles)
    pp.solutionMethod=0; % 0 is exhaustive, 1 is evolutionary based
    
    pp.PopulationSize_Data=1000;
    pp.ParetoFraction_Data=0.5;
    pp.Generations_Data=50;
    
    pp.numberOfSensors=['1:',num2str(handles.B.nZones)];
    set(handles.PopulationSize_Data,'enable','off');
    set(handles.ParetoFraction_Data,'enable','off');
    set(handles.Generations_Data,'enable','off');
        
    if ((exist('gamultiobj','file')==2)==0)
        set(handles.Evolutionary,'enable','off');
%         msgbox('GAMULTIOBJ is not currenty installed in MATLAB','Error','error');
    end
    
    set(handles.Exhaustive,'Value',1);
    set(handles.Evolutionary,'Value',0);
    set(handles.PopulationSize_Data,'String',pp.PopulationSize_Data);
    set(handles.ParetoFraction_Data,'String',pp.ParetoFraction_Data);
    set(handles.Generations_Data,'String',pp.Generations_Data);
    set(handles.numberOfSensors,'String',pp.numberOfSensors);

    % Update handles structure
    guidata(hObject, handles);
    
% --- Outputs from this function are returned to the command line.
function varargout = SolveSensorPlacementGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
varargout{2} = handles.msg;
delete(hObject);


% --- Executes on button press in Exhaustive.
function Exhaustive_Callback(hObject, eventdata, handles)
% hObject    handle to Exhaustive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Exhaustive

    value = get(handles.Exhaustive,'Value');
    if value==1
        set(handles.Exhaustive,'Value',1);
        set(handles.Evolutionary,'Value',0);
        set(handles.PopulationSize_Data,'enable','off');
        set(handles.ParetoFraction_Data,'enable','off');
        set(handles.Generations_Data,'enable','off');
    elseif ((exist('gamultiobj','file')==2)==1)
        set(handles.Evolutionary,'Value',1);
        set(handles.PopulationSize_Data,'enable','on');
        set(handles.ParetoFraction_Data,'enable','on');
        set(handles.Generations_Data,'enable','on');
    end

% --- Executes on button press in Evolutionary.
function Evolutionary_Callback(hObject, eventdata, handles)
% hObject    handle to Evolutionary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Evolutionary

    value = get(handles.Evolutionary,'Value');
    if value==1 && ((exist('gamultiobj','file')==2)==1)
        set(handles.Exhaustive,'Value',0);
        set(handles.Evolutionary,'Value',1);
        set(handles.PopulationSize_Data,'enable','on');
        set(handles.ParetoFraction_Data,'enable','on');
        set(handles.Generations_Data,'enable','on');
    else
        set(handles.PopulationSize_Data,'enable','off');
        set(handles.ParetoFraction_Data,'enable','off');
        set(handles.Generations_Data,'enable','off');
        set(handles.Exhaustive,'Value',1);
    end


function ParetoFraction_Data_Callback(hObject, eventdata, handles)
% hObject    handle to ParetoFraction_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ParetoFraction_Data as text
%        str2double(get(hObject,'String')) returns contents of ParetoFraction_Data as a double


% --- Executes during object creation, after setting all properties.
function ParetoFraction_Data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ParetoFraction_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PopulationSize_Data_Callback(hObject, eventdata, handles)
% hObject    handle to PopulationSize_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PopulationSize_Data as text
%        str2double(get(hObject,'String')) returns contents of PopulationSize_Data as a double


% --- Executes during object creation, after setting all properties.
function PopulationSize_Data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PopulationSize_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Generations_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Generations_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Generations_Data as text
%        str2double(get(hObject,'String')) returns contents of Generations_Data as a double


% --- Executes during object creation, after setting all properties.
function Generations_Data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Generations_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numberOfSensors_Callback(hObject, eventdata, handles)
% hObject    handle to numberOfSensors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numberOfSensors as text
%        str2double(get(hObject,'String')) returns contents of numberOfSensors as a double


% --- Executes during object creation, after setting all properties.
function numberOfSensors_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numberOfSensors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Solve.
function Solve_Callback(hObject, eventdata, handles)
% hObject    handle to Solve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    [errorCode,handles.pp] = CheckForError(hObject,handles);
    if errorCode
        return;
    end
    handles.pp.numberOfSensors=get(handles.numberOfSensors,'String');
%     set(handles.SolveSensorPlacementGui,'visible','off');
    
    SuccessFlag=SolveSensorPlacement(handles);
    
%     value = get(handles.Exhaustive,'Value');
    
%     handles.msg=[' Solution of Sensor Placement in file: ',handles.file0,'.y',num2str(handles.pp.solutionMethod),''];
%     uiwait(msgbox(handles.msg));
    
    if SuccessFlag~=0
        guidata(hObject, handles);
        uiresume
    end

%     SolutionsSesnorsGui(handles);
 
    
    
    
function [errorCode,pp] = CheckForError(hObject,handles)
    errorCode=0;
    pp.PopulationSize_Data=str2num(get(handles.PopulationSize_Data, 'String'));
    pp.ParetoFraction_Data=str2num(get(handles.ParetoFraction_Data, 'String'));
    pp.Generations_Data=str2num(get(handles.Generations_Data, 'String'));
    pp.numberOfSensors=str2num(get(handles.numberOfSensors,'String'));

    % methods
    Evolutionary=get(handles.Evolutionary, 'Value'); 
    Exhaustive=get(handles.Exhaustive, 'Value'); 
    if Evolutionary
        pp.solutionMethod=1;
    elseif Exhaustive
        pp.solutionMethod=0;
    else
         msgbox('        Give Solution Method', 'Error', 'modal');
         errorCode=1;
         return
    end
    
    if get(handles.Evolutionary,'Value');
        if  ~length(pp.PopulationSize_Data) || pp.PopulationSize_Data<0
            msgbox('           Give Population', 'Error', 'modal')
            errorCode=1;
            return
        end

        if ~length(pp.ParetoFraction_Data) || pp.ParetoFraction_Data<0
            msgbox('       Give Pareto Fraction', 'Error', 'modal')
            errorCode=1;
            return
        end

        if ~length(pp.Generations_Data) || pp.Generations_Data<0
            msgbox('          Give Generations', 'Error', 'modal')
            errorCode=1;
            return
        end
    end

    if ~length(pp.numberOfSensors) || sum(pp.numberOfSensors<0) || sum((pp.numberOfSensors)>handles.B.nZones)>0
        msgbox('     Give Number of Sensors', 'Error', 'modal')
        errorCode=1;
        return
    end

    % Update handles structure
    guidata(hObject, handles);

% --- Executes on button press in DefaultParameters.
function DefaultParameters_Callback(hObject, eventdata, handles)
% hObject    handle to DefaultParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    DefaultSolveParameters(hObject,handles);


% --- Executes on button press in LoadImpactMatrix.
function LoadImpactMatrix_Callback(hObject, eventdata, handles)
% hObject    handle to LoadImpactMatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    [fileW,pathName] = uigetfile('*.w','Select the MATLAB *.w file');
    pathfileW=[pathName,fileW];
    pathfileW=pathfileW(1:end-2);
    fileW = fileW(1:end-2);
    if isnumeric(pathfileW)
        pathfileW=[];
    end
    if ~isempty((pathfileW)) 
        load([pathfileW,'.w'],'-mat');
        handles.fileW=fileW;
        if ~strcmp(handles.file0,handles.fileW)
            set(handles.Solve,'enable','off');
%             set(handles.LoadImpactMatrix,'enable','off');
            msgbox(['        Wrong File "',pathfileW,'.w"'],'Error','modal');
            set(handles.FileTextW,'String','')
        else
            set(handles.Solve,'enable','on');
            set(handles.FileTextW,'String',[handles.file0,'.w']);
        end
        % Update handles structure
        guidata(hObject, handles);
    end
    
% --- Executes on button press in LoadScenarios.
function LoadScenarios_Callback(hObject, eventdata, handles)
% hObject    handle to LoadScenarios (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    [file0,pathName] = uigetfile('*.0','Select the MATLAB *.0 file');
    pathfile0=[pathName,file0];
    pathfile0=pathfile0(1:end-2);
    file0 = file0(1:end-2);
    if isnumeric(pathfile0)
        pathfile0=[];
    end
    if ~isempty((pathfile0)) 
        load([pathfile0,'.0'],'-mat');clc;
        handles.file0=file0;
        if ~strcmp(handles.B.ProjectName,B.ProjectName)
            set(handles.Solve,'enable','off');
            set(handles.LoadImpactMatrix,'enable','off');
            msgbox(['        Wrong File "',pathfile0,'.0"'],'Error','modal');
            set(handles.FileText0,'String','')
        else
            set(handles.LoadImpactMatrix,'enable','on');
            set(handles.Solve,'enable','off');
            set(handles.FileText0,'String',[file0,'.0']);
        end
        handles.P=P;
        hanldes.B=B;
        % Update handles structure
        guidata(hObject, handles);
    end
    


% --- Executes when user attempts to close SolveSensorPlacementGui.
function SolveSensorPlacementGui_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to SolveSensorPlacementGui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
% delete(hObject);
uiresume
