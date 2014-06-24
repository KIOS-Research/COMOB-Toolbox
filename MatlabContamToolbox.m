%{
 Copyright 2013 KIOS Research Center for Intelligent Systems and Networks, University of Cyprus (www.kios.org.cy)

 Licensed under the EUPL, Version 1.1 or � as soon they will be approved by the European Commission - subsequent versions of the EUPL (the "Licence");
 You may not use this work except in compliance with theLicence.
 You may obtain a copy of the Licence at:

 http://ec.europa.eu/idabc/eupl

 Unless required by applicable law or agreed to in writing, software distributed under the Licence is distributed on an "AS IS" basis,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the Licence for the specific language governing permissions and limitations under the Licence.
%}

function varargout = MatlabContamToolbox(varargin)
% MatlabContamToolbox MATLAB code for MatlabContamToolbox.fig
%      MatlabContamToolbox, by itself, creates a new MatlabContamToolbox or raises the existing
%      singleton*.
%
%      H = MatlabContamToolbox returns the handle to a new MatlabContamToolbox or the handle to
%      the existing singleton*.
%
%      MatlabContamToolbox('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MatlabContamToolbox.M with the given input arguments.
%
%      MatlabContamToolbox('Property','Value',...) creates a new MatlabContamToolbox or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MatlabContamToolbox_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MatlabContamToolbox_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% edit the above text to modify the response to help MatlabContamToolbox

% Last Modified by GUIDE v2.5 20-Jan-2014 17:10:31

% Begin initialization code - DO NOT EDIT
clc
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

% Choose default command line output for MatlabContamToolbox
handles.output = hObject;

path(path,genpath(pwd));
%path(path,'SPLACE');
%path(path,'SPLACE\GuiSplace');
%path(path,'Help\Logos');
% path(path,'CDI');


%rgb= imread('kios_logo.png');
rgb= imread('KIOS.jpg');
axes(handles.axes2)
image(rgb)
axis on
set(handles.axes2,'xtick',[]);
set(handles.axes2,'ytick',[]);
%axis off

%rgb= imread('ucy_logo.png');
rgb= imread('ucy.jpg');
axes(handles.axes3)
image(rgb)
axis on
set(handles.axes3,'xtick',[]);
set(handles.axes3,'ytick',[]);
%axis off

rgb= imread('tepak.jpg');
axes(handles.axes4)
image(rgb)
axis on
set(handles.axes4,'xtick',[]);
set(handles.axes4,'ytick',[]);


%inactive until set a prj file
set(handles.LevelUp, 'Enable', 'off', 'Visible', 'off')
set(handles.LevelDown, 'Enable', 'off', 'Visible', 'off')
% set(handles.edit6, 'Enable', 'off')
% set(handles.edit5, 'Enable', 'off')
set(handles.edit4, 'Enable', 'off')
set(handles.edit2, 'Enable', 'off')
set(handles.edit1, 'Enable', 'off')
set(handles.edit12, 'Enable', 'off')
set(handles.edit13, 'Enable', 'off')
set(handles.release,'Enable', 'off')
set(handles.zone, 'Enable', 'off')
set(handles.weather, 'Enable', 'off')
set(handles.path, 'Enable', 'off')
set(handles.SensorsData, 'Enable', 'off')
set(handles.plot, 'Enable', 'off')
set(handles.airflows, 'Enable', 'off')
set(handles.run, 'Enable', 'off')
set(handles.RunContaminantEvent, 'Enable', 'off')
set(handles.Concentrations, 'Enable', 'off')
set(handles.CDE, 'Enable', 'off')
set(handles.CIE, 'Enable', 'off')
set(handles.ActiveDistributedCDI, 'Enable', 'off')
set(handles.DeactiveDistribudedCDI, 'Enable', 'off')


set(handles.SaveConcentrations, 'Enable', 'off')
% set(handles.SaveAmatrix, 'Enable', 'off')
set(handles.FDIparameters, 'Enable', 'off')
% set(handles.FDIrun, 'Enable', 'off')
set(handles.FDIresults, 'Enable', 'off')
% set(handles.multiple, 'Enable', 'off')
set(handles.ParameterSelection, 'Enable', 'off')
set(handles.Calculate, 'Enable', 'off')
set(handles.ComputeImpactMatrix, 'Enable', 'off')
set(handles.SolveSensorPlacement, 'Enable', 'off')
setappdata(0,'HandleMainGUI',hObject);
% jModel = javax.swing.SpinnerNumberModel(100,0,1000,1);
% handles.jSpinner = javax.swing.JSpinner(jModel);
% handles.jhSpinner = javacomponent(handles.jSpinner, [161,159,88,22], handles.uipanel3);

% javax.swing.JSpinner.NumberEditor(handles.jhSpinner, 'spinner', 'String', 'decimalFormatPattern')
%  handles.jhSpinner.setEditor(decimalFormatPattern)
% handles.jSpinner.NumberEditor(handles.jhSpinner, decimalFormatPattern)
% handles.jhSpinner.setEnabled(false)
% value = jhSpinner.getValue
% jhSpinner.setValue(10)
% set(handles.jSpinner,'Enable','off')

handles.ok=0;
handles.Noise = 0;
handles.time = 0;
handles.fig1 = 0;
handles.fig2 = 0;
handles.fig3 = 0;
handles.ActiveDistributed = 0;
% handles.Sources = [];

F.choice = 1;
F.Ex0 = 0.1;
F.Ez0 = 0.5;
F.LearningRate = 10e7;
F.Theta = 10;
F.InitialSourceEstimation = 0.05;
F.UncertaintiesBound = 0.2;
F.NoiseBound = 0.03;
F.Tolerances.Wd = 0;
F.Tolerances.Ws = 0;
F.Tolerances.Ztemp = 0;
F.Tolerances.PathsOpenings = 0;
F.Tolerances.Iterations = 100;
F.DetectionThreshold = 0;
F.DetectionResidual = 0;
F.IsolationThreshold = 0;
F.IsolationResidual = 0;
F.DetectionTime = 0;
F.SourceEstimation = 0;
F.Amatrices = 0;
F.DA = 0.2;
F.Calc = 0;
F.NominalChoice = 1;
F.NominalFile = '';
F.MatricesFile = '';

handles.F = F;


handles.choice = 1;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MatlabContamToolbox wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = MatlabContamToolbox_OutputFcn(hObject, eventdata, handles) 

% Get pushbutton string from handles structure and output it
% varargout{1} = handles.opn


% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function edit_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function simulation_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)

    % Get direction and the project file
    [filename, pathname] = uigetfile('*.prj', 'Select a CONTAM Project File (*.prj)');
    
    % if file exist
    if filename ~= 0
        X=readPRJ([pathname,filename]);
        if exist('Project.File','file')==2
            load Project.File -mat
            file0=[];
            save('Project.File','file0','-mat')
        end
        B.filename = filename;
        i=1;
        while strcmp(X.project{i},'! Ta       Pb      Ws    Wd    rh  day u..')~=1
            i=i+1;
        end
        i=i+1;
        out = textscan(X.project{i},'%s','delimiter',' ','multipleDelimsAsOne',1);
        B.AmbientTemperature = str2double(out{1}{1})-273.15; % Kelvin to Celcius
        B.AmbientPressure = str2double(out{1}{2});
        B.WindSpeed = str2double(out{1}{3}); % m/s
        B.WindDirection = str2double(out{1}{4}); % degree

        for i=3:(length(X.ZonesData)-1)
            out = textscan(X.ZonesData{i},'%s','delimiter',' ','multipleDelimsAsOne',1);
            V(i-2)=str2double(out{1}{8});
            B.Temp(i-2) = str2double(out{1}{9})-273.15; % Kelvin to Celcius
            B.ZoneName{i-2} = out{1}{11};
            out = textscan(X.InitialZoneConcentrations{i},'%s','delimiter',' ','multipleDelimsAsOne',1);
            B.x0(i-2)= str2double(out{1}{2});            
        end
       
        B.v=V;
        B.V=diag(V);
               
        B.nZones=length(V);
        B.Zones=1:B.nZones;
        
        B.A = zeros(B.nZones,B.nZones);
        
        b1= zeros(B.nZones);
        B.nZones2 = B.nZones;
        for i=1:B.nZones
          if B.V(i,i)~=0;
            b1(i,i)= 1/B.V(i,i);
          else
            b1(i,i)= B.V(i,i);
            B.nZones2 = B.nZones2 - 1;
          end
        end
        B.B=b1;
        %         B.B=inv(B.V); 
        B.C=eye(B.nZones);
        B.D=0;
        
        B.xext = 0;
        B.X=X;
        
        out = textscan(X.LevelIconData{1},'%s','delimiter',' ','multipleDelimsAsOne',1);
        handles.level = str2double(out{1}{1});
        
        for lv = 1:handles.level
            B.Level(lv).s = 0;
        end
        
        B.LevelCounter = 1;
        handles.F.IsolationDecision=zeros(1,B.nZones);
        for i=1:B.nZones 
            B.clr{i} = 'w';
        end
        [B.Size B.X1 B.Y1 handles.cmp] = plotB(X,handles.axes1,B.LevelCounter,handles.F.IsolationDecision,B.clr,B.WindDirection, B.C,get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));
        set(handles.axes1, 'buttondownfcn', @axes1_ButtonDownFcn)
      if handles.level>1
          set(handles.LevelUp, 'Enable', 'on', 'Visible', 'on')
      else
          set(handles.LevelUp, 'Enable', 'off', 'Visible', 'off')
          set(handles.LevelDown, 'Enable', 'off', 'Visible', 'off')
      end


    % write the direction of prj to edit1
    set(handles.edit3,'String', [pathname, filename]);

    if (handles.ok==0)
        % Enable the edit
%         set(handles.edit6,'Enable', 'on')
%         set(handles.edit5,'Enable', 'on')
        set(handles.edit4,'Enable', 'on')
        set(handles.edit2, 'Enable', 'on')        
        set(handles.edit1, 'Enable', 'on')
        set(handles.edit12, 'Enable', 'on','String', num2str(B.WindDirection))
        set(handles.edit13, 'Enable', 'on','String', num2str(B.WindSpeed))
        set(handles.release, 'Enable', 'on')        
        set(handles.weather, 'Enable', 'on')        
        set(handles.path, 'Enable', 'on')        
        set(handles.zone, 'Enable', 'on')
        set(handles.SensorsData, 'Enable', 'on')
        set(handles.run, 'Enable', 'on')
        set(handles.ParameterSelection, 'Enable', 'on')        
        set(handles.Calculate, 'Enable', 'on')
        set(handles.ComputeImpactMatrix, 'Enable', 'on')
        set(handles.SolveSensorPlacement, 'Enable', 'on')
        set(handles.FDIparameters, 'Enable', 'on')
        set(handles.RunContaminantEvent, 'Enable', 'on')
        set(handles.Concentrations, 'Enable', 'on')
        set(handles.CDE, 'Enable', 'on')
        set(handles.CIE, 'Enable', 'on')
        set(handles.ActiveDistributedCDI, 'Enable', 'on')
        % set(handles.FDIrun, 'Enable', 'off')
%         set(handles.FDIresults, 'Enable', 'off')
%         set(handles.multiple, 'Enable', 'on')
    end

        out = textscan(X.AirflowPaths{1},'%s','delimiter',' ','multipleDelimsAsOne',1);
        B.Paths=str2double(out{1}{1});

        handles.j=0;
        for i=3:(length(X.AirflowPaths)-1)
                out = textscan(X.AirflowPaths{i},'%s','delimiter',' ','multipleDelimsAsOne',1);
                flags = str2double(out{1}{2});
            if (flags==16) || (flags==32) || (flags==64)
               handles.j=handles.j+1;
            end
        end
        B.Paths = B.Paths - handles.j;

        % fill table for path
        handles.opn = '';
        for i=1:B.Paths
            handles.opn{i,1}=['Path', num2str(i)];
            handles.opn{i,2}= 'Open';
            handles.airflow(i)=0;
        end
        
        B.Openings= ones(1,B.Paths+handles.j);

        %initial release
        for i=1:B.nZones
            handles.release(i)= false;
        end
        handles.release(1)= true;
        handles.ok=1;
        
        pause(0.1)
        handles.B = B;
        handles.u = zeros(handles.B.nZones,1);
        handles.point = get(handles.axes1, 'CurrentPoint');
%         axesHandle  = get(hObject,'Parent');
%         set(axesHandle, 'UserData', handles.u)
        pause(0.1)
        UserData.B = handles.B;
        UserData.u = handles.u;        
        set(get(hObject,'Parent'), 'UserData', UserData)
%         type = get(handles.axes1, 'CurrentPoint')
%         set(handles.axes1, 'CurrentPoint', [0 0 1])
%         type = get(handles.axes1, 'CurrentPoint')
    end
guidata(hObject, handles);

% --- Executes on button press in release.
function release_Callback(hObject, eventdata, handles)
    set(handles.exit, 'Enable', 'off')
        for i=1:handles.B.nZones
            data{i,1} = handles.B.ZoneName{i};
            data{i,2}= handles.release(i);
        end
    data{1,3} = 'Release Contaminant Source';
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    setappdata(HandleMainGUI,'SharedData', data); 

    change_release
    uiwait(change_release)

    HandleMainGUI=getappdata(0,'HandleMainGUI');
    SomeDataShared=getappdata(HandleMainGUI,'SharedData');
    for i=1:handles.B.nZones
        handles.release(i)=SomeDataShared{i,2} ;
    end
    set(handles.exit, 'Enable', 'on')
guidata(hObject, handles);

% --------------------------------------------------------------------
function weather_Callback(hObject, eventdata, handles)
    set(handles.exit, 'Enable', 'off')
    data(1)=handles.B.AmbientTemperature;
    data(2)=handles.B.WindDirection;
    data(3)=handles.B.AmbientPressure;
    data(4)=handles.B.WindSpeed;
    data(5)=handles.B.xext;

    HandleMainGUI=getappdata(0,'HandleMainGUI');
    setappdata(HandleMainGUI,'SharedData', data); 

    change_weather
    uiwait(change_weather)

    HandleMainGUI=getappdata(0,'HandleMainGUI');
    SomeDataShared=getappdata(HandleMainGUI,'SharedData');
    handles.B.AmbientTemperature = SomeDataShared(1);
    handles.B.WindDirection= SomeDataShared(2);
    handles.B.AmbientPressure= SomeDataShared(3);
    handles.B.WindSpeed= SomeDataShared(4);
    handles.B.xext= SomeDataShared(5);
    set(handles.exit, 'Enable', 'on')
guidata(hObject, handles);

% --------------------------------------------------------------------
function zone_Callback(hObject, eventdata, handles)
    set(handles.exit, 'Enable', 'off')
    for i=1:handles.B.nZones
        data{i,1} = handles.B.ZoneName{i};
        data{i,2} = handles.B.v(i);
        data{i,3} = handles.B.Temp(i);
        data{i,4}=handles.B.x0(i);
    end

        HandleMainGUI=getappdata(0,'HandleMainGUI');
        setappdata(HandleMainGUI,'SharedData', data); 

        change_zone
        uiwait(change_zone)

        HandleMainGUI=getappdata(0,'HandleMainGUI');
        SomeDataShared=getappdata(HandleMainGUI,'SharedData');
        for i=1:handles.B.nZones
            handles.B.ZoneName{i}= SomeDataShared{i,1} ;
            handles.B.v(i) = SomeDataShared{i,2} ;
            handles.B.Temp(i) = SomeDataShared{i,3};
            handles.B.x0(i)= SomeDataShared{i,4} ;
        end
        
        handles.B.V=diag(handles.B.v);
        b1= zeros(handles.B.nZones);
        for i=1:handles.B.nZones
          if handles.B.V(i,i)~=0;
            b1(i,i)= 1/handles.B.V(i,i);
          else
            b1(i,i)= handles.B.V(i,i);
          end
        end
        handles.B.B=b1;
        set(handles.exit, 'Enable', 'on')
guidata(hObject, handles);

% --------------------------------------------------------------------
function path_Callback(hObject, eventdata, handles)
    set(handles.exit, 'Enable', 'off')
    %When you want to edit shared data you must get the handle
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    %write a local variable called MyData to SharedData, any type of data
    setappdata(HandleMainGUI,'SharedData', handles.opn ); 

    change_path
    uiwait(change_path)
    %When you want to edit shared data you must get the handle
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    %get SharedData and SaveConcentrations it to a local variable called SomeDataShared
    SomeDataShared=getappdata(HandleMainGUI,'SharedData'); 

    for i=1:handles.B.Paths
        handles.opn{i,2}=SomeDataShared{i,2};
       switch SomeDataShared{i,2}
           case 'Open'
             handles.B.Openings(i)=1;
           case 'Half Open'
             handles.B.Openings(i)=0.5;
            case 'Close'
             handles.B.Openings(i)=0;
        end
    end
    set(handles.exit, 'Enable', 'on')
guidata(hObject, handles);

% --- Executes on button press in SensorsData.
function SensorsData_Callback(hObject, eventdata, handles)
% hObject    handle to SensorsData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.exit, 'Enable', 'off')
    data{1} = handles.B.C;
    data{2} = handles.Noise;
    data{3} = handles.B.ZoneName;
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    setappdata(HandleMainGUI,'SharedData', data); 

    change_sensor
    uiwait(change_sensor)

    HandleMainGUI=getappdata(0,'HandleMainGUI');
    SomeDataShared=getappdata(HandleMainGUI,'SharedData');
    
    handles.B.C = SomeDataShared{1};
    handles.Noise = SomeDataShared{2};
    set(handles.exit, 'Enable', 'on')
guidata(hObject, handles);

% --------------------------------------------------------------------
function run_Callback(hObject, eventdata, handles)
    if  isempty(get(handles.edit1, 'String'))
        msgbox('Specify the contaminant release source', 'Error', 'error')
        return
    end
    
    if  isempty(str2num(get(handles.edit1, 'String')))
        msgbox('     Give A Valid Number', 'Error', 'error')
        return
    end
                
    if (str2double(get(handles.edit1, 'String'))<=0)
        msgbox('Give positive contaminant release source', 'Error', 'error')
        return
    end

    if  isempty(get(handles.edit2, 'String'))
        msgbox('Give simulation Time', 'Error', 'error')
        return
    end
    
    if  isempty(str2num(get(handles.edit2, 'String')))
        msgbox('     Give A Valid Number', 'Error', 'error')
        return
    end
    
    if (str2double(get(handles.edit2, 'String'))<1)|| (str2double(get(handles.edit2, 'String'))>24)
        msgbox('Simulation Time must be 1-24', 'Error', 'error')
        return
    end

    if  isempty(get(handles.edit4, 'String'))
        msgbox('Give simulation Time Step', 'Error', 'error')
        return
    end
    
    if  isempty(str2num(get(handles.edit4, 'String')))
        msgbox('     Give A Valid Number', 'Error', 'error')
        return
    end
    
    if (str2double(get(handles.edit4, 'String'))<=0)||(str2double(get(handles.edit4, 'String'))>str2double(get(handles.edit2, 'String')))
        msgbox('Time must be 0-Simulation Time', 'Error', 'error')
        return
    end
    
    if  isempty(get(handles.edit5, 'String'))
        msgbox('Give Contaminant Source Start Time', 'Error', 'error')
        return
    end
    
    if  isempty(str2num(get(handles.edit5, 'String')))
        msgbox('     Give A Valid Number', 'Error', 'error')
        return
    end
    
    if (str2double(get(handles.edit5, 'String'))<0)
        msgbox('Start Time must be positive', 'Error', 'error')
        return
    end
    
    if  isempty(get(handles.edit6, 'String'))
        msgbox('Give Contaminant Source Stop Time', 'Error', 'error')
        return
    end
    
    if  isempty(str2num(get(handles.edit6, 'String')))
        msgbox('     Give A Valid Number', 'Error', 'error')
        return
    end
    
    if (str2double(get(handles.edit6, 'String'))<0)
        msgbox('Stop Time must be positive', 'Error', 'error')
        return
    end
    
    if (str2double(get(handles.edit6, 'String')) > str2double(get(handles.edit2, 'String')))
        msgbox('Stop Time must smaller than Simulation Time', 'Error', 'error')
        return
    end
    
    if (str2double(get(handles.edit6, 'String'))<= str2double(get(handles.edit5, 'String')))
        msgbox('Stop Time must be greater than Start Time', 'Error', 'error')
        return
    end
    
    
    k=0;        
    for i=1:handles.B.nZones
        if handles.release(i)
            k=1;
        end        
    end
    if (k==0)
    msgbox('Specify release locations', 'Error', 'error')
        return
    end
    [v.figure1,v.axes2,v.text_progress]=LoadGui;
    v.str='Run Simulation...';
    pp=0;
    
    nload=pp/(3+2*handles.B.nZones); 
    v.color=char('red');
    progressbar(v,nload)
    pp=pp+1;
    
    [Amat Qext Flows] = computeAmatrix(handles.B, handles.B.WindDirection, handles.B.WindSpeed, handles.B.AmbientTemperature, handles.B.AmbientPressure, handles.B.v, handles.B.Temp, handles.B.Openings);
    
    nload=pp/(3+2*handles.B.nZones); 
    v.color=char('red');
    progressbar(v,nload)
    pp=pp+1;
    
    clear handles.flows
    handles.flows = Flows;
    
    clear handles.Amat
    handles.F.Nominal = Amat;
    handles.Amat = Amat;
    C = eye(handles.B.nZones);
    sys=ss(Amat,handles.B.B,C,handles.B.D);

    hours=str2double(get(handles.edit2, 'String'));
    TimeStep=str2double(get(handles.edit4, 'String'));
    StartTime=str2double(get(handles.edit5, 'String'));
    StopTime=str2double(get(handles.edit6, 'String'))';
    
    handles.hours=str2double(get(handles.edit2, 'String'));
    handles.TimeStep=str2double(get(handles.edit4, 'String'));
    handles.StartTime=str2double(get(handles.edit5, 'String'));
    handles.StopTime=str2num(get(handles.edit6, 'String'));
    
    clear handles.t
    t=0:TimeStep:hours;
    handles.t = t;
    
    j=0;    
    uint=zeros(handles.B.nZones,length(t));
    
    nload=pp/(3+2*handles.B.nZones); 
    v.color=char('red');
    progressbar(v,nload)
    pp=pp+1;
    
    for i=1:handles.B.nZones
        if handles.release(i)
            j=j+1;
            uint(i,find(t>StartTime,1):find(t>StopTime-TimeStep,1))=str2double(get(handles.edit1, 'String'));
            handles.zn{j}=handles.B.ZoneName{i};
        end
        nload=pp/(3+2*handles.B.nZones); 
        v.color=char('red');
        progressbar(v,nload)
        pp=pp+1;
    end

    for i=1:handles.B.nZones
        uext(i,1:length(t))=Qext(i) * handles.B.xext/handles.B.v(i);
        nload=pp/(3+2*handles.B.nZones); 
        v.color=char('red');
        progressbar(v,nload)
        pp=pp+1;
    end

    u=uint + uext;
 
    x = lsim(sys,u,t, handles.B.x0);
    handles.x = x + (2*handles.Noise)*rand(size(x)) - handles.Noise;
    nload=pp/(3+2*handles.B.nZones); 
    v.color=char('red');
    progressbar(v,nload)
    close(v.figure1);
    
    set(handles.plot, 'Enable', 'on')    
    set(handles.airflows, 'Enable', 'on')    
    set(handles.SaveConcentrations, 'Enable', 'on')
    set(handles.FDIparameters, 'Enable', 'on')
    set(handles.FDIrun, 'Enable', 'on')
    set(handles.SaveAmatrix, 'Enable', 'on')
    set(handles.FDIresults, 'Enable', 'off')
    
    msgbox('Simulation Run Completed')
guidata(hObject, handles);

% --------------------------------------------------------------------
function plot_Callback(hObject, eventdata, handles)

    % plot concentration
    figure(1)
    set(figure(1), 'Name', 'Contaminant Concentration');
    plot(handles.t, handles.B.C*handles.x')
    xlabel('Time (h)');ylabel('Actual concentration (g/m^3)');
%     title(['Contaminant Source into',handles.zn]);
    [row col] = find(handles.B.C);
    legend(handles.B.ZoneName(col));
    grid on
uiwait(figure(1))

% --------------------------------------------------------------------
function airflows_Callback(hObject, eventdata, handles)
    set(handles.exit, 'Enable', 'off')
    for i=3:(length(handles.B.X.AirflowPaths)-1)
        out = textscan(handles.B.X.AirflowPaths{i},'%s','delimiter',' ','multipleDelimsAsOne',1);
        pzn(i-2)=str2double(out{1}{3});
        pzm(i-2)=str2double(out{1}{4});
    end
    
    for i=1:handles.B.Paths
        data{i,1}=handles.opn{i,1}; 
        if pzn(i)==-1
            data{i,2} =['Ambient  ---> ', num2str(pzm(i)),'.',handles.B.ZoneName{pzm(i)}];
        elseif pzm(i)==-1
            data{i,2} =[num2str(pzn(i)),'.',handles.B.ZoneName{pzn(i)}, '--->  Ambient'];
        else
            data{i,2} = [num2str(pzn(i)),'.',handles.B.ZoneName{pzn(i)}, '  --->  ',num2str(pzm(i)),'.', handles.B.ZoneName{pzm(i)}];
        end
        data{i,3}=handles.flows(1,i);
    end
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    setappdata(HandleMainGUI,'SharedData', data);
    airflows_results
    uiwait(airflows_results)
    set(handles.exit, 'Enable', 'on')
guidata(hObject, handles);

% --- Executes on button press in SaveConcentrations.
function SaveConcentrations_Callback(hObject, eventdata, handles)
% hObject    handle to SaveConcentrations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    C=handles.x;
uisave('C', 'Concentration')

% --- Executes on button press in SaveAmatrix.
function SaveAmatrix_Callback(hObject, eventdata, handles)
% hObject    handle to SaveAmatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    A=handles.Amat;
uisave('A', 'Amatrix')

% --------------------------------------------------------------------
function exit_Callback(hObject, eventdata, handles)
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    
    if (isappdata(0,'HandleMainGUI') & isappdata(HandleMainGUI,'SharedData'))
        rmappdata(HandleMainGUI,'SharedData') %do rmappdata for all data shared 
     
    end
   
close all
close



function edit1_Callback(hObject, eventdata, handles)
set(handles.edit1, 'Enable', 'off')
set(handles.edit1, 'Enable', 'on')
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_Callback(hObject, eventdata, handles)
set(handles.edit2, 'Enable', 'off')
set(handles.edit2, 'Enable', 'on')
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit3_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --------------------------------------------------------------------
function multiple_Callback(hObject, eventdata, handles)
% hObject    handle to multiple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if  isempty(get(handles.edit1, 'String'))
    msgbox('Specify the contaminant release source', 'Error', 'error')
    return
end

if (str2double(get(handles.edit1, 'String'))<=0)
    msgbox('Give positive contaminant release source', 'Error', 'error')
    return
end

if  isempty(get(handles.edit2, 'String'))
    msgbox('Give simulation Time', 'Error', 'error')
    return
end

if (str2double(get(handles.edit2, 'String'))<1)|| (str2double(get(handles.edit2, 'String'))>24)
    msgbox('Simulation Time must be 1-24', 'Error', 'error')
    return
end
data{:,1}=handles.B.Openings(1:handles.B.Paths+handles.j);
data{:,2}= handles.B.AmbientTemperature;
data{:,3}= handles.B.AmbientPressure;
data{:,4}= handles.B.v;
data{:,5}= handles.B.Temp;
data{:,6}= handles.B.x0;
data{:,7}= handles.val;
data{:,8}= handles.pathname;
data{:,9}= str2double(get(handles.edit1, 'String'));
data{:,10}= str2double(get(handles.edit2, 'String'));
HandleMainGUI=getappdata(0,'HandleMainGUI');
setappdata(HandleMainGUI,'SharedData', data); 

uiwait(multiple_data)

% --- Executes on button press in LevelUp.
function LevelUp_Callback(hObject, eventdata, handles)
% hObject    handle to LevelUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    UserData = get(get(hObject,'Parent'), 'UserData');    
    handles.B = UserData.B;
    clear lH
    lH = findobj(handles.axes1,'Type','line','-and', 'MarkerEdgeColor','r');
    if ~isempty(lH)
        clear ii
        
        xp = []; 
        yp = [];
        for ii = lH'
            xp=[xp, get(ii,'Xdata')]; %Getting coordinates of line object
            yp=[yp, get(ii,'Ydata')];                                                     
        end        
        for jj = 1:length(xp)
            TH = findobj(handles.axes1,'Type','text', '-and', 'Position', [xp(jj), yp(jj), []]);               
            handles.B.Level(handles.B.LevelCounter).str{jj} = get(TH, 'String');
        end
        handles.B.Level(handles.B.LevelCounter).s = 1;
        handles.B.Level(handles.B.LevelCounter).xp = xp;
        handles.B.Level(handles.B.LevelCounter).yp = yp;
    else
        handles.B.Level(handles.B.LevelCounter).s = 0;
    end
    
    
    handles.B.LevelCounter = handles.B.LevelCounter+1;
    
    [handles.B.Size handles.B.X1 handles.B.Y1 handles.cmp] = plotB(handles.B.X,handles.axes1,handles.B.LevelCounter,handles.F.IsolationDecision,handles.B.clr,handles.B.WindDirection,handles.B.C,get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));
    
    if handles.B.Level(handles.B.LevelCounter).s
       plot(handles.B.Level(handles.B.LevelCounter).xp, handles.B.Level(handles.B.LevelCounter).yp, 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
        for jj = 1:length(handles.B.Level(handles.B.LevelCounter).xp)
            str1{1} = handles.B.Level(handles.B.LevelCounter).str{jj}{1};
            str1{2} = handles.B.Level(handles.B.LevelCounter).str{jj}{2};
            text(handles.B.Level(handles.B.LevelCounter).xp(jj), handles.B.Level(handles.B.LevelCounter).yp(jj), str1)                         
        end
%         clear xp yp str str1
    end
    
    if handles.B.LevelCounter==handles.level
        set(handles.LevelUp, 'Enable', 'off', 'Visible', 'off')
    else
        set(handles.LevelUp, 'Enable', 'on', 'Visible', 'on')
    end
  
    if handles.B.LevelCounter ~= 1
        set(handles.LevelDown, 'Enable', 'on', 'Visible', 'on')
    else
        set(handles.LevelDown, 'Enable', 'off', 'Visible', 'off')
    end
    
       
    UserData.B = handles.B;
    set(get(hObject,'Parent'),'UserData', UserData)
   
  guidata(hObject, handles);

% --- Executes on button press in LevelDown.
function LevelDown_Callback(hObject, eventdata, handles)
% hObject    handle to LevelDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    UserData = get(get(hObject,'Parent'), 'UserData');    
    handles.B = UserData.B;
    clear lH
    lH = findobj(handles.axes1,'Type','line','-and', 'MarkerEdgeColor','r');
    if ~isempty(lH)
        clear ii
        xp = []; 
        yp = [];
        for ii = lH'
            xp=[xp, get(ii,'Xdata')]; %Getting coordinates of line object
            yp=[yp, get(ii,'Ydata')];                                                     
        end   
        for jj = 1:length(xp)
            TH = findobj(handles.axes1,'Type','text', '-and', 'Position', [xp(jj), yp(jj), []]);               
            handles.B.Level(handles.B.LevelCounter).str{jj} = get(TH, 'String');
        end
        handles.B.Level(handles.B.LevelCounter).s = 1;
        handles.B.Level(handles.B.LevelCounter).xp = xp;
        handles.B.Level(handles.B.LevelCounter).yp = yp;
    else
        handles.B.Level(handles.B.LevelCounter).s = 0;
    end    
    
    handles.B.LevelCounter = handles.B.LevelCounter-1;
    
    [handles.B.Size handles.B.X1 handles.B.Y1 handles.cmp] = plotB(handles.B.X,handles.axes1,handles.B.LevelCounter,handles.F.IsolationDecision,handles.B.clr,handles.B.WindDirection, handles.B.C, get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));
    
    if handles.B.Level(handles.B.LevelCounter).s
       plot(handles.B.Level(handles.B.LevelCounter).xp, handles.B.Level(handles.B.LevelCounter).yp, 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
        for jj = 1:length(handles.B.Level(handles.B.LevelCounter).xp)
            str1{1} = handles.B.Level(handles.B.LevelCounter).str{jj}{1};
            str1{2} = handles.B.Level(handles.B.LevelCounter).str{jj}{2};
            text(handles.B.Level(handles.B.LevelCounter).xp(jj), handles.B.Level(handles.B.LevelCounter).yp(jj), str1)                         
        end
%       clear xp yp str str1
    end
    
    if handles.B.LevelCounter==handles.level
        set(handles.LevelUp, 'Enable', 'off', 'Visible', 'off')
    else
        set(handles.LevelUp, 'Enable', 'on', 'Visible', 'on')
    end

    if handles.B.LevelCounter ~= 1
        set(handles.LevelDown, 'Enable', 'on', 'Visible', 'on')
    else
        set(handles.LevelDown, 'Enable', 'off', 'Visible', 'off')
    end
    
       
    UserData.B = handles.B;
    set(get(hObject,'Parent'),'UserData', UserData)
    
  guidata(hObject, handles);

  
function X = readPRJ(filename)
        
    fid = fopen(filename, 'r');

    % Section 1: Project, Weather, Simulation, and Output Controls
    X.project{1} = fgetl(fid);
    i = 1;
    while strcmp(X.project{i},'-999')~=1
        if strcmp(X.project{i},'!sim_mf slae rs maxi   relcnvg   abscnvg relax gamma ucc')==1
            i = i +1;
            X.project{i} = fgetl(fid);
            c = X.project{i};
            c(5) = '1';
            X.project{i} = c;
        else
            i = i +1;
            X.project{i} = fgetl(fid);
        end
    end
   
    % Section 2: Species and Contaminants
    i =1;
    X.SpeciesContaminants{i} = fgetl(fid);
    while strcmp(X.SpeciesContaminants{i},'-999')~=1
        i = i +1;
        X.SpeciesContaminants{i} = fgetl(fid);
    end

    % Section 3: Level and Icon Data (coordinates)
    i =1;
    X.LevelIconData{i} = fgetl(fid);
    while strcmp(X.LevelIconData{i},'-999')~=1
        i = i +1;
        X.LevelIconData{i} = fgetl(fid);
    end

    % Section 4: Day Schedules
    i =1;
    X.DaySchedules{i} = fgetl(fid);
    while strcmp(X.DaySchedules{i},'-999')~=1
        i = i +1;
        X.DaySchedules{i} = fgetl(fid);
    end

    % Section 5: Week Schedules
    i =1;
    X.WeekSchedules{i} = fgetl(fid);
    while strcmp(X.WeekSchedules{i},'-999')~=1
        i = i +1;
        X.WeekSchedules{i} = fgetl(fid);
    end

    % Section 6: Wind Pressure Profiles
    i =1;
    X.WindPressureProfiles{i} = fgetl(fid);
    while strcmp(X.WindPressureProfiles{i},'-999')~=1
        i = i +1;
        X.WindPressureProfiles{i} = fgetl(fid);
    end

    % Section 7: Kinetic Reactions
    i =1;
    X.KineticReactions{i} = fgetl(fid);
    while strcmp(X.KineticReactions{i},'-999')~=1
        i = i +1;
        X.KineticReactions{i} = fgetl(fid);
    end

    % Section 8a: Filter Elements
    i =1;
    X.FilterElements{i} = fgetl(fid);
    while strcmp(X.FilterElements{i},'-999')~=1
        i = i +1;
        X.FilterElements{i} = fgetl(fid);
    end

    % Section 8b: Filters 
    i =1;
    X.Filters{i} = fgetl(fid);
    while strcmp(X.Filters{i},'-999')~=1
        i = i +1;
        X.Filters{i} = fgetl(fid);
    end

    % Section 9: Source/Sink Elements 
    i =1;
    X.SourceSinkElements{i} = fgetl(fid);
    while strcmp(X.SourceSinkElements{i},'-999')~=1
        i = i +1;
        X.SourceSinkElements{i} = fgetl(fid);
    end

    % Section 10: Airflow Elements 
    i =1;
    X.AirflowElements{i} = fgetl(fid);
    while strcmp(X.AirflowElements{i},'-999')~=1
        i = i +1;
        X.AirflowElements{i} = fgetl(fid);
    end

    % Section 11: Duct Elements 
    i =1;
    X.DuctElements{i} = fgetl(fid);
    while strcmp(X.DuctElements{i},'-999')~=1
        i = i +1;
        X.DuctElements{i} = fgetl(fid);
    end

    % Section 12a: Control Super Elements 
    i =1;
    X.ControlSuperElements{i} = fgetl(fid);
    while strcmp(X.ControlSuperElements{i},'-999')~=1
        i = i +1;
        X.ControlSuperElements{i} = fgetl(fid);
    end

    % Section 12b: Control Nodes 
    i =1;
    X.ControlNodes{i} = fgetl(fid);
    while strcmp(X.ControlNodes{i},'-999')~=1
        i = i +1;
        X.ControlNodes{i} = fgetl(fid);
    end

    % Section 13: Simple Air Handling System (AHS)
    i =1;
    X.AHS{i} = fgetl(fid);
    while strcmp(X.AHS{i},'-999')~=1
        i = i +1;
        X.AHS{i} = fgetl(fid);
    end

    % Section 14: Zones
    i =1;
    X.ZonesData{i} = fgetl(fid);
    while strcmp(X.ZonesData{i},'-999')~=1
        i = i +1;
        X.ZonesData{i} = fgetl(fid);
    end

    % Section 15: Initial Zone Concentrations
    i =1;
    X.InitialZoneConcentrations{i} = fgetl(fid);
    while strcmp(X.InitialZoneConcentrations{i},'-999')~=1
        i = i +1;
        X.InitialZoneConcentrations{i} = fgetl(fid);
    end

    % Section 16: Airflow Paths
    i =1;
    X.AirflowPaths{i} = fgetl(fid);
    while strcmp(X.AirflowPaths{i},'-999')~=1
        i = i +1;
        X.AirflowPaths{i} = fgetl(fid);
    end

    % Section 17: Duct Junctions
    i =1;
    X.DuctJunctions{i} = fgetl(fid);
    while strcmp(X.DuctJunctions{i},'-999')~=1
        i = i +1;
        X.DuctJunctions{i} = fgetl(fid);
    end

    % Section 18: Initial Junction Concentrations
    i =1;
    X.InitialJunctionConcentrations{i} = fgetl(fid);
    while strcmp(X.InitialJunctionConcentrations{i},'-999')~=1
        i = i +1;
        X.InitialJunctionConcentrations{i} = fgetl(fid);
    end

    % Section 19: Duct Segments
    i =1;
    X.DuctSegments{i} = fgetl(fid);
    while strcmp(X.DuctSegments{i},'-999')~=1
        i = i +1;
        X.DuctSegments{i} = fgetl(fid);
    end

    % Section 20: Source/Sinks
    i =1;
    X.SourceSinks{i} = fgetl(fid);
    while strcmp(X.SourceSinks{i},'-999')~=1
        i = i +1;
        X.SourceSinks{i} = fgetl(fid);
    end

    % Section 21: Occupancy Schedules
    i =1;
    X.OccupancySchedules{i} = fgetl(fid);
    while strcmp(X.OccupancySchedules{i},'-999')~=1
        i = i +1;
        X.OccupancySchedules{i} = fgetl(fid);
    end

    % Section 22: Exposures
    i =1;
    X.Exposures{i} = fgetl(fid);
    while strcmp(X.Exposures{i},'-999')~=1
        i = i +1;
        X.Exposures{i} = fgetl(fid);
    end

    % Section 23: Annotations
    i =1;
    X.Annotations{i} = fgetl(fid);
    while strcmp(X.Annotations{i},'-999')~=1
        i = i +1;
        X.Annotations{i} = fgetl(fid);
    end

    fclose(fid);
    
    
function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function MultipleScenarios_Callback(hObject, eventdata, handles)
% hObject    handle to MultipleScenarios (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ParameterSelection_Callback(hObject, eventdata, handles)
% hObject    handle to ParameterSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

CreateScenariosGui(handles.B);

% --------------------------------------------------------------------
function Calculate_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    close(findobj('type','figure','name','Run Multiple Scenarios'))

    load([pwd,'\SPLACE\RESULTS\','pathname.File'],'pathname','-mat');
    
    if exist('File0.File','file')==2 
        load([pwd,'\SPLACE\RESULTS\','File0.File'],'-mat');
        if exist([pathname,file0],'file')==2
            if ~isempty(file0) 
                load([pathname,file0],'-mat');
            else
                B.filename=handles.B.filename;
            end
        else
            B.filename=[];
        end
    else
        file0=[];
    end

    arguments.file0=file0(1:end-2);
    arguments.B=handles.B;
    runMultipleScenariosGui(arguments);

% --------------------------------------------------------------------
function SensorPlacement_Callback(hObject, eventdata, handles)
% hObject    handle to SensorPlacement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in FDIparameters.
function FDIparameters_Callback(hObject, eventdata, handles)
% hObject    handle to FDIparameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    Data{1} = handles.F;
    Data{2} = handles.B;
    Data{3} = handles.B.A;
    
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    setappdata(HandleMainGUI,'SharedData', Data); 
    change_FDIparameters
    uiwait(change_FDIparameters)
    
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    SomeDataShared=getappdata(HandleMainGUI,'SharedData');
    handles.F=SomeDataShared;
guidata(hObject, handles);


% --- Executes on button press in FDIrun.
function FDIrun_Callback(hObject, eventdata, handles)
% hObject    handle to FDIrun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  
    set(handles.FDIresults, 'Enable', 'off')
    
    [v.figure1,v.axes2,v.text_progress]=LoadGui;
    v.str='Source Detection...';
    pp=0;
    
    nload=pp/(3+length(handles.t)+2*handles.B.nZones); 
    v.color=char('red');
    progressbar(v,nload)
    pp=pp+1;
    
    C = eye(handles.B.nZones);
    sys=ss(handles.F.Nominal,handles.B.B,C,0);
    
    if handles.F.UncertaintiesBound==0
        % Find the poles to set the L matrix.
        pols = pole(sys)' - 0.1;
    else
        pols = pole(sys)' - handles.F.UncertaintiesBound*3;
    end
    
    % Create the L matrix.
    L = place(handles.F.Nominal',C',pols)';

    % Create the A0 matrix
    A0 = handles.F.Nominal - L*C;
    
    % find the p-> || expm(A0*t) || and pd-> || expm(A0*t)*L ||
    for i=1:length(handles.t)
        p(i)=norm(expm(A0*handles.t(i)));
        pd(i)= norm(expm(A0*handles.t(i))*L);
        nload=pp/(3+length(handles.t)+2*handles.B.nZones); 
        v.color=char('red');
        progressbar(v,nload)
        pp=pp+1;
    end
    
       
    % find the parameters for ksi and rho
    data = fit(handles.t', p', 'exp1');
    coefval = coeffvalues(data);
    rho =  coefval(1);
    ksi = -coefval(2);
    
    % find the parameters for ksi_d and rho_d
    clear data coefval
    data = fit(handles.t', pd', 'exp1');
    coefval = coeffvalues(data);
    rho_d =  coefval(1);
    ksi_d = -coefval(2);
    
    nload=pp/(3+length(handles.t)+2*handles.B.nZones); 
    v.color=char('red');
    progressbar(v,nload)
    pp=pp+1;
    
    % find the parameters for alpha, zita, alpha_d and zita_d.
    for j = 1:handles.B.nZones
        clear data data2 coefval coefval2
        for i=1:length(handles.t)
           az(i,j)=norm(C(j,:)*expm(A0*handles.t(i)));
           az_d(i,j)=norm(C(j,:)*expm(A0*handles.t(i))*L);
        end
        data = fit(handles.t', az(:,j), 'exp1');
        coefval = coeffvalues(data);
        alpha(j) = coefval(1);
        zita(j) = -coefval(2);

        data2 = fit(handles.t', az_d(:,j), 'exp1');
        coefval2 = coeffvalues(data2);
        alpha_d(j) = coefval2(1);
        zita_d(j) = -coefval2(2);
        
        nload=pp/(3+length(handles.t)+2*handles.B.nZones); 
        v.color=char('red');
        progressbar(v,nload)
        pp=pp+1;
    end
    clear data data2 coefval coefval2
    
       
    % Get the response of the system under healthy condition (Without
    % contaminat relese).
    x_He = lsim(sys,zeros(handles.B.nZones,length(handles.t)),handles.t);
    % The output with noise.
    y_He = x_He + (2*handles.F.NoiseBound)*rand(size(x_He)) - handles.F.NoiseBound;
    
    
    % Create The observer state space system.
    sys_obs = ss(A0,L,C,0);

    % Get the response from observer with healthy contitions
    x_hat = lsim(sys_obs, y_He, handles.t);
    y_hat = C*x_hat';
           
    % function to find the adaptive threshold Ey
    Ey = Detection_Threshold(handles.F.UncertaintiesBound, handles.F.NoiseBound, ksi, rho, ksi_d, rho_d, alpha, zita, alpha_d, zita_d, x_hat, handles.t, handles.B.nZones, handles.F.Ex0);
            
    % Get the response from observer with contaminant release.
    x_hat2 = lsim(sys_obs, handles.x, handles.t);
    y_hat2 = C*x_hat2';

    % The output estimation error
    ey = abs(handles.x - y_hat2');
    
    nload=pp/(3+length(handles.t)+2*handles.B.nZones); 
    v.color=char('red');
    progressbar(v,nload)
    pp=pp+1;
    
    % Find the Detection time Td
    i = 1;
    while (Ey(i,:) > ey(i,:))&(i < length(handles.t))
        i = i+1;
    end
     i = i+1;
     
          
     for j=1:handles.B.nZones
        [row(j) col(j)] = find(Ey(:,j)>ey(:,j),1,'last');
        nload=pp/(3+length(handles.t)+2*handles.B.nZones); 
        v.color=char('red');
        progressbar(v,nload)
        pp=pp+1;
     end
    
     c(1,:)= row(row<length(handles.t));
     c(2,:)= find(row<length(handles.t));
     
     zd = sortrows(c',1);
          
     
    handles.F.DetectionThreshold = Ey;
    handles.F.DetectionResidual = ey;
    
    nload=pp/(3+length(handles.t)+2*handles.B.nZones); 
    v.color=char('red');
    progressbar(v,nload)    
    close(v.figure1);
    
    if i<length(handles.t)
        handles.F.DetectionTime = handles.t(i);
        min = (handles.t(i) - fix(handles.t(i)))*60;
        sec = (min - fix(min))*60;
        uiwait(msgbox(sprintf('Contaminant Source Detected at Time %02d:%02d:%02d',fix(handles.t(i)), fix(min), fix(sec)), 'Warning', 'warn'));
        pause(1)
    else
        uiwait(msgbox('No Contaminant Source', 'Warning', 'warn'));
        pause(1)
        return
    end
    
    [v.figure1,v.axes2,v.text_progress]=LoadGui;
    v.str='Solve Isolation..';
    
    
    time2 = handles.t(i:length(handles.t));
    IT = 1;pp=0;
%         time2 = handles.t(1:length(handles.t)-i+1);
    for l=1:handles.B.nZones
        clear T Y            
        clear ZITA 
        clear Eyj Eyj1 Eyj2 Eyj3 Eyj4
        clear Omega Omega_abs C_Omega
        clear Ezj_th x_hat_abs ZITA_abs
        clear Ezj1 Ezj2 Ezj3 Ejt Ejda

        Fj = zeros(handles.B.nZones,1);
        Fj(l)=1;
        initial = zeros(2*handles.B.nZones+1,1);
        initial(2*handles.B.nZones+1) =   handles.F.InitialSourceEstimation;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           if mod(pp,100)==1
            nload=pp/(handles.B.nZones); 
            v.color=char('red');
            progressbar(v,nload)
%           end
            pp=pp+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        [T Y] = ode15s(@(tm,y2) myode(tm, y2, handles.F.Nominal, L, C, handles.x, handles.t, handles.F.LearningRate, handles.B.B, Fj), time2, initial);
        ZITA = Y(:,1:handles.B.nZones)';
        Omega = Y(:,handles.B.nZones+1:2*handles.B.nZones)';

        clear inp
        inp = ones(1,length(handles.t)-i+1);
        % Ez
        for k=1:length(time2)
            Omega_abs(k) = norm(Omega(:,k));
            ZITA_abs(k)= norm(ZITA(:,k));
            Ezj1(k)=rho*exp(-ksi*(time2(k)-handles.F.DetectionTime))*handles.F.Ez0;
        end

        sys1 = tf(rho*handles.F.UncertaintiesBound, [1 ksi]);
        Ezj2 = lsim(sys1, ZITA_abs, time2, 0);

        sys2 = tf(rho_d*handles.F.NoiseBound, [1 ksi_d]);
        Ezj3 = lsim(sys2, inp, time2, 0);

        Ejt = Omega_abs*handles.F.Theta + Ezj1 + Ezj2' + Ezj3';


        sys3 = tf(rho*handles.F.UncertaintiesBound, [1 ksi-(rho*handles.F.UncertaintiesBound)]);
        Ejda = lsim(sys3, Ejt, time2, 0);

        Ezj_th = Ejt + Ejda';

        % Ey

        for j=1:handles.B.nZones
            for k=1:length(time2)
                Eyj1(j,k)=alpha(j)*exp(-zita(j)*(time2(k)-handles.F.DetectionTime))*handles.F.Ez0;
                C_Omega(j,k)= norm(C(j,:)*Omega(:,k));
            end

            sys6= tf(alpha(j)*handles.F.UncertaintiesBound, [1 zita(j)]);
            sys7= tf(alpha_d(j)*handles.F.NoiseBound, [1 zita_d(j)]);

            Eyj2(j,:)= lsim(sys6, Ezj_th, time2,0);
            Eyj3(j,:)= lsim(sys6, ZITA_abs, time2, 0);
            Eyj4(j,:)= lsim(sys7, inp, time2, 0);

            Eyj(j,:) = C_Omega(j,k)*handles.F.Theta + Eyj1(j,:) + Eyj2(j,:) + Eyj3(j,:) + Eyj4(j,:) + handles.F.NoiseBound;

        end
        % find the estimation error
        clear Eyi
        Eyi = abs(handles.x(i:end,:)' - C*ZITA);
        IsolationThreshold(:,:,l) = Eyj;
        IsolationResidual(:,:,l) = Eyi;
        SourceEstimation(:,l) = Y(:,2*handles.B.nZones+1);
        if Eyi < Eyj
            handles.F.IsolationDecision(l) = 1;
        else
            handles.F.IsolationDecision(l) = 0;
        end
        [row col] = find(Eyi > Eyj,1); 

        if IT < col
            IT = col;
        end

    end

        if length(zd(:,2))>1
            clear T Y            
            clear ZITA 
            clear Eyj Eyj1 Eyj2 Eyj3 Eyj4
            clear Omega Omega_abs C_Omega
            clear Ezj_th x_hat_abs ZITA_abs
            clear Ezj1 Ezj2 Ezj3 Ejt Ejda
            time2 = handles.t(i:length(handles.t));
            Fj = zeros(handles.B.nZones,1);
            Fj(zd(:,2))=1;
            initial = zeros(2*handles.B.nZones+1,1);
            initial(2*handles.B.nZones+1) =   handles.F.InitialSourceEstimation;

            [T Y] = ode15s(@(tm,y2) myode(tm, y2, handles.F.Nominal, L, C, handles.x, handles.t, handles.F.LearningRate, handles.B.B, Fj), time2, initial);
            ZITA = Y(:,1:handles.B.nZones)';
            Omega = Y(:,handles.B.nZones+1:2*handles.B.nZones)';

            clear inp
            inp = ones(1,length(handles.t)-i+1);
            % Ez
            for k=1:length(time2)
                Omega_abs(k) = norm(Omega(:,k));
                ZITA_abs(k)= norm(ZITA(:,k));
            end

            for k=1:length(time2)
                Ezj1(k)=rho*exp(-ksi*(time2(k)-handles.F.DetectionTime))*handles.F.Ez0;
            end

            sys1 = tf(rho*handles.F.UncertaintiesBound, [1 ksi]);
            Ezj2 = lsim(sys1, ZITA_abs, time2, 0);

            sys2 = tf(rho_d*handles.F.NoiseBound, [1 ksi_d]);
            Ezj3 = lsim(sys2, inp, time2, 0);

            Ejt = Omega_abs*handles.F.Theta + Ezj1 + Ezj2' + Ezj3';


            sys3 = tf(rho*handles.F.UncertaintiesBound, [1 ksi-(rho*handles.F.UncertaintiesBound)]);
            Ejda = lsim(sys3, Ejt, time2, 0);

            Ezj_th = Ejt + Ejda';

            % Ey

            for j=1:handles.B.nZones
                for k=1:length(time2)
                    Eyj1(j,k)=alpha(j)*exp(-zita(j)*(time2(k)-handles.F.DetectionTime))*handles.F.Ez0;
                    C_Omega(j,k)= norm(C(j,:)*Omega(:,k));
                end

                sys6= tf(alpha(j)*handles.F.UncertaintiesBound, [1 zita(j)]);
                sys7= tf(alpha_d(j)*handles.F.NoiseBound, [1 zita_d(j)]);

                Eyj2(j,:)= lsim(sys6, Ezj_th, time2,0);
                Eyj3(j,:)= lsim(sys6, ZITA_abs, time2, 0);
                Eyj4(j,:)= lsim(sys7, inp, time2, 0);

                Eyj(j,:) = C_Omega(j,k)*handles.F.Theta + Eyj1(j,:) + Eyj2(j,:) + Eyj3(j,:) + Eyj4(j,:) + handles.F.NoiseBound;

            end
            % find the estimation error
            clear Eyi
            Eyi = abs(handles.x(i:end,:)' - C*ZITA);

            IsolationThreshold(:,:,l+1) = Eyj;
            IsolationResidual(:,:,l+1) = Eyi;
            SourceEstimation(:,l+1) = Y(:,2*handles.B.nZones+1);
            if Eyi<Eyj
                handles.F.IsolationDecision(zd(:,2)) = 1;
            end
       end

    handles.F.IsolationThreshold = IsolationThreshold;
    handles.F.IsolationResidual = IsolationResidual;
    handles.F.SourceEstimation = SourceEstimation;
    handles.F.IsolationTime = time2(IT);

    k = find(handles.F.IsolationDecision);
    nload=pp/(handles.B.nZones); 
    v.color=char('red');
    progressbar(v,nload) 
    if length(k)==1            
        uiwait(msgbox(sprintf('Contaminant Source in Z%d: %s', k, handles.B.ZoneName{k}), 'Warning', 'warn'));            
    elseif length(k)~=0
        uiwait(msgbox(sprintf('Contaminant Source in Zones : %s', num2str(k)), 'Warning', 'warn')); 
    else
        uiwait(msgbox('No Isolation Decision', 'Warning', 'warn'));
    end
    plotB(handles.B.X,handles.axes1,handles.B.LevelCounter,handles.F.IsolationDecision,handles.B.clr,handles.B.WindDirection,handles.B.C,get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));
      
    close(v.figure1);
    
    set(handles.FDIresults, 'Enable', 'on')
guidata(hObject, handles);


% --- Executes on button press in FDIresults.
function FDIresults_Callback(hObject, eventdata, handles)
% hObject    handle to FDIresults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    Data{1} = handles.F;
    Data{2} = handles.B;
    Data{3} = handles.t;
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    setappdata(HandleMainGUI,'SharedData', Data); 
    FDI_results
    uiwait(FDI_results)


% --------------------------------------------------------------------
function ComputeImpactMatrix_Callback(hObject, eventdata, handles)
% hObject    handle to ComputeImpactMatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    load([pwd,'\SPLACE\RESULTS\','pathname.File'],'pathname','-mat');

    if exist('File0.File','file')==2 
        load([pwd,'\SPLACE\RESULTS\','File0.File'],'-mat');
        if exist([pathname,file0],'file')==2
            if ~isempty(file0) 
                load([pathname,file0],'-mat');
            else
                B.filename=handles.B.filename;
            end
        else
            B.filename=[];
        end
    else
        file0=[];
    end

    arguments.file0=file0(1:end-2);
    arguments.B=handles.B;
    ComputeImpactMatricesGui(arguments);

% --------------------------------------------------------------------
function SolveSensorPlacement_Callback(hObject, eventdata, handles)
% hObject    handle to SolveSensorPlacement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    close(findobj('type','figure','name','Solve Sensor Placement'))
    load([pwd,'\SPLACE\RESULTS\','pathname.File'],'pathname','-mat');

    if exist('File0.File','file')==2 
        load([pwd,'\SPLACE\RESULTS\','File0.File'],'-mat');
        if exist([pathname,file0],'file')==2
            if ~isempty(file0) 
                    load([pathname,file0],'-mat');
                if exist([pathname,file0(1:end-2),'.w'],'file')==2
                else
                    B.filename=[];
                end
            else
                B.filename=handles.B.filename;
            end
        else
            B.filename=[];
        end
    else
        file0=[];
    end

    arguments.file0=file0(1:end-2);
    arguments.B=handles.B;
    arguments.axes1=handles.axes1;
    arguments.ZoneID = get(handles.ZoneID,'Value');
    arguments.PathID = get(handles.PathID,'Value');
    SolveSensorPlacementGui(arguments);
  

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%rmpath('SPLACE');
%rmpath('SPLACE\GuiSplace');
%rmpath('SPLACE\Mfiles');
%rmpath('CDI');
rmpath(genpath(pwd));
% close all
% Hint: delete(hObject) closes the figure
delete(hObject);


% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
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


% --- Executes on button press in RunContaminantEvent.
function RunContaminantEvent_Callback(hObject, eventdata, handles)
% hObject    handle to RunContaminantEvent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    

    if ~isempty(findobj('Name','Contaminant Concentration'))
        close(findobj('Name','Contaminant Concentration'))
    end
    
    if ~isempty(findobj('Name','Contaminant Detection Estimator'))
        close(findobj('Name','Contaminant Detection Estimator'))
    end
    
    if ~isempty(findobj('Name','Contaminant Isolation Decision'))
        close(findobj('Name','Contaminant Isolation Decision'))
    end

    if ~isempty(findobj('Name','Contaminant Detection Estimator 1'))
        close(findobj('Name','Contaminant Detection Estimator 1'))
    end
    
    if ~isempty(findobj('Name','Contaminant Detection Estimator 2'))
        close(findobj('Name','Contaminant Detection Estimator 2'))
    end
    
    if ~isempty(findobj('Name','Contaminant Detection Estimator 3'))
        close(findobj('Name','Contaminant Detection Estimator 3'))
    end
    
    if ~isempty(findobj('Name','Contaminant Isolation Decision 1'))
        close(findobj('Name','Contaminant Isolation Decision 1'))
    end
    
    if ~isempty(findobj('Name','Contaminant Isolation Decision 2'))
        close(findobj('Name','Contaminant Isolation Decision 2'))
    end
    
    if ~isempty(findobj('Name','Contaminant Isolation Decision 3'))
        close(findobj('Name','Contaminant Isolation Decision 3'))
    end
    
    oldmsgs = cellstr(get(handles.edit14,'String'));
    set(handles.edit14,'String',[oldmsgs;{'>> Prepare for running...'}] );
    set(handles.RunContaminantEvent,'Enable', 'inactive')
    set(handles.FDIresults, 'Enable', 'off')
    guidata(hObject, handles);
    
%     if matlabpool('size') == 0 % checking to see if my pool is already open
%         matlabpool open 2
%     end
    	
            
    for i=1:handles.B.nZones 
        handles.B.clr{i} = 'w';
    end
    lH = findobj(handles.axes1,'Type','line','-and', 'MarkerEdgeColor','r');
    if ~isempty(lH)
        clear ii
        jj=1;
        for ii = lH'
            xp(jj)=get(ii,'Xdata'); %Getting coordinates of line object
            yp(jj)=get(ii,'Ydata');
            TH = findobj(handles.axes1,'Type','text', '-and', 'Position', [xp(jj), yp(jj), []]);               
            str{jj} = get(TH, 'String');
            jj = jj + 1;                        
        end
    end

    [B.Size B.X1 B.Y1 handles.cmp] = plotB(handles.B.X,handles.axes1,handles.B.LevelCounter,handles.F.IsolationDecision,handles.B.clr,handles.B.WindDirection,handles.B.C,get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));
    if ~isempty(lH)
       plot(xp, yp, 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
        for jj = 1:length(lH)
            str1{1} = str{jj}{1};
            str1{2} = '  at 00:00:00';
            text(xp(jj), yp(jj), str1)
            clear str1
        end
        clear xp yp str ii jj
    end


    hours=str2double(get(handles.edit2, 'String'));
    TimeStep=str2double(get(handles.edit4, 'String'));
    Dt = [0 TimeStep];
    handles.t = 0:TimeStep:hours+TimeStep;
    handles.time = 0;

%     u = zeros(handles.B.nZones,round((hours+TimeStep)/TimeStep));
    he = zeros(handles.B.nZones,round((hours+TimeStep)/TimeStep));

    [Amat Qext Flows] = computeAmatrix(handles.B, handles.B.WindDirection, handles.B.WindSpeed, handles.B.AmbientTemperature, handles.B.AmbientPressure, handles.B.v, handles.B.Temp, handles.B.Openings);

    clear handles.flows
    handles.flows = Flows;


    % Real system
    handles.B.A = Amat;
    C = eye(handles.B.nZones);
    handles.B.C = C;
    sys=ss(Amat,handles.B.B,C,handles.B.D);
    if handles.ActiveDistributed == 0
%         set(handles.ActiveDistributedCDI, 'Enable', 'inactive')
        % Observer system
        if handles.F.UncertaintiesBound==0 % Find the poles to set the L matrix.            
            pols = pole(sys)' - 0.1;
        else
            pols = pole(sys)' - handles.F.UncertaintiesBound*3;
        end
        
    
        % Create the gain matrix L.
        L = place(Amat,C',pols)';

        % Create the A0 matrix
        A0 = Amat - L*C;        
        sys_obs = ss(A0,L,C,0);

         % find the p-> || expm(A0*t) || and pd-> || expm(A0*t)*L ||
        parfor j=1:length(handles.t)
            p(j)=norm(expm(A0*handles.t(j)));
            pd(j)= norm(expm(A0*handles.t(j))*L);        
        end

        % find the parameters for ksi and rho
        data = fit(handles.t', p', 'exp1');
        coefval = coeffvalues(data);
        rho =  coefval(1);
        ksi = -coefval(2);

        % find the parameters for ksi_d and rho_d
        clear data coefval
        data = fit(handles.t', pd', 'exp1');
        coefval = coeffvalues(data);
        rho_d =  coefval(1);
        ksi_d = -coefval(2);

        % find the parameters for alpha, zita, alpha_d and zita_d.
        for j = 1:handles.B.nZones
            clear data data2 coefval coefval2
            parfor k=1:length(handles.t)
               az(k,j)=norm(C(j,:)*expm(A0*handles.t(k)));
               az_d(k,j)=norm(C(j,:)*expm(A0*handles.t(k))*L);
            end
            data = fit(handles.t', az(:,j), 'exp1');
            coefval = coeffvalues(data);
            alpha(j) = coefval(1);
            zita(j) = -coefval(2);

            data2 = fit(handles.t', az_d(:,j), 'exp1');
            coefval2 = coeffvalues(data2);
            alpha_d(j) = coefval2(1);
            zita_d(j) = -coefval2(2);

        end
        clear data data2 coefval coefval2


        x0 = zeros(handles.B.nZones,1);
        he0 = zeros(handles.B.nZones,1);
        x_hat0 = zeros(handles.B.nZones,1);
        x_hat20  = zeros(handles.B.nZones,1);
        Initial.E1_DA0 = zeros(handles.B.nZones,1);
        Initial.E1_d0 = 0;
        Initial.E2_t0 = zeros(handles.B.nZones,1);
        Initial.Ey1DA0 = zeros(handles.B.nZones,1);
        Initial.Ey2DA0 = zeros(handles.B.nZones,1);
        Initial.Ey1d0 = zeros(handles.B.nZones,1);
        

        parfor isolator=1:handles.B.nZones
            initial1(isolator).init =   zeros((2*handles.B.nZones+1),1);
            initial1(isolator).init(2*handles.B.nZones+1) = 0.05;
        end

        nz = handles.B.nZones;
        parfor isolator1=1:handles.B.nZones        
            InitIso(isolator1).Ezj20 = zeros(nz,1);
            InitIso(isolator1).Ezj30 = 0;
            InitIso(isolator1).Ejda0 = zeros(nz,1);
            InitIso(isolator1).Eyj20 = zeros(nz,1);
            InitIso(isolator1).Eyj30 = zeros(nz,1);
            InitIso(isolator1).Eyj40 = zeros(nz,1);        
        end

        i=1;
        iso = 0;
        rst = 0;
        isorst = 0;
        Logical = zeros(handles.B.nZones,1);


        uint = zeros(handles.B.nZones,2);
        HeInp = zeros(handles.B.nZones,2);

        x = zeros(round((hours+TimeStep)/TimeStep),handles.B.nZones);
        x_He = zeros(round((hours+TimeStep)/TimeStep),handles.B.nZones);
        x_hat = zeros(round((hours+TimeStep)/TimeStep),handles.B.nZones);
%         ey = zeros(round((hours+TimeStep)/TimeStep),handles.B.nZones);
        x_hat2 = zeros(round((hours+TimeStep)/TimeStep),handles.B.nZones);
%         Ey = zeros(handles.B.nZones,round((hours+TimeStep)/TimeStep));
%%
%         if get(handles.Concentrations,'Value')
%             figure('Name','Contaminant Concentration','Units','centimeters','Position',[3 3 19 15],'NumberTitle', 'off','Visible','on')
%         else
%             figure('Name','Contaminant Concentration','Units','centimeters','Position',[3 3 19 15],'NumberTitle', 'off','Visible','off')
%         end
%         axes('fontname','Times New Roman')
%         handles.fig1 = gcf;
%         style = hgexport('factorystyle');
%         style.Bounds = 'tight';
%         hgexport(handles.fig1,'-clipboard',style,'applystyle', true);
%         drawnow;
%         clrs = lines(handles.B.nZones);
%            for j=1:handles.B.nZones
%     %         subplot(14,1,j)
%             sb(j)=scrollsubplot(4,1,j);
%             h(j) = plot(0,0,'Color',clrs(j,:));
%             xlim([0 1])
%             xlabel('Time (hr)')
%             ylabel('g/m^3')
%             ylim([-0.04 max(x0(j))+0.1])
%             set(gca,'YTick',linspace(0,max(x0(j))+0.1,4))
%             title(['Zone ', num2str(j)])
%     %         linkdata(h(j))
%            end
 %%
 
        
% [0.4839285714285715 0.379047619047619 0.31488095238095243 0.2885714285714286]
        fig = figure('position', get(0, 'screensize'), 'visible', 'off');
        set(fig,'Units','centimeters');
        pos = get(fig,'position');
        clear fig
        P.pos = [-0.0264382 0.8989 40*pos(1,3)/100 3.5*handles.B.nZones];
%         P.pos = [-0.0015197568389057749 0 1 round(handles.B.nZones/3)];
        if get(handles.Concentrations,'Value')
            fig = auto_scroll_GUI_template(P);
            set(fig,'Name','Contaminant Concentration','Units','centimeters','Position',[57.5*pos(1,3)/100 53.5*pos(1,4)/100 42*pos(1,3)/100 41*pos(1,4)/100],'NumberTitle', 'off','Visible','on')
            hf = get(fig, 'Children');
        else
            fig = auto_scroll_GUI_template(P);
            set(fig,'Name','Contaminant Concentration','Units','centimeters','Position',[57.5*pos(1,3)/100 53.5*pos(1,4)/100 42*pos(1,3)/100 41*pos(1,4)/100],'NumberTitle', 'off','Visible','off')
            hf = get(fig, 'Children');
        end

        clrs = lines(handles.B.nZones);
        for j=1:handles.B.nZones
            sb(j) = subplot(handles.B.nZones,1,j, 'Parent', hf(1),'Units','normalized','Position',[0.145 1-j*(0.025+(1/handles.B.nZones-0.035)) 0.8 (1/handles.B.nZones-0.035)]);
            %             sb(j)=scrollsubplot(4,1,j);
            h(j) = plot(0,0,'Color',clrs(j,:),'Parent',sb(j));
            %             xlim([0 hours],'Parent',sb(j))
            %             xlabel('Time (hr)','Parent',sb(j));
            ylabel('g/m^3','Parent',sb(j));
            %             ylim([-0.04 max(x0(j))+0.1],'Parent',sb(j))
            set(sb(j),'YTick',linspace(0,max(x0(j))+0.1,4), 'XLim', [0 hours], 'YLim', [-0.04 max(x0(j))+0.1])
            title(['Zone ', num2str(j)],'Parent',sb(j));
            %         linkdata(h(j))
        end
        pause(0.1)
           

 %%
  
%         if get(handles.CDE,'Value')
%             figure('Name','Contaminant Detection Estimator','Units','centimeters','Position',[3 3 19 15],'NumberTitle', 'off','Visible','on')
%         else
%             figure('Name','Contaminant Detection Estimator','Units','centimeters','Position',[3 3 19 15],'NumberTitle', 'off','Visible','off')
%         end
%     %     figure('Name','Contaminant Detection Estimator','Units','centimeters','Position',[3 3 17 15],'NumberTitle', 'off')
%         axes('fontname','Times New Roman')
%         handles.fig2 = gcf;
%         style = hgexport('factorystyle');
%         style.Bounds = 'tight';
%         hgexport(handles.fig2,'-clipboard',style,'applystyle', true);
%         drawnow;
%         sb2(1)=scrollsubplot(4,1,1);
%         D1(1) = plot(0,x0(1));
%         xlim([0 hours])
%         hold on
%         D2(1) = plot(0,x0(1),'--r');
%         xlim([0 hours])
%         xlabel('Time (hr)')
%         ylabel(['Zone ', num2str(1)])
%         ylim([-0.04 max(x0(1))+0.1])
%         set(gca,'YTick',linspace(0,max(x0(1))+0.1,4))
%         lg = legend('$\varepsilon_{y}$ Residual', '$\overline{\varepsilon}_{y}$ Threshold', 'Location', 'Best');
%         set(lg,'interpreter','latex','FontName','Helvetica','FontSize',12)
%         for j=2:handles.B.nZones
%     %         subplot(round(handles.B.nZones/2),2,j)
%             sb2(j)=scrollsubplot(4,1,j);
%             D1(j) = plot(0,x0(j));
%             xlim([0 hours])
%             hold on
%             D2(j) = plot(0,x0(j),'--r');
%             xlim([0 hours])
%             xlabel('Time (hr)')
%             ylabel(['Zone ', num2str(j)])
%             ylim([-0.04 max(x0(j))+0.1])
%             set(gca,'YTick',linspace(0,max(x0(j))+0.1,4))
%     %         title(['Zone ', num2str(j)])
%         end  
%%
%         P.pos = [-0.0264382 0.8989 13 round(handles.B.nZones/4)*14];
        if get(handles.CDE,'Value')
            fig2 = auto_scroll_GUI_template2(P);
            set(fig2,'Name','Contaminant Detection Estimator','Units','centimeters','Position',[57.5*pos(1,3)/100 1 42*pos(1,3)/100 41*pos(1,4)/100],'NumberTitle', 'off','Visible','on')
            hf2 = get(fig2, 'Children');
        else
            fig2 = auto_scroll_GUI_template2(P);
            set(fig2,'Name','Contaminant Detection Estimator','Units','centimeters','Position',[57.5*pos(1,3)/100 1 42*pos(1,3)/100 41*pos(1,4)/100],'NumberTitle', 'off','Visible','off')
            hf2 = get(fig2, 'Children');
        end
    %     figure('Name','Contaminant Detection Estimator','Units','centimeters','Position',[3 3 17 15],'NumberTitle', 'off')
%         axes('fontname','Times New Roman')
%         handles.fig2 = gcf;
%         style = hgexport('factorystyle');
%         style.Bounds = 'tight';
%         hgexport(fig2,'-clipboard',style,'applystyle', true);
%         drawnow;
        sb2(1)=subplot(handles.B.nZones,1,1,'Parent', hf2(1),'Units','normalized','Position',[0.145 1-(0.025+(1/handles.B.nZones-0.035)) 0.8 (1/handles.B.nZones-0.035)]);
        D1(1) = plot(0,x0(1),'Parent', sb2(1));
%         xlim([0 hours])
        hold on
        D2(1) = plot(0,x0(1),'--r', 'Parent', sb2(1));
%         xlim([0 hours])
%         xlabel('Time (hr)','Parent', sb2(1));
        ylabel(['Zone ', num2str(1)],'Parent', sb2(1));
%         ylim([-0.04 max(x0(1))+0.1])
        set(sb2(1),'YTick',linspace(0,max(x0(1))+0.1,4),'XLim',[0 hours], 'YLim',[-0.04 max(x0(1))+0.1])
        lg = legend('$\varepsilon_{y}$ Residual', '$\overline{\varepsilon}_{y}$ Threshold', 'Location', 'Best');
        set(lg,'interpreter','latex','FontName','Helvetica','FontSize',12);
        
        for j=2:handles.B.nZones
            sb2(j)=subplot(handles.B.nZones,1,j,'Parent', hf2(1),'Units','normalized','Position',[0.145 1-j*(0.025+(1/handles.B.nZones-0.035)) 0.8 (1/handles.B.nZones-0.035)]);
%             sb2(j)=scrollsubplot(4,1,j);
            D1(j) = plot(0,x0(j),'Parent', sb2(j));
%             xlim([0 hours])
            hold on
            D2(j) = plot(0,x0(j),'--r','Parent', sb2(j));
%             xlim([0 hours])
%             xlabel('Time (hr)','Parent', sb2(j))
            ylabel(['Zone ', num2str(j)],'Parent', sb2(j))
%             ylim([-0.04 max(x0(j))+0.1])
            set(sb2(j),'YTick',linspace(0,max(x0(j))+0.1,4),'XLim',[0 hours], 'YLim',[-0.04 max(x0(j))+0.1])
    %         title(['Zone ', num2str(j)])
        end  

%%
        pause(0.01)   
        
%         guidata(hObject,handles);
        while i<round((hours+TimeStep)/TimeStep)
            handles.time = handles.t(i);     
            
            axesHandle  = get(hObject,'Parent');
%             Handles = guidata(axesHandle); % Obtain current value
%             Handles.B.LevelCounter = Handles.B.LevelCounter + 1;  % Update value
%             guidata(axesHandle, Handles);  % Store value
%             drawnow;  % Let other events be processed
            



%             Data1 = guidata(handles.LevelUp);
%             Data2 = guidata(handles.LevelDown);
%             handles.B.LevelCounter = Data1.B.LevelCounter
%             drawnow;
%             Handles = guidata(handles.LevelUp);
%             handles.B.LevelCounter = Handles.B.LevelCounter + 1;
%             drawnow;
%             handles.B.Level = Handles.B.Level;
%             handles.B.Level.s = Handles.B.Level.s;
%             handles.B.Level.xp = Handles.B.Level.xp;
%             handles.B.Level.yp = Handles.B.Level.yp;            
            
%             guidata(axesHandle, Handles);
%             drawnow; 
%             pause(0.1);
%             H = get(axesHandle, 'UserData');
%             handles.u = H.u;
%             handles.Sources = H.Sources;
            UserData = get(axesHandle, 'UserData'); 
            handles.u = UserData.u;
            handles.B = UserData.B;
            parfor k=1:2
                uint(:,k) = handles.u;
            end

            

            if (handles.B.WindDirection ~= str2num(get(handles.edit12, 'String')))||(handles.B.WindSpeed ~= str2num(get(handles.edit13, 'String')))
                handles.B.WindDirection = str2num(get(handles.edit12, 'String'));
                handles.B.WindSpeed = str2num(get(handles.edit13, 'String'));
                [Amat Qext Flows] = computeAmatrix(handles.B, handles.B.WindDirection, handles.B.WindSpeed, handles.B.AmbientTemperature, handles.B.AmbientPressure, handles.B.v, handles.B.Temp, handles.B.Openings);

                clear handles.flows
                handles.flows = Flows;


                % Real system
                handles.B.A = Amat;
                C = eye(handles.B.nZones);
                sys=ss(Amat,handles.B.B,C,handles.B.D);

                % Observer system
                if handles.F.UncertaintiesBound==0 % Find the poles to set the L matrix.            
                    pols = pole(sys)' - 0.1;
                else
                    pols = pole(sys)' - handles.F.UncertaintiesBound*3;
                end
                % Create the gain matrix L.
                L = place(Amat',C',pols)';

                % Create the A0 matrix
                A0 = Amat - L*C;        
                sys_obs = ss(A0,L,C,0);

                % find the p-> || expm(A0*t) || and pd-> || expm(A0*t)*L ||
                parfor j=1:length(handles.t)
                    p(j)=norm(expm(A0*handles.t(j)));
                    pd(j)= norm(expm(A0*handles.t(j))*L);        
                end

                % find the parameters for ksi and rho
                data = fit(handles.t', p', 'exp1');
                coefval = coeffvalues(data);
                rho =  coefval(1);
                ksi = -coefval(2);

                % find the parameters for ksi_d and rho_d
                clear data coefval
                data = fit(handles.t', pd', 'exp1');
                coefval = coeffvalues(data);
                rho_d =  coefval(1);
                ksi_d = -coefval(2);

                % find the parameters for alpha, zita, alpha_d and zita_d.
                for j = 1:handles.B.nZones
                    clear data data2 coefval coefval2
                    parfor k=1:length(handles.t)
                       az(k,j)=norm(C(j,:)*expm(A0*handles.t(k)));
                       az_d(k,j)=norm(C(j,:)*expm(A0*handles.t(k))*L);
                    end
                    data = fit(handles.t', az(:,j), 'exp1');
                    coefval = coeffvalues(data);
                    alpha(j) = coefval(1);
                    zita(j) = -coefval(2);

                    data2 = fit(handles.t', az_d(:,j), 'exp1');
                    coefval2 = coeffvalues(data2);
                    alpha_d(j) = coefval2(1);
                    zita_d(j) = -coefval2(2);

                end
                clear data data2 coefval coefval2     

            end



    %         clear handles.Amat
        %     handles.F.Nominal = Amat;



            % Actual concentrations
            x(i:i+1,:) = lsim(sys, uint, Dt, x0);
            x0 = x(i+1,:)';

            clear y
            t = 0:TimeStep:TimeStep*i;
            y = x(1:i+1,:); 
            for j=1:handles.B.nZones                       
                set(h(j),'YData',y(:,j) ,'XData',t)            
                set(sb(j), 'YLim',[-0.04, max(x(:,j))+0.1],'YTick',linspace(0,max(x(:,j))+0.1,4))
            end  
            refreshdata        

            if isorst == 0
                HeInp(:,1) = he(:,i);
                HeInp(:,2) = he(:,i+1);
                
                % Under healthy conditions concentrations
                x_He(i:i+1,:) = lsim(sys,HeInp,Dt,he0);
                he0 = x_He(i+1,:)';

                % Under healthy conditions estimated concentrations
                x_hat(i:i+1,:) = lsim(sys_obs, x_He(i:i+1,:), Dt, x_hat0);
                x_hat0 = x_hat(i+1,:)';

                % Estimated concentrations
                x_hat2(i:i+1,:) = lsim(sys_obs, x(i:i+1,:), Dt, x_hat20);
                x_hat20 = x_hat2(i+1,:)';

                % estimation error
                ey = abs(x(1:i+1,:) - x_hat2(1:i+1,:));

        %         [Ey(:,i:i+1) Initial] = Detection_Threshold(handles.F.UncertaintiesBound, handles.F.NoiseBound, ksi, rho, ksi_d, rho_d, alpha, zita, alpha_d, zita_d, x_hat, [i i+1]*TimeStep, Dt, handles.B.nZones, handles.F.Ex0, Initial);
                [Ey(:,i:i+1) Initial] = DetectionThreshold(handles.F.UncertaintiesBound, handles.F.NoiseBound, ksi, rho, ksi_d, rho_d, alpha, zita, alpha_d, zita_d, x_hat(i:i+1,:), [i i+1]*TimeStep, Dt, handles.B.nZones, handles.F.Ex0, Initial);

                for j=1:handles.B.nZones
                    y1 = Ey(j,1:i+1);
                    y2 = ey(1:i+1,j);
                    t = 0:TimeStep:TimeStep*i;
                    set(D2(j),'YData',y1)
                    set(D2(j),'XData',t)
                    set(D1(j),'YData',y2)
                    set(D1(j),'XData',t)
                    set(sb2(j), 'YLim',[-0.04, max([ey(:,j); Ey(j,:)'])+0.1],'YTick',linspace(0,max([ey(:,j); Ey(j,:)'])+0.1,4))
        %             refreshdata(D1(j), D2(j), sb2(j))
                end
                if max(Ey(:,i) < ey(i,:)')
                   isorst = 1;
                else
                   isorst = 0;
                end
            end

            if isorst

                iso = iso + 1;
                Dtime(iso) = i*TimeStep;

                if rst == 0
                    for j=1:handles.B.nZones 
                        handles.B.clr{j} = [255/255 153/255 153/255];
                    end
                    UserData.B = handles.B;
                    set(get(hObject,'Parent'),'UserData', UserData)
                    
                    clear lH
                    lH = findobj(handles.axes1,'Type','line','-and', 'MarkerEdgeColor','r');
                    if ~isempty(lH)
                        clear ii

                        for ii = lH'
                            xp=get(ii,'Xdata'); %Getting coordinates of line object
                            yp=get(ii,'Ydata');                   
    %                                                
                        end
                        for jj = 1:length(xp)
                            TH = findobj(handles.axes1,'Type','text', '-and', 'Position', [xp(jj), yp(jj), []]);               
                            str{jj} = get(TH, 'String');
                        end
                    end
                    plotB(handles.B.X, handles.axes1, handles.B.LevelCounter, handles.F.IsolationDecision,handles.B.clr,handles.B.WindDirection,handles.B.C,get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));
                    if ~isempty(lH)
                       plot(xp, yp, 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
                        for jj = 1:length(xp)
                            str1{1} = str{jj}{1};
                            str1{2} = str{jj}{2};
                            text(xp(jj), yp(jj), str1)                         
                        end
                        clear xp yp str str1
                    end

                    mins = ((Dtime(1)) - fix(Dtime(1)))*60;
                    sec = (mins - fix(mins))*60;                
                    text(3, 2, ['Contaminant Detected at ', sprintf('%02d:%02d:%02d !!!',fix(Dtime(1)),fix(mins),fix(sec))], 'FontSize',13','FontWeight','bold')

                    oldmsgs = cellstr(get(handles.edit14,'String'));
                    set(handles.edit14,'String',[oldmsgs;{['>> Contaminant Detected at ', sprintf('%02d:%02d:%02d !!!',fix(Dtime(1)),fix(mins),fix(sec))]}] );

    %                 figure('Name','Contaminant Isolation Decision','Units','centimeters','Position',[3 3 17 15],'NumberTitle', 'off')
                    if get(handles.CIE,'Value')
                        fig3 = auto_scroll_GUI_template3(P);
                        set(fig3,'Name','Contaminant Isolation Decision','Units','centimeters','Position',[57.5*pos(1,3)/100 1 42*pos(1,3)/100 41*pos(1,4)/100],'NumberTitle', 'off','Visible','on')
                        hf3 = get(fig3, 'Children');
                    else
                        fig3 = auto_scroll_GUI_template3(P);
                        set(fig3,'Name','Contaminant Isolation Decision','Units','centimeters','Position',[57.5*pos(1,3)/100 1 42*pos(1,3)/100 41*pos(1,4)/100],'NumberTitle', 'off','Visible','off')
                        hf3 = get(fig3, 'Children');
                    end
                            
                    
%                     axes('fontname','Times New Roman')
%                     handles.fig3 = gcf;
%                     style = hgexport('factorystyle');
%                     style.Bounds = 'tight';
%                     hgexport(handles.fig3,'-clipboard',style,'applystyle', true);
%                     drawnow;
                    for j=1:handles.B.nZones
%                         scrollsubplot(4,1,j);
                        sb3(j) =  subplot(handles.B.nZones,1,j,'Parent', hf3(1),'Units','normalized','Position',[0.145 1-j*(0.025+(1/handles.B.nZones-0.035)) 0.8 (1/handles.B.nZones-0.035)]);
                        I(j) = plot(0,Logical(j,1),'LineWidth',1.5,'Parent',sb3(j));
%                         xlabel('Time (hr)')
%                         xlim([Dtime(1) hours])
%                         ylim([-0.2 1.2])
                        title(['Zone ', num2str(j)],'Parent',sb3(j))
%                         set(gca,'YTick',[0;1])
                        set(sb3(j),'YTick',[0;1], 'XLim', [Dtime(1) hours], 'YLim', [-0.2 1.2])
                    end
                    YY1 = zeros(round((hours+TimeStep)/TimeStep)-i+1,2*handles.B.nZones+1,handles.B.nZones); % need to change dimension for multiple source
                    Logical = zeros(handles.B.nZones,round((hours+TimeStep)/TimeStep)-i+1);
%                     IsolationResidual(:).Eyi = zeros(handles.B.nZones,round((hours+TimeStep)/TimeStep)-i+1);
%                     IsolationThrhld(:).Eyj = zeros(handles.B.nZones,round((hours+TimeStep)/TimeStep)-i+1);
                    IsoChk = 1:handles.B.nZones;
                    rst = 1;
                end
                

                for isolator2 = IsoChk
                    Fj = zeros(handles.B.nZones,1);
                    Fj(isolator2)=1;
    %                 clear Y1 T
                    [T ISO(isolator2).Y] = ode15s(@(tm,y2) myode2(tm, y2, Amat, L, C, x(i:i+1,:), Dt, handles.F.LearningRate, handles.B.B, Fj, 1), Dt, initial1(isolator2).init);
                end  
                
                Y = struct2cell(ISO);
                for isolator3 = IsoChk
                    YY1(iso:iso+1,:,isolator3) = [Y{isolator3}(1,:); Y{isolator3}(end,:)];
                    initial1(isolator3).init = ISO(isolator3).Y(end,:)';
                end
                ZITA = YY1(iso:iso+1,1:handles.B.nZones,:); 
                OMEGA = YY1(iso:iso+1,(handles.B.nZones+1):2*handles.B.nZones,:);            

    %             IsolationResidual(isolator).Eyi(1:handles.B.nZones,iso:iso+1) = abs(x(i:i+1,:)' - C*YY1(iso:iso+1,1:handles.B.nZones,isolator)');
    %             Eyi(1:handles.B.nZones,iso:iso+1,isolator) = abs(x(i:i+1,:)' - C*YY1(iso:iso+1,1:handles.B.nZones,isolator)');


                for isolator = IsoChk
    %                 r = size(Y1);
    %                 YY1(iso:iso+1,:,isolator) = [Y1(1,:); Y1(r(1),:)];
    %                 initial1(isolator).init = Y1(r(1),:)';
    %     %             Eyi(:,:,isolator) = abs(x(i+1-iso:i+1,:)' - C*YY1(1:iso+1,1:14,isolator)')';
                    IsolationResidual(isolator).Eyi(1:handles.B.nZones,iso:iso+1) = abs(x(i:i+1,:)' - C*YY1(iso:iso+1,1:handles.B.nZones,isolator)');
                    [IsolationThrhld(isolator).Eyj(1:handles.B.nZones,iso:iso+1) InitIso(isolator)] = IsolationThreshold(handles.F.UncertaintiesBound, handles.F.NoiseBound, ksi, rho, ksi_d, rho_d, alpha, zita, alpha_d, zita_d, [i-1 i]*TimeStep, Dt, Dtime(1)-TimeStep, handles.B.nZones, C, handles.F.Theta, handles.F.Ez0, ZITA(:,:,isolator)', OMEGA(:,:,isolator), InitIso(isolator));
                    

    %                 Eyi(1:handles.B.nZones,iso:iso+1,isolator) = abs(x(i:i+1,:)' - C*YY1(iso:iso+1,1:handles.B.nZones,isolator)');
    %                 [Eyj(1:handles.B.nZones,iso:iso+1,isolator) InitIso(isolator)] = IsolationThreshold(handles.F.UncertaintiesBound, handles.F.NoiseBound, ksi, rho, ksi_d, rho_d, alpha, zita, alpha_d, zita_d, [i-1 i]*TimeStep, Dt, Dtime(1)-TimeStep, handles.B.nZones, C, handles.F.Theta, handles.F.Ez0, YY1(iso:iso+1,1:handles.B.nZones,isolator)', YY1(iso:iso+1,(handles.B.nZones+1):2*handles.B.nZones,isolator), InitIso(isolator));

    %                 if Eyi(1:handles.B.nZones,iso+1,isolator)<Eyj(1:handles.B.nZones,iso+1,isolator) & Logical(isolator,iso)==0
    %                     Logical(isolator,iso+1) = 0;
    %                 else
    %                     Logical(isolator,iso+1) = 1;
    %                 end

                end
%                 clear IsoChk
%                 IsoChk = [];
                for isolator4 = IsoChk
                    if IsolationResidual(isolator4).Eyi(1:handles.B.nZones,iso+1)<IsolationThrhld(isolator4).Eyj(1:handles.B.nZones,iso+1) & Logical(isolator4,iso)==0
                        Logical(isolator4,iso+1) = 0;                        
%                         IsoChk = [IsoChk, isolator4];
                    else
                        Logical(isolator4,iso+1:end) = 1;
                        IsoChk(IsoChk == isolator4) = [];
                    end            
                end

                if max(Logical(:,iso)~=Logical(:,iso+1))
                    handles.IsoTime = i*TimeStep;
                    if length(find(Logical(:,iso+1)==0)) == 1
                        for j=1:handles.B.nZones
                            if Logical(j,iso+1)
                                handles.B.clr{j} = 'w';
                            else
                                handles.B.clr{j} = [1 1 153/255];
                            end
                        end
                        UserData.B = handles.B;
                        set(get(hObject,'Parent'),'UserData', UserData)
                        
                        clear lH
                        lH = findobj(handles.axes1,'Type','line','-and', 'MarkerEdgeColor','r');
                        if ~isempty(lH)
                            clear ii

                            for ii = lH'
                                xp=get(ii,'Xdata'); %Getting coordinates of line object
                                yp=get(ii,'Ydata');                   
            %                                                
                            end
                            for jj = 1:length(xp)
                                TH = findobj(handles.axes1,'Type','text', '-and', 'Position', [xp(jj), yp(jj), []]);               
                                str{jj} = get(TH, 'String');
                            end
                        end
                        plotB(handles.B.X, handles.axes1, handles.B.LevelCounter, handles.F.IsolationDecision,handles.B.clr,handles.B.WindDirection,handles.B.C,get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));
                        mins = ((handles.IsoTime) - fix(handles.IsoTime))*60;
                        sec = (mins - fix(mins))*60;                
                        text(3, 2, ['Contaminant Isolated in  Z', num2str(find(Logical(:,iso+1)==0)), sprintf(' at %02d:%02d:%02d !!!',fix(handles.IsoTime),fix(mins),fix(sec))], 'FontSize',13','FontWeight','bold')
                        oldmsgs = cellstr(get(handles.edit14,'String'));
                        set(handles.edit14,'String',[oldmsgs;{['>> Contaminant Isolated in  Z', num2str(find(Logical(:,iso+1)==0)), sprintf(' at %02d:%02d:%02d !!!',fix(handles.IsoTime),fix(mins),fix(sec))]}] );
                        if ~isempty(lH)
                           plot(xp, yp, 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
                            for jj = 1:length(xp)
                                str1{1} = str{jj}{1};
                                str1{2} = str{jj}{2};
                                text(xp(jj), yp(jj), str1)                         
                            end
                            clear xp yp str str1

                        end 
                        
                    else
                        for j=1:handles.B.nZones
                            if Logical(j,iso+1)
                                handles.B.clr{j} = 'w';
                            else
                                handles.B.clr{j} = [255/255 153/255 153/255];
                            end
                        end
                        UserData.B = handles.B;
                        set(get(hObject,'Parent'),'UserData', UserData)
                        
                        clear lH
                        lH = findobj(handles.axes1,'Type','line','-and', 'MarkerEdgeColor','r');
                        if ~isempty(lH)
                            clear ii

                            for ii = lH'
                                xp=get(ii,'Xdata'); %Getting coordinates of line object
                                yp=get(ii,'Ydata');                   
        %                                                
                            end
                            for jj = 1:length(xp)
                                TH = findobj(handles.axes1,'Type','text', '-and', 'Position', [xp(jj), yp(jj), []]);               
                                str{jj} = get(TH, 'String');
                            end
                        end
                        plotB(handles.B.X, handles.axes1, handles.B.LevelCounter, handles.F.IsolationDecision,handles.B.clr,handles.B.WindDirection,handles.B.C,get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));
                        mins = (Dtime(1) - fix(Dtime(1)))*60;
                        sec = (mins - fix(mins))*60;                
                        text(3, 2, ['Contaminant Detected at ', sprintf('%02d:%02d:%02d !!!',fix(Dtime(1)),fix(mins),fix(sec))], 'FontSize',13','FontWeight','bold')
                        if ~isempty(lH)
                           plot(xp, yp, 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
                            for jj = 1:length(xp)
                                str1{1} = str{jj}{1};
                                str1{2} = str{jj}{2};
                                text(xp(jj), yp(jj), str1)                         
                            end
                            clear xp yp str str1

                        end
                    end       
                    
                end

                t2 = Dtime(1):TimeStep:TimeStep*i;
                a = TimeStep/15;
                timeAxis=bsxfun(@plus,(0:a:0.0167-a)', t2); %subsampled time axis
                for j=1:handles.B.nZones                
    %                 yl = Logical(j,1:iso);                
                    plotdata=bsxfun(@times,ones(15,1),Logical(j,1:iso));                
                    set(I(j),'YData',plotdata(:))
                    set(I(j),'XData',timeAxis(:))
                    refreshdata(I(j))
                end 
    %             refreshdata(I)
            end

            i=i+1;
            pause(0.15)
            guidata(hObject, handles);
        end
        set(handles.ActiveDistributedCDI,'Enable', 'on')
        handles.F.DetectionThreshold = Ey';
        handles.F.DetectionResidual = ey;
        handles.x = x(1:length(handles.t),:);
        if isorst
            handles.F.DetectionTime = Dtime(1);
            handles.F.IsolationThreshold = IsolationThrhld;
            handles.F.IsolationResidual = IsolationResidual;
            handles.F.SourceEstimation = YY1(:,2*handles.B.nZones+1,:);
            handles.F.IsolationTime = handles.IsoTime;
        end
        
        
    else
%% Distributed CDI         
%         set(handles.DeactiveDistribudedCDI, 'Enable', 'inactive')

%% Define matrices
        A1 = Amat(1:5,1:5);

        A2 = zeros(5,5);
        A2(1,1) = Amat(6,6);
        A2(2,1) = Amat(8,6);
        A2(1,2) = Amat(6,8);
        A2(2,2) = Amat(8,8);
        A2(3,2) = Amat(9,8);
        A2(2,3) = Amat(8,9);
        A2(3,3) = Amat(9,9);
        A2(4,3) = Amat(12,9);
        A2(5,3) = Amat(13,9);
        A2(3,4) = Amat(9,12);
        A2(4,4) = Amat(12,12);
        A2(5,4) = Amat(13,12);
        A2(3,5) = Amat(9,13);
        A2(4,5) = Amat(12,13);
        A2(5,5) = Amat(13,13);

        A3 = zeros(4,4);
        A3(1,1) = Amat(7,7);
        A3(2,1) = Amat(10,7);
        A3(1,2) = Amat(7,10);
        A3(2,2) = Amat(10,10);
        A3(3,2) = Amat(11,10);
        A3(2,3) = Amat(10,11);
        A3(3,3) = Amat(11,11);
        A3(4,3) = Amat(14,11);
        A3(3,4) = Amat(11,14);
        A3(4,4) = Amat(14,14);

        
        H1 = zeros(5,1);
        H1(4,1) = Amat(4,8);

        H2 = zeros(5,3);
        H2(2,1)= Amat(8,4);
        H2(2,2)= Amat(8,7);
        H2(2,3)= Amat(8,14);

        H3 = zeros(4,1);
        H3(1,1) = Amat(7,8);
        H3(4,1) = Amat(14,8);
        
        
        B1 = handles.B.B(1:5,1:5);

        B2 = zeros(5,5);
        B2(1,1) = handles.B.B(6,6);
        B2(2,2) = handles.B.B(8,8);
        B2(3,3) = handles.B.B(9,9);
        B2(4,4) = handles.B.B(12,12);
        B2(5,5) = handles.B.B(13,13);

        B3 = zeros(4,4);
        B3(1,1) = handles.B.B(7,7);
        B3(2,2) = handles.B.B(10,10);
        B3(3,3) = handles.B.B(11,11);
        B3(4,4) = handles.B.B(14,14);
        
%         [ns nz] = size(handles.B.C);
%         clear C
%         C = handles.B.C;
        C=zeros(11,14);
        C(1,1)=1;
        C(2,2)=1;
        C(3,4)=1;
        C(4,6)=1;
        C(5,7)= 1;
        C(6,8)= 1;
        C(7,9)= 1;
        C(8,10)= 1;
        C(9,11)=1;
        C(10,12)=1;
        C(11,14)=1;
        [ns nz] = size(C);
        handles.B.C = C;
        
        C1 = [];
        C2 = [];
        C3 = [];
        count1 = 0;
        count2 = 0;
        count3 = 0;
        izn1 = [];
        izn2 = [];
        izn3 = [];
        
        for j=1:ns
            zn = find(C(j,:));
            switch zn
                case {1, 2, 3, 4, 5}
                    count1 = count1 + 1;
                    c1 = zeros(1,5);
                    c1(1,find([1, 2, 3, 4, 5]==zn)) = 1;
                    C1 = [C1; c1];
                    zn1(count1) = j;                    
                case {6, 8, 9, 12, 13}
                    count2 = count2 + 1;
                    c2 = zeros(1,5);
                    c2(1,find([6, 8, 9, 12, 13]==zn)) = 1;
                    C2 = [C2; c2];
                    zn2(count2) = j;                    
                case {7, 10, 11, 14}
                    count3 = count3 + 1;
                    c3 = zeros(1,4);
                    c3(1,find([7, 10, 11, 14]==zn)) = 1;
                    C3 = [C3; c3];
                    zn3(count3) = j;
                    
            end
            if any(8==zn)
                izn1 = [izn1, j];                       
            end
            
            if any([4, 7, 14]==zn)
                izn2 = [izn2, j];                       
            end
            
            if any(8==zn)
                izn3 = [izn3, j];                       
            end
            
        end
        
        
        
        % check if the system is observable
        Ob1 = obsv(A1,C1);
        if ((length(A1) - rank(Ob1)) ~= 0)
            msgbox('The Subsystem 1 is not Observable', 'Error', 'error')
            oldmsgs = cellstr(get(handles.edit14,'String'));
            set(handles.edit14,'String',[oldmsgs;{'>> The Subsystem 1 is not Observable'}])
            return
        end
        
        % check if the system is observable
        Ob2 = obsv(A2,C2);
        if ((length(A2) - rank(Ob2)) ~= 0) 
            msgbox('The Subsystem 2 is not Observable', 'Error', 'error')
            oldmsgs = cellstr(get(handles.edit14,'String'));
            set(handles.edit14,'String',[oldmsgs;{'>> The Subsystem 2 is not Observable'}])
            return
        end
        
        % check if the system is observable
        Ob3 = obsv(A3,C3);
        if ((length(A3) - rank(Ob3)) ~= 0) 
            msgbox('The Subsystem 3 is not Observable', 'Error', 'error')
            oldmsgs = cellstr(get(handles.edit14,'String'));
            set(handles.edit14,'String',[oldmsgs;{'>> The Subsystem 3 is not Observable'}])
            return
        end

%% Define parameters         
        DA1 = 0.1854;
%         DA2 = 0.2298;
        DA2 = 0.18; 
        DA3 = 0.0745;

        DH1 = 0.0564;
        DH2 = 0.1620;
        DH3 = 0;
                
        pol1 = eig(A1) - handles.F.UncertaintiesBound*3;
        pol2 = eig(A2) - DA2;%[DA2*10; DA2*2; DA2*5; DA2*4; DA2];
        pol3 = eig(A3) - handles.F.UncertaintiesBound*3;
        
        L1 = place(A1',C1',pol1)';
        L2 = place(A2',C2',pol2)';
        L3 = place(A3',C3',pol3)';
        
        A01 = A1 - L1*C1;
        A02 = A2 - L2*C2;
        A03 = A3 - L3*C3;
        
        
        
        parfor j=1:length(handles.t)    
            p1(j)=norm(expm(A01*handles.t(j)));
            p2(j)=norm(expm(A02*handles.t(j)));
            p3(j)=norm(expm(A03*handles.t(j)));

            pd1(j)=norm(expm(A01*handles.t(j))*L1);
            pd2(j)=norm(expm(A02*handles.t(j))*L2);
            pd3(j)=norm(expm(A03*handles.t(j))*L3);

            pz1(j)=norm(expm(A01*handles.t(j))*H1);
            pz2(j)=norm(expm(A02*handles.t(j))*H2);
            pz3(j)=norm(expm(A03*handles.t(j))*H3);
        end
        
        data = fit(handles.t', p1', 'exp1');
        coefval = coeffvalues(data);       
        rho1 = coefval(1); 
        ksi1 = -coefval(2);

        data = fit(handles.t', p2', 'exp1');
        coefval = coeffvalues(data);        
        rho2 = coefval(1); 
        ksi2 = -coefval(2);

        data = fit(handles.t', p3', 'exp1');
        coefval = coeffvalues(data);        
        rho3 = coefval(1); 
        ksi3 = -coefval(2);

        data = fit(handles.t', pd1', 'exp1');
        coefval = coeffvalues(data);
        rho_d1 =  coefval(1);
        ksi_d1 = -coefval(2);

        data = fit(handles.t', pd2', 'exp1');
        coefval = coeffvalues(data);
        rho_d2 =  coefval(1);
        ksi_d2 = -coefval(2);

        data = fit(handles.t', pd3', 'exp1');
        coefval = coeffvalues(data);
        rho_d3 =  coefval(1);
        ksi_d3 = -coefval(2);


        data = fit(handles.t', pz1', 'exp1');
        coefval = coeffvalues(data);
        rho_z1 =  coefval(1);
        ksi_z1 = -coefval(2);

        data = fit(handles.t', pz2', 'exp1');
        coefval = coeffvalues(data);
        rho_z2 =  coefval(1);
        ksi_z2 = -coefval(2);

        data = fit(handles.t', pz3', 'exp1');
        coefval = coeffvalues(data);
        rho_z3 =  coefval(1);
        ksi_z3 = -coefval(2);
        
        for j = 1:count1
                clear data data2 coefval coefval2
                parfor k=1:length(handles.t)
                   az1(k,j)=norm(C1(j,:)*expm(A01*handles.t(k)));
                   az_d1(k,j)=norm(C1(j,:)*expm(A01*handles.t(k))*L1);
                   az_z1(k,j)=norm(C1(j,:)*expm(A01*handles.t(k))*H1);
                end
                data = fit(handles.t', az1(:,j), 'exp1');
                coefval = coeffvalues(data);
                alpha1(j) = coefval(1);
                zita1(j) = -coefval(2);

                data2 = fit(handles.t', az_d1(:,j), 'exp1');
                coefval2 = coeffvalues(data2);
                alpha_d1(j) = coefval2(1);
                zita_d1(j) = -coefval2(2);

                data3 = fit(handles.t', az_z1(:,j), 'exp1');
                coefval2 = coeffvalues(data3);
                alpha_z1(j) = coefval2(1);
                zita_z1(j) = -coefval2(2);

        end

        for j = 1:count2
                clear data data2 coefval coefval2
                parfor k=1:length(handles.t)
                   az2(k,j)=norm(C2(j,:)*expm(A02*handles.t(k)));
                   az_d2(k,j)=norm(C2(j,:)*expm(A02*handles.t(k))*L2);
                   az_z2(k,j)=norm(C2(j,:)*expm(A02*handles.t(k))*H2);
                end
                data = fit(handles.t', az2(:,j), 'exp1');
                coefval = coeffvalues(data);
                alpha2(j) = coefval(1);
                zita2(j) = -coefval(2);

                data2 = fit(handles.t', az_d2(:,j), 'exp1');
                coefval2 = coeffvalues(data2);
                alpha_d2(j) = coefval2(1);
                zita_d2(j) = -coefval2(2);

                data3 = fit(handles.t', az_z2(:,j), 'exp1');
                coefval2 = coeffvalues(data3);
                alpha_z2(j) = coefval2(1);
                zita_z2(j) = -coefval2(2);        
        end

        for j = 1:count3
                clear data data2 coefval coefval2
                parfor k=1:length(handles.t)
                   az3(k,j)=norm(C3(j,:)*expm(A03*handles.t(k)));
                   az_d3(k,j)=norm(C3(j,:)*expm(A03*handles.t(k))*L3);
                   az_z3(k,j)=norm(C3(j,:)*expm(A03*handles.t(k))*H3);
                end
                data = fit(handles.t', az3(:,j), 'exp1');
                coefval = coeffvalues(data);
                alpha3(j) = coefval(1);
                zita3(j) = -coefval(2);

                data2 = fit(handles.t', az_d3(:,j), 'exp1');
                coefval2 = coeffvalues(data2);
                alpha_d3(j) = coefval2(1);
                zita_d3(j) = -coefval2(2);

                data3 = fit(handles.t', az_z3(:,j), 'exp1');
                coefval2 = coeffvalues(data3);
                alpha_z3(j) = coefval2(1);
                zita_z3(j) = -coefval2(2);        
        end
               
        x0 = zeros(handles.B.nZones,1);
        he0 = zeros(handles.B.nZones,1);
        
        Initial(1).E1_DA0 = zeros(handles.B.nZones,1);
        Initial(1).E1_d0 = 0;
        Initial(1).E2_t0 = zeros(handles.B.nZones,1);
        Initial(1).E1zd0 = 0;
        Initial(1).E1z0 = 0;
        Initial(1).Ey1DA0 = zeros(handles.B.nZones,1);
        Initial(1).Ey2DA0 = zeros(handles.B.nZones,1);
        Initial(1).Ey1d0 = zeros(handles.B.nZones,1);
        Initial(1).Ey2d0 = zeros(handles.B.nZones,1);
        Initial(1).Ey1DH0 = zeros(handles.B.nZones,1);
        
        Initial(2).E1_DA0 = zeros(handles.B.nZones,1);
        Initial(2).E1_d0 = 0;
        Initial(2).E2_t0 = zeros(handles.B.nZones,1);
        Initial(2).E1zd0 = 0;
        Initial(2).E1z0 = 0;
        Initial(2).Ey1DA0 = zeros(handles.B.nZones,1);
        Initial(2).Ey2DA0 = zeros(handles.B.nZones,1);
        Initial(2).Ey1d0 = zeros(handles.B.nZones,1);
        Initial(2).Ey2d0 = zeros(handles.B.nZones,1);
        Initial(2).Ey1DH0 = zeros(handles.B.nZones,1);
        
        Initial(3).E1_DA0 = zeros(handles.B.nZones,1);
        Initial(3).E1_d0 = 0;
        Initial(3).E2_t0 = zeros(handles.B.nZones,1);
        Initial(3).E1zd0 = 0;
        Initial(3).E1z0 = 0;
        Initial(3).Ey1DA0 = zeros(handles.B.nZones,1);
        Initial(3).Ey2DA0 = zeros(handles.B.nZones,1);
        Initial(3).Ey1d0 = zeros(handles.B.nZones,1);
        Initial(3).Ey2d0 = zeros(handles.B.nZones,1);
        Initial(3).Ey1DH0 = zeros(handles.B.nZones,1);
        
        InitEstDet = zeros(handles.B.nZones,1);
        InitEstDet2 = zeros(handles.B.nZones,1);

        
        parfor isolator=1:5
            initial1(isolator).init =   zeros((2*5+1),1);
            initial1(isolator).init(2*5+1) = 0.05;
        end
       
        parfor isolator=1:5
            initial2(isolator).init =   zeros((2*5+1),1);
            initial2(isolator).init(2*5+1) = 0.05;
        end
        
        parfor isolator=1:4
            initial3(isolator).init =   zeros((2*4+1),1);
            initial3(isolator).init(2*4+1) = 0.05;
        end
        
        parfor isolator1=1:5        
            InitIso1(isolator1).Ezj20 = zeros(nz,1);
            InitIso1(isolator1).Ezj30 = 0;
            InitIso1(isolator1).E1zd0 = 0;
            InitIso1(isolator1).E1z0 = 0;
            InitIso1(isolator1).Ejda0 = zeros(nz,1);
            InitIso1(isolator1).Eyj20 = zeros(nz,1);
            InitIso1(isolator1).Eyj30 = zeros(nz,1);
            InitIso1(isolator1).Eyj40 = zeros(nz,1);
            InitIso1(isolator1).Eyj50 = zeros(nz,1);
            InitIso1(isolator1).Eyj60 = zeros(nz,1);
        end

        
        parfor isolator1=1:5        
            InitIso2(isolator1).Ezj20 = zeros(nz,1);
            InitIso2(isolator1).Ezj30 = 0;
            InitIso2(isolator1).E1zd0 = 0;
            InitIso2(isolator1).E1z0 = 0;
            InitIso2(isolator1).Ejda0 = zeros(nz,1);
            InitIso2(isolator1).Eyj20 = zeros(nz,1);
            InitIso2(isolator1).Eyj30 = zeros(nz,1);
            InitIso2(isolator1).Eyj40 = zeros(nz,1);
            InitIso2(isolator1).Eyj50 = zeros(nz,1);
            InitIso2(isolator1).Eyj60 = zeros(nz,1);
        end
        
        parfor isolator1=1:4        
            InitIso3(isolator1).Ezj20 = zeros(nz,1);
            InitIso3(isolator1).Ezj30 = 0;
            InitIso3(isolator1).E1zd0 = 0;
            InitIso3(isolator1).E1z0 = 0;
            InitIso3(isolator1).Ejda0 = zeros(nz,1);
            InitIso3(isolator1).Eyj20 = zeros(nz,1);
            InitIso3(isolator1).Eyj30 = zeros(nz,1);
            InitIso3(isolator1).Eyj40 = zeros(nz,1);
            InitIso3(isolator1).Eyj50 = zeros(nz,1);
            InitIso3(isolator1).Eyj60 = zeros(nz,1);
        end
        
        i=1;
        iso1 = 0;
        iso2 = 0;
        iso3 = 0;
        rst1 = 0;
        rst2 = 0;
        rst3 = 0;
        isorst1 = 0;
        isorst2 = 0;
        isorst3 = 0;
        isodecision3 =  0;
%         Logical = zeros(handles.B.nZones,1);


        uint = zeros(handles.B.nZones,2);
        HeInp = zeros(handles.B.nZones,2);

        x = zeros(round((hours+TimeStep)/TimeStep),handles.B.nZones);
        x_He = zeros(round((hours+TimeStep)/TimeStep),handles.B.nZones);        
%         ey1 = zeros(round((hours+TimeStep)/TimeStep),3);
%         ey2 = zeros(round((hours+TimeStep)/TimeStep),4);
%         ey3 = zeros(round((hours+TimeStep)/TimeStep),4);
        x_hat1 = zeros(round((hours+TimeStep)/TimeStep),5);
        x_hat2 = zeros(round((hours+TimeStep)/TimeStep),5);
        x_hat3 = zeros(round((hours+TimeStep)/TimeStep),4);
        x_Hat1 = zeros(round((hours+TimeStep)/TimeStep),5);
        x_Hat2 = zeros(round((hours+TimeStep)/TimeStep),5);
        x_Hat3 = zeros(round((hours+TimeStep)/TimeStep),4);
        Ey1 = zeros(3,round((hours+TimeStep)/TimeStep));
        Ey2 = zeros(4,round((hours+TimeStep)/TimeStep));
        Ey3 = zeros(4,round((hours+TimeStep)/TimeStep));
%% Contaminant Concentration figure        
%         P.pos = [-0.0264382 0.8989 16 round(ns/4)*15];
        fig = figure('position', get(0, 'screensize'), 'visible', 'off');
        set(fig,'Units','centimeters');
        pos = get(fig,'position');
        clear fig
        P.pos = [-0.0264382 0.8989 40*pos(1,3)/100 3.5*handles.B.nZones];
        
        if get(handles.Concentrations,'Value')
            fig = auto_scroll_GUI_template(P);
            set(fig,'Name','Contaminant Concentration','Units','centimeters','Position',[57.5*pos(1,3)/100 53.5*pos(1,4)/100 42*pos(1,3)/100 41*pos(1,4)/100],'NumberTitle', 'off','Visible','on')
            hf = get(fig, 'Children');
        else
            fig = auto_scroll_GUI_template(P);
            set(fig,'Name','Contaminant Concentration','Units','centimeters','Position',[57.5*pos(1,3)/100 53.5*pos(1,4)/100 42*pos(1,3)/100 41*pos(1,4)/100],'NumberTitle', 'off','Visible','off')
            hf = get(fig, 'Children');
        end

        clrs = lines(ns);
        for j=1:ns
            sb(j) = subplot(ns,1,j, 'Parent', hf(1),'Units','normalized','Position',[0.145 1-j*(0.025+(1/handles.B.nZones-0.035)) 0.8 (1/handles.B.nZones-0.035)]);
            h(j) = plot(0,0,'Color',clrs(j,:),'Parent',sb(j));
            %             xlabel('Time (hr)','Parent',sb(j));
            ylabel('g/m^3','Parent',sb(j));
            set(sb(j),'YTick',linspace(0,max(x0(j))+0.1,4), 'XLim', [0 hours], 'YLim', [-0.04 max(x0(j))+0.1])
            title(['Zone ', num2str(find(C(j,:)))],'Parent',sb(j));
        end
           
%% CDEs figures
        pause(0.1)
        ns1 = 3;
        zones1 = [1, 2, 3];  
%         P.pos = [-0.0264382 0.8989 16 round(ns1/4)*15];
        P.pos = [-0.0264382 0.8989 40*pos(1,3)/100 3.5*ns1];
        if get(handles.CDE,'Value')
            fig2 = auto_scroll_GUI_template4(P);
            set(fig2,'Name','Contaminant Detection Estimator 1','Units','centimeters','Position',[57.5*pos(1,3)/100 69*pos(1,4)/100 42*pos(1,3)/100 26*pos(1,4)/100],'NumberTitle', 'off','Visible','on')
            hf2 = get(fig2, 'Children');
        else
            fig2 = auto_scroll_GUI_template4(P);
            set(fig2,'Name','Contaminant Detection Estimator 1','Units','centimeters','Position',[57.5*pos(1,3)/100 69*pos(1,4)/100 42*pos(1,3)/100 26*pos(1,4)/100],'NumberTitle', 'off','Visible','off')
            hf2 = get(fig2, 'Children');
        end
        
        sb2(1)=subplot(ns1,1,1,'Parent', hf2(1),'Units','centimeters','Position',[2.4 3.5*ns1-(0.09+3.3) 33*pos(1,3)/100 2.2]);
        D1a(1) = plot(0,x0(1),'Parent', sb2(1));
        hold on
        D2a(1) = plot(0,x0(1),'--r', 'Parent', sb2(1));
        ylabel(['Zone ', num2str(zones1(1))],'Parent', sb2(1));
        set(sb2(1),'YTick',linspace(0,max(x0(1))+0.1,4),'XLim',[0 hours], 'YLim',[-0.04 max(x0(1))+0.1])
        lg = legend('$\varepsilon_{y}$ Residual', '$\overline{\varepsilon}_{y}$ Threshold', 'Location', 'Best');
        set(lg,'interpreter','latex','FontName','Helvetica','FontSize',12);
        
        for j=2:ns1
            sb2(j)=subplot(ns1,1,j,'Parent', hf2(1),'Units','centimeters','Position',[2.4 3.5*ns1-(0.09+j*3.3) 33*pos(1,3)/100 2.2]);
            D1a(j) = plot(0,x0(j),'Parent', sb2(j));
            hold on
            D2a(j) = plot(0,x0(j),'--r','Parent', sb2(j));
            ylabel(['Zone ', num2str(zones1(j))],'Parent', sb2(j))
            set(sb2(j),'YTick',linspace(0,max(x0(j))+0.1,4),'XLim',[0 hours], 'YLim',[-0.04 max(x0(j))+0.1])
        end  
        
        pause(0.1)
        ns2 = 4;
        zones2 = [6, 8, 9, 12];
%         P.pos = [-0.0264382 0.8989 16 round(ns2/4)*15];
        P.pos = [-0.0264382 0.8989 40*pos(1,3)/100 3.5*ns2];
        if get(handles.CDE,'Value')
            fig3 = auto_scroll_GUI_template5(P);
            set(fig3,'Name','Contaminant Detection Estimator 2','Units','centimeters','Position',[57.5*pos(1,3)/100 34.5*pos(1,4)/100 42*pos(1,3)/100 26*pos(1,4)/100],'NumberTitle', 'off','Visible','on')
            hf3 = get(fig3, 'Children');
        else
            fig3 = auto_scroll_GUI_template5(P);
            set(fig3,'Name','Contaminant Detection Estimator 2','Units','centimeters','Position',[57.5*pos(1,3)/100 34.5*pos(1,4)/100 42*pos(1,3)/100 26*pos(1,4)/100],'NumberTitle', 'off','Visible','off')
            hf3 = get(fig3, 'Children');
        end
        
        sb3(1)=subplot(ns2,1,1,'Parent', hf3(1),'Units','centimeters','Position',[2.4 3.5*ns2-(0.09+3.3) 33*pos(1,3)/100 2.2]);
        D1b(1) = plot(0,x0(1),'Parent', sb3(1));
        hold on
        D2b(1) = plot(0,x0(1),'--r', 'Parent', sb3(1));
        ylabel(['Zone ', num2str(zones2(1))],'Parent', sb3(1));
        set(sb3(1),'YTick',linspace(0,max(x0(1))+0.1,4),'XLim',[0 hours], 'YLim',[-0.04 max(x0(1))+0.1])
        lg = legend('$\varepsilon_{y}$ Residual', '$\overline{\varepsilon}_{y}$ Threshold', 'Location', 'Best');
        set(lg,'interpreter','latex','FontName','Helvetica','FontSize',12);
        
        for j=2:ns2
            sb3(j)=subplot(ns2,1,j,'Parent', hf3(1),'Units','centimeters','Position',[2.4 3.5*ns2-j*(0.09+3.3) 33*pos(1,3)/100 2.2]);
            D1b(j) = plot(0,x0(j),'Parent', sb3(j));
            hold on
            D2b(j) = plot(0,x0(j),'--r','Parent', sb3(j));
            ylabel(['Zone ', num2str(zones2(j))],'Parent', sb3(j))
            set(sb3(j),'YTick',linspace(0,max(x0(j))+0.1,4),'XLim',[0 hours], 'YLim',[-0.04 max(x0(j))+0.1])
        end
        
        pause(0.1) 
        ns3 = 4;
        zones3 = [7, 10, 11, 14];
%         P.pos = [-0.0264382 0.8989 16 round(ns3/4)*15];
        P.pos = [-0.0264382 0.8989 40*pos(1,3)/100 3.5*ns3];
        if get(handles.CDE,'Value')
            fig4 = auto_scroll_GUI_template6(P);
            set(fig4,'Name','Contaminant Detection Estimator 3','Units','centimeters','Position',[57.5*pos(1,3)/100 0.9 42*pos(1,3)/100 26*pos(1,4)/100],'NumberTitle', 'off','Visible','on')
            hf4 = get(fig4, 'Children');
        else
            fig4 = auto_scroll_GUI_template6(P);
            set(fig4,'Name','Contaminant Detection Estimator 3','Units','centimeters','Position',[57.5*pos(1,3)/100 0.9 42*pos(1,3)/100 26*pos(1,4)/100],'NumberTitle', 'off','Visible','off')
            hf4 = get(fig4, 'Children');
        end
        
        sb4(1)=subplot(ns3,1,1,'Parent', hf4(1),'Units','centimeters','Position',[2.4 3.5*ns3-(0.09+3.3) 33*pos(1,3)/100 2.2]);
        D1c(1) = plot(0,x0(1),'Parent', sb4(1));
        hold on
        D2c(1) = plot(0,x0(1),'--r', 'Parent', sb4(1));
        ylabel(['Zone ', num2str(zones3(1))],'Parent', sb4(1));
        set(sb4(1),'YTick',linspace(0,max(x0(1))+0.1,4),'XLim',[0 hours], 'YLim',[-0.04 max(x0(1))+0.1])
        lg = legend('$\varepsilon_{y}$ Residual', '$\overline{\varepsilon}_{y}$ Threshold', 'Location', 'Best');
        set(lg,'interpreter','latex','FontName','Helvetica','FontSize',12);
        
        for j=2:ns3
            sb4(j)=subplot(ns3,1,j,'Parent', hf4(1),'Units','centimeters','Position',[2.4 3.5*ns3-j*(0.09+3.3) 33*pos(1,3)/100 2.2]);
            D1c(j) = plot(0,x0(j),'Parent', sb4(j));
            hold on
            D2c(j) = plot(0,x0(j),'--r','Parent', sb4(j));
            ylabel(['Zone ', num2str(zones3(j))],'Parent', sb4(j))
            set(sb4(j),'YTick',linspace(0,max(x0(j))+0.1,4),'XLim',[0 hours], 'YLim',[-0.04 max(x0(j))+0.1])
        end
        
        pause(0.01)  
%% Simulation

        while i<round((hours+TimeStep)/TimeStep)
            handles.time = handles.t(i);     

            axesHandle  = get(hObject,'Parent');
%             H = get(axesHandle, 'UserData');
%             handles.u = H.u;
%             handles.Sources = H.Sources;
            pause(0.05)
            UserData = get(axesHandle, 'UserData'); 
            handles.u = UserData.u;
            handles.B = UserData.B;
            handles.B.C = C;
            parfor k=1:2
                uint(:,k) = handles.u;
            end

            HeInp(:,1) = he(:,i);
            HeInp(:,2) = he(:,i+1);
            
            % Actual concentrations
            x(i:i+1,:) = lsim(sys, uint, Dt, x0);
            x0 = x(i+1,:)';
            y = C*x';

            t = 0:TimeStep:TimeStep*i;
            for j=1:ns                       
                set(h(j),'YData',y(j,1:i+1) ,'XData',t)            
                set(sb(j), 'YLim',[-0.04, max(y(j,:))+0.1],'YTick',linspace(0,max(y(j,:))+0.1,4))
            end  

            
            % Under healthy conditions concentrations
            x_He(i:i+1,:) = lsim(sys,HeInp,Dt,he0);
            he0 = x_He(i+1,:)';
            y_He = C*x_He';
            
            clear X X2
            [T X] = ode15s(@(tm,y2) myode23(tm, y2, A01, L1, H1, A02, L2, H2, A03, L3, H3, zn1, izn1, zn2, izn2, zn3, izn3, y_He(:,i:i+1), Dt), Dt, InitEstDet);
            InitEstDet = X(end,:)';            
            
            x_hat1(i:i+1,:) = [X(1,1:5); X(end,1:5)];
            
            x_hat2(i:i+1,:) = [X(1,6:10); X(end,6:10)];
            
            x_hat3(i:i+1,:) = [X(1,11:14); X(end,11:14)];
            
%             ez1 = x_He(:,8) - x_hat1(:,2);
%             ez2 = [x_He(:,4) - x_hat1(:,4), x_He(:,7) - x_hat3(:,1), x_He(:,14) - x_hat3(:,4)];
%             ez3 = x_He(:,8) - x_hat1(:,2);
            
            ez1(i:i+1) =  handles.F.NoiseBound;
%             ez2 = [x_He(:,4) - x_hat1(:,4), x_He(:,7) - x_hat3(:,1), x_He(:,14) - x_hat3(:,4)];
            ez3(i:i+1) = handles.F.NoiseBound;
            
            for k = i:i+1
%                 ez2norm(k) = norm(ez2(k,:));
                ez2norm(k) = handles.F.NoiseBound;
                znorm(k) = norm([x_He(k,4), x_He(k,7), x_He(k,14)]);
            end
                       
            [T X2] = ode15s(@(tm,y2) myode23(tm, y2, A01, L1, H1, A02, L2, H2, A03, L3, H3, zn1, izn1, zn2, izn2, zn3, izn3, y(:,i:i+1), Dt), Dt, InitEstDet2);
            InitEstDet2 = X2(end,:)'; 
            
            x_Hat1(i:i+1,:) = [X2(1,1:5); X2(end,1:5)];
            
            x_Hat2(i:i+1,:) = [X2(1,6:10); X2(end,6:10)];
            
            x_Hat3(i:i+1,:) = [X2(1,11:14); X2(end,11:14)];
                      
            if isorst1 == 0
                               
                % estimation error
                ey1 = abs(y(zn1,:) - C1*x_Hat1');

                [Ey1(:,i:i+1) Initial(1)] = DetectionThresholdCDI(DA1, DH1, handles.F.NoiseBound, ksi1, rho1, ksi_d1, rho_d1, ksi_z1, rho_z1, alpha1, zita1, alpha_d1, zita_d1, alpha_z1, zita_z1, x_hat1(i:i+1,:), [i i+1]*TimeStep, Dt, 3, handles.F.Ex0, ez1(i:i+1), abs(x_He(i:i+1,8)), Initial(1));
                for j=1:ns1                  
                    t = 0:TimeStep:TimeStep*i;
                    set(D2a(j),'YData',Ey1(j,1:i+1))
                    set(D2a(j),'XData',t)
                    set(D1a(j),'YData',ey1(j,1:i+1))
                    set(D1a(j),'XData',t)
                    set(sb2(j), 'YLim',[-0.04, max([ey1(j,:), Ey1(j,:)])+0.1],'YTick',linspace(0,max([ey1(j,:), Ey1(j,:)])+0.1,4))
                end
                
                if max(Ey1(:,i) < ey1(:,i))
                   isorst1 = 1;
                else
                   isorst1 = 0;
                end
            end
            
            if isorst2 == 0
                               
                % estimation error
                ey2 = abs(y(zn2,:) - C2*x_Hat2');
                
                [Ey2(:,i:i+1) Initial(2)] = DetectionThresholdCDI(DA2, DH2, handles.F.NoiseBound, ksi2, rho2, ksi_d2, rho_d2, ksi_z2, rho_z2, alpha2, zita2, alpha_d2, zita_d2, alpha_z2, zita_z2, x_hat2(i:i+1,:), [i i+1]*TimeStep, Dt, 4, handles.F.Ex0, ez2norm(i:i+1), znorm(i:i+1), Initial(2));
                
                for j=1:ns2                  
                    t = 0:TimeStep:TimeStep*i;
                    set(D2b(j),'YData',Ey2(j,1:i+1))
                    set(D2b(j),'XData',t)
                    set(D1b(j),'YData',ey2(j,1:i+1))
                    set(D1b(j),'XData',t)
                    set(sb3(j), 'YLim',[-0.04, max([ey2(j,:), Ey2(j,:)])+0.1],'YTick',linspace(0,max([ey2(j,:), Ey2(j,:)])+0.1,4))
                end
                
                if max(Ey2(:,i) < ey2(:,i))
                   isorst2 = 1;
                else
                   isorst2 = 0;
                end
            end
            
            if isorst3 == 0
                               
                % estimation error
                ey3 = abs(y(zn3,:) - C3*x_Hat3');
 
                [Ey3(:,i:i+1) Initial(3)] = DetectionThresholdCDI(DA3, DH3, handles.F.NoiseBound, ksi3, rho3, ksi_d3, rho_d3, ksi_z3, rho_z3, alpha3, zita3, alpha_d3, zita_d3, alpha_z3, zita_z3, x_hat3(i:i+1,:), [i i+1]*TimeStep, Dt, 4, handles.F.Ex0, ez3(i:i+1), abs(x_He(i:i+1,8)), Initial(3));

                for j=1:ns3                  
                    t = 0:TimeStep:TimeStep*i;
                    set(D2c(j),'YData',Ey3(j,1:i+1))
                    set(D2c(j),'XData',t)
                    set(D1c(j),'YData',ey3(j,1:i+1))
                    set(D1c(j),'XData',t)
                    set(sb4(j), 'YLim',[-0.04, max([ey3(j,:), Ey3(j,:)])+0.1],'YTick',linspace(0,max([ey3(j,:), Ey3(j,:)])+0.1,4))
                end
                
                if max(Ey3(:,i) < ey3(:,i))
                   isorst3 = 1;
                else
                   isorst3 = 0;
                end
            end
            
            if isorst1
                iso1 = iso1 + 1;
                Dtime1(iso1) = i*TimeStep;
                
                if rst1 == 0
%                     parfor j=1:handles.B.nZones 
%                         clr{j} = 'w';
%                     end
                    
                    zns1 = [1 2 3 4 5]; 
                    for j = zns1
                        handles.B.clr{j} = [255/255 153/255 153/255];
                    end
                    UserData.B = handles.B;
                    set(axesHandle,'UserData', UserData)
                    
                    clear lH
                    lH = findobj(handles.axes1,'Type','line','-and', 'MarkerEdgeColor','r');
                    if ~isempty(lH)
                        clear ii
                        
                        xp = []; 
                        yp = [];
                        for ii = lH'
                            xp=[xp, get(ii,'Xdata')]; %Getting coordinates of line object
                            yp=[yp, get(ii,'Ydata')];                                                     
                        end
                        for jj = 1:length(xp)
                            TH = findobj(handles.axes1,'Type','text', '-and', 'Position', [xp(jj), yp(jj), []]);               
                            str{jj} = get(TH, 'String');
                        end
                    end
                    plotB(handles.B.X, handles.axes1, handles.B.LevelCounter, handles.F.IsolationDecision,handles.B.clr, handles.B.WindDirection, handles.B.C,get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));
                    if ~isempty(lH)
                       plot(xp, yp, 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
                        for jj = 1:length(xp)
                            str1{1} = str{jj}{1};
                            str1{2} = str{jj}{2};
                            text(xp(jj), yp(jj), str1)                         
                        end
                        clear xp yp str str1
                    end

                    mins = (Dtime1(1) - fix(Dtime1(1)))*60;
                    sec = (mins - fix(mins))*60;                
                    text(3, 2, ['Contaminant Detected in Subsystem 1 at ', sprintf('%02d:%02d:%02d !!!',fix(Dtime1(1)),fix(mins),fix(sec))], 'FontSize',12','FontWeight','bold')

                    oldmsgs = cellstr(get(handles.edit14,'String'));
                    set(handles.edit14,'String',[oldmsgs;{['>> Contaminant Detected in Subsystem 1 at ', sprintf('%02d:%02d:%02d !!!',fix(Dtime1(1)),fix(mins),fix(sec))]}] );
                    
                    P.pos = [-0.0264382 0.8989 40*pos(1,3)/100 3.5*length(zns1)];
                    if get(handles.CIE,'Value')
                        fig5 = auto_scroll_GUI_template7(P);
                        set(fig5,'Name','Contaminant Isolation Decision 1','Units','centimeters','Position',[57.5*pos(1,3)/100 69*pos(1,4)/100 42*pos(1,3)/100 26*pos(1,4)/100],'NumberTitle', 'off','Visible','on')
                        hf5 = get(fig5, 'Children');
                    else
                        fig5 = auto_scroll_GUI_template7(P);
                        set(fig5,'Name','Contaminant Isolation Decision 1','Units','centimeters','Position',[2.5 2.5 16 16],'NumberTitle', 'off','Visible','off')
                        hf5 = get(fig5, 'Children');
                    end                           
                    
                    for j=1:5
                        sb5(j) =  subplot(5,1,j,'Parent', hf5(1));
                        I1(j) = plot(0,0,'LineWidth',1.5,'Parent',sb5(j));
                        title(['Zone ', num2str(zns1(j))],'Parent',sb5(j))
                        set(sb5(j),'YTick',[0;1], 'XLim', [Dtime1(1) hours], 'YLim', [-0.2 1.2])
                    end
                    YY1 = zeros(round((hours+TimeStep)/TimeStep)-i+1,2*5+1,5); % need to change dimension for multiple source
                    Logical1 = zeros(5,round((hours+TimeStep)/TimeStep)-i+1);
                    IsolationResidual1(:).Eyi = zeros(ns1,round((hours+TimeStep)/TimeStep)-i+1);
                    IsolationThrhld1(:).Eyj = zeros(ns1,round((hours+TimeStep)/TimeStep)-i+1);
                    IsoChk1 = 1:5;
                end
                rst1 = 1;
                
                for isolator2 = IsoChk1
                    Fj = zeros(5,1);
                    Fj(isolator2)=1;
                    [T ISO1(isolator2).Y] = ode15s(@(tm,y2) myode5(tm, y2, A1, L1, C1, H1, y(zn1,i:i+1)', y(izn1,i:i+1)',Dt, handles.F.LearningRate, B1, Fj, 1), Dt, initial1(isolator2).init);

                end
                
                Y = struct2cell(ISO1);
                for isolator3 = IsoChk1
                    YY1(iso1:iso1+1,:,isolator3) = [Y{isolator3}(1,:); Y{isolator3}(end,:)];
                    initial1(isolator3).init = ISO1(isolator3).Y(end,:)';
                end
                ZITA = YY1(iso1:iso1+1,1:5,:); 
                OMEGA = YY1(iso1:iso1+1,(5+1):2*5,:);            
                inzone1 = 4;
                for isolator = IsoChk1
%                     if ~isorst2 
%                      Iez1(iso1:iso1+1) = abs(y(izn1,i:i+1) - x_Hat2(i:i+1,2)');
                     Iez1(iso1:iso1+1) = handles.F.NoiseBound;
%                     else
%                         Iez1(iso1:iso1+1) = abs(y(izn1,i:i+1) - ZITA2(:,2,isolator)');
%                     end
                    IsolationResidual1(isolator).Eyi(1:ns1,iso1:iso1+1) = abs(y(zn1,i:i+1) - C1*YY1(iso1:iso1+1,1:5,isolator)');
                    [IsolationThrhld1(isolator).Eyj(1:ns1,iso1:iso1+1) InitIso1(isolator)] = IsolationThresholdCDI(DA1, DH1, handles.F.NoiseBound, ksi1, rho1, ksi_d1, rho_d1, ksi_z1, rho_z1, alpha1, zita1, alpha_d1, zita_d1, alpha_z1, zita_z1, [i-1 i]*TimeStep, Dt, Dtime1(1)-TimeStep, ns1, C1, handles.F.Theta, handles.F.Ez0, ZITA(:,:,isolator)', OMEGA(:,:,isolator), Iez1(iso1:iso1+1), abs(y(izn1,i:i+1))', inzone1, InitIso1(isolator));
                end
                
                for isolator4 = IsoChk1
                    if IsolationResidual1(isolator4).Eyi(1:ns1,iso1+1)<IsolationThrhld1(isolator4).Eyj(1:ns1,iso1+1) & Logical1(isolator4,iso1)==0
                        Logical1(isolator4,iso1+1) = 0;                        
                    else
                        Logical1(isolator4,iso1+1:end) = 1;
                        IsoChk1(IsoChk1 == isolator4) = [];
                    end            
                end
                
                if max(Logical1(:,iso1)~=Logical1(:,iso1+1))
                    handles.IsoTime1 = handles.time;
                    if length(find(Logical1(:,iso1+1)==0)) == 1                         
                        for j=1:length(zns1)
                            if Logical1(j,iso1+1)
                                handles.B.clr{zns1(j)} = 'w';
                            else
                                handles.B.clr{zns1(j)} = [1 1 153/255];
                            end
                        end
                        UserData.B = handles.B;
                        set(axesHandle,'UserData', UserData)
                        
                        clear lH
                        lH = findobj(handles.axes1,'Type','line','-and', 'MarkerEdgeColor','r');
                        if ~isempty(lH)
                            clear ii
                            
                            xp = []; 
                            yp = [];
                            for ii = lH'
                                xp=[xp, get(ii,'Xdata')]; %Getting coordinates of line object
                                yp=[yp, get(ii,'Ydata')];                                                     
                            end
                            for jj = 1:length(xp)
                                TH = findobj(handles.axes1,'Type','text', '-and', 'Position', [xp(jj), yp(jj), []]);               
                                str{jj} = get(TH, 'String');
                            end
                        end
                        plotB(handles.B.X, handles.axes1, handles.B.LevelCounter, handles.F.IsolationDecision,handles.B.clr,handles.B.WindDirection,handles.B.C,get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));
                        mins = (handles.IsoTime1 - fix(handles.IsoTime1))*60;
                        sec = (mins - fix(mins))*60;                
                        text(3, 2, ['Contaminant Isolated in  Z', num2str(zns1(find(Logical1(:,iso1+1)==0))), sprintf(' at %02d:%02d:%02d !!!',fix(handles.IsoTime1),fix(mins),fix(sec))], 'FontSize',13','FontWeight','bold')
                        oldmsgs = cellstr(get(handles.edit14,'String'));
                        set(handles.edit14,'String',[oldmsgs;{['>> Contaminant Isolated in  Z', num2str(zns1(find(Logical1(:,iso1+1)==0))), sprintf(' at %02d:%02d:%02d !!!',fix(handles.IsoTime1),fix(mins),fix(sec))]}] );
                        if ~isempty(lH)
                           plot(xp, yp, 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
                            for jj = 1:length(xp)
                                str1{1} = str{jj}{1};
                                str1{2} = str{jj}{2};
                                text(xp(jj), yp(jj), str1)                         
                            end
                            clear xp yp str str1

                        end 
                        
                    else
                        for j=1:5
                            if Logical1(j,iso1+1)
                                handles.B.clr{zns1(j)} = 'w';
                            else
                                handles.B.clr{zns1(j)} = [255/255 153/255 153/255];
                            end
                        end
                        UserData.B = handles.B;
                        set(axesHandle,'UserData', UserData)
                        
                        clear lH
                        lH = findobj(handles.axes1,'Type','line','-and', 'MarkerEdgeColor','r');
                        if ~isempty(lH)
                            clear ii

                            xp = []; 
                            yp = [];
                            for ii = lH'
                                xp=[xp, get(ii,'Xdata')]; %Getting coordinates of line object
                                yp=[yp, get(ii,'Ydata')];                                                     
                            end
                            for jj = 1:length(xp)
                                TH = findobj(handles.axes1,'Type','text', '-and', 'Position', [xp(jj), yp(jj), []]);               
                                str{jj} = get(TH, 'String');
                            end
                        end
                        plotB(handles.B.X, handles.axes1, handles.B.LevelCounter, handles.F.IsolationDecision,handles.B.clr,handles.B.WindDirection,handles.B.C,get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));
%                         mins = (Dtime1(1) - fix(Dtime1(1)))*60;
%                         sec = (mins - fix(mins))*60;                
%                         text(3, 2, ['Contaminant Detected in Subsystem 1 at ', sprintf('%02d:%02d:%02d !!!',fix(Dtime1(1)),fix(mins),fix(sec))], 'FontSize',12','FontWeight','bold')
                        if ~isempty(lH)
                           plot(xp, yp, 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
                            for jj = 1:length(xp)
                                str1{1} = str{jj}{1};
                                str1{2} = str{jj}{2};
                                text(xp(jj), yp(jj), str1)                         
                            end
                            clear xp yp str str1

                        end
                    end
                end
                
                t2 = Dtime1(1):TimeStep:TimeStep*i;
                a = TimeStep/15;
                timeAxis=bsxfun(@plus,(0:a:0.0167-a)', t2); %subsampled time axis
                for j=1:length(zns1)          
                    plotdata=bsxfun(@times,ones(15,1),Logical1(j,1:iso1));                
                    set(I1(j),'YData',plotdata(:))
                    set(I1(j),'XData',timeAxis(:))
                end
                
            end
            
            if isorst2
                iso2 = iso2 + 1;
                Dtime2(iso2) = i*TimeStep;
                
                if rst2 == 0
%                     parfor j=1:handles.B.nZones 
%                         clr{j} = 'w';
%                     end
                    
                    zns2 = [6, 8, 9, 12, 13];
                    for j = zns2
                        handles.B.clr{j} = [255/255 153/255 153/255];
                    end
                    UserData.B = handles.B;
                    set(axesHandle,'UserData', UserData)
                    
                    clear lH
                    lH = findobj(handles.axes1,'Type','line','-and', 'MarkerEdgeColor','r');
                    if ~isempty(lH)
                        clear ii
                        
                        xp = []; 
                        yp = [];
                        for ii = lH'
                            xp=[xp, get(ii,'Xdata')]; %Getting coordinates of line object
                            yp=[yp, get(ii,'Ydata')];                                                     
                        end
                        
                        for jj = 1:length(xp)
                            TH = findobj(handles.axes1,'Type','text', '-and', 'Position', [xp(jj), yp(jj), []]);               
                            str{jj} = get(TH, 'String');
                        end
                    end
                    plotB(handles.B.X, handles.axes1, handles.B.LevelCounter, handles.F.IsolationDecision,handles.B.clr,handles.B.WindDirection,handles.B.C,get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));
                    if ~isempty(lH)
                       plot(xp, yp, 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
                        for jj = 1:length(xp)
                            str1{1} = str{jj}{1};
                            str1{2} = str{jj}{2};
                            text(xp(jj), yp(jj), str1)                         
                        end
                        clear xp yp str str1
                    end

                    mins = (Dtime2(1) - fix(Dtime2(1)))*60;
                    sec = (mins - fix(mins))*60;                
                    text(3, 2, ['Contaminant Detected in Subsystem 2 at ', sprintf('%02d:%02d:%02d !!!',fix(Dtime2(1)),fix(mins),fix(sec))], 'FontSize',12','FontWeight','bold')

                    oldmsgs = cellstr(get(handles.edit14,'String'));
                    set(handles.edit14,'String',[oldmsgs;{['>> Contaminant Detected in Subsystem 2 at ', sprintf('%02d:%02d:%02d !!!',fix(Dtime2(1)),fix(mins),fix(sec))]}] );
                    
                    P.pos = [-0.0264382 0.8989 40*pos(1,3)/100 3.5*length(zns2)];
                    if get(handles.CIE,'Value')
                        fig6 = auto_scroll_GUI_template8(P);
                        set(fig6,'Name','Contaminant Isolation Decision 2','Units','centimeters','Position',[57.5*pos(1,3)/100 34.5*pos(1,4)/100 42*pos(1,3)/100 26*pos(1,4)/100],'NumberTitle', 'off','Visible','on')
                        hf6 = get(fig6, 'Children');
                    else
                        fig6 = auto_scroll_GUI_template8(P);
                        set(fig6,'Name','Contaminant Isolation Decision 2','Units','centimeters','Position',[2.5 2.5 16 16],'NumberTitle', 'off','Visible','off')
                        hf6 = get(fig6, 'Children');
                    end                           
                    
                    for j=1:5
                        sb6(j) =  subplot(5,1,j,'Parent', hf6(1));
                        I2(j) = plot(0,0,'LineWidth',1.5,'Parent',sb6(j));
                        title(['Zone ', num2str(zns2(j))],'Parent',sb6(j))
                        set(sb6(j),'YTick',[0;1], 'XLim', [Dtime2(1) hours], 'YLim', [-0.2 1.2])
                    end
                    YY2 = zeros(round((hours+TimeStep)/TimeStep)-i+1,2*5+1,5); % need to change dimension for multiple source
                    Logical2 = zeros(5,round((hours+TimeStep)/TimeStep)-i+1);
                    IsolationResidual2(:).Eyi = zeros(ns2,round((hours+TimeStep)/TimeStep)-i+1);
                    IsolationThrhld2(:).Eyj = zeros(ns2,round((hours+TimeStep)/TimeStep)-i+1);
                    IsoChk2 = 1:5;
                    for isolator=1:5
                        initial2(isolator).init(1:4) =   y(zn2,i);                        
                    end
                end
                rst2 = 1;
                
                for isolator2 = 1:5
                    Fj = zeros(5,1);
                    Fj(isolator2)=1;
                    [T ISO2(isolator2).Y] = ode15s(@(tm,y2) myode5(tm, y2, A2, L2, C2, H2, y(zn2,i:i+1)', y(izn2,i:i+1)',Dt, handles.F.LearningRate, B2, Fj, 1), Dt, initial2(isolator2).init);

                end
                
                Y2 = struct2cell(ISO2);
                for isolator3 = 1:5
                    YY2(iso2:iso2+1,:,isolator3) = [Y2{isolator3}(1,:); Y2{isolator3}(end,:)];
                    initial2(isolator3).init = ISO2(isolator3).Y(end,:)';
                end
                ZITA2 = YY2(iso2:iso2+1,1:5,:); 
                OMEGA2 = YY2(iso2:iso2+1,(5+1):2*5,:);            
                
%                 if isodecision3
%                     Iez2(iso2) = norm(y(izn2,i)-[ZITA3(iso3-1,4,criso3); x_Hat3(i,1); x_Hat3(i,4)]);
%                     Iez2(iso2+1) = norm(y(izn2,i+1)-[x_Hat1(i+1,4); x_Hat3(i+1,1); x_Hat3(i+1,4)]);                
%                     znorm2(iso2:iso2+1) = [norm(y(izn2,i)), norm(y(izn2,i+1))];                    
%                 else
%                     Iez2(iso2) = norm(y(izn2,i)-[x_Hat1(i,4); x_Hat3(i,1); x_Hat3(i,4)]);
%                     Iez2(iso2+1) = norm(y(izn2,i+1)-[x_Hat1(i+1,4); x_Hat3(i+1,1); x_Hat3(i+1,4)]);                
%                     znorm2(iso2:iso2+1) = [norm(y(izn2,i)), norm(y(izn2,i+1))];
%                 end
                Iez2(iso2) = handles.F.NoiseBound;
                Iez2(iso2+1) = handles.F.NoiseBound;                
                znorm2(iso2:iso2+1) = [norm(y(izn2,i)), norm(y(izn2,i+1))];
                inzone2 = 2;
                for isolator = 1:5                    
                    IsolationResidual2(isolator).Eyi(1:ns2,iso2:iso2+1) = abs(y(zn2,i:i+1) - C2*YY2(iso2:iso2+1,1:5,isolator)');
                    [IsolationThrhld2(isolator).Eyj(1:ns2,iso2:iso2+1) InitIso2(isolator)] = IsolationThresholdCDI(DA2, DH2, handles.F.NoiseBound, ksi2, rho2, ksi_d2, rho_d2, ksi_z2, rho_z2, alpha2, zita2, alpha_d2, zita_d2, alpha_z2, zita_z2, [i-1 i]*TimeStep, Dt, Dtime2(1)-TimeStep, ns2, C2, handles.F.Theta, handles.F.Ez0, ZITA2(:,:,isolator)', OMEGA2(:,:,isolator), Iez2(iso2:iso2+1), znorm2(iso2:iso2+1), inzone2, InitIso2(isolator));
                end
                
                for isolator4 = IsoChk2
                    if IsolationResidual2(isolator4).Eyi(1:ns2,iso2+1)<IsolationThrhld2(isolator4).Eyj(1:ns2,iso2+1) & Logical2(isolator4,iso2)==0
                        Logical2(isolator4,iso2+1) = 0;                        
                    else
                        Logical2(isolator4,iso2+1:end) = 1;
                        IsoChk2(IsoChk2 == isolator4) = [];
                    end            
                end
                
                if max(Logical2(:,iso2)~=Logical2(:,iso2+1))
                    handles.IsoTime2 = handles.time;
                    if length(find(Logical2(:,iso2+1)==0)) == 1                         
                        for j=1:length(zns2)
                            if Logical2(j,iso2+1)
                                handles.B.clr{zns2(j)} = 'w';
                            else
                                handles.B.clr{zns2(j)} = [1 1 153/255];
                            end
                        end
                        UserData.B = handles.B;
                        set(axesHandle,'UserData', UserData)
                        
                        clear lH
                        lH = findobj(handles.axes1,'Type','line','-and', 'MarkerEdgeColor','r');
                        if ~isempty(lH)
                            clear ii
                            
                            xp = []; 
                            yp = [];
                            for ii = lH'
                                xp=[xp, get(ii,'Xdata')]; %Getting coordinates of line object
                                yp=[yp, get(ii,'Ydata')];                                                     
                            end
                            
                            for jj = 1:length(xp)
                                TH = findobj(handles.axes1,'Type','text', '-and', 'Position', [xp(jj), yp(jj), []]);               
                                str{jj} = get(TH, 'String');
                            end
                        end
                        plotB(handles.B.X, handles.axes1, handles.B.LevelCounter, handles.F.IsolationDecision,handles.B.clr,handles.B.WindDirection,handles.B.C,get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));
                        mins = (handles.IsoTime2 - fix(handles.IsoTime2))*60;
                        sec = (mins - fix(mins))*60;                
                        text(3, 2, ['Contaminant Isolated in  Z', num2str(zns2(find(Logical2(:,iso2+1)==0))), sprintf(' at %02d:%02d:%02d !!!',fix(handles.IsoTime2),fix(mins),fix(sec))], 'FontSize',13','FontWeight','bold')
                        oldmsgs = cellstr(get(handles.edit14,'String'));
                        set(handles.edit14,'String',[oldmsgs;{['>> Contaminant Isolated in  Z', num2str(zns2(find(Logical2(:,iso2+1)==0))), sprintf(' at %02d:%02d:%02d !!!',fix(handles.IsoTime2),fix(mins),fix(sec))]}] );
                        if ~isempty(lH)
                           plot(xp, yp, 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
                            for jj = 1:length(xp)
                                str1{1} = str{jj}{1};
                                str1{2} = str{jj}{2};
                                text(xp(jj), yp(jj), str1)                         
                            end
                            clear xp yp str str1

                        end 
                        
                    else
                        for j=1:length(zns2)
                            if Logical2(j,iso2+1)
                                handles.B.clr{zns2(j)} = 'w';
                            else
                                handles.B.clr{zns2(j)} = [255/255 153/255 153/255];
                            end
                        end
                        UserData.B = handles.B;
                        set(axesHandle,'UserData', UserData)
                        
                        clear lH
                        lH = findobj(handles.axes1,'Type','line','-and', 'MarkerEdgeColor','r');
                        if ~isempty(lH)
                            clear ii
                            
                            xp = []; 
                            yp = [];
                            for ii = lH'
                                xp=[xp, get(ii,'Xdata')]; %Getting coordinates of line object
                                yp=[yp, get(ii,'Ydata')];                                                     
                            end
                            for jj = 1:length(xp)
                                TH = findobj(handles.axes1,'Type','text', '-and', 'Position', [xp(jj), yp(jj), []]);               
                                str{jj} = get(TH, 'String');
                            end
                        end
                        plotB(handles.B.X, handles.axes1, handles.B.LevelCounter, handles.F.IsolationDecision,handles.B.clr,handles.B.WindDirection,handles.B.C,get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));
%                         mins = (Dtime1(1) - fix(Dtime1(1)))*60;
%                         sec = (mins - fix(mins))*60;                
%                         text(3, 2, ['Contaminant Detected in Subsystem 1 at ', sprintf('%02d:%02d:%02d !!!',fix(Dtime1(1)),fix(mins),fix(sec))], 'FontSize',12','FontWeight','bold')
                        if ~isempty(lH)
                           plot(xp, yp, 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
                            for jj = 1:length(xp)
                                str1{1} = str{jj}{1};
                                str1{2} = str{jj}{2};
                                text(xp(jj), yp(jj), str1)                         
                            end
                            clear xp yp str str1

                        end
                    end
                end
                
                t2 = Dtime2(1):TimeStep:TimeStep*i;
                a = TimeStep/15;
                timeAxis=bsxfun(@plus,(0:a:0.0167-a)', t2); %subsampled time axis
                for j=1:length(zns2)          
                    plotdata=bsxfun(@times,ones(15,1),Logical2(j,1:iso2));                
                    set(I2(j),'YData',plotdata(:))
                    set(I2(j),'XData',timeAxis(:))
                end
            end
            
            if isorst3
                iso3 = iso3 + 1;
                Dtime3(iso3) = i*TimeStep;
                
                if rst3 == 0
%                     parfor j=1:handles.B.nZones 
%                         clr{j} = 'w';
%                     end
                    
                    zns3 = [7, 10, 11, 14];
                    for j = zns3
                        handles.B.clr{j} = [255/255 153/255 153/255];
                    end
                    UserData.B = handles.B;
                    set(axesHandle,'UserData', UserData)
                    
                    clear lH
                    lH = findobj(handles.axes1,'Type','line','-and', 'MarkerEdgeColor','r');
                    if ~isempty(lH)
                        clear ii
                        
                        xp = []; 
                        yp = [];
                        for ii = lH'
                            xp=[xp, get(ii,'Xdata')]; %Getting coordinates of line object
                            yp=[yp, get(ii,'Ydata')];                                                     
                        end
                        for jj = 1:length(xp)
                            TH = findobj(handles.axes1,'Type','text', '-and', 'Position', [xp(jj), yp(jj), []]);               
                            str{jj} = get(TH, 'String');
                        end
                    end
                    plotB(handles.B.X, handles.axes1, handles.B.LevelCounter, handles.F.IsolationDecision,handles.B.clr,handles.B.WindDirection,handles.B.C,get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));
                    if ~isempty(lH)
                       plot(xp, yp, 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
                        for jj = 1:length(xp)
                            str1{1} = str{jj}{1};
                            str1{2} = str{jj}{2};
                            text(xp(jj), yp(jj), str1)                         
                        end
                        clear xp yp str str1
                    end

                    mins = (Dtime3(1) - fix(Dtime3(1)))*60;
                    sec = (mins - fix(mins))*60;                
                    text(3, 2, ['Contaminant Detected in Subsystem 3 at ', sprintf('%02d:%02d:%02d !!!',fix(Dtime3(1)),fix(mins),fix(sec))], 'FontSize',12','FontWeight','bold')

                    oldmsgs = cellstr(get(handles.edit14,'String'));
                    set(handles.edit14,'String',[oldmsgs;{['>> Contaminant Detected in Subsystem 3 at ', sprintf('%02d:%02d:%02d !!!',fix(Dtime3(1)),fix(mins),fix(sec))]}] );
                    
                    P.pos = [-0.0264382 0.8989 40*pos(1,3)/100 3.5*length(zns3)];
                    if get(handles.CIE,'Value')
                        fig7 = auto_scroll_GUI_template9(P);
                        set(fig7,'Name','Contaminant Isolation Decision 3','Units','centimeters','Position',[57.5*pos(1,3)/100 0.9 42*pos(1,3)/100 26*pos(1,4)/100],'NumberTitle', 'off','Visible','on')
                        hf7 = get(fig7, 'Children');
                    else
                        fig7 = auto_scroll_GUI_template9(P);
                        set(fig7,'Name','Contaminant Isolation Decision 3','Units','centimeters','Position',[2.5 2.5 16 16],'NumberTitle', 'off','Visible','off')
                        hf7 = get(fig7, 'Children');
                    end                           
                    
                    for j=1:4
                        sb7(j) =  subplot(4,1,j,'Parent', hf7(1));
                        I3(j) = plot(0,0,'LineWidth',1.5,'Parent',sb7(j));
                        title(['Zone ', num2str(zns3(j))],'Parent',sb7(j))
                        set(sb7(j),'YTick',[0;1], 'XLim', [Dtime3(1) hours], 'YLim', [-0.2 1.2])
                    end
                    YY3 = zeros(round((hours+TimeStep)/TimeStep)-i+1,2*4+1,4); % need to change dimension for multiple source
                    Logical3 = zeros(4,round((hours+TimeStep)/TimeStep)-i+1);
                    IsolationResidual3(:).Eyi = zeros(ns3,round((hours+TimeStep)/TimeStep)-i+1);
                    IsolationThrhld3(:).Eyj = zeros(ns3,round((hours+TimeStep)/TimeStep)-i+1);
                    IsoChk3 = 1:4;
                end
                rst3 = 1;
                
                for isolator2 = IsoChk3
                    Fj = zeros(4,1);
                    Fj(isolator2)=1;
                    [T ISO3(isolator2).Y] = ode15s(@(tm,y2) myode5(tm, y2, A3, L3, C3, H3, y(zn3,i:i+1)', y(izn3,i:i+1)',Dt, handles.F.LearningRate, B3, Fj, 1), Dt, initial3(isolator2).init);

                end
                
                Y3 = struct2cell(ISO3);
                for isolator3 = IsoChk3
                    YY3(iso3:iso3+1,:,isolator3) = [Y3{isolator3}(1,:); Y3{isolator3}(end,:)];
                    initial3(isolator3).init = ISO3(isolator3).Y(end,:)';
                end
                ZITA3 = YY3(iso3:iso3+1,1:4,:); 
                OMEGA3 = YY3(iso3:iso3+1,(4+1):2*4,:);            
                
                Iez3(iso3:iso3+1) = handles.F.NoiseBound;
                inzone3 = [1, 4];
                for isolator = IsoChk3
%                     Iez3(iso3:iso3+1) = abs(y(izn3,i:i+1) - x_Hat2(i:i+1,2)');
                    IsolationResidual3(isolator).Eyi(1:ns3,iso3:iso3+1) = abs(y(zn3,i:i+1) - C3*YY3(iso3:iso3+1,1:4,isolator)');
                    [IsolationThrhld3(isolator).Eyj(1:ns3,iso3:iso3+1) InitIso3(isolator)] = IsolationThresholdCDI(DA3, DH3, handles.F.NoiseBound, ksi3, rho3, ksi_d3, rho_d3, ksi_z3, rho_z3, alpha3, zita3, alpha_d3, zita_d3, alpha_z3, zita_z3, [i-1 i]*TimeStep, Dt, Dtime3(1)-TimeStep, ns3, C3, handles.F.Theta, handles.F.Ez0, ZITA3(:,:,isolator)', OMEGA3(:,:,isolator), Iez3(iso3:iso3+1), abs(y(izn3,i:i+1))', inzone3, InitIso3(isolator));
                end
                
                for isolator4 = IsoChk3
                    if IsolationResidual3(isolator4).Eyi(1:ns3,iso3+1)<IsolationThrhld3(isolator4).Eyj(1:ns3,iso3+1) & Logical3(isolator4,iso3)==0
                        Logical3(isolator4,iso3+1) = 0;                        
                    else
                        Logical3(isolator4,iso3+1:end) = 1;
                        IsoChk3(IsoChk3 == isolator4) = [];
                    end            
                end
                
                if max(Logical3(:,iso3)~=Logical3(:,iso3+1))
                    handles.IsoTime3 = handles.time;
                    if length(find(Logical3(:,iso3+1)==0)) == 1                        
                        for j=1:length(zns3)
                            if Logical3(j,iso3+1)
                                handles.B.clr{zns3(j)} = 'w';
                            else
                                handles.B.clr{zns3(j)} = [1 1 153/255];
                                isodecision3 =  1;
                                criso3 = j;
                            end
                        end
                        UserData.B = handles.B;
                        set(axesHandle,'UserData', UserData)
                        
                        clear lH
                        lH = findobj(handles.axes1,'Type','line','-and', 'MarkerEdgeColor','r');
                        if ~isempty(lH)
                            clear ii 
                            
                            xp = []; 
                            yp = [];
                            for ii = lH'
                                xp=[xp, get(ii,'Xdata')]; %Getting coordinates of line object
                                yp=[yp, get(ii,'Ydata')];                                                     
                            end
                            for jj = 1:length(xp)
                                TH = findobj(handles.axes1,'Type','text', '-and', 'Position', [xp(jj), yp(jj), []]);               
                                str{jj} = get(TH, 'String');
                            end
                        end
                        plotB(handles.B.X, handles.axes1, handles.B.LevelCounter, handles.F.IsolationDecision,handles.B.clr,handles.B.WindDirection,handles.B.C,get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));
                        mins = (handles.IsoTime3 - fix(handles.IsoTime3))*60;
                        sec = (mins - fix(mins))*60;                
                        text(3, 2, ['Contaminant Isolated in  Z', num2str(zns3(find(Logical3(:,iso3+1)==0))), sprintf(' at %02d:%02d:%02d !!!',fix(handles.IsoTime3),fix(mins),fix(sec))], 'FontSize',13','FontWeight','bold')
                        oldmsgs = cellstr(get(handles.edit14,'String'));
                        set(handles.edit14,'String',[oldmsgs;{['>> Contaminant Isolated in  Z', num2str(zns3(find(Logical3(:,iso3+1)==0))), sprintf(' at %02d:%02d:%02d !!!',fix(handles.IsoTime3),fix(mins),fix(sec))]}] );
                        if ~isempty(lH)
                           plot(xp, yp, 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
                            for jj = 1:length(xp)
                                str1{1} = str{jj}{1};
                                str1{2} = str{jj}{2};
                                text(xp(jj), yp(jj), str1)                         
                            end
                            clear xp yp str str1

                        end 
                        
                    else
                        for j=1:length(zns3)
                            if Logical3(j,iso3+1)
                                handles.B.clr{zns3(j)} = 'w';
                            else
                                handles.B.clr{zns3(j)} = [255/255 153/255 153/255];
                            end
                        end
                        UserData.B = handles.B;
                        set(axesHandle,'UserData', UserData)
                        
                        clear lH
                        lH = findobj(handles.axes1,'Type','line','-and', 'MarkerEdgeColor','r');
                        if ~isempty(lH)
                            clear ii
                            
                            xp = []; 
                            yp = [];
                            for ii = lH'
                                xp=[xp, get(ii,'Xdata')]; %Getting coordinates of line object
                                yp=[yp, get(ii,'Ydata')];                                                     
                            end
                            for jj = 1:length(xp)
                                TH = findobj(handles.axes1,'Type','text', '-and', 'Position', [xp(jj), yp(jj), []]);               
                                str{jj} = get(TH, 'String');
                            end
                        end
                        plotB(handles.B.X, handles.axes1, handles.B.LevelCounter, handles.F.IsolationDecision,handles.B.clr,handles.B.WindDirection,handles.B.C,get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));
%                         mins = (Dtime1(1) - fix(Dtime1(1)))*60;
%                         sec = (mins - fix(mins))*60;                
%                         text(3, 2, ['Contaminant Detected in Subsystem 1 at ', sprintf('%02d:%02d:%02d !!!',fix(Dtime1(1)),fix(mins),fix(sec))], 'FontSize',12','FontWeight','bold')
                        if ~isempty(lH)
                            plot(xp, yp, 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
                            for jj = 1:length(xp)
                                str1{1} = str{jj}{1};
                                str1{2} = str{jj}{2};
                                text(xp(jj), yp(jj), str1)                         
                            end
                            clear xp yp str str1
                        
                        end
                    end
                end
                
                t2 = Dtime3(1):TimeStep:TimeStep*i;
                a = TimeStep/15;
                timeAxis=bsxfun(@plus,(0:a:TimeStep-a)', t2); %subsampled time axis
                for j=1:length(zns3)          
                    plotdata=bsxfun(@times,ones(15,1),Logical3(j,1:iso3));                
                    set(I3(j),'YData',plotdata(:))
                    set(I3(j),'XData',timeAxis(:))
                end
                
            end
            
            i = i+1;
            pause(0.15)
            guidata(hObject, handles);
        end
        set(handles.DeactiveDistribudedCDI, 'Enable', 'on')
        handles.x = x(1:length(handles.t),:);
    end
    handles.time = 0;
    set(handles.RunContaminantEvent,'Enable', 'on') 
    set(handles.FDIresults, 'Enable', 'on')
    set(handles.SaveConcentrations, 'Enable', 'on')
    set(handles.plot, 'Enable', 'on')
    set(handles.airflows, 'Enable', 'on')
%     matlabpool close    
    guidata(hObject, handles);
    
function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double

handles.B.WindDirection = str2num(get(handles.edit12, 'String'));
jH = findobj(handles.axes1,'Type','patch', '-and', 'LineWidth', 0.3, '-and', 'FaceColor', .5*[1,1,1]);
xp=get(jH(1),'Xdata');

lH = findobj(handles.axes1);

for ii=lH'
    if find(round(handles.cmp) == round(ii))
        delete(ii)
    end
end
handles.cmp = comprose(xp(1),5,4,2,handles.B.WindDirection,8,'LineWidth',0.3,'FaceColor',.5*[1,1,1]);
set(handles.edit12, 'Enable', 'off')
set(handles.edit12, 'Enable', 'on')


panel = get(hObject,'Parent');
UserData = get(get(panel,'Parent'), 'UserData'); 
UserData.B = handles.B;
set(get(panel,'Parent'),'UserData', UserData)

guidata(hObject, handles);


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
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double
handles.B.WindSpeed = str2num(get(handles.edit13, 'String'));
set(handles.edit13, 'Enable', 'off')
set(handles.edit13, 'Enable', 'on')


panel = get(hObject,'Parent');
UserData = get(get(panel,'Parent'), 'UserData'); 
UserData.B = handles.B;
set(get(panel,'Parent'),'UserData', UserData)

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    axesHandle  = get(hObject,'Parent');
    Handles = guidata(axesHandle); 
%     Handles = get(handles);
    Handles.type = get(axesHandle, 'selectiontype');
    Handles.point = get(hObject, 'CurrentPoint');
    
    
    
    if (Handles.B.Size(1)< Handles.point(1,1))&(Handles.B.Size(2)>Handles.point(1,1))&(Handles.B.Size(3)< Handles.point(1,2))&(Handles.B.Size(4)> Handles.point(1,2))
        j =1; i=5;
        while (j ~= Handles.B.LevelCounter)
            while (strcmp(Handles.B.X.LevelIconData{i},'!icn col row  #')~=1)
                i=i+1;    
            end
            j = j + 1;
            i = i + 1;
        end

        clear out
        out = textscan(Handles.B.X.LevelIconData{i},'%s','delimiter',' ','multipleDelimsAsOne',1);
        while (length(out{1})==4)
            Data1(i-4,1) = str2double(out{1}{1})';
            Data1(i-4,2) = str2double(out{1}{2})';
            Data1(i-4,3) = str2double(out{1}{3});
            Data1(i-4,4) = str2double(out{1}{4});
            i = i+1;
            out = textscan(Handles.B.X.LevelIconData{i},'%s','delimiter',' ','multipleDelimsAsOne',1);
        end

        k=0; 
        m=0;
        for i = 1:length(Data1)
            if (Data1(i,1)==14)||(Data1(i,1)==15)||(Data1(i,1)==16)||(Data1(i,1)==17)||(Data1(i,1)==18)||(Data1(i,1)==19)||(Data1(i,1)==20)||(Data1(i,1)==21)||(Data1(i,1)==22)
                k=k+1;
                Data(k,:)= Data1(i,1:3);
            end
            if(Data1(i,1)==5)||(Data1(i,1)==6)
                m=m+1;
                Data3(m,:)= Data1(i,1:4);
            end
        end
        if  exist('Data','var')

                col = Handles.point(1,1);
                row = Handles.point(1,2);

                r = find(Data(:,3) < row);
                c = find(Data(1:max(r),2) < col);
                l = max(c);

                clear Data4
                Data4(1,:) = Data(l,:);

                if (Data4(1,1)==14)||(Data4(1,1)==17)||(Data4(1,1)==18)||(Data4(1,1)==19)||(Data4(1,1)==21)||(Data4(1,1)==22)
                    dir = 1; % right
                elseif (Data4(1,1)==15)
                    dir = 2; % left
                elseif (Data4(1,1)==16)||(Data4(1,1)==20)
                    dir = 3; % up
                end

                clear col row
                col = 0; row = 0;
                i = 2;
                while (Data4(1,2) ~= col)||(Data4(1,3)~=row)
                    switch dir
                        case 1 % right
                            row = Data4(i-1,3);              
                            l = min(find((Data(:,3)==row)&(Data(:,2) > Data4(i-1,2))));
                            col = Data(l,2);
                            Data4(i,:)= Data(l,:);
                            if (Data4(i,1)==16)
                                dir = 3;
                            elseif (Data4(i,1)==15)||(Data4(i,1)==19)||(Data4(i,1)==20)||(Data4(i,1)==22)
                                dir = 4;
                            elseif (Data4(i,1)==21)
                                dir = 1;
                            end
                        case 2 % left
                            row = Data4(i-1,3);
                            l = max(find((Data(:,3)==row)&(Data(:,2) < Data4(i-1,2))));
                            col = Data(l,2);
                            Data4(i,:)= Data(l,:);
                            if (Data4(i,1)==17)||(Data4(i,1)==18)||(Data4(i,1)==21)||(Data4(i,1)==22)
                                dir = 3;
                            elseif (Data4(i,1)==14)
                                dir = 4;
                            elseif (Data4(i,1)==19)
                                dir = 2;
                            end
                        case 3 % up
                            col = Data4(i-1,2);              
                            l = max(find((Data(:,2)==col)&(Data(:,3) < Data4(i-1,3))));
                            row = Data(l,3);
                            Data4(i,:)= Data(l,:);
                            if (Data4(i,1)==14)||(Data4(i,1)==18)||(Data4(i,1)==19)||(Data4(i,1)==22)
                                dir = 1;
                            elseif (Data4(i,1)==15)
                                dir = 2;
                            elseif (Data4(i,1)==20)
                                dir = 3;
                            end
                        case 4 % down
                            col = Data4(i-1,2);              
                            l = min(find((Data(:,2)==col)&(Data(:,3) > Data4(i-1,3))));
                            row = Data(l,3);
                            Data4(i,:)= Data(l,:);
                            if (Data4(i,1)==17)
                                dir = 1;
                            elseif (Data4(i,1)==16)||(Data4(i,1)==20)||(Data4(i,1)==21)||(Data4(i,1)==22)
                                dir = 2;
                            elseif (Data4(i,1)==18)
                                dir = 4;
                            end
                    end
                    i = i + 1;        
                end

                clear X Y
                X= Data4(:,2);
                Y= Data4(:,3);
                    
                s=size(Data3);
%                 for z = 1:s(1)
%                     if (size(Handles.B.X1{z})==size(X))&(size(Handles.B.Y1{z})==size(Y))
%                         if (Handles.B.X1{z}==X)&(Handles.B.Y1{z}==Y)
%                             Z = Data3(z,4);
%                         end
%                     end
%                 end
                
                for z = 1:s(1)
                    if inpolygon(Data3(z,2),Data3(z,3),X,Y)                        
                        Z = Data3(z,4);                    
                    end
                end


        end
        if strcmp(Handles.type,'normal')
            Handles.u(Z) = Handles.u(Z) + str2double(get(Handles.edit1, 'String'));
            u = str2double(get(Handles.edit1, 'String'));
            mins = (Handles.time - fix(Handles.time))*60;
            sec = (mins - fix(mins))*60;
            plot(Handles.point(1,1), Handles.point(1,2), 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
%             set(lH,'hittest','off');
            str{1} = ['\leftarrow  ',num2str(u), ' g/h '];
            str{2} = ['  at ', sprintf('%02d:%02d:%02d',fix(Handles.time),fix(mins),fix(sec))];
            text(Handles.point(1,1), Handles.point(1,2), str)
            oldmsgs = cellstr(get(Handles.edit14,'String'));
%             set(Handles.edit14,'Value',length([oldmsgs;{['>> A contaminant source released in Z', num2str(Z), ' with ', num2str(u), sprintf(' g/h at %02d:%02d:%02d.',fix(Handles.time),fix(mins),fix(sec))]}]));
            set(Handles.edit14,'String',[oldmsgs;{['>> A contaminant source released in Z', num2str(Z), ' with ', num2str(u), sprintf(' g/h at %02d:%02d:%02d.',fix(Handles.time),fix(mins),fix(sec))]}] );
%             set(Handles.edit14,'ListboxTop',get(Handles.edit14,'ListboxTop')+1)
%             a = get(Handles.edit14,'ListboxTop')+1
%             set(Handles.edit14,'ListboxTop',a)
%             Handles.Sources = [Handles.Sources, lH];
%             ['\leftarrow ',num2str(u), ' g/h ',sprintf('\n'),' at ', sprintf('%02d:%02d:%02d',fix(Handles.time),fix(mins),fix(sec))]
%             sprintf('\leftarrow %f g/h \n at %02d:%02d:%02d', u,fix(Handles.time),fix(mins),fix(sec))
        elseif strcmp(Handles.type,'alt')
            %Finding the closest point and highlighting it
            lH = findobj(hObject,'Marker', 'o', '-and', 'MarkerFaceColor','r', '-and','MarkerSize',14, '-and','MarkerEdgeColor','r');
            
            minDist = realmax;
%             finalIdx = NaN;
            finalH = NaN;
%             finalT = NaN;
            pt = Handles.point;
            
            xp = []; 
            yp = [];
            for ii = lH'
                xp=[xp, get(ii,'Xdata')]; %Getting coordinates of line object
                yp=[yp, get(ii,'Ydata')];                                                     
            end
            
            for ii = 1:length(xp)
%                 xp=get(ii,'Xdata'); %Getting coordinates of line object
%                 yp=get(ii,'Ydata');
                
                col = xp(ii);
                row = yp(ii);

                r = find(Data(:,3) < row);
                c = find(Data(1:max(r),2) < col);
                l = max(c);

                clear Data4
                Data4(1,:) = Data(l,:);

                if (Data4(1,1)==14)||(Data4(1,1)==17)||(Data4(1,1)==18)||(Data4(1,1)==19)||(Data4(1,1)==21)||(Data4(1,1)==22)
                    dir = 1; % right
                elseif (Data4(1,1)==15)
                    dir = 2; % left
                elseif (Data4(1,1)==16)||(Data4(1,1)==20)
                    dir = 3; % up
                end

                clear col row
                col = 0; row = 0;
                i = 2;
                while (Data4(1,2) ~= col)||(Data4(1,3)~=row)
                    switch dir
                        case 1 % right
                            row = Data4(i-1,3);              
                            l = min(find((Data(:,3)==row)&(Data(:,2) > Data4(i-1,2))));
                            col = Data(l,2);
                            Data4(i,:)= Data(l,:);
                            if (Data4(i,1)==16)
                                dir = 3;
                            elseif (Data4(i,1)==15)||(Data4(i,1)==19)||(Data4(i,1)==20)||(Data4(i,1)==22)
                                dir = 4;
                            elseif (Data4(i,1)==21)
                                dir = 1;
                            end
                        case 2 % left
                            row = Data4(i-1,3);
                            l = max(find((Data(:,3)==row)&(Data(:,2) < Data4(i-1,2))));
                            col = Data(l,2);
                            Data4(i,:)= Data(l,:);
                            if (Data4(i,1)==17)||(Data4(i,1)==18)||(Data4(i,1)==21)||(Data4(i,1)==22)
                                dir = 3;
                            elseif (Data4(i,1)==14)
                                dir = 4;
                            elseif (Data4(i,1)==19)
                                dir = 2;
                            end
                        case 3 % up
                            col = Data4(i-1,2);              
                            l = max(find((Data(:,2)==col)&(Data(:,3) < Data4(i-1,3))));
                            row = Data(l,3);
                            Data4(i,:)= Data(l,:);
                            if (Data4(i,1)==14)||(Data4(i,1)==18)||(Data4(i,1)==19)||(Data4(i,1)==22)
                                dir = 1;
                            elseif (Data4(i,1)==15)
                                dir = 2;
                            elseif (Data4(i,1)==20)
                                dir = 3;
                            end
                        case 4 % down
                            col = Data4(i-1,2);              
                            l = min(find((Data(:,2)==col)&(Data(:,3) > Data4(i-1,3))));
                            row = Data(l,3);
                            Data4(i,:)= Data(l,:);
                            if (Data4(i,1)==17)
                                dir = 1;
                            elseif (Data4(i,1)==16)||(Data4(i,1)==20)||(Data4(i,1)==21)||(Data4(i,1)==22)
                                dir = 2;
                            elseif (Data4(i,1)==18)
                                dir = 4;
                            end
                    end
                    i = i + 1;        
                end
                
                clear Xp Yp
                Xp= Data4(:,2);
                Yp= Data4(:,3);
                
                if (size(X)==size(Xp))&(size(Y)==size(Yp))
                    if (X==Xp)&(Y==Yp)
                        dx=daspect(hObject);      %Aspect ratio is needed to compensate for uneven axis when calculating the distance
                        [newDist idx] = min( ((pt(1,1)-xp(ii)).*dx(2)).^2 + ((pt(1,2)-yp(ii)).*dx(1)).^2 );
                        if (newDist < minDist)
                            finalH = ii;
%                             finalIdx = idx;
                            minDist = newDist;
                        end
                    end
                end
            end
            if ~isequaln(finalH,NaN)
                
%                 xp=get(finalH,'Xdata'); %Getting coordinates of line object
%                 yp=get(finalH,'Ydata');
%                 zp=get(finalH,'Zdata');
                TH = findobj(hObject,'Type','text', '-and', 'Position', [xp(finalH), yp(finalH), 0]);               
                str = get(TH, 'String');
                out = textscan(str{1},'%s','delimiter',' ','multipleDelimsAsOne',2);
                u = str2double(out{1}{2})';
                Handles.u(Z) = Handles.u(Z) - u;
%                 for jj = 1:length(Handles.Sources)
%                     if (xp(finalH)==get(Handles.Sources(jj),'Xdata'))&(yp(finalH)==get(Handles.Sources(jj),'Ydata'))
%                        k = jj; 
%                     end
%                 end
                for jj = 1:length(xp)
                    TH2 = findobj(hObject,'Type','text', '-and', 'Position', [xp(jj), yp(jj), []]);               
                    str{jj} = get(TH2, 'String');
                    delete(TH2)
                end
                
                delete(lH)                
                for ii = 1:length(xp)
                    if ii ~= finalH
                        plot(xp(ii), yp(ii), 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
                        str1{1} = str{ii}{1};
                        str1{2} = str{ii}{2};
                        text(xp(ii), yp(ii), str1)                           
                    end
                end
%                 delete(Handles.Sources(k))
%                 Handles.Sources(k) = [];
%                 lH2 = findobj(hObject,'Type','line','-and', 'MarkerEdgeColor','r', '-and', 'Position', [xp(finalH), yp(finalH), 0]);
%                 delete(lH2)
                
                oldmsgs = cellstr(get(Handles.edit14,'String'));
                set(Handles.edit14,'String',[oldmsgs;{['>> A contaminant source removed from Z', num2str(Z), ' with ', num2str(u), ' g/h']}]);
            end
            
        end
    end

UserData.B = Handles.B;
UserData.u = Handles.u;
set(axesHandle, 'UserData', UserData)    
% drawnow; pause(0.5);
% HandleMainGUI=getappdata(0,'HandleMainGUI');
% setappdata(axesHandle,'SharedData', Handles);
% setappdata(axesHandle,'CurrentPoint',ptH);
guidata(axesHandle, Handles);



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


% --- Executes on button press in Concentrations.
function Concentrations_Callback(hObject, eventdata, handles)
% hObject    handle to Concentrations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Concentrations
    if ~isempty(findobj('Name','Contaminant Concentration'))
        lH = findobj('Name','Contaminant Concentration');
        if get(handles.Concentrations, 'Value')
            set(lH, 'Visible', 'on')
        else
            set(lH, 'Visible', 'off')
        end
    end
    
%     if handles.fig1~=0
%         if get(handles.Concentrations, 'Value')
%             set(handles.fig1, 'Visible', 'on')
%         else
%             set(handles.fig1, 'Visible', 'off')
%         end
%     end
    
guidata(hObject, handles);


% --- Executes on button press in CDE.
function CDE_Callback(hObject, eventdata, handles)
% hObject    handle to CDE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CDE
    if ~isempty(findobj('Name','Contaminant Detection Estimator'))
        lH = findobj('Name','Contaminant Detection Estimator');
        if get(handles.CDE, 'Value')
            set(lH, 'Visible', 'on')
        else
            set(lH, 'Visible', 'off')
        end
    end
    
    if ~isempty(findobj('Name','Contaminant Detection Estimator 1'))
        lH = findobj('Name','Contaminant Detection Estimator 1');
        if get(handles.CDE, 'Value')
            set(lH, 'Visible', 'on')
        else
            set(lH, 'Visible', 'off')
        end
    end
    
    if ~isempty(findobj('Name','Contaminant Detection Estimator 2'))
        lH = findobj('Name','Contaminant Detection Estimator 2');
        if get(handles.CDE, 'Value')
            set(lH, 'Visible', 'on')
        else
            set(lH, 'Visible', 'off')
        end
    end
    
    if ~isempty(findobj('Name','Contaminant Detection Estimator 3'))
        lH = findobj('Name','Contaminant Detection Estimator 3');
        if get(handles.CDE, 'Value')
            set(lH, 'Visible', 'on')
        else
            set(lH, 'Visible', 'off')
        end
    end    
    
%     if handles.fig2~=0
%         if get(handles.CDE, 'Value')
%             set(handles.fig2, 'Visible', 'on')
%         else
%             set(handles.fig2, 'Visible', 'off')
%         end
%     end
    
guidata(hObject, handles);
% --- Executes on button press in CIE.
function CIE_Callback(hObject, eventdata, handles)
% hObject    handle to CIE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CIE
    if ~isempty(findobj('Name','Contaminant Isolation Decision'))
        lH = findobj('Name','Contaminant Isolation Decision');
        if get(handles.CIE, 'Value')
            set(lH, 'Visible', 'on')
        else
            set(lH, 'Visible', 'off')
        end
    end
    
    if ~isempty(findobj('Name','Contaminant Isolation Decision 1'))
        lH = findobj('Name','Contaminant Isolation Decision 1');
        if get(handles.CIE, 'Value')
            set(lH, 'Visible', 'on')
        else
            set(lH, 'Visible', 'off')
        end
    end
    
    if ~isempty(findobj('Name','Contaminant Isolation Decision 2'))
        lH = findobj('Name','Contaminant Isolation Decision 2');
        if get(handles.CIE, 'Value')
            set(lH, 'Visible', 'on')
        else
            set(lH, 'Visible', 'off')
        end
    end
    
    if ~isempty(findobj('Name','Contaminant Isolation Decision 3'))
        lH = findobj('Name','Contaminant Isolation Decision 3');
        if get(handles.CIE, 'Value')
            set(lH, 'Visible', 'on')
        else
            set(lH, 'Visible', 'off')
        end
    end
    
    
%     if handles.fig3~=0
%         if get(handles.CIE, 'Value')
%             set(handles.fig3, 'Visible', 'on')
%         else
%             set(handles.fig3, 'Visible', 'off')
%         end
%     end
    
guidata(hObject, handles);    


% --------------------------------------------------------------------
function ActiveDistributedCDI_Callback(hObject, eventdata, handles)
% hObject    handle to ActiveDistributedCDI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    oldmsgs = cellstr(get(handles.edit14,'String'));
    set(handles.edit14,'String',[oldmsgs;{'>> Distributed CDI Activated'}] );
    set(handles.ActiveDistributedCDI, 'Enable', 'off')
    set(handles.DeactiveDistribudedCDI, 'Enable', 'on')
    handles.ActiveDistributed = 1;
    handles.F.IsolationDecision = [1 1 1 1 1 2 3 2 2 3 3 2 2 3];
    
    C=zeros(10,14);
    C(1,1)=1;
    C(2,2)=1;
    C(3,4)=1;
    C(4,6)=1;
    C(5,7)= 1;
    C(6,8)= 1;
    C(7,9)= 1;
    C(8,10)= 1;
    C(9,11)=1;
    C(10,12)=1;
    C(11,14)=1;
    handles.B.C = C; % for general must delete
    
    for j=1:handles.B.nZones
        handles.B.clr{j} = 'w';
    end
    clear lH
    lH = findobj(handles.axes1,'Type','line','-and', 'MarkerEdgeColor','r');
    if ~isempty(lH)
        clear ii

        for ii = lH'
            xp=get(ii,'Xdata'); %Getting coordinates of line object
            yp=get(ii,'Ydata');                   
    %                                                
        end
        for jj = 1:length(xp)
            TH = findobj(handles.axes1,'Type','text', '-and', 'Position', [xp(jj), yp(jj), []]);               
            str{jj} = get(TH, 'String');
        end
    end
    plotB(handles.B.X, handles.axes1, handles.B.LevelCounter, handles.F.IsolationDecision,handles.B.clr,handles.B.WindDirection,handles.B.C,get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));
    if ~isempty(lH)
       plot(xp, yp, 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
        for jj = 1:length(xp)
            str1{1} = str{jj}{1};
            str1{2} = str{jj}{2};
            text(xp(jj), yp(jj), str1)                         
        end
        clear xp yp str str1
    end 
guidata(hObject, handles); 

% --------------------------------------------------------------------
function DeactiveDistribudedCDI_Callback(hObject, eventdata, handles)
% hObject    handle to DeactiveDistribudedCDI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    oldmsgs = cellstr(get(handles.edit14,'String'));
    set(handles.edit14,'String',[oldmsgs;{'>> Distributed CDI Deactivated'}] );
    set(handles.ActiveDistributedCDI, 'Enable', 'on')
    set(handles.DeactiveDistribudedCDI, 'Enable', 'off')
    handles.ActiveDistributed = 0;
    handles.F.IsolationDecision=zeros(1,handles.B.nZones);
    
    handles.B.C = eye(handles.B.nZones); % for general must delete
    
    for j=1:handles.B.nZones
        handles.B.clr{j} = 'w';
    end
    clear lH
    lH = findobj(handles.axes1,'Type','line','-and', 'MarkerEdgeColor','r');
    if ~isempty(lH)
        clear ii

        for ii = lH'
            xp=get(ii,'Xdata'); %Getting coordinates of line object
            yp=get(ii,'Ydata');                   
    %                                                
        end
        for jj = 1:length(xp)
            TH = findobj(handles.axes1,'Type','text', '-and', 'Position', [xp(jj), yp(jj), []]);               
            str{jj} = get(TH, 'String');
        end
    end
    plotB(handles.B.X, handles.axes1, handles.B.LevelCounter, handles.F.IsolationDecision,handles.B.clr,handles.B.WindDirection,handles.B.C,get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));
    if ~isempty(lH)
       plot(xp, yp, 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
        for jj = 1:length(xp)
            str1{1} = str{jj}{1};
            str1{2} = str{jj}{2};
            text(xp(jj), yp(jj), str1)                         
        end
        clear xp yp str str1
    end


guidata(hObject, handles);


% --------------------------------------------------------------------
function CDI_Callback(hObject, eventdata, handles)
% hObject    handle to CDI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ZoneID.
function ZoneID_Callback(hObject, eventdata, handles)
% hObject    handle to ZoneID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ZoneID

clear lH
lH = findobj(handles.axes1,'Type','line','-and', 'MarkerEdgeColor','r');
if ~isempty(lH)
    clear ii

    xp = []; 
    yp = [];
    for ii = lH'
        xp=[xp, get(ii,'Xdata')]; %Getting coordinates of line object
        yp=[yp, get(ii,'Ydata')];                                                     
    end        
    for jj = 1:length(xp)
        TH = findobj(handles.axes1,'Type','text', '-and', 'Position', [xp(jj), yp(jj), []]);               
        str{jj} = get(TH, 'String');
    end
end

plotB(handles.B.X,handles.axes1,handles.B.LevelCounter,handles.F.IsolationDecision,handles.B.clr,handles.B.WindDirection,handles.B.C,get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));

if ~isempty(lH)
   plot(xp, yp, 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
    for jj = 1:length(xp)
        str1{1} = str{jj}{1};
        str1{2} = str{jj}{2};
        text(xp(jj), yp(jj), str1)                         
    end
    clear xp yp str str1
end



% --- Executes on button press in PathID.
function PathID_Callback(hObject, eventdata, handles)
% hObject    handle to PathID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PathID

clear lH
lH = findobj(handles.axes1,'Type','line','-and', 'MarkerEdgeColor','r');
if ~isempty(lH)
    clear ii

    xp = []; 
    yp = [];
    for ii = lH'
        xp=[xp, get(ii,'Xdata')]; %Getting coordinates of line object
        yp=[yp, get(ii,'Ydata')];                                                     
    end        
    for jj = 1:length(xp)
        TH = findobj(handles.axes1,'Type','text', '-and', 'Position', [xp(jj), yp(jj), []]);               
        str{jj} = get(TH, 'String');
    end
end

plotB(handles.B.X,handles.axes1,handles.B.LevelCounter,handles.F.IsolationDecision,handles.B.clr,handles.B.WindDirection,handles.B.C,get(handles.ZoneID,'Value'),get(handles.PathID,'Value'));

if ~isempty(lH)
   plot(xp, yp, 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
    for jj = 1:length(xp)
        str1{1} = str{jj}{1};
        str1{2} = str{jj}{2};
        text(xp(jj), yp(jj), str1)                         
    end
    clear xp yp str str1
end
