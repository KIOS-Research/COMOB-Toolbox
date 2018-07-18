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

function varargout = MatlabContamToolbox(varargin)
% MATLABCONTAMTOOLBOX MATLAB code for MatlabContamToolbox.fig
%      MATLABCONTAMTOOLBOX, by itself, creates a new MATLABCONTAMTOOLBOX or raises the existing
%      singleton*.
%
%      H = MATLABCONTAMTOOLBOX returns the handle to a new MATLABCONTAMTOOLBOX or the handle to
%      the existing singleton*.
%
%      MATLABCONTAMTOOLBOX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MATLABCONTAMTOOLBOX.M with the given input arguments.
%
%      MATLABCONTAMTOOLBOX('Property','Value',...) creates a new MATLABCONTAMTOOLBOX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MatlabContamToolbox_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MatlabContamToolbox_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MatlabContamToolbox

% Last Modified by GUIDE v2.5 12-May-2018 11:57:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MatlabContamToolbox_OpeningFcn, ...
                   'gui_OutputFcn',  @MatlabContamToolbox_OutputFcn, ...
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


% --- Executes just before MatlabContamToolbox is made visible.
function MatlabContamToolbox_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MatlabContamToolbox (see VARARGIN)
% Clear Building properties and other variables from base workspace
evalin( 'base', 'clear' )
clc % Clear the command window
% Choose default command line output for MatlabContamToolbox
handles.output = hObject;

% Position the figure in the center of the screen
movegui(handles.MatlabContamToolbox,'center')

% To include all the folders and subfolders inside the main folder
path(path,genpath(pwd));

% KIOS Logo
rgb= imread('KIOS.jpg');
axes(handles.axes2)
image(rgb)
axis on
set(handles.axes2,'xtick',[]);
set(handles.axes2,'ytick',[]);
set(handles.axes2,'Parent',handles.axes1a)
% uistack(handles.axes2, 'top')

% UCY Logo
rgb= imread('ucy.jpg');
axes(handles.axes3)
image(rgb)
axis on
set(handles.axes3,'xtick',[]);
set(handles.axes3,'ytick',[]);
set(handles.axes3,'Parent',handles.axes1a)


% Tepak Logo
rgb= imread('tepak2.png');
axes(handles.axes4)
image(rgb)
axis on
set(handles.axes4,'xtick',[]);
set(handles.axes4,'ytick',[]);
set(handles.axes4,'Parent',handles.axes1a)
set(handles.axes1,'Parent',handles.axes1a)

%Set off until open CONTAM project file
set(handles.LevelUp, 'Enable', 'off')
set(handles.LevelDown, 'Enable', 'off')
set(handles.ZoneID, 'Enable', 'off')
set(handles.PathID, 'Enable', 'off')

set(handles.CreateScenarios, 'Enable', 'off')
handles.Algorithms.Enable='off';
handles.SimulateScenarios.Enable='off';
set(handles.SetDistributedSubsystems, 'Enable', 'off')
handles.ResultsTab.Enable='off';
handles.DefaultBuildingProperties.Enable='off';
set(handles.CDIResults, 'Enable', 'off')
set(handles.ComputeImpactMatrix, 'Enable', 'off')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles.ResultsInformationListbox.Visible='off';
handles.SaveResults.Visible='off';
handles.DisplayResults.Visible='off';
handles.LoadResults.Visible='off';
handles.RemoveFiles.Visible='off';
handles.ChooseSimulationData.Visible='off';
handles.RunSimulation.Visible='off';
handles.LoadScenariosM.Visible='off';
handles.ScenariosFileTextM.Visible='off';
handles.ResultsFileText.Visible='off';
handles.DisplayResults.Visible='off';
handles.ResultsListbox.Visible='off';


% Enable Building Properties button
handles.DefaultBuildingProperties.Enable='off';
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MatlabContamToolbox wait for user response (see UIRESUME)
% uiwait(handles.MatlabContamToolbox);


% --- Outputs from this function are returned to the command line.
function varargout = MatlabContamToolbox_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function Open_Callback(hObject, eventdata, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Clear Building properties and other variables from base workspace
evalin( 'base', 'clear' )

[ProjectName,ProjectPath] = uigetfile('PROJECTS\*.prj', ...
                                      'Select a CONTAM Project File (*.prj)');

if ProjectName~=0
    
    msg = '>> Loading CONTAM Project ...';
    pause(0.2)
    
    % reads Data from CONTAM project file
    B = readPRJ(ProjectPath,ProjectName);
    
    if ~strcmp(B.X.project{1}(1:11),'ContamW 3.1')
         uiwait(msgbox(['The version of the sellected project file (i.e.,ContamW ' X.project{1}(8:11)...
                        ') is not supported. Please use a  CONTAM version 3.1 project file.'], 'Error', 'error'))
                    return;
    end
    
    set(handles.MatlabContamToolbox, 'Name', ['Matlab - CONTAM Toolbox: ',B.ProjectName])

        
    if B.nLevel>1
       set(handles.LevelUp, 'Enable', 'on', 'Visible', 'on')
    else
       set(handles.LevelUp, 'Enable', 'off' )
       set(handles.LevelDown, 'Enable', 'off')
    end

    set(handles.ZoneID, 'Enable', 'on')
    set(handles.PathID, 'Enable', 'on')
    set(handles.CreateScenarios, 'Enable', 'on')
    handles.Algorithms.Enable='on';
    handles.SimulateScenarios.Enable='on';
    set(handles.SetDistributedSubsystems, 'Enable', 'on')
    set(handles.CDIResults, 'Enable', 'on')
    set(handles.ComputeImpactMatrix, 'Enable', 'on')
    handles.ResultsTab.Enable='on';
    handles.DefaultBuildingProperties.Enable='on';
        
    handles.CDI0=DefaultParametersCDI;
    handles.B = B;
    
    if handles.axes2~=0
        delete(handles.axes2);
        delete(handles.axes3);
        delete(handles.axes4);
        handles.axes2 = 0;
        handles.axes3 = 0;
        handles.axes4 = 0;
    end
      
    % The plotB function plots the building schematic
    [B.Size B.X1 B.Y1 handles.cmp B.ZoneID] = plotB(B.X,handles.axes1,...
                                                    handles.axes5,...
                                                    B.LevelCounter,...
                                                    B.Decomposition,...
                                                    B.clr,...
                                                    B.WindDirection,...
                                                    B.C,...
                                                    get(handles.ZoneID,'Value'),...
                                                    get(handles.PathID,'Value'));   
    
    % Enable Building Properties button
    handles.DefaultBuildingProperties.Enable='on';
    handles.AllPossiblePartitions={};
    % Update handles structure
    guidata(hObject, handles);    
end



% --- Executes on button press in ZoneID.
function ZoneID_Callback(hObject, eventdata, handles)
% hObject    handle to ZoneID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ZoneID


B = handles.B;
temp_obj=findobj(0,'Name','Sensor Placement Results');

if ~isempty(temp_obj)
    figure2_handles=guidata(temp_obj);
    figure2_handles.B.LevelCounter=B.LevelCounter;
    figure2_handles.ZoneID=handles.ZoneID.Value;
    figure2_handles.PathID=handles.PathID.Value;

    SensorPlacementResults('VisualizeInMainWindow',figure2_handles)
else
    plotB(B.X,handles.axes1,...
          handles.axes5,...
          B.LevelCounter,...
          B.Decomposition,...
          B.clr,...
          B.WindDirection,...
          B.C,...
          get(handles.ZoneID,'Value'),...
          get(handles.PathID,'Value'));
end

% --- Executes on button press in PathID.
function PathID_Callback(hObject, eventdata, handles)
% hObject    handle to PathID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PathID
B = handles.B;
temp_obj=findobj(0,'Name','Sensor Placement Results');

if ~isempty(temp_obj)
    figure2_handles=guidata(temp_obj);
    figure2_handles.B.LevelCounter=B.LevelCounter;
    figure2_handles.PathID=handles.PathID.Value;
    figure2_handles.ZoneID=handles.ZoneID.Value;

    SensorPlacementResults('VisualizeInMainWindow',figure2_handles)
else
    plotB(B.X,handles.axes1,...
          handles.axes5,...
          B.LevelCounter,...
          B.Decomposition,...
          B.clr,...
          B.WindDirection,...
          B.C,...
          get(handles.ZoneID,'Value'),...
          get(handles.PathID,'Value'));
end
% --- Executes on button press in LevelUp.
function LevelUp_Callback(hObject, eventdata, handles)
% hObject    handle to LevelUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

B = handles.B;

B.LevelCounter = B.LevelCounter+1; % goes up one level


temp_obj=findobj(0,'Name','Sensor Placement Results');

if ~isempty(temp_obj)
    figure2_handles=guidata(temp_obj);
    figure2_handles.B.LevelCounter=B.LevelCounter;
    figure2_handles.ZoneID=handles.ZoneID.Value;
    figure2_handles.PathID=handles.PathID.Value;

% SensorPlacementResults(VisualizeInMainWindow(figure2.handles))
    SensorPlacementResults('VisualizeInMainWindow',figure2_handles)
else
% plots the building schematic
    plotB(B.X,handles.axes1,...
          handles.axes5,...
          B.LevelCounter,...
          B.Decomposition,...
          B.clr,...
          B.WindDirection,...
          B.C,...
          get(handles.ZoneID,'Value'),...
          get(handles.PathID,'Value'));
end  
 % if last level 
if B.LevelCounter==B.nLevel
    set(handles.LevelUp, 'Enable', 'off')
else
    set(handles.LevelUp, 'Enable', 'on')
end

% if not first level
if B.LevelCounter ~= 1
    set(handles.LevelDown, 'Enable', 'on')
else
    set(handles.LevelDown, 'Enable', 'off')
end

handles.B = B;

guidata(hObject, handles);  

% --- Executes on button press in LevelDown.
function LevelDown_Callback(hObject, eventdata, handles)
% hObject    handle to LevelDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

B = handles.B;

B.LevelCounter = B.LevelCounter-1; % goes down one level


temp_obj=findobj(0,'Name','Sensor Placement Results');

if ~isempty(temp_obj)
    figure2_handles=guidata(temp_obj);
    figure2_handles.B.LevelCounter=B.LevelCounter;
    figure2_handles.ZoneID=handles.ZoneID.Value;
    figure2_handles.PathID=handles.PathID.Value;

% SensorPlacementResults(VisualizeInMainWindow(figure2.handles))
    SensorPlacementResults('VisualizeInMainWindow',figure2_handles)
else
    % plots the building schematic
    plotB(B.X,handles.axes1,...
          handles.axes5,...
          B.LevelCounter,...
          B.Decomposition,...
          B.clr,...
          B.WindDirection,...
          B.C,...
          get(handles.ZoneID,'Value'),...
          get(handles.PathID,'Value'));
  
end  
% if last level 
if B.LevelCounter==B.nLevel
    set(handles.LevelUp, 'Enable', 'off')
else
    set(handles.LevelUp, 'Enable', 'on')
end

% if not first level 
if B.LevelCounter ~= 1
    set(handles.LevelDown, 'Enable', 'on')
else
    set(handles.LevelDown, 'Enable', 'off')
end

handles.B = B;
guidata(hObject, handles);

% --------------------------------------------------------------------
function CDIParameters_Callback(hObject, eventdata, handles)
% hObject    handle to CDIParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

B = handles.B;
%Compute Nominal Amat
[Amat Qext Flows] = computeAmatrix(B,B.WindDirection,...
                                   B.WindSpeed,...
                                   B.AmbientTemperature,...
                                   B.AmbientPressure,...
                                   B.v, B.Temp, B.Openings);
if strcmp(eventdata.Source.Tag,'Centralized')
    handles.CDI0.ActiveDistributed=0;
elseif strcmp(eventdata.Source.Tag,'Distributed')
    if isempty(handles.CDI0.nSub) || isempty(handles.CDI0.Subsystems{1})
        
        selection = questdlg(['Subsystems have to be defined before running Distributed CDI. Do you wish to define them now?'],...
          'Close Request Function',...
          'Yes','No','Yes'); 
       switch selection, 
          case 'No',
              return
           case 'Yes',
%             SetDistributedSubsystems_Callback(hObject, eventdata, handles);
            arguments1.CDI = handles.CDI0;
            arguments1.B = handles.B;
            
            if isfield(handles,'AllPossiblePartitions')
                if ~isempty(handles.AllPossiblePartitions)
                    arguments1.AllPossiblePartitions=handles.AllPossiblePartitions;
                else
                    arguments1.AllPossiblePartitions={};
                end
            else
                arguments1.AllPossiblePartitions={};
            end

            [A B C] = SetDistributedSubsystemsGUI(arguments1);
            if ~any(any(B.B.Decomposition))
                return
            end
            handles.CDI0 = B.CDI;
            handles.B = B.B;
            handles.AllPossiblePartitions=C;


            if isfield(handles.B.X,'Sim')
                handles.B.X = rmfield(handles.B.X ,'Sim');
            end

            % plots the building schematic
            plotB(handles.B.X,handles.axes1,...
                  handles.axes5,...
                  handles.B.LevelCounter,...
                  handles.B.Decomposition,...
                  handles.B.clr,...
                  handles.B.WindDirection,...
                  handles.B.C,...
                  get(handles.ZoneID,'Value'),...
                  get(handles.PathID,'Value'));
  
       end
    end
  handles.CDI0.ActiveDistributed=1;
end

% arguments.AlgorithmSelection=eventdata.Source.Parent.Tag;
arguments.CDI0=handles.CDI0;
arguments.B=handles.B; % Nominal Building Paramenters
arguments.Amat = Amat; % Nominal A matrix
clear B
guidata(hObject, handles);

[A B]=CDIParametersGUI3(arguments);
handles.CDI0 = B.CDI0;
handles.B = B.B;
guidata(hObject, handles);
% var=CDIParameter(handles)

% --------------------------------------------------------------------
function RunCDIalgorithm_Callback(hObject, eventdata, handles)
% hObject    handle to RunCDIalgorithm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(findobj('type','figure','name','Run Multiple CDI'))

load([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');
 
if exist('File0.File','file')==2 
    load([pwd,'\RESULTS\','File0.File'],'-mat');
    if exist([pathname,file0],'file')==2
        if ~isempty(file0) 
            load([pathname,file0],'-mat');
        else
            B.ProjectName = handles.B.ProjectName;
        end
    else
        B.ProjectName=[];
    end
else
    file0=[];
end

arguments.file0=file0(1:end-2);
arguments.B=handles.B;
arguments.CDI0=handles.CDI0;
arguments.AlgorithmSelection=eventdata.Source.Tag;
[A B] = RunMultipleCDIGUI(arguments);

guidata(hObject, handles);

% --------------------------------------------------------------------
function ComputeImpactMatrix_Callback(hObject, eventdata, handles)
% hObject    handle to ComputeImpactMatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');
 
if exist('File0.File','file')==2 
    load([pwd,'\RESULTS\','File0.File'],'-mat');
    if exist([pathname,file0],'file')==2
        if ~isempty(file0) 
            load([pathname,file0],'-mat');
        else
            B.ProjectName = handles.B.ProjectName;
        end
    else
        B.ProjectName=[];
    end
else
    file0=[];
end

arguments.file0=file0(1:end-2);
arguments.B=handles.B;

[A B]=ComputeImpactMatricesGui(arguments);

guidata(hObject, handles);

% --------------------------------------------------------------------
function SolveSensorPlacement_Callback(hObject, eventdata, handles)
% hObject    handle to SolveSensorPlacement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(findobj('type','figure','name','Solve Sensor Placement'))
load([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');

if exist('File0.File','file')==2 
    load([pwd,'\RESULTS\','File0.File'],'-mat');
    if exist([pathname,file0],'file')==2
        if ~isempty(file0) 
                load([pathname,file0],'-mat');
            if exist([pathname,file0(1:end-2),'.w'],'file')==2
            else
                B.ProjectName=[];
            end
        else
            B.ProjectName = handles.B.ProjectName;
        end
    else
        B.ProjectName=[];
    end
else
    file0=[];
end

arguments.file0=file0(1:end-2);
arguments.B=handles.B;

[A B]=SolveSensorPlacementGui(arguments); % Solve Sensor Placement

guidata(hObject, handles);

% --------------------------------------------------------------------
function CreateScenarios_Callback(hObject, eventdata, handles)
% hObject    handle to CreateScenarios (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[A B] = CreateScenariosGui(handles.B);

handles.B = B.B;

if isfield(handles.B,'X')
    if isfield(handles.B.X,'Sim')
        handles.B.X = rmfield(handles.B.X ,'Sim');
    end
end
% plots the building schematic
plotB(handles.B.X,handles.axes1,...
      handles.axes5,...
      handles.B.LevelCounter,...
      handles.B.Decomposition,...
      handles.B.clr,...
      handles.B.WindDirection,...
      handles.B.C,...
      get(handles.ZoneID,'Value'),...
      get(handles.PathID,'Value'));


guidata(hObject, handles);

% --------------------------------------------------------------------
function RunMultipleScenarios_Callback(hObject, eventdata, handles)
% hObject    handle to RunMultipleScenarios (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(findobj('type','figure','name','Run Multiple Scenarios'))

load([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');
 
if exist('File0.File','file')==2 
    load([pwd,'\RESULTS\','File0.File'],'-mat');
    if exist([pathname,file0],'file')==2
        if ~isempty(file0) 
            load([pathname,file0],'-mat');
        else
            B.ProjectName = handles.B.ProjectName;
        end
    else
        B.ProjectName=[];
    end
else
    file0=[];
end

for i=1:handles.B.nZones 
    handles.B.clr{i} = 'w'; % color for the zone area    
end

arguments.file0=file0(1:end-2);
arguments.B=handles.B;

[A B] = runMultipleScenariosGui(arguments);

guidata(hObject, handles);

% --------------------------------------------------------------------
function SetDistributedSubsystems_Callback(hObject, eventdata, handles)
% hObject    handle to SetDistributedSubsystems (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arguments.CDI = handles.CDI0;
arguments.B = handles.B;
if isfield(handles,'AllPossiblePartitions')
    if ~isempty(handles.AllPossiblePartitions)
        arguments.AllPossiblePartitions=handles.AllPossiblePartitions;
    else
        arguments.AllPossiblePartitions={};
    end
else
    arguments.AllPossiblePartitions={};
end

[A,B,C] = SetDistributedSubsystemsGUI(arguments);

handles.CDI0 = B.CDI;
handles.B = B.B;
handles.AllPossiblePartitions=C;

if isfield(handles.B.X,'Sim')
    handles.B.X = rmfield(handles.B.X ,'Sim');
end

% plots the building schematic
plotB(handles.B.X,handles.axes1,...
      handles.axes5,...
      handles.B.LevelCounter,...
      handles.B.Decomposition,...
      handles.B.clr,...
      handles.B.WindDirection,...
      handles.B.C,...
      get(handles.ZoneID,'Value'),...
      get(handles.PathID,'Value'));
  
  
guidata(hObject, handles);

% --------------------------------------------------------------------
function SensorData_Callback(hObject, eventdata, handles)
% hObject    handle to SensorData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[A B]=SensorDataGUI(handles.B);

handles.B = B;

if isfield(handles.B.X,'Sim')
    handles.B.X = rmfield(handles.B.X ,'Sim');
end

% plots the building schematic
plotB(handles.B.X,handles.axes1,...
      handles.axes5,...
      handles.B.LevelCounter,...
      handles.B.Decomposition,...
      handles.B.clr,...
      handles.B.WindDirection,...
      handles.B.C,...
      get(handles.ZoneID,'Value'),...
      get(handles.PathID,'Value'));

guidata(hObject, handles);
% --------------------------------------------------------------------
function CDIResults_Callback(hObject, eventdata, handles)
% hObject    handle to CDIResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(findobj('type','figure','name','CDI Results'))

load([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');
 
if exist('File0.File','file')==2 
    load([pwd,'\RESULTS\','File0.File'],'-mat');
    if exist([pathname,file0],'file')==2
        if ~isempty(file0) 
            load([pathname,file0],'-mat');
        else
            B.ProjectName = handles.B.ProjectName;
        end
    else
        B.ProjectName=[];
    end
else
    file0=[];
end

arguments.file0=file0(1:end-2);
arguments.B=handles.B;
CDIResultsGUI2(arguments);

% --------------------------------------------------------------------
function ScenarioResults_Callback(hObject, eventdata, handles)
% hObject    handle to ScenarioResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


close(findobj('type','figure','name','Scenario Results'))

load([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');
 
if exist('File0.File','file')==2 
    load([pwd,'\RESULTS\','File0.File'],'-mat');
    if exist([pathname,file0],'file')==2
        if ~isempty(file0) 
            load([pathname,file0],'-mat');
        else
            B.ProjectName = handles.B.ProjectName;
        end
    else
        B.ProjectName=[];
    end
else
    file0=[];
end

arguments.file0=file0(1:end-2);
arguments.B=handles.B;
ScenarioResultsGUI(arguments);


% --- Executes on button press in ChooseSimulationData.
function ChooseSimulationData_Callback(hObject, eventdata, handles)
% hObject    handle to ChooseSimulationData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

arguments.Sim = handles.Sim;
arguments.B = handles.BR;
[A B] = SimulationDataGUI(arguments);
handles.Sim = B.Sim;

% Update handles structure
guidata(hObject, handles);
% --- Executes on button press in DisplayResults.
function DisplayResults_Callback(hObject, eventdata, handles)
% hObject    handle to DisplayResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

file0 = get(handles.ScenariosFileTextM,'String');
fileR = get(handles.ResultsFileText,'String');
[Path Name Extension] =  fileparts(fileR);
SceNum = regexp(Extension,'\d+','match');
Extn = Extension(1:end-length(SceNum{1}));
arguments.pathName = handles.pathName;
arguments.file0=file0;
arguments.fileR=fileR;
switch Extn            
    case '.c'        
        ScenarioResultsGUI(arguments);        
    case '.cdi'
        CDIResultsGUI2(arguments);        
end
            


% --------------------------------------------------------------------
function Save_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F = getframe(handles.axes1);
[im,map] = frame2im(F);

if isfield(handles, 'pathfileR')
    [Path Name Extension] =  fileparts(handles.pathfileR);
    [file0,pathname] = uiputfile([Path,'\','*.png'],'Save Results',[Path,'\',Name,'.png']);
else
    if isfield(handles, 'B')
        [file0,pathname] = uiputfile([pwd,'\RESULTS\','*.png'],'Save Results',[pwd,'\RESULTS\',handles.B.ProjectName(1:end-4),'.png']);
    else
        warndlg('Save failed. No building model has been loaded.','! Warning !')
        return
    end
end

if isnumeric(file0)
    file0=[];
end

if ~isempty((file0))
    imwrite(im,[pathname,file0]);
end

% --------------------------------------------------------------------
function DefaultBuildingProperties_Callback(hObject, eventdata, handles)
% hObject    handle to DefaultBuildingProperties (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
setDefaultBuildingPropertiesWorkspace(handles.B)
openvar('DefaultBuildingProperties')
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Algorithms_Callback(hObject, eventdata, handles)
% hObject    handle to Algorithms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Centralized_Callback(hObject, eventdata, handles)
% hObject    handle to Centralized (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Distributed_Callback(hObject, eventdata, handles)
% hObject    handle to Distributed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function SensorPlacementResults_Callback(hObject, eventdata, handles)
% hObject    handle to SensorPlacementResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(findobj('type','figure','name','CDI Results'))

load([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');
 
if exist('File0.File','file')==2 
    load([pwd,'\RESULTS\','File0.File'],'-mat');
    if exist([pathname,file0],'file')==2
        if ~isempty(file0) 
            load([pathname,file0],'-mat');
            temp_file_name=regexp(file0,'\.','split');
            filey=[temp_file_name{1} '.y0'];
            if exist([pathname,filey],'file')==2
                           
                if ~isempty(filey) 
                     arguments.filey=filey;
                end
            else
                arguments.filey=[];
            end
        else
            B.ProjectName = handles.B.ProjectName;
        end
    else
        B.ProjectName=[];
    end
else
    file0=[];
end

arguments.file0=file0(1:end-2);
arguments.B=handles.B;
arguments.axes1=handles.axes1;
arguments.axes5=handles.axes5;
arguments.ZoneID=get(handles.ZoneID,'Value');
arguments.PathID=get(handles.PathID,'Value');

handles.File.Enable='off';
handles.SimulateScenarios.Enable='off';
handles.Algorithms.Enable='off';
handles.Results.Enable='off';


SensorPlacementResults(arguments);

% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function ResultsTab_Callback(hObject, eventdata, handles)
% hObject    handle to ResultsTab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function About_Callback(hObject, eventdata, handles)
% hObject    handle to About (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
about;

% --------------------------------------------------------------------
function Instructions_Callback(hObject, eventdata, handles)
% hObject    handle to Instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('Instructions.html');


% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)