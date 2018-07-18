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
function varargout = ScenarioResultsGUI(varargin)
% SCENARIORESULTSGUI MATLAB code for ScenarioResultsGUI.fig
%      SCENARIORESULTSGUI, by itself, creates a new SCENARIORESULTSGUI or raises the existing
%      singleton*.
%
%      H = SCENARIORESULTSGUI returns the handle to a new SCENARIORESULTSGUI or the handle to
%      the existing singleton*.
%
%      SCENARIORESULTSGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SCENARIORESULTSGUI.M with the given input arguments.
%
%      SCENARIORESULTSGUI('Property','Value',...) creates a new SCENARIORESULTSGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ScenarioResultsGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ScenarioResultsGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ScenarioResultsGUI

% Last Modified by GUIDE v2.5 18-Oct-2017 11:48:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ScenarioResultsGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ScenarioResultsGUI_OutputFcn, ...
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


% --- Executes just before ScenarioResultsGUI is made visible.
function ScenarioResultsGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ScenarioResultsGUI (see VARARGIN)

% Choose default command line output for ScenarioResultsGUI
handles.output = hObject;

temp_handle=findobj('Tag','MatlabContamToolbox');
temp_handle.Pointer='watch';
drawnow;

if isfield(varargin{1},'fileR')
    load([varargin{1}.pathName,varargin{1}.file0],'-mat');
    load([varargin{1}.pathName,varargin{1}.fileR],'-mat');
    handles.B = B;
    handles.P = P;
    handles.C = C;    
    handles.file0 = varargin{1}.file0(1:end-2);
    
    set(handles.ScenariosFileText,'String',varargin{1}.file0)
    set(handles.LoadResults,'enable','on');
    set(handles.ResultsFileText,'String',varargin{1}.fileR)
    set(handles.ScenarioPopup,'enable','on');
    set(handles.ScenarioPopup,'String',1:length(C.x));
%     set(handles.ResultsInformationListbox,'Foregroundcolor','b');
%     set(handles.ResultsInformationListbox,'fontsize',8);
    
    idx = handles.P.ScenariosFlowIndex(1,:);
    idx2 = handles.P.ScenariosContamIndex(1,:);
    
    
    w=[{'********************************* '};{'Scenario Data'};{'********************************* '}];
    w=[w;{' '};{'Weather Data:'};{'---------------------------------------- '};{' '}];            
    w=[w;{['Wind Direction: ',num2str(handles.P.FlowParamScenarios{1}(idx(1))), ' ^{o}']}];
    w=[w;{['Wind Speed: ',num2str(handles.P.FlowParamScenarios{2}(idx(2))), ' m/s']}; {' '}];
    w=[w;{'Source Data:'};{'---------------------------------------- '};{' '}];
    w=[w;{['Number of contaminant sources: ',num2str(handles.P.SourcesMax)]}];

    SL = []; SR = []; RT = []; DT = [];
    for i = 1:length(handles.P.SourceLocationScenarios{idx2(4)})
        SL = [SL, 'Z',num2str(handles.P.SourceLocationScenarios{idx2(4)}(i)), '   '];
        SR = [SR, num2str(handles.P.SourceParamScenarios{1}(idx2(1))),' g/hr   '];
        RT = [RT, num2str(handles.P.SourceParamScenarios{2}(idx2(2))), ' hr   '];
        DT = [DT, num2str(handles.P.SourceParamScenarios{3}(idx2(3))), ' hr   '];
    end

    w=[w;{['Source location: ', SL]}];
    w=[w;{['Source genaration rate : ', SR]}];
    w=[w;{['Release time: ', RT]}];
    w=[w;{['Duration Time: ', DT]};{' '}];

    w=[w;{' '}];

%     set(handles.ResultsInformationListbox,'Value',1,'ListboxTop', 1);
%     set(handles.ResultsInformationListbox,'String',w); 

    set(handles.ScenarioPopup,'enable','on');
%     set(handles.Save,'enable','on');            
    set(handles.SelectZonesPlot,'enable','on');
    set(handles.SameAxes,'enable','on','Value', 1);
    set(handles.GridOn,'enable','on','Value', 1);
    set(handles.PlotConcentrations,'enable','on');
    set(handles.DisplayAirflows,'enable','on');
    set(handles.DisplayAirflowsGraph,'enable','on');
    

    for i=1:handles.B.nS
        handles.chooseZone(i) = true;                
    end
    
else
    
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

    if strcmp(handles.B.ProjectName,B.ProjectName)
        handles.B=B;
        set(handles.ScenariosFileText,'String',[handles.file0,'.0'])
        
        handles.ResultsPanel=fillScenarioResultsPanel(pathname,handles.file0,handles.ResultsPanel,handles.P);
        
        set(handles.LoadResults,'enable','on');
        if exist([pathname,handles.file0,'.c1'],'file')==2
            if ~isempty([handles.file0,'.c1'])
                load([pathname,handles.file0,'.c1'],'-mat');
                handles.C = C;
                set(handles.ResultsFileText,'String',[handles.file0,'.c1'])
                set(handles.ScenarioPopup,'enable','on');
                set(handles.ScenarioPopup,'String',1:length(C.x));
%                 set(handles.ResultsInformationListbox,'Foregroundcolor','b');
%                 set(handles.ResultsInformationListbox,'fontsize',8);

                idx = handles.P.ScenariosFlowIndex(1,:);
                idx2 = handles.P.ScenariosContamIndex(1,:);

                w=[{'********************************* '};{'Scenario Data'};{'********************************* '}];
                w=[w;{' '};{'Weather Data:'};{'---------------------------------------- '};{' '}];            
                w=[w;{['Wind Direction: ',num2str(handles.P.FlowParamScenarios{1}(idx(1))), ' ^{o}']}];
                w=[w;{['Wind Speed: ',num2str(handles.P.FlowParamScenarios{2}(idx(2))), ' m/s']}; {' '}];
                w=[w;{'Source Data:'};{'---------------------------------------- '};{' '}];
                w=[w;{['Number of contaminant sources: ',num2str(handles.P.SourcesMax)]}];

                SL = []; SR = []; RT = []; DT = [];
                for i = 1:length(handles.P.SourceLocationScenarios{idx2(4)})
                    SL = [SL, 'Z',num2str(handles.P.SourceLocationScenarios{idx2(4)}(i)), '   '];
                    SR = [SR, num2str(handles.P.SourceParamScenarios{1}(idx2(1))),' g/hr   '];
                    RT = [RT, num2str(handles.P.SourceParamScenarios{2}(idx2(2))), ' hr   '];
                    DT = [DT, num2str(handles.P.SourceParamScenarios{3}(idx2(3))), ' hr   '];
                end

                w=[w;{['Source location: ', SL]}];
                w=[w;{['Source genaration rate : ', SR]}];
                w=[w;{['Release time: ', RT]}];
                w=[w;{['Duration Time: ', DT]};{' '}];

                w=[w;{' '}];

%                 set(handles.ResultsInformationListbox,'Value',1,'ListboxTop', 1);
%                 set(handles.ResultsInformationListbox,'String',w); 

                set(handles.ScenarioPopup,'enable','on');
%                set(handles.Save,'enable','on');            
                set(handles.SelectZonesPlot,'enable','on');
                set(handles.SameAxes,'enable','on','Value', 1);
                set(handles.GridOn,'enable','on','Value', 1);
                set(handles.PlotConcentrations,'enable','on');
                set(handles.DisplayAirflows,'enable','on');
                set(handles.DisplayAirflowsGraph,'enable','on');

                for i=1:handles.B.nS
                    handles.chooseZone(i) = true;                
                end

            else
                set(handles.ScenarioPopup,'enable','off');
%                 set(handles.Save,'enable','off');            
                set(handles.SelectZonesPlot,'enable','off');
                set(handles.SameAxes,'enable','off','Value', 1);
                set(handles.GridOn,'enable','off','Value', 1);
                set(handles.PlotConcentrations,'enable','off');
                set(handles.DisplayAirflows,'enable','off');
                set(handles.DisplayAirflowsGraph,'enable','off');


            end       
        end
    else
        set(handles.LoadResults,'enable','off');
        set(handles.ScenarioPopup,'enable','off');
%         set(handles.Save,'enable','off');
        set(handles.SelectZonesPlot,'enable','off');
        set(handles.SameAxes,'enable','off','Value', 1);
        set(handles.GridOn,'enable','off','Value', 1);
        set(handles.PlotConcentrations,'enable','off');
        set(handles.DisplayAirflows,'enable','off');
        set(handles.DisplayAirflowsGraph,'enable','off');
    end
end




% Update handles structure
guidata(hObject, handles);
temp_handle.Pointer='arrow';
clear temp_handle
uiwait
% UIWAIT makes ScenarioResultsGUI wait for user response (see UIRESUME)
% uiwait(handles.ScenarioResultsGUI);

function ResultsPanel=fillScenarioResultsPanel (pathname, file0,ResultsPanel,P)
 % This function is used for loading all the scenarios into each tab of the scenario results table   
   
    handles.ScenarioResultsGUI.Pointer='watch';

    
    % Find all scenario files from folder
    fileNames=dir([pathname,file0,'.c*']);
    
    for i =1:size(P.ScenariosFlowIndex,1)
        ScenarioFileNames{i}=[file0 '.c' num2str(i)];
    end
    
    % If tabgroup exists then delete its childres else create it
    if ~isempty(ResultsPanel.Children)
            % Delete tabs and not tabgroup for performance
            delete(ResultsPanel.Children.Children)
            tgroup=ResultsPanel.Children;
    else
        tgroup = uitabgroup('Parent',ResultsPanel);
    end
    
    tgroup.Position(3:4)=[1,1];
    
    for i=1:length(ScenarioFileNames)
        SceNum{1}=num2str(i);
%         load([pathname,ScenarioFileNames{i}],'-mat');
        %%%%%%%%%%%%%%%%%%%%%%%% Plot results in matrix tab form
        %%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%
        %%% Here i need to check that if many scenarios are loaded
        %%% the tabs appear OK on the panel
        tab{i} = uitab('Parent',tgroup, 'Title', ScenarioFileNames{i});
%         tab2 = uitab('Parent', tgroup, 'Title', 'Next file');
%         tab3 = uitab('Parent', tgroup, 'Title', 'next file');
        RowNames={};
        for j=1: size(P.ScenariosContamIndex,1)
            RowNames{j}= ['Sc. ' num2str(j)];
        end

        ScenarioResultsDisplayTable = uitable(tab{i});
        ScenarioResultsDisplayTable.Data=cell(1,1);
        ScenarioResultsDisplayTable.Units='normalized';
        ScenarioResultsDisplayTable.Position=[0 0 1 1];
        ScenarioResultsDisplayTable.ColumnName={' Wind Direction (degrees) ';' WindSpeed (m/s) '; ' Number of sources '; ' Source Location ';' Source Generation Rate (g/hr) '; ' Release Time (hr)'; 'Duration (hr) '};
        ScenarioResultsDisplayTable.ColumnFormat = {'char', 'char','char', 'char','char', 'char','char'};

        ScenarioResultsDisplayTable.RowName=RowNames;
        ScenarioResultsDisplayTable.ColumnWidth='auto';
        
        %                 ScenarioResultsDisplayTable.RearrangeableColumns='off'; % If the user is allowed to sellect anything from the table this property must be turned off
        for j=1:size(P.ScenariosContamIndex,1)
            idx = P.ScenariosFlowIndex(str2double(SceNum{1}),:);
            idx2 = P.ScenariosContamIndex(j,:);
            SL=[];SR=[];RT=[];DT=[];
            for k = 1:length(P.SourceLocationScenarios{idx2(4)}) % For loop in case of multible sources
                SL = [SL, 'Z',num2str(P.SourceLocationScenarios{idx2(4)}(k)), '  '];
                SR = [SR, num2str(P.SourceParamScenarios{1}(idx2(1))), '  '];
                RT = [RT, num2str(P.SourceParamScenarios{2}(idx2(2))), '  '];
                DT = [DT, num2str(P.SourceParamScenarios{3}(idx2(3))), '  '];
            end
            ScenarioResultsDisplayTable.Data(j,1:7)={P.FlowParamScenarios{1}(idx(1)),P.FlowParamScenarios{2}(idx(2)),P.SourcesMax...
                                                           SL,SR,RT,DT};
        end       
    end 
    handles.ScenarioResultsGUI.Pointer='arrow';

   
          
                
% --- Outputs from this function are returned to the command line.
function varargout = ScenarioResultsGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
delete(hObject);


% --- Executes on button press in LoadScenarios.
function LoadScenarios_Callback(hObject, eventdata, handles)
% hObject    handle to LoadScenarios (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Set pointer into watch
        handles.ScenarioResultsGUI.Pointer='watch';

[file0,pathName] = uigetfile([pwd,'\RESULTS\*.0'],'Select the MATLAB *.0 file');
pathfile0=[pathName,file0];
pathfile0=pathfile0(1:end-2);
file0 = file0(1:end-2);
if isnumeric(pathfile0)
    pathfile0=[];
end

if ~isempty((pathfile0)) 
    load([pathfile0,'.0'],'-mat');
    clc;
    handles.file0=file0;
    if ~strcmp(handles.B.ProjectName,B.ProjectName)
%         set(handles.Solve,'enable','off');
        set(handles.LoadResults,'enable','off');
        uiwait(msgbox(['        Wrong File "',pathfile0,'.0"'],'Error','modal'));
        set(handles.ScenariosFileText,'String','')
        set(handles.ResultsFileText,'String', '')
        set(handles.ScenarioPopup,'enable','off');
%         set(handles.Save,'enable','off');            
        set(handles.SelectZonesPlot,'enable','off');
        set(handles.SameAxes,'enable','off','Value', 1);
        set(handles.GridOn,'enable','off','Value', 1);
        set(handles.PlotConcentrations,'enable','off');
        set(handles.DisplayAirflows,'enable','off');
        set(handles.DisplayAirflowsGraph,'enable','off');
    else
        set(handles.LoadResults,'enable','on');
%         set(handles.Save,'enable','off');        
        set(handles.ScenarioPopup,'enable','off');                       
        set(handles.SelectZonesPlot,'enable','off');
        set(handles.SameAxes,'enable','off','Value', 1);
        set(handles.GridOn,'enable','off','Value', 1);
        set(handles.PlotConcentrations,'enable','off');
        set(handles.DisplayAirflows,'enable','off');
        set(handles.DisplayAirflowsGraph,'enable','off');
        set(handles.ResultsFileText,'String', ' ')
        set(handles.ScenariosFileText,'String',[file0,'.0']);
         
        
    
        handles.ResultsPanel=fillScenarioResultsPanel (pathName, file0,handles.ResultsPanel,P);
        
    end
    handles.P=P;
    handles.B=B;
    
    % Set pointer back to arrow
        handles.ScenarioResultsGUI.Pointer='arrow';
    
    % Update handles structure
    guidata(hObject, handles);
    
end



% --- Executes on button press in LoadResults.
function LoadResults_Callback(hObject, eventdata, handles)
% hObject    handle to LoadResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Set pointer into watch
        handles.ScenarioResultsGUI.Pointer='watch';
[fileR,pathName] = uigetfile([pwd,'\RESULTS\*.c*'],'Select the MATLAB *.c* file');
pathfileR=[pathName,fileR];
pathfileR=pathfileR(1:end-3);

if isnumeric(pathfileR)
    pathfileR=[];
end

if ~isempty(pathfileR)
    load([pathName,fileR],'-mat');
    [p handles.fileR e]=fileparts(fileR);
    if ~strcmp(handles.file0,handles.fileR)
        uiwait(msgbox(['        Wrong File "',pathName,fileR,'"'],'Error','modal'));
        set(handles.ResultsFileText,'String',' ')
%         set(handles.Save,'enable','off');
        set(handles.ScenarioPopup,'enable','off');                       
        set(handles.SelectZonesPlot,'enable','off');
        set(handles.SameAxes,'enable','off','Value', 1);
        set(handles.GridOn,'enable','off','Value', 1);
        set(handles.PlotConcentrations,'enable','off');
        set(handles.DisplayAirflows,'enable','off');
        set(handles.DisplayAirflowsGraph,'enable','off');
%         set(handles.ResultsInformationListbox,'Value',1,'ListboxTop', 1);
%         set(handles.ResultsInformationListbox,'String',' '); 
        
        % Set pointer back to arrow
        handles.ScenarioResultsGUI.Pointer='arrow';
        return        
    else
        set(handles.ResultsFileText,'String',fileR)
        set(handles.ScenarioPopup,'enable','on','String',1:length(C.x),'Value',1);        
%         set(handles.Save,'enable','on');
        set(handles.ScenarioPopup,'enable','on');                       
        set(handles.SelectZonesPlot,'enable','on');
        set(handles.SameAxes,'enable','on','Value', 1);
        set(handles.GridOn,'enable','on','Value', 1);
        set(handles.PlotConcentrations,'enable','on');
        set(handles.DisplayAirflows,'enable','on');
        set(handles.DisplayAirflowsGraph,'enable','on');
        
        [Path Name Extension] =  fileparts(fileR);
        SceNum = regexp(Extension,'\d+','match');
%         set(handles.ResultsInformationListbox,'Foregroundcolor','b');
%         set(handles.ResultsInformationListbox,'fontsize',8);
        
        
        switch handles.P.Method
            case 'grid'
                idx = handles.P.ScenariosFlowIndex(str2double(SceNum{1}),:);
                idx2 = handles.P.ScenariosContamIndex(1,:);

                w=[{'********************************* '};{'Scenario Data'};{'********************************* '}];
                w=[w;{' '};{'Weather Data:'};{'---------------------------------------- '};{' '}];            
                w=[w;{['Wind Direction: ',num2str(handles.P.FlowParamScenarios{1}(idx(1))), ' ^{o}']}];
                w=[w;{['Wind Speed: ',num2str(handles.P.FlowParamScenarios{2}(idx(2))), ' m/s']}; {' '}];
                w=[w;{'Source Data:'};{'---------------------------------------- '};{' '}];
                w=[w;{['Number of contaminant sources: ',num2str(handles.P.SourcesMax)]}];

                SL = []; SR = []; RT = []; DT = [];
                for i = 1:length(handles.P.SourceLocationScenarios{idx2(4)})
                    SL = [SL, 'Z',num2str(handles.P.SourceLocationScenarios{idx2(4)}(i)), '   '];
                    SR = [SR, num2str(handles.P.SourceParamScenarios{1}(idx2(1))),' g/hr   '];
                    RT = [RT, num2str(handles.P.SourceParamScenarios{2}(idx2(2))), ' hr   '];
                    DT = [DT, num2str(handles.P.SourceParamScenarios{3}(idx2(3))), ' hr   '];
                end

                w=[w;{['Source location: ', SL]}];
                w=[w;{['Source genaration rate : ', SR]}];
                w=[w;{['Release time: ', RT]}];
                w=[w;{['Duration Time: ', DT]};{' '}];
                
            case 'random'                
                idx = handles.P.ScenariosFlowIndex(str2double(SceNum{1}),:);
                idx2 = handles.P.ScenariosContamIndex(str2double(SceNum{1}),:);

                w=[{'********************************* '};{'Scenario Data'};{'********************************* '}];
                w=[w;{' '};{'Weather Data:'};{'---------------------------------------- '};{' '}];            
                w=[w;{['Wind Direction: ',num2str(handles.P.FlowParamScenarios{1}(idx(1))), ' ^{o}']}];
                w=[w;{['Wind Speed: ',num2str(handles.P.FlowParamScenarios{2}(idx(2))), ' m/s']}; {' '}];
                w=[w;{'Source Data:'};{'---------------------------------------- '};{' '}];
                w=[w;{['Number of contaminant sources: ',num2str(handles.P.SourcesMax)]}];

                SL = []; SR = []; RT = []; DT = [];
                for i = 1:length(handles.P.SourceLocationScenarios{idx2(4)})
                    SL = [SL, 'Z',num2str(handles.P.SourceLocationScenarios{idx2(4)}(i)), '   '];
                    SR = [SR, num2str(handles.P.SourceParamScenarios{1}(idx2(1))),' g/hr   '];
                    RT = [RT, num2str(handles.P.SourceParamScenarios{2}(idx2(2))), ' hr   '];
                    DT = [DT, num2str(handles.P.SourceParamScenarios{3}(idx2(3))), ' hr   '];
                end

                w=[w;{['Source location: ', SL]}];
                w=[w;{['Source genaration rate : ', SR]}];
                w=[w;{['Release time: ', RT]}];
                w=[w;{['Duration Time: ', DT]};{' '}];
                
        end
%         set(handles.ResultsInformationListbox,'Value',1,'ListboxTop', 1);
%         set(handles.ResultsInformationListbox,'String',w);

        for i=1:handles.B.nS
            handles.chooseZone(i) = true;                
        end
    end

    handles.C = C;
    
    % Set pointer back to arrow
        handles.ScenarioResultsGUI.Pointer='arrow';
    % Update handles structure
    guidata(hObject, handles);
    
    
end
    
    
% --- Executes on selection change in ScenarioPopup.
function ScenarioPopup_Callback(hObject, eventdata, handles)
% hObject    handle to ScenarioPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ScenarioPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ScenarioPopup

Sce = get(handles.ScenarioPopup,'Value');
fileR = get(handles.ResultsFileText,'String');
[Path Name Extension] =  fileparts(fileR);
SceNum = regexp(Extension,'\d+','match');
% set(handles.ResultsInformationListbox,'Foregroundcolor','b');
% set(handles.ResultsInformationListbox,'fontsize',8);

switch handles.P.Method
        case 'grid'
            idx = handles.P.ScenariosFlowIndex(str2double(SceNum{1}),:);
            idx2 = handles.P.ScenariosContamIndex(Sce,:);

            w=[{'********************************* '};{'Scenario Data'};{'********************************* '}];
            w=[w;{' '};{'Weather Data:'};{'---------------------------------------- '};{' '}];            
            w=[w;{['Wind Direction: ',num2str(handles.P.FlowParamScenarios{1}(idx(1))), ' ^{o}']}];
            w=[w;{['Wind Speed: ',num2str(handles.P.FlowParamScenarios{2}(idx(2))), ' m/s']}; {' '}];
            w=[w;{'Source Data:'};{'---------------------------------------- '};{' '}];
            w=[w;{['Number of contaminant sources: ',num2str(handles.P.SourcesMax)]}];

            SL = []; SR = []; RT = []; DT = [];
            for i = 1:length(handles.P.SourceLocationScenarios{idx2(4)})
                SL = [SL, 'Z',num2str(handles.P.SourceLocationScenarios{idx2(4)}(i)), '   '];
                SR = [SR, num2str(handles.P.SourceParamScenarios{1}(idx2(1))),' g/hr   '];
                RT = [RT, num2str(handles.P.SourceParamScenarios{2}(idx2(2))), ' hr   '];
                DT = [DT, num2str(handles.P.SourceParamScenarios{3}(idx2(3))), ' hr   '];
            end

            w=[w;{['Source location: ', SL]}];
            w=[w;{['Source genaration rate : ', SR]}];
            w=[w;{['Release time: ', RT]}];
            w=[w;{['Duration Time: ', DT]};{' '}];
    case 'random'
            idx = handles.P.ScenariosFlowIndex(str2double(SceNum{1}),:);
            idx2 = handles.P.ScenariosContamIndex(str2double(SceNum{1}),:);

            w=[{'********************************* '};{'Scenario Data'};{'********************************* '}];
            w=[w;{' '};{'Weather Data:'};{'---------------------------------------- '};{' '}];            
            w=[w;{['Wind Direction: ',num2str(handles.P.FlowParamScenarios{1}(idx(1))), ' ^{o}']}];
            w=[w;{['Wind Speed: ',num2str(handles.P.FlowParamScenarios{2}(idx(2))), ' m/s']}; {' '}];
            w=[w;{'Source Data:'};{'---------------------------------------- '};{' '}];
            w=[w;{['Number of contaminant sources: ',num2str(handles.P.SourcesMax)]}];

            SL = []; SR = []; RT = []; DT = [];
            for i = 1:length(handles.P.SourceLocationScenarios{idx2(4)})
                SL = [SL, 'Z',num2str(handles.P.SourceLocationScenarios{idx2(4)}(i)), '   '];
                SR = [SR, num2str(handles.P.SourceParamScenarios{1}(idx2(1))),' g/hr   '];
                RT = [RT, num2str(handles.P.SourceParamScenarios{2}(idx2(2))), ' hr   '];
                DT = [DT, num2str(handles.P.SourceParamScenarios{3}(idx2(3))), ' hr   '];
            end

            w=[w;{['Source location: ', SL]}];
            w=[w;{['Source genaration rate : ', SR]}];
            w=[w;{['Release time: ', RT]}];
            w=[w;{['Duration Time: ', DT]};{' '}];
end

% set(handles.ResultsInformationListbox,'Value',1,'ListboxTop', 1);
% set(handles.ResultsInformationListbox,'String',w); 

% Update handles structure
 guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ScenarioPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ScenarioPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SameAxes.
function SameAxes_Callback(hObject, eventdata, handles)
% hObject    handle to SameAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SameAxes


% --- Executes on button press in SelectZonesPlot.
function SelectZonesPlot_Callback(hObject, eventdata, handles)
% hObject    handle to SelectZonesPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hf = findall(0,'Tag','SelectZones');
if ~isempty(hf)
    return
end

for i = 1:length(handles.B.Sensors)
    arguments.ZoneName{i} = handles.B.ZoneName{handles.B.Sensors(i)};
end
arguments.chooseZone  = handles.chooseZone;

[A B]= SelectZones(arguments);

% uiwait(SelectZonesPlot)
handles.chooseZone = B.chooseZone;

guidata(hObject, handles);

% --- Executes on button press in GridOn.
function GridOn_Callback(hObject, eventdata, handles)
% hObject    handle to GridOn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of GridOn


% --- Executes on button press in PlotConcentrations.
function PlotConcentrations_Callback(hObject, eventdata, handles)
% hObject    handle to PlotConcentrations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


Sce = get(handles.ScenarioPopup, 'Value');
zones = find(handles.chooseZone);
% plot concentration
hf = figure('Name', 'Contaminant Concentration');
if get(handles.SameAxes, 'Value')       
    plot(handles.P.t, handles.C.x{Sce}(:,zones))
    xlabel('Time [hr]');
    ylabel('Actual concentration [g/m^3]');
    % [row col] = find(handles.B.C);
    
    for i = 1:length(zones)
        leg{i} = cell2mat(['Z',num2str(handles.B.Sensors(zones(i))),': ',handles.B.ZoneName(handles.B.Sensors(zones(i)))]);
    end
    legend(leg);
    if get(handles.GridOn, 'Value')
        grid on
    end
else
    if length(zones)==1           
        plot(handles.P.t, handles.C.x{Sce}(:,zones))
        xlabel('Time [hr]');
        ylabel('Actual concentration [g/m^3]');
        % [row col] = find(handles.B.C);
        title(cell2mat(['Z',num2str(handles.B.Sensors(zones)),': ',handles.B.ZoneName(handles.B.Sensors(zones))]));
        if get(handles.GridOn, 'Value')
            grid on
        end        
    else
        for i=1:length(zones)
            subplot(round(length(zones)/2),2,i)
            plot(handles.P.t, handles.C.x{Sce}(:,zones(i)))
            xlabel('Time [hr]');
            ylabel('[g/m^3]');
            title(cell2mat(['Z',num2str(handles.B.Sensors(zones(i))),': ',handles.B.ZoneName(handles.B.Sensors(zones(i)))]));
            if get(handles.GridOn, 'Value')
                grid on
            end 
        end
    end    
end




% --- Executes on button press in DisplayAirflows.
function DisplayAirflows_Callback(hObject, eventdata, handles)
% hObject    handle to DisplayAirflows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Sce = get(handles.ScenarioPopup, 'Value');
arguments.B = handles.B;
arguments.Flows = handles.C.Flows;
DisplayAirflowsGUI(arguments)

% --- Executes when user attempts to close ScenarioResultsGUI.
function ScenarioResultsGUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to ScenarioResultsGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
uiresume


% --- Executes on button press in DisplayAirflowsGraph.
function DisplayAirflowsGraph_Callback(hObject, eventdata, handles)
% hObject    handle to DisplayAirflowsGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp_mat=handles.C.A';
temp_mat(temp_mat<0)=0;
for i=1:handles.B.nZones
    IDs{i}=['Zone ' num2str(i)];
end

view(biograph(temp_mat,IDs))


% --- Executes on button press in export.
function export_Callback(hObject, eventdata, handles)
% hObject    handle to export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% This function exports to workspace a struct as well as a table containing
% all simulation data

% Load data of the scenario tab that is currently sellected. (A matrix, Flows and the contaminant time series)
SellectedScenarioTab=handles.ResultsPanel.Children.SelectedTab.Title;

    LoadedScenario=load([pwd,'\RESULTS\',SellectedScenarioTab],'-mat');
      [path filename extension]=fileparts([pwd,'\RESULTS\',SellectedScenarioTab]);
            
%         [Path Name Extension] =  fileparts(fileR);
        SceNum = str2num(extension(3:end));
       
    

%     handles.C = C;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(handles.P.Method,'random')
    SimulationNum=length(handles.P.SourceLocationScenarios);
else
    SimulationNum=1;
    for i=1:length(handles.P.SourceSamples)
        SimulationNum=SimulationNum*handles.P.SourceSamples{i};
    end
    SimulationNum=SimulationNum*length(handles.P.SourceLocationScenarios);
end
% Final Table initialization of rows
SimulationResults=table({'Measurement Units';'Simulation Parameters';'State Space';'Environmental Parameters';'Building Parameters';'Contaminant Source';'Concentration Time Series'});

T_VariableNames{1}=['Data'];

%Initialize Contaminant Time Series Table
TimeSeries_Row_Names=[];
count=1;
for i=handles.B.Sensors'
    TimeSeries_Row_Names{count}=['Z' num2str(i)];
    count=count+1;
end
Time=handles.P.t;
concentration=array2table(Time','VariableNames',{'Time'});

%Progressbar initialization
progressbar2('Constracting Table');

% Construction of structure and Table

for i=1:SimulationNum
    
    % Measurement Units
    Simulation{i}.MeasurementUnits(1,:)=[{'Time Series'},{'hours'}];
    Simulation{i}.MeasurementUnits(end+1,:)=[{'Ambient Wind Direction'},{'degrees'}];
    Simulation{i}.MeasurementUnits(end+1,:)=[{'Ambient Wind Speed'},{'m/s'}];
    Simulation{i}.MeasurementUnits(end+1,:)=[{'Ambient Temperature'},{'Celsius'}];
    Simulation{i}.MeasurementUnits(end+1,:)=[{'Ambient Pressure'},{'Pa'}];
    Simulation{i}.MeasurementUnits(end+1,:)=[{'Path Openings'},{'[0,1] 0:Closed 1:Open'}];
    Simulation{i}.MeasurementUnits(end+1,:)=[{'Sensor Location'},{'Zone Number'}];
    Simulation{i}.MeasurementUnits(end+1,:)=[{'Flows'},{'m^3/h'}];
    Simulation{i}.MeasurementUnits(end+1,:)=[{'Generation Rate'},{'g/h'}];
    Simulation{i}.MeasurementUnits(end+1,:)=[{'Duration'},{'hours'}];
    Simulation{i}.MeasurementUnits(end+1,:)=[{'SS matrix A=(Q^-1)Ass'},{'1/h'}];
    Simulation{i}.MeasurementUnits(end+1,:)=[{'SS matrix B=(Q^-1)Bss'},{'1/m^3'}];
    Simulation{i}.MeasurementUnits(end+1,:)=[{'SS matrix C'},{'binary matrix'}];
    Simulation{i}.MeasurementUnits(end+1,:)=[{'SS matrix D'},{''}];
    Simulation{i}.MeasurementUnits(end+1,:)=[{'SS matrix Gss'},{'Binary index matrix'}];

    Simulation{i}.MeasurementUnits(end+1,:)=[{'SS matrix u=\Delta fx'},{'g/h'}];

    Simulation{i}.MeasurementUnits(end+1,:)=[{'Concentration'},{'g/m^3'}];

    
    %Simulation Parameters
    Simulation{i}.SimulationParameters.TimeSeries=handles.P.t;
    Simulation{i}.SimulationParameters.TimeStep=handles.P.TimeStep;
    Simulation{i}.SimulationParameters.Method=handles.P.Method;
    Simulation{i}.SimulationParameters.ScenarioSelection=handles.P.ScenarioSelection;
    
    %State Space Data
    Simulation{i}.StateSpace.A=LoadedScenario.C.A;
    Simulation{i}.StateSpace.B=handles.B.B;
    Simulation{i}.StateSpace.C=handles.B.C;
    Simulation{i}.StateSpace.D=handles.B.D;
    Simulation{i}.StateSpace.x0=handles.B.x0;

    %Environmental Parameters
    %%%%%%% Here we should take the data from handles.P.GlowParamScenarios
    %%%%%%% for each different c file.
    Simulation{i}.EnvironmentalParameters.AmbientWindDirection=handles.P.FlowParamScenarios{1}(handles.P.ScenariosFlowIndex(SceNum,1));
    Simulation{i}.EnvironmentalParameters.AmbientWindSpeed=handles.P.FlowParamScenarios{2}(handles.P.ScenariosFlowIndex(SceNum,2));
    Simulation{i}.EnvironmentalParameters.AmbientTemperature=handles.P.FlowParamScenarios{3}(handles.P.ScenariosFlowIndex(SceNum,3));
    Simulation{i}.EnvironmentalParameters.AmbientPressure=handles.B.AmbientPressure;
    

    %Building Parameters
    Simulation{i}.BuildingParameters.PathOpenings=handles.P.FlowParamScenarios{6}(handles.P.ScenariosFlowIndex(SceNum,6),:);
    Simulation{i}.BuildingParameters.ZonesNumber=handles.P.nZones;
    Simulation{i}.BuildingParameters.SensorLocation=handles.B.Sensors;
    Simulation{i}.BuildingParameters.ZonesVolume=handles.P.FlowParamScenarios{4}(handles.P.ScenariosFlowIndex(SceNum,4),:);
    Simulation{i}.BuildingParameters.ZoneTemperature=handles.P.FlowParamScenarios{5}(handles.P.ScenariosFlowIndex(SceNum,5),:);
    Simulation{i}.BuildingParameters.ZoneNames=handles.B.ZoneName;
    Simulation{i}.BuildingParameters.Flows=LoadedScenario.C.Flows;
    Simulation{i}.BuildingParameters.Partitioning=[];
    
    %Contaminant Parameters
    Simulation{i}.ContaminantSource.GenerationRate=handles.P.SourceParamScenarios{1}(handles.P.ScenariosContamIndex(i,1));
    Simulation{i}.ContaminantSource.StartTime=handles.P.SourceParamScenarios{2}(handles.P.ScenariosContamIndex(i,2));
    Simulation{i}.ContaminantSource.Duration=handles.P.SourceParamScenarios{3}(handles.P.ScenariosContamIndex(i,3));
    Simulation{i}.ContaminantSource.MaxNumber=handles.P.SourcesMax;
    SL=[];
     for cc = 1:length(handles.P.SourceLocationScenarios{handles.P.ScenariosContamIndex(i,4)})
                SL = [SL, 'Z',num2str(handles.P.SourceLocationScenarios{handles.P.ScenariosContamIndex(i,4)}(cc)), '   '];
     end
    Simulation{i}.ContaminantSource.Location=SL;

    %Concentration
    if strcmp(handles.P.Method,'random')
        for j=1:handles.B.nS
            concentration(:,j+1)=table(LoadedScenario.C.x{1}(:,j));
        end
    else
        for j=1:handles.B.nS
            concentration(:,j+1)=table(LoadedScenario.C.x{i}(:,j));
        end
    end
    % Give names to concentration time series columns
    concentration.Properties.VariableNames(2:end)=TimeSeries_Row_Names;
    Simulation{i}.ConcentrationTimeSeries=concentration;
     % Construct table
     SimulationResults(:,i+1)=table({Simulation{i}.MeasurementUnits;Simulation{i}.SimulationParameters;Simulation{i}.StateSpace;Simulation{i}.EnvironmentalParameters;Simulation{i}.BuildingParameters; Simulation{i}.ContaminantSource;concentration});
     % Construct struct for Table column names
     T_VariableNames{i+1}=['Simulation_' num2str(i)];
    
     %%%%%%%%%%%%%%%%% Progress bar %%%%%%%%%%%%%%%%%%%%%
      if isempty(findobj('Tag','ProgressBar'))
        exitflag=-1;
        return
      end
     progressbar2(i/SimulationNum); 
  
end

% Give names to Table Columns
SimulationResults.Properties.VariableNames=T_VariableNames;
 
assignin('base','ScenarioResults',SimulationResults);
% assignin('base','Simulation',Simulation);
openvar('ScenarioResults','Simulation')
uiresume

% Code for encoding and decoding into and from json format
% text = jsonencode(T);
%  value = jsondecode(text)
