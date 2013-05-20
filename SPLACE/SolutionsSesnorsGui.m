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

function varargout = SolutionsSesnorsGui(varargin)
% SOLUTIONSSESNORSGUI MATLAB code for SolutionsSesnorsGui.fig
%      SOLUTIONSSESNORSGUI, by itself, creates a new SOLUTIONSSESNORSGUI or raises the existing
%      singleton*.
%
%      H = SOLUTIONSSESNORSGUI returns the handle to a new SOLUTIONSSESNORSGUI or the handle to
%      the existing singleton*.
%
%      SOLUTIONSSESNORSGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOLUTIONSSESNORSGUI.M with the given input arguments.
%
%      SOLUTIONSSESNORSGUI('Property','Value',...) creates a new SOLUTIONSSESNORSGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SolutionsSesnorsGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SolutionsSesnorsGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SolutionsSesnorsGui

% Last Modified by GUIDE v2.5 29-Apr-2013 12:59:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SolutionsSesnorsGui_OpeningFcn, ...
                   'gui_OutputFcn',  @SolutionsSesnorsGui_OutputFcn, ...
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


% --- Executes just before SolutionsSesnorsGui is made visible.
function SolutionsSesnorsGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SolutionsSesnorsGui (see VARARGIN)

    % Choose default command line output for SolutionsSesnorsGui
    handles.output = hObject;
    set(handles.figure1,'name','S-PLACE:Sensor Placement');

    % UIWAIT makes SolutionsSesnorsGui wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
    handles.Exhaustive=varargin{1}.Exhaustive;
    handles.file0=varargin{1}.file0;
    handles.B=varargin{1}.B;
    handles.MainGuiaxes1=varargin{1}.MainGuiaxes1;
    handles.pp.numberOfSensors=varargin{1}.pp.numberOfSensors;
    
    value = get(handles.Exhaustive,'Value');
    if value==1
        load([handles.file0,'.y0'],'Y', '-mat'); %Exhaustive method
    else
        load([handles.file0,'.y1'],'Y', '-mat'); %Evolutionary method
    end
    
    set(handles.SplaceTable,'Foregroundcolor','b');  
    set(handles.SplaceTable,'fontsize',8);%10
    
    w=[{'------S-PLACE------'};{' '}];
    set(handles.SplaceTable,'visible','on');
    a=str2num(handles.pp.numberOfSensors);
    u=1;
    w=[w;{['------Sensors-Placement: ',num2str(a(1))]}];
    
    i=1;k=1;pp=1;
    while i<size(Y.F,1)+1
            ss=Y.xIndex{u};
        if Y.F(i,1)==a(u) 
            r=Y.F(k,:);k=k+1;
            f1=r(2);
            f2=r(3);
            ss1=ss(pp,:);
            Sensors=handles.B.ZoneName{ss1};
            SensorsSS= [num2str(Sensors),''];
            if length(ss1)>1
                for t=2:length(ss1)
                    SensorsSS = [SensorsSS,'  ',num2str(handles.B.ZoneName{ss1(t)})];
                end
            end
            w=[w;{['mean=',num2str(sprintf('%10.2f',f1)),'      max=',num2str(sprintf('%10.2f',f2)),'      Zones: ',SensorsSS]}];
            set(handles.SplaceTable,'Value',length(w));
            set(handles.SplaceTable,'String',w);
        else
            u=u+1;
            pp=0;
            i=i-1;
            w=[w;{['------Sensors-Placement: ',num2str(a(u))]}];
        end
        i=i+1;pp=pp+1;
    end
    
    % Update handles structure
    guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = SolutionsSesnorsGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in SplaceTable.
function SplaceTable_Callback(hObject, eventdata, handles)
% hObject    handle to SplaceTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SplaceTable contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SplaceTable

    lineSensors = get(handles.SplaceTable,'Value');
    StringSensors = get(handles.SplaceTable,'String');

    tline = StringSensors(lineSensors);
    tline = regexp(tline, '\s*','split');
    tline = tline{1};
    
    if length(tline)>2
        set(handles.SplaceTable,'enable','inactive');

        SensorsZonesID=tline(6:end);
        IsolationDecision=zeros(1,handles.B.nZones);
        IndexZones=zeros(1,handles.B.nZones);
        for i=1:length(SensorsZonesID)
            Zones{i}=strcmp(SensorsZonesID(i),handles.B.ZoneName);
            IndexZones(i)=find(Zones{i},1);
            if IndexZones(i)~=0
                IsolationDecision(IndexZones(i))=1;
            end
        end
        axes(handles.MainGuiaxes1)
        plotB(handles.B.X,handles.MainGuiaxes1,handles.B.LevelCounter,IsolationDecision);
        axis on
        set(handles.MainGuiaxes1,'Color','w')
        set(handles.MainGuiaxes1,'XTick',[])
        set(handles.MainGuiaxes1,'YTick',[])
        set(handles.SplaceTable,'enable','on');
    end
    

% --- Executes during object creation, after setting all properties.
function SplaceTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SplaceTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
