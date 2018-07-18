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

function varargout = ComputeImpactMatricesGui(varargin)
% COMPUTEIMPACTMATRICESGUI M-file for ComputeImpactMatricesGui.fig
% In This M file you can see how the axes along with a patch can be used to
% render a progress bar for your existing Gui. Box Property of the Axes
% must be enabled in order to make the axes look like a progress bar and
% also the xTick & yTick values must be set to empty. In order to change
% the Color of the Patch do pass the color value to changecolor function.
% Run this m file and click on the start button to see how this progress bar works.
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ComputeImpactMatricesGui_OpeningFcn, ...
                   'gui_OutputFcn',  @ComputeImpactMatricesGui_OutputFcn, ...
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


% --- Executes just before ComputeImpactMatricesGui is made visible.
function ComputeImpactMatricesGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ComputeImpactMatricesGui (see VARARGIN)
% Choose default command line output for ComputeImpactMatricesGui
    handles.output = hObject;

    handles.file0 = varargin{1}.file0;
    handles.B = varargin{1}.B;    
    load([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');

    if exist([pathname,handles.file0,'.0'],'file')==2
        if ~isempty([handles.file0,'.0']) 
            load([pathname,handles.file0,'.0'],'-mat');
            handles.P=P;
        else
            B.ProjectName=handles.B.ProjectName;
        end
    else
        B.ProjectName=[];
    end

    if ~strcmp(handles.B.ProjectName,B.ProjectName)
        set(handles.start,'enable','off');
        set(handles.SensorThreshold,'enable','off');
        set(handles.InhalationRate,'enable','off');
        set(handles.FileText,'String','')
    else
        set(handles.start,'enable','on');
        set(handles.InhalationRate,'enable','on');
        set(handles.SensorThreshold,'enable','on');
        set(handles.FileText,'String',[handles.file0,'.0'])
        SensorThreshold=0.75;
        set(handles.SensorThreshold,'String',SensorThreshold);
        InhalationRate=0.5;
        set(handles.InhalationRate,'String',InhalationRate);
        ZonesOccupancyTableFunction(hObject, eventdata, handles);
        
    end

    %Sensor Placement Panel Initialization
%     set(handles.FileText0,'String',[handles.file0,'.0'])
    set(handles.FileTextW,'String','');
    set(handles.Solve,'enable','off');
    handles.Solve.BackgroundColor=[0.94 0.94 0.94];
    set(handles.PopulationSize_Data,'enable','off');
    set(handles.ParetoFraction_Data,'enable','off');
    set(handles.Generations_Data,'enable','off');
    set(handles.numberOfSensors,'enable','off');
    set(handles.Exhaustive,'enable','off');
    set(handles.Evolutionary,'enable','off');
    
    set(handles.load,'enable','on');
%     handles.str='Compute Impact Matrix';
%     set(handles.ComputeImpactMatricesGui,'name',handles.str);
    handles.msg = '';
    % Update handles structure    
    guidata(hObject, handles);    
    uiwait

    
function ZonesOccupancyTableFunction(hObject, eventdata, handles) 
    B=handles.B;
    % Zones
    ZoneTableColumnName=B.ZoneName;
    set(handles.ZoneTable, 'ColumnName', ZoneTableColumnName);
    set(handles.ZoneTable,'RowName',{'Occupancy'});

    % Column Edit Table
    ColumnEditable='true ';
    for i=1:B.nZones
        ColumnEditable = strcat({ColumnEditable},' true');
        ColumnEditable = ColumnEditable{1,1};
    end
    set(handles.ZoneTable,'ColumnEditable',str2num(ColumnEditable));

    % Zones Volume
    ZoneTable=0.5*ones(1,B.nZones);
%      ZoneTable=[0.5, 0.1, 0.2, 4, 4, 0.2, 0.5, 1 ,...
%          1, 0.1 , 0.1, 0.1, 0.2, 1];
    
    set(handles.ZoneTable,'data',ZoneTable);

% --- Outputs from this function are returned to the command line.
function varargout = ComputeImpactMatricesGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
varargout{2} = handles.msg;
delete(hObject);

% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    handles.SensorThreshold1=str2num(get(handles.SensorThreshold, 'String'));
    if  ~length(handles.SensorThreshold1) || handles.SensorThreshold1<0
        msgbox('Give number of Sensor Threshold', 'Error', 'modal')
        return
    end
    handles.InhalationRate1=str2num(get(handles.InhalationRate, 'String'));
    if  ~length(handles.InhalationRate1) || handles.InhalationRate1<0
        msgbox('Give number of Inhalation Rate', 'Error', 'modal')
        return
    end
    
%     set(handles.start,'enable','off');
%     set(handles.load,'enable','off');
    
    handles.ZoneOccupancy = get(handles.ZoneTable,'data');
    % Update handles structure
    guidata(hObject, handles);
    
    errorflag=ComputeImpactMatrices(handles);
    if errorflag==1
        return
    end
%     msgbox(['        Compute Impact Matrix in file "',handles.file0,'.w"']);
    
%     pause(0.1);
%     close(handles.str);
    handles.msg=['      Impact Matrix Computed in file "',handles.file0,'.w"'];
    uiwait(msgbox(handles.msg));
%     guidata(hObject, handles);
    
    %%%% Solve Sensor Placement
%      set(handles.LoadImpactMatrix,'enable','off');
%     set(handles.Solve,'enable','off');
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

    if exist([pathname,handles.file0,'.w'],'file')==2
        set(handles.Solve,'enable','on');
        handles.Solve.BackgroundColor=[0 1 0];

        if exist([pathname,handles.file0,'.w'],'file')==2
            set(handles.FileTextW,'String',[handles.file0,'.w']);
        end
    end
    
    handles.pp=DefaultSolveParameters(hObject,handles);
    
    handles.msg = '';
    
    % Update handles structure
    guidata(hObject, handles);
    
    
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
    
    set(handles.Exhaustive,'enable','on');
    set(handles.Evolutionary,'enable','on');
    set(handles.Exhaustive,'Value',1);
    set(handles.Evolutionary,'Value',0);
    set(handles.PopulationSize_Data,'String',pp.PopulationSize_Data);
    set(handles.ParetoFraction_Data,'String',pp.ParetoFraction_Data);
    set(handles.Generations_Data,'String',pp.Generations_Data);
    set(handles.numberOfSensors,'enable','on');
    set(handles.numberOfSensors,'String',pp.numberOfSensors);

    % Update handles structure
    guidata(hObject, handles);    
    
    
    
%     uiresume
    
% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    [file0,pathName] = uigetfile([pwd,'\RESULTS\*.0'],'Select the MATLAB *.0 file');
%     file0=[pathName,file0];
    file0=file0(1:end-2);
    
    if isnumeric(file0)
        file0=[];
    end
    if ~isempty((file0)) 
        load([pathName,file0,'.0'],'-mat');
        handles.file0=file0;
        if ~strcmp(handles.B.ProjectName,B.ProjectName) %|| ~exist([handles.file0,'.w'],'file')
            set(handles.start,'enable','off');
            set(handles.SensorThreshold,'enable','off');
            msgbox(['        Wrong File "',file0,'.0"'],'Error','modal');
            set(handles.FileText,'String','')
        else
            set(handles.start,'enable','on');
            set(handles.InhalationRate,'enable','on');
            set(handles.SensorThreshold,'enable','on');
            SensorThreshold=0.75;
            set(handles.SensorThreshold,'String',SensorThreshold);
            InhalationRate=0.5;
            ZonesOccupancyTableFunction(hObject, eventdata, handles) 
            set(handles.InhalationRate,'String',InhalationRate);
            set(handles.FileText,'String',[handles.file0,'.0'])
        end
        handles.P=P;
        hanldes.B=B;
        
        %Sensor Placement Panel Initialization
%         set(handles.FileText0,'String',[handles.file0,'.0'])
        set(handles.Solve,'enable','off');
        set(handles.FileTextW,'String','');
        set(handles.Solve,'enable','off');
        handles.Solve.BackgroundColor=[0.94 0.94 0.94];

        set(handles.PopulationSize_Data,'enable','off');
        set(handles.ParetoFraction_Data,'enable','off');
        set(handles.Generations_Data,'enable','off');
        set(handles.numberOfSensors,'enable','off');
        set(handles.Exhaustive,'enable','off');
        set(handles.Evolutionary,'enable','off');
        
        
        % Update handles structure
        guidata(hObject, handles);
    end

% --- Executes on mouse press over axes background.
function axes2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function SensorThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to SensorThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SensorThreshold as text
%        str2double(get(hObject,'String')) returns contents of SensorThreshold as a double


% --- Executes during object creation, after setting all properties.
function SensorThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SensorThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function InhalationRate_Callback(hObject, eventdata, handles)
% hObject    handle to InhalationRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of InhalationRate as text
%        str2double(get(hObject,'String')) returns contents of InhalationRate as a double


% --- Executes during object creation, after setting all properties.
function InhalationRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InhalationRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in ZoneTable.
function ZoneTable_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to ZoneTable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

    ZoneTable = get(handles.ZoneTable,'data');

    row = eventdata.Indices(1);
    col = eventdata.Indices(2);
    edit = eventdata.EditData;
    previous = eventdata.PreviousData;
    new = eventdata.NewData;

    edit = str2num(edit);
    d = length(edit);

    % Column1 %
    if d==1 && row==1 && edit>-1
        ZoneTable(row,col)= new;
        set(handles.ZoneTable,'data',ZoneTable);
    else 
        ZoneTable(row,col)=previous;
        set(handles.ZoneTable,'data',ZoneTable);
    end
    


% --- Executes when user attempts to close ComputeImpactMatricesGui.
function ComputeImpactMatricesGui_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to ComputeImpactMatricesGui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
handles.msg = '';
uiresume


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
    if SuccessFlag~=0
        uistack(handles.ComputeImpactMatricesGui,'top');
        guidata(hObject, handles);
        uiresume
    end

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
            handles.Solve.BackgroundColor=[0.94 0.94 0.94];

%             set(handles.LoadImpactMatrix,'enable','off');
            msgbox(['        Wrong File "',pathfileW,'.w"'],'Error','modal');
            set(handles.FileTextW,'String','')
        else
            set(handles.Solve,'enable','on');
            handles.Solve.BackgroundColor=[0 1 0];

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
            handles.Solve.BackgroundColor=[0.94 0.94 0.94];

            set(handles.LoadImpactMatrix,'enable','off');
            msgbox(['        Wrong File "',pathfile0,'.0"'],'Error','modal');
%             set(handles.FileText0,'String','')
        else
            set(handles.LoadImpactMatrix,'enable','on');
            set(handles.Solve,'enable','off');
            handles.Solve.BackgroundColor=[0.94 0.94 0.94];

%             set(handles.FileText0,'String',[file0,'.0']);
        end
        handles.P=P;
        hanldes.B=B;
        % Update handles structure
        guidata(hObject, handles);
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
