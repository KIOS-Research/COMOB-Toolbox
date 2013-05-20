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

function varargout = MATCONTA(varargin)
% MATCONTA MATLAB code for MATCONTA.fig
%      MATCONTA, by itself, creates a new MATCONTA or raises the existing
%      singleton*.
%
%      H = MATCONTA returns the handle to a new MATCONTA or the handle to
%      the existing singleton*.
%
%      MATCONTA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MATCONTA.M with the given input arguments.
%
%      MATCONTA('Property','Value',...) creates a new MATCONTA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MATCONTA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MATCONTA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% edit the above text to modify the response to help MATCONTA

% Last Modified by GUIDE v2.5 16-May-2013 14:14:32

% Begin initialization code - DO NOT EDIT
clc
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MATCONTA_OpeningFcn, ...
                   'gui_OutputFcn',  @MATCONTA_OutputFcn, ...
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


% --- Executes just before MATCONTA is made visible.
function MATCONTA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MATCONTA (see VARARGIN)

% Choose default command line output for MATCONTA
handles.output = hObject;

path(path,'SPLACE');
%path(path,'SPLACE\GuiSplace');
path(path,'Help\Logos');
path(path,'CDI');


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
set(handles.edit6, 'Enable', 'off')
set(handles.edit5, 'Enable', 'off')
set(handles.edit4, 'Enable', 'off')
set(handles.edit2, 'Enable', 'off')
set(handles.edit1, 'Enable', 'off')
set(handles.release,'Enable', 'off')
set(handles.zone, 'Enable', 'off')
set(handles.weather, 'Enable', 'off')
set(handles.path, 'Enable', 'off')
set(handles.SensorsData, 'Enable', 'off')
set(handles.plot, 'Enable', 'off')
set(handles.airflows, 'Enable', 'off')
set(handles.run, 'Enable', 'off')
set(handles.SaveConcentrations, 'Enable', 'off')
set(handles.SaveAmatrix, 'Enable', 'off')
set(handles.FDIparameters, 'Enable', 'off')
set(handles.FDIrun, 'Enable', 'off')
set(handles.FDIresults, 'Enable', 'off')
set(handles.multiple, 'Enable', 'off')
set(handles.ParameterSelection, 'Enable', 'off')
set(handles.Calculate, 'Enable', 'off')
set(handles.ComputeImpactMatrix, 'Enable', 'off')
set(handles.SolveSensorPlacement, 'Enable', 'off')
setappdata(0,'HandleMainGUI',hObject);
handles.ok=0;
handles.Noise = 0;

F.choice = 1;
F.Ex0 = 0.1;
F.Ez0 = 0.3;
F.LearningRate = 10e7;
F.Theta = 20;
F.InitialSourceEstimation = 0.05;
F.UncertaintiesBound = 0;
F.NoiseBound = 0;
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
F.DA = 0;
F.Calc = 0;
F.NominalChoice = 1;
F.NominalFile = '';
F.MatricesFile = '';

handles.F = F;


handles.choice = 1;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MATCONTA wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = MATCONTA_OutputFcn(hObject, eventdata, handles) 

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
        b1= zeros(B.nZones);
        for i=1:B.nZones
          if B.V(i,i)~=0;
            b1(i,i)= 1/B.V(i,i);
          else
            b1(i,i)= B.V(i,i);
          end
        end
        B.B=b1;
        %         B.B=inv(B.V); 
        B.D=0;
        B.C=eye(B.nZones);
        B.xext = 0;
        B.X=X;
        
        out = textscan(X.LevelIconData{1},'%s','delimiter',' ','multipleDelimsAsOne',1);
        handles.level = str2double(out{1}{1});
        B.LevelCounter = 1;
        handles.F.IsolationDecision=zeros(1,B.nZones);
        plotB(X,handles.axes1,B.LevelCounter,handles.F.IsolationDecision);
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
        set(handles.edit6,'Enable', 'on')
        set(handles.edit5,'Enable', 'on')
        set(handles.edit4,'Enable', 'on')
        set(handles.edit2, 'Enable', 'on')        
        set(handles.edit1, 'Enable', 'on')        
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
         
        handles.B = B;
        
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
   

close



function edit1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_Callback(hObject, eventdata, handles)

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
    handles.B.LevelCounter = handles.B.LevelCounter+1;
    
    if  ~isequal(handles.F.IsolationDecision,zeros(1,handles.F.IsolationDecision))
        plotB(handles.B.X,handles.axes1,handles.B.LevelCounter,handles.F.IsolationDecision);
    else
        plotB(handles.B.X,handles.axes1,handles.B.LevelCounter,zeros(1,handles.B.nZones));
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
  guidata(hObject, handles);

% --- Executes on button press in LevelDown.
function LevelDown_Callback(hObject, eventdata, handles)
% hObject    handle to LevelDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    handles.B.LevelCounter = handles.B.LevelCounter-1;
    if  ~isequal(handles.F.IsolationDecision,zeros(1,handles.F.IsolationDecision))
        plotB(handles.B.X,handles.axes1,handles.B.LevelCounter,handles.F.IsolationDecision);
    else
        plotB(handles.B.X,handles.axes1,handles.B.LevelCounter,zeros(1,handles.B.nZones));
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

    if exist('Project.File','file')==2 
        load Project.File -mat;
        if exist(file0,'file')==2
            if ~isempty(file0) 
                load(file0,'-mat');
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
    Data{3} = handles.Amat;
    
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
        pols = pole(sys)' - handles.F.UncertaintiesBound*2;
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
        min = handles.t(i) - fix(handles.t(i));
        sec = min - fix(min);
        uiwait(msgbox(sprintf('Contaminant Source Detected at Time %02d:%02d:%02d',fix(handles.t(i)), fix(min*60), fix(sec*60)), 'Warning', 'warn'));
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
    plotB(handles.B.X,handles.axes1,handles.B.LevelCounter,handles.F.IsolationDecision);
      
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
close(findobj('type','figure','name','Compute Impact Matrix'))

    if exist('Project.File','file')==2 
        load Project.File -mat;
        if exist(file0,'file')==2
            if ~isempty(file0) 
                load(file0,'-mat');
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

    if exist('Project.File','file')==2 
        load Project.File -mat;
        if exist(file0,'file')==2
            if ~isempty(file0) 
                load(file0,'-mat');
                if exist([file0(1:end-2),'.w'],'file')==2
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
    SolveSensorPlacementGui(arguments);
    
    


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rmpath('SPLACE');
%rmpath('SPLACE\GuiSplace');
%rmpath('SPLACE\Mfiles');
rmpath('CDI');
% Hint: delete(hObject) closes the figure
delete(hObject);
