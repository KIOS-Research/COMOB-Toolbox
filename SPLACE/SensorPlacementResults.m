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

function varargout = SensorPlacementResults(varargin)
% SENSORPLACEMENTRESULTS MATLAB code for SensorPlacementResults.fig
%      SENSORPLACEMENTRESULTS, by itself, creates a new SENSORPLACEMENTRESULTS or raises the existing
%      singleton*.
%
%      H = SENSORPLACEMENTRESULTS returns the handle to a new SENSORPLACEMENTRESULTS or the handle to
%      the existing singleton*.
%
%      SENSORPLACEMENTRESULTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SENSORPLACEMENTRESULTS.M with the given input arguments.
%
%      SENSORPLACEMENTRESULTS('Property','Value',...) creates a new SENSORPLACEMENTRESULTS or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SensorPlacementResults_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SensorPlacementResults_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SensorPlacementResults

% Last Modified by GUIDE v2.5 12-May-2018 17:45:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SensorPlacementResults_OpeningFcn, ...
                   'gui_OutputFcn',  @SensorPlacementResults_OutputFcn, ...
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

% --- Executes just before SensorPlacementResults is made visible.
function SensorPlacementResults_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SensorPlacementResults (see VARARGIN)

temp_handle=findobj('Tag','MatlabContamToolbox');
temp_handle.Pointer='watch';
drawnow;


% Choose default command line output for SensorPlacementResults
handles.output = hObject;
handles.file0 = varargin{1}.file0;
    handles.B = varargin{1}.B;
    handles.filey=varargin{1}.filey;
    handles.Main_window_axes1=varargin{1}.axes1;
    handles.Main_window_axes5=varargin{1}.axes5;
    handles.ZoneID=varargin{1}.ZoneID;
    handles.PathID=varargin{1}.PathID;
    
    % Results Table Initialization
    SensorPlacementResultsTable_initilization(hObject, eventdata)  

    % Initialization of selection
    handles.Rselection=1;
    
%Load results if exist
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
        set(handles.ScenarioFile,'String','')
    else
         set(handles.ScenarioFile,'String',[handles.file0,'.0'])
        if exist([pathname,handles.file0,'.y0'],'file')==2
            if exist([pathname,handles.file0,'.y0'],'file')==2
                set(handles.SensorPlacementResultFile,'String',[handles.file0,'.y0']);
                load([pathname,handles.filey],'-mat')
                handles.SensorPlacementResults=Y;
                FillData(hObject,handles);
            end
            set(handles.LoadScenarioFile,'enable','on');
        else
            set(handles.LoadSensorPlacementResults,'enable','on');
        end
    end    

% Update handles structure
guidata(hObject, handles);
temp_handle.Pointer='arrow';
clear temp_handle
initialize_gui(hObject, handles, false);

% UIWAIT makes SensorPlacementResults wait for user response (see UIRESUME)
% uiwait(handles.SensorPlacementResults_GUI);

function FillData(hObject,handles)

  handles.SensorPlacementResultsSelection.String{1}='No selection';
%                 SenzorZoneNames_temp={};
                for i=1:size(handles.SensorPlacementResults.x,1)
                    handles.SensorPlacementResultsSelection.String{i+1}=['Sensor Placement ' num2str(i)];
%                     SenzorZoneNames_temp{1}={''};
                    temp_s={};
                    [~,indj,S]=find(handles.SensorPlacementResults.x(i,:));
                    s_num=sum(S);
                    for j=1:s_num
                        if j==1
                            if  s_num==1
                                temp_s=sprintf('[  Z%d  ]',indj(j));
                            else
                                temp_s=sprintf('[  Z%d,',indj(j));
                            end
                        else
                            if j==s_num
                                temp_s=strcat(temp_s,sprintf('  Z%d  ]',indj(j)));
                            else
                                temp_s=strcat(temp_s,sprintf('  Z%d,',indj(j)));
                            end
                           % SenzorZoneNames_temp{i}={SenzorZoneNames_temp{i} ' Z' num2str(handles.SensorPlacementResults.xIndex{i}(j))};
                        end
                    end
                    SenzorZoneNames_temp{i}=temp_s;
                end
                r_names_temp={};
                for i=1:size(handles.SensorPlacementResults.F,1)
                    handles.SensorPlacementResultsTable.Data{i,1}=sprintf('%d',handles.SensorPlacementResults.F(i,1));
                    handles.SensorPlacementResultsTable.Data{i,2}=sprintf('%.4f',handles.SensorPlacementResults.F(i,2));
                    handles.SensorPlacementResultsTable.Data{i,3}=sprintf('%.4f',handles.SensorPlacementResults.F(i,3));             
                    handles.SensorPlacementResultsTable.Data{i,4}=SenzorZoneNames_temp{i};
                    r_names_temp{i}=['Sensors Placement ' num2str(i)];
                end
                handles.SensorPlacementResultsTable.ColumnName={'Sens. Num.','Mean','Max','Zones'};
                handles.SensorPlacementResultsTable.RowName=r_names_temp;


guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = SensorPlacementResults_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.

% Update handles structure
guidata(handles.SensorPlacementResults_GUI, handles);

function VisualizeInMainWindow(handles)

            for i=1:length(handles.B.clr)
                handles.B.clr{i} = [1 1 1];
            end
            
            if handles.Rselection~=1
                [~,indj]=find(handles.SensorPlacementResults.x(handles.Rselection-1,:));
                for i=1:length(indj)
                    handles.B.clr{indj(i)} = [153/255 255/255 51/255];
                end
            end
            
            plotB(handles.B.X,handles.Main_window_axes1,...
                  handles.Main_window_axes5,...
                  handles.B.LevelCounter,...
                  handles.B.Decomposition,...
                  handles.B.clr,...
                  handles.B.WindDirection,...
                  handles.B.C,...
                  handles.ZoneID,...
                  handles.PathID);
% Added to store in handles any changes made by the MatlabContamToolbox
% main figure
guidata(handles.SensorPlacementResults_GUI, handles);
                
            


% --- Executes on selection change in ResultsListbox.
function ResultsListbox_Callback(hObject, eventdata, handles)
% hObject    handle to ResultsListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns ResultsListbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ResultsListbox
lineResults = get(handles.ResultsListbox,'Value');
StringResults = get(handles.ResultsListbox,'String');

            tline = StringResults(lineResults);
            tline = regexp(tline, '\s*','split');
            tline = tline{1};
            
            if length(tline)>2
                SensorsZonesID=tline(6:end);
                for i=1:handles.B.nZones 
                    handles.B.clr{i} = 'w';
                end
                IndexZones=zeros(1,handles.B.nZones);
                for i=2:2:length(SensorsZonesID)
                    IndexZones(i-1) = str2double(regexprep(SensorsZonesID(i),'[()]',''));
                    if IndexZones(i-1)~=0
                        handles.B.clr{IndexZones(i-1)} = [153/255 255/255 51/255];
                    end
                end

                plotB(handles.B.X,handles.Main_window_axes1,...
                      handles.Main_window_axes5,...
                      handles.B.LevelCounter,...
                      handles.B.Decomposition,...
                      handles.B.clr,...
                      handles.B.WindDirection,...
                      handles.B.C,...
                      handles.ZoneID,...
                      handles.PathID);
            end
            

guidata(hObject,handles)   

% --- Executes during object creation, after setting all properties.
function ResultsListbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ResultsListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LoadSensorPlacementResults.
function LoadSensorPlacementResults_Callback(hObject, eventdata, handles)
% hObject    handle to LoadSensorPlacementResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filey,pathname] = uigetfile('*.y0','Select the MATLAB *.0 file',[pwd,'\RESULTS\',]);
    filey=filey(1:end-3);
    
     handles.SensorPlacementResults_GUI.Pointer='watch';

    if strcmp(filey,handles.file0)
    
        if isnumeric(filey)
            filey=[];
        end
            if exist([pathname,filey,'.y0'],'file')==2
                    handles.filey=[filey '.y0'];
                    set(handles.SensorPlacementResultFile,'String',handles.filey);
                    load([pathname,handles.filey],'-mat')
                    handles.SensorPlacementResults=Y;          
            else
                set(handles.LoadSensorPlacementResults,'enable','on');
            end

            FillData(hObject,handles)
    else
         msgbox(['        Wrong File "',filey,'.y0" for the selected scenario'],'Error','modal');
            set(handles.SensorPlacementResultFile,'String','');
    end     
    
   handles.SensorPlacementResults_GUI.Pointer='arrow';
 
guidata(hObject,handles)   


% --- Executes on button press in LoadScenarioFile.
function LoadScenarioFile_Callback(hObject, eventdata, handles)
% hObject    handle to LoadScenarioFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file0,pathName] = uigetfile('*.0','Select the MATLAB *.0 file',[pwd,'\RESULTS\',]);
%     file0=[pathName,file0];
    file0=file0(1:end-2);
    
    if isnumeric(file0)
        file0=[];
    end
    if ~isempty((file0)) 
        load([pathName,file0,'.0'],'-mat');
        handles.file0=file0;
        if ~strcmp(handles.B.ProjectName,B.ProjectName) %|| ~exist([handles.file0,'.w'],'file')
%             set(handles.start,'enable','off');
%             set(handles.SensorThreshold,'enable','off');
            msgbox(['        Wrong File "',file0,'.0"'],'Error','modal');
            set(handles.SensorPlacementResultFile,'String','')
        else

            set(handles.ScenarioFile,'String',[handles.file0,'.0']);
            set(handles.SensorPlacementResultFile,'String',[]);
            handles.SensorPlacementResultsSelection.Value=1;
            handles.Rselection=1;
            VisualizeInMainWindow(handles);
            SensorPlacementResultsTable_initilization(hObject,handles)            

        end
        handles.B=B;
        % Update handles structure
        figure(handles.SensorPlacementResults_GUI);
        guidata(hObject, handles);
    end

function SensorPlacementResultsTable_initilization(hObject,handles)

    
    r_names_temp={};
    for i=1:3
        r_names_temp{i}=['Sensors Placement ' num2str(i)];
    end
    handles.SensorPlacementResultsTable.ColumnName={'Sens. Num.','Mean','Max','Zones'};
    handles.SensorPlacementResultsTable.RowName=r_names_temp;
    handles.SensorPlacementResultsTable.Data=cell(3,3);

        
guidata(hObject, handles);


% --- Executes on selection change in SensorPlacementResultsSelection.
function SensorPlacementResultsSelection_Callback(hObject, eventdata, handles)
% hObject    handle to SensorPlacementResultsSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SensorPlacementResultsSelection contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SensorPlacementResultsSelection
handles.Rselection=eventdata.Source.Value;
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function SensorPlacementResultsSelection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SensorPlacementResultsSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ViewSolutionButton.
function ViewSolutionButton_Callback(hObject, eventdata, handles)
% hObject    handle to ViewSolutionButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
VisualizeInMainWindow(handles);
figure(handles.SensorPlacementResults_GUI)


% --- Executes when user attempts to close SensorPlacementResults_GUI.
function SensorPlacementResults_GUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to SensorPlacementResults_GUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

temp_obj=findobj(0,'Tag','MatlabContamToolbox');

if ~isempty(temp_obj)
    figure2_handles=guidata(temp_obj);
end

figure2_handles.File.Enable='on';
figure2_handles.SimulateScenarios.Enable='on';
figure2_handles.Algorithms.Enable='on';
figure2_handles.Results.Enable='on';

handles.Rselection=1;
VisualizeInMainWindow(handles)
% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in ExportSensorPlacementResults_Button.
function ExportSensorPlacementResults_Button_Callback(hObject, eventdata, handles)
% hObject    handle to ExportSensorPlacementResults_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 for i=1:size(handles.SensorPlacementResults.x,1)
    temp_s={};
    [~,indj,S]=find(handles.SensorPlacementResults.x(i,:));
    s_num=sum(S);
    for j=1:s_num
        if j==1
            if  s_num==1
                temp_s=sprintf('[  Z%d  ]',indj(j));
            else
                temp_s=sprintf('[  Z%d,',indj(j));
            end
        else
            if j==s_num
                temp_s=strcat(temp_s,sprintf('  Z%d  ]',indj(j)));
            else
                temp_s=strcat(temp_s,sprintf('  Z%d,',indj(j)));
            end
        end
    end
    SenzorZoneNames_temp{i}=temp_s;
 end
    % Row names are not used for now
    RowNames=[];
    for i=1:size(handles.SensorPlacementResults.F,1)
        RowNames{i}=['Sensors Placement ' num2str(i)];
    end
    
    VariableNames={'Sensor_Number','Mean','Max','Sensor_Zones'};

    SensorPlacementResults=table(handles.SensorPlacementResults.F(:,1),handles.SensorPlacementResults.F(:,2),handles.SensorPlacementResults.F(:,3),SenzorZoneNames_temp');
    SensorPlacementResults.Properties.VariableNames=VariableNames;
    
 assignin('base',['SensorPlacementResults_' handles.filey(1:end-3)],SensorPlacementResults);
openvar(['SensorPlacementResults_' handles.filey(1:end-3)]);
uiresume   
    
    
    
