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

function varargout = runMultipleScenariosGui(varargin)
% RUNMULTIPLESCENARIOSGUI M-file for runMultipleScenariosGui.fig
% In This M file you can see how the axes along with a patch can be used to
% render a progress bar for your existing Gui. Box Property of the Axes
% must be enabled in order to make the axes look like a progress bar and
% also the xTick & yTick values must be set to empty. In order to change
% the Color of the Patch do pass the color value to changecolor function.
% Run this m file and click on the start button to see how this progress bar works.
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @runMultipleScenariosGui_OpeningFcn, ...
                   'gui_OutputFcn',  @runMultipleScenariosGui_OutputFcn, ...
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


% --- Executes just before runMultipleScenariosGui is made visible.
function runMultipleScenariosGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to runMultipleScenariosGui (see VARARGIN)
% Choose default command line output for runMultipleScenariosGui
    handles.output = hObject;
%     position=get(handles.runMultipleScenariosGui,'Position');
%     set(handles.runMultipleScenariosGui,'Position',[104 50 110 7]);
    
    
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
        set(handles.FileText,'String','')
    else
        set(handles.start,'enable','on');
        set(handles.FileText,'String',[handles.file0,'.0'])
    end

    set(handles.load,'enable','on');
%     handles.str='Run Multiple Scenarios';
%     set(handles.runMultipleScenariosGui,'name',handles.str);
    handles.msg = '';
    % Update handles structure
    guidata(hObject, handles);
        
    uiwait


% --- Outputs from this function are returned to the command line.
function varargout = runMultipleScenariosGui_OutputFcn(hObject, eventdata, handles) 
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

    set(handles.start,'enable','off');
    set(handles.load,'enable','off');
    
    exitflag=runMultipleScenarios(handles)
    if exitflag~=-1
        handles.msg = ['The simulation of "', handles.file0 ,'.0" is completed']; 
        uiwait(msgbox(handles.msg));
    guidata(hObject, handles);
    uiresume
    else
        return
    end
    
%     close(handles.runMultipleScenariosGui);
    
        
% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    load([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');

    [file0,pathNM] = uigetfile([pathname,'*.0'],'Select the MATLAB *.0 file');
    if length(pathNM)~=1
        pathname=pathNM;
    end
    
    file0=file0(1:end-2);
    if isnumeric(file0)
        file0=[];
    end
    if ~isempty((file0)) 
        save([pwd,'\RESULTS\','File0.File'],'file0','-mat');
        load([pathname,file0,'.0'],'-mat');
        handles.file0=file0;
        if ~strcmp(handles.B.ProjectName,B.ProjectName)
            set(handles.start,'enable','off');
            msgbox(['        Wrong File "',file0,'.0"'],'Error','modal');
            set(handles.FileText,'String','')
        else
            set(handles.start,'enable','on');
            set(handles.FileText,'String',[handles.file0,'.0'])
        end
        handles.P=P;
        hanldes.B=B;
        % Update handles structure
        guidata(hObject, handles);
    end
    save([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');
    
% --- Executes on mouse press over axes background.
function axes2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close runMultipleScenariosGui.
function runMultipleScenariosGui_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to runMultipleScenariosGui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
handles.msg = '';
uiresume
