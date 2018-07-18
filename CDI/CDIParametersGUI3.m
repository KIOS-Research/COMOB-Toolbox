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
function varargout = CDIParametersGUI3(varargin)
% CDIPARAMETERSGUI3 MATLAB code for CDIParametersGUI3.fig
%      CDIPARAMETERSGUI3, by itself, creates a new CDIPARAMETERSGUI3 or raises the existing
%      singleton*.
%
%      H = CDIPARAMETERSGUI3 returns the handle to a new CDIPARAMETERSGUI3 or the handle to
%      the existing singleton*.
%
%      CDIPARAMETERSGUI3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CDIPARAMETERSGUI3.M with the given input arguments.
%
%      CDIPARAMETERSGUI3('Property','Value',...) creates a new CDIPARAMETERSGUI3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CDIParametersGUI3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CDIParametersGUI3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CDIParametersGUI3

% Last Modified by GUIDE v2.5 16-Jan-2018 10:08:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CDIParametersGUI3_OpeningFcn, ...
                   'gui_OutputFcn',  @CDIParametersGUI3_OutputFcn, ...
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


% --- Executes just before CDIParametersGUI3 is made visible.
function CDIParametersGUI3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CDIParametersGUI3 (see VARARGIN)

    
% Choose default command line output for CDIParametersGUI3
handles.output = hObject;


handles.CDI = varargin{1}.CDI0;
handles.B = varargin{1}.B; % Nominal Building Parameters
handles.Amat = varargin{1}.Amat; % Nominal Amat with building parameters in handles.B
handles.CDI0 = handles.CDI; % for Cancel button
handles.CDI = SetGuiParameters(handles.CDI,handles);

%%% Change latex_ text boxes to text with latex interpreter
handles.laxis = axes('parent',handles.uipanel5,'units','normalized','position',[0 0 1 1],'visible','off');
% Find all static text UICONTROLS whose 'Tag' starts with latex_
lbls = findobj(handles.uipanel5,'-regexp','tag','latex_*');
for i=1:length(lbls)
      l = lbls(i);
      % Get current text, position and tag
      set(l,'units','normalized');
      s = get(l,'string');
      p = get(l,'position');
      t = get(l,'tag');
      % Remove the UICONTROL
      delete(l);
      % Replace it with a TEXT object 
      handles.(t) = text(p(1),p(2),s,'interpreter','latex');
      handles.(t).HorizontalAlignment='center';
      handles.(t).VerticalAlignment='middle';	

end

if exist([pwd,'\RESULTS\','pathname.File'],'file')==2 
    load([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');
    
    if exist('File0.File','file')==2 
        load([pwd,'\RESULTS\','File0.File'],'-mat'); % load last computed .0 file if it exist
        if isempty(handles.CDI.MatricesFile)
            C={{''},{''}};
        else
            warning('off')
            C=strsplit(handles.CDI.MatricesFile,'\RESULTS'); 
            warning('on') 
        end
        if strcmp(C{2},file0)
            if strcmp([pathname,file0],handles.CDI.MatricesFile)
                handles.file0=file0;
                if exist([pathname,file0],'file')==2
                    if ~isempty(file0) 
                        load([pathname,file0],'-mat'); % load matrices B and P of the corresponding .0 file
                        handles.P=P;
                        handles.B=B;
                        handles.CDI.choice=2;
                        setNominalBuildingParameters(handles)
                    else
                        handles.CDI.choice=1;
                    end
                else
                    B.ProjectName=[];
                end
            else
               handles.file0=[];
            end
        else
            handles.file0=file0;
        end
    else
        handles.file0=[];
    end
end

 if isempty(handles.ScenarioFileEdit.String)
    handles.RunCDI_Button.Enable='off';
    handles.RunCDI_Button.BackgroundColor=[0.94 0.94 0.94];
    handles.Compute.Enable='off';
    handles.FileRadio.Enable='off';
    handles.TolerancesRadio.Enable='off';
    handles.WindDirectionEdit.Enable='off';
    handles.WindSpeedEdit.Enable='off';
    handles.ZoneTemperatureEdit.Enable='off';
    handles.PathOpeningsEdit.Enable='off'; 
    handles.MaxIterationEdit.Enable='off';
 end

% Update handles structure
guidata(hObject, handles);
if strcmp(handles.CDIParametersGUI3.Visible,'off')
    handles.CDIParametersGUI3.Visible='on';
end
% UIWAIT makes CDIParametersGUI3 wait for user response (see UIRESUME)
% uiwait(handles.CDIParametersGUI3);
uiwait

% --- Outputs from this function are returned to the command line.
function varargout = CDIParametersGUI3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%% Since these are updated before we run the CDI they are not needed to be
%%% outputed
% Get default command line output from handles structure
varargout{1} =  handles.output;
varargout{2}.B = handles.B;
varargout{2}.CDI0 = handles.CDI;
delete(hObject)

function CDI = SetGuiParameters(CDI,handles)

if CDI.ActiveDistributed   
    
    set(handles.uitable1,'ColumnName',{'DA','DH'})
    colergen = @(color,text) ['<html><table border=0 width=400 bgcolor=',color,'><TR><TD>',text,'</TD></TR> </table></html>'];
    for i= 1:CDI.nSub
        TableRowName(1,i) = {['Subsystem', num2str(i)]};
        data1(i,:) = [CDI.SubsystemsData{i}.UncertaintiesBound...
                      CDI.SubsystemsData{i}.UncertaintiesBound2];
                  
                  
        data2(i,:) = [{colergen('#F0F0F0',['Subsystem', num2str(i)])},...
                      CDI.SubsystemsData{i}.Ex0,...
                      CDI.SubsystemsData{i}.Ez0,...
                      CDI.SubsystemsData{i}.LearningRate,...
                      CDI.SubsystemsData{i}.Theta,...
                      CDI.SubsystemsData{i}.InitialSourceEstimation];
        data3(i,1) = CDI.SubsystemsData{i}.NoiseBound;           
    end
    set(handles.uitable1,'RowName', TableRowName)
    set(handles.uitable1,'ColumnEditable',str2num('true true'));
    set(handles.uitable1,'data',data1);
    set(handles.uitable2,'ColumnWidth',{100 'auto' 'auto' 'auto' 'auto' 'auto'})
    set(handles.uitable2,'ColumnName',{'<html><center />  </html>',...
                                       '<html><center />Initial Maximum<br /> State Estimation<br /> Error for Detection</html>',...
                                       '<html><center />Initial Maximum<br /> State Estimation<br /> Error for Isolation</html>',...
                                       '<html><center />Learning<br /> Rate</html>',...
                                       '<html><center />Maximum<br /> Interval Value</html>',...
                                       '<html><center />Initial Value of<br /> Source Estimation</html>'})
                                   
                                  
                                   
    set(handles.uitable2,'RowName',[])
    % Column Edit Table
    ColumnEditable='false';
    for i=1:6
        ColumnEditable = strcat({ColumnEditable},' true');
        ColumnEditable = ColumnEditable{1,1};
    end
    set(handles.uitable2,'ColumnEditable',str2num(ColumnEditable));
    
    set(handles.uitable2,'data',data2);   

    set(handles.uitable3,'ColumnName',{'Noise Bound'})
    set(handles.uitable3,'RowName',TableRowName)
    set(handles.uitable3,'ColumnEditable',str2num('true'));
    set(handles.uitable3,'data',data3);
    
else
    
    set(handles.uitable1,'ColumnName',{'DA'})
    set(handles.uitable1,'RowName',{'System'})
    set(handles.uitable1,'ColumnEditable',str2num('true'));
    set(handles.uitable1,'data',CDI.UncertaintiesBound);
    set(handles.uitable2,'ColumnWidth',{100 'auto' 'auto' 'auto' 'auto' 'auto'})
    set(handles.uitable2,'ColumnName',{'<html><center />  </html>',...
                                       '<html><center />Initial Maximum<br /> State Estimation<br /> Error for Detection</html>',...
                                       '<html><center />Initial Maximum<br /> State Estimation<br /> Error for Isolation</html>',...
                                       '<html><center />Learning<br /> Rate</html>',...
                                       '<html><center />Maximum<br /> Interval Value</html>',...
                                       '<html><center />Initial Value of<br /> Source Estimation</html>'})
                                   
                                  
                                   
    set(handles.uitable2,'RowName',[])
    % Column Edit Table
    ColumnEditable='false';
    for i=1:6
        ColumnEditable = strcat({ColumnEditable},' true');
        ColumnEditable = ColumnEditable{1,1};
    end
    set(handles.uitable2,'ColumnEditable',str2num(ColumnEditable));
    colergen = @(color,text) ['<html><table border="0" width=400 bgcolor=',color,'><TR><TD>',text,'</TD></TR> </table></html>'];
    set(handles.uitable2,'data',[{colergen('#F0F0F0','System')}, CDI.Ex0, CDI.Ez0, CDI.LearningRate, CDI.Theta, CDI.InitialSourceEstimation]);   

    set(handles.uitable3,'ColumnName',{'Noise Bound'})
    set(handles.uitable3,'RowName',{'System'})
    set(handles.uitable3,'ColumnEditable',str2num('true'));
    set(handles.uitable3,'data',CDI.NoiseBound);
end

set(handles.WindDirectionEdit, 'String', num2str(CDI.Tolerances.Wd));
set(handles.WindSpeedEdit, 'String', num2str(CDI.Tolerances.Ws));
set(handles.ZoneTemperatureEdit, 'String', num2str(CDI.Tolerances.Ztemp));
set(handles.PathOpeningsEdit, 'String', num2str(CDI.Tolerances.PathsOpenings));
set(handles.MaxIterationEdit, 'String', num2str(CDI.Tolerances.Iterations));
set(handles.LoadFile, 'Enable', 'on');

switch CDI.choice
    case 1 %% Tolerance
        set(handles.TolerancesRadio, 'Value',1); % radio button
        set(handles.FileRadio, 'Value',0); % radio button
        set(handles.WindDirectionEdit, 'Enable', 'on');
        set(handles.WindSpeedEdit, 'Enable', 'on');
        set(handles.ZoneTemperatureEdit, 'Enable', 'on');
        set(handles.PathOpeningsEdit, 'Enable', 'on');
        set(handles.MaxIterationEdit, 'Enable', 'on');
        handles.ScenarioFileEdit.String=handles.CDI.MatricesFile;
        C=strsplit(handles.ScenarioFileEdit.String,'RESULTS\');
        if length(C)>1
            handles.ScenarioFileRunCDI.String=C{2};
        end
         set(handles.ScenarioFileEdit, 'Enable', 'on');
    
    case 2 % Uncertainties Calculated from file            
        set(handles.TolerancesRadio, 'Value',0); % radio button
        set(handles.FileRadio, 'Value',1); % radio button            
        set(handles.WindDirectionEdit, 'Enable', 'off');
        set(handles.WindSpeedEdit, 'Enable', 'off');    
        set(handles.ZoneTemperatureEdit, 'Enable', 'off');
        set(handles.PathOpeningsEdit, 'Enable', 'off');
        set(handles.MaxIterationEdit, 'Enable', 'off');
        
        handles.ScenarioFileEdit.String=handles.CDI.MatricesFile;
        C=strsplit(handles.ScenarioFileEdit.String,'RESULTS\');

        if length(C)>1
            handles.ScenarioFileRunCDI.String=C{2};
        end

         set(handles.ScenarioFileEdit, 'Enable', 'on');
        
end

% Set Nominal matrix for CDI
CDI.Nominal = handles.Amat; 


% This are variables for using other Amat as the nominal. It will be
% used in future update
CDI.NominalChoice = 1;
CDI.NominalFile = ''; 




function setNominalBuildingParameters(handles)

handles.WindDirectionNominalValue.String=num2str(handles.B.WindDirection);
% taking the temperature of one zone only. In future release this should
% give the ability of changing the temperature of each zone separetly since
% this ability is given in create scenario phase
handles.ZoneTemperatureNominalValue.String=num2str(handles.B.Temp(1)); 
handles.WindSpeedNominalValue.String=num2str(handles.B.WindSpeed);
handles.PathOpeningsNominalValue.String=num2str(1);


% --- Executes on button press in LoadFile.
function LoadFile_Callback(hObject, eventdata, handles)
% hObject    handle to LoadFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% load([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');
[filename, pathname] = uigetfile([pwd,'\RESULTS\*.0'], 'Select a Scenarios File (*.0)');
if ~isnumeric(filename)
    set(handles.ScenarioFileEdit, 'String', [pathname, filename])

    handles.file0=filename;
    if exist([pathname,handles.file0],'file')==2
        if ~isempty(handles.file0) 
            load([pathname,handles.file0],'-mat'); % load matrices B and P of the corresponding .0 file
            handles.CDI.MatricesFile = [pathname, filename];
            handles.ScenarioFileRunCDI.String=handles.file0;
            handles.P=P;
            handles.B=B;
            handles.CDI.Nominal=B.A;
            handles.Amat=B.A;
            handles.CDI=SetGuiParameters(handles.CDI,handles);
            setNominalBuildingParameters(handles);
            % Enable Run button
            handles.RunCDI_Button.Enable='on';
            handles.RunCDI_Button.BackgroundColor=[0 1 0];
            if handles.CDI.choice==1 & strcmp(handles.Compute.Enable,'off')
                % Enable buttons
                handles.Compute.Enable='on';
                handles.FileRadio.Enable='on';
                handles.TolerancesRadio.Enable='on';
                handles.WindDirectionEdit.Enable='on';
                handles.WindSpeedEdit.Enable='on';
                handles.ZoneTemperatureEdit.Enable='on';
                handles.PathOpeningsEdit.Enable='on'; 
                handles.MaxIterationEdit.Enable='on';
            end
        else
           
        end
    else
        B.ProjectName=[];
    end
    
guidata(hObject, handles);
end

% --- Executes on button press in LoadAmatrix.
function LoadAmatrix_Callback(hObject, eventdata, handles)
% hObject    handle to LoadAmatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile([pwd,'\RESULTS\*.c*'], 'Select a Scenarios File (*.c*)');
if isempty(filename) ||isempty(pathname)
    return
end
% set(handles.AmatrixFileEdit, 'String', [pathname, filename])
handles.CDI.NominalFile = [pathname, filename];
if exist(handles.CDI.NominalFile,'file')
    load(handles.CDI.NominalFile,'-mat');
    if ~exist('C')
       uiwait(msgbox('The sellected .c* file is incorrect'))
       set(handles.AmatrixFileEdit, 'String','')
    else
        if size(handles.Amat)~= size(C.A)
           uiwait(msgbox('Dimension of Mat File is incorrect'))
           return
        end
            handles.CDI.Nominal = C.A; % Set sellected scenario Amat as the Nominal
            C=strsplit(filename,'.')
            handles.ScenarioFileRunCDI.String=[C{1} '.0'];
    end
end
guidata(hObject, handles);

function AmatrixFileEdit_Callback(hObject, eventdata, handles)
% hObject    handle to AmatrixFileEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmatrixFileEdit as text
%        str2double(get(hObject,'String')) returns contents of AmatrixFileEdit as a double


% --- Executes during object creation, after setting all properties.
function AmatrixFileEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmatrixFileEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in TolerancesRadio.
function TolerancesRadio_Callback(hObject, eventdata, handles)
% hObject    handle to TolerancesRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TolerancesRadio

set(handles.FileRadio, 'Value',0);
set(handles.WindDirectionEdit, 'Enable', 'on');
set(handles.WindSpeedEdit, 'Enable', 'on');    
set(handles.ZoneTemperatureEdit, 'Enable', 'on');
set(handles.PathOpeningsEdit, 'Enable', 'on');
set(handles.MaxIterationEdit, 'Enable', 'on');
% set(handles.ScenarioFileEdit, 'Enable', 'off');
% set(handles.LoadFile, 'Enable', 'off');
handles.CDI.choice = 1;
guidata(hObject, handles);


% --- Executes on button press in FileRadio.
function FileRadio_Callback(hObject, eventdata, handles)
% hObject    handle to FileRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FileRadio
set(handles.TolerancesRadio, 'Value',0);
set(handles.WindDirectionEdit, 'Enable', 'off');
set(handles.WindSpeedEdit, 'Enable', 'off');    
set(handles.ZoneTemperatureEdit, 'Enable', 'off');
set(handles.PathOpeningsEdit, 'Enable', 'off');
set(handles.MaxIterationEdit, 'Enable', 'off');
% set(handles.ScenarioFileEdit, 'Enable', 'on');
% set(handles.LoadFile, 'Enable', 'on');
handles.CDI.choice = 2;
guidata(hObject, handles);


function WindDirectionEdit_Callback(hObject, eventdata, handles)
% hObject    handle to WindDirectionEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WindDirectionEdit as text
%        str2double(get(hObject,'String')) returns contents of WindDirectionEdit as a double

if  isempty(get(handles.WindDirectionEdit, 'String'))
    set(handles.WindDirectionEdit, 'String','0')
    uiwait(msgbox('     Give A Valid Number', 'Error', 'error'))
    return
end

if  isempty(str2num(get(handles.WindDirectionEdit, 'String')))
    set(handles.WindDirectionEdit, 'String','0')
    uiwait(msgbox('     Give A Valid Number', 'Error', 'error'))
    return
end

if (str2double(get(handles.WindDirectionEdit, 'String'))<0)|| (str2double(get(handles.WindDirectionEdit, 'String'))>360)
    set(handles.WindDirectionEdit, 'String','0')
    uiwait(msgbox('Wind Direction must be 0-360 deg', 'Error', 'error'))
    return
end

handles.CDI.Tolerances.Wd = str2double(get(handles.WindDirectionEdit, 'String'));

set(handles.WindDirectionEdit, 'Enable', 'off');
set(handles.WindDirectionEdit, 'Enable', 'on');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function WindDirectionEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WindDirectionEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WindSpeedEdit_Callback(hObject, eventdata, handles)
% hObject    handle to WindSpeedEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WindSpeedEdit as text
%        str2double(get(hObject,'String')) returns contents of WindSpeedEdit as a double
if  isempty(get(handles.WindSpeedEdit, 'String'))
    set(handles.WindSpeedEdit, 'String','0')
    uiwait(msgbox('     Give A Valid Number', 'Error', 'error'))
    return
end

if  isempty(str2num(get(handles.WindSpeedEdit, 'String')))
    set(handles.WindSpeedEdit, 'String','0')
    uiwait(msgbox('     Give A Valid Number', 'Error', 'error'))
    return
end

if  str2num(get(handles.WindSpeedEdit, 'String'))<0
    set(handles.WindSpeedEdit, 'String','0')
    uiwait(msgbox('     Give A Valid Number', 'Error', 'error'))
    return
end

handles.CDI.Tolerances.Ws = str2double(get(handles.WindSpeedEdit, 'String'));

set(handles.WindSpeedEdit, 'Enable', 'off');
set(handles.WindSpeedEdit, 'Enable', 'on');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function WindSpeedEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WindSpeedEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ZoneTemperatureEdit_Callback(hObject, eventdata, handles)
% hObject    handle to ZoneTemperatureEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ZoneTemperatureEdit as text
%        str2double(get(hObject,'String')) returns contents of ZoneTemperatureEdit as a double
if  isempty(get(handles.ZoneTemperatureEdit, 'String'))
    set(handles.ZoneTemperatureEdit, 'String','0')
    uiwait(msgbox('     Give A Valid Number', 'Error', 'error'))
    return
end

if  isempty(str2num(get(handles.ZoneTemperatureEdit, 'String')))
    set(handles.ZoneTemperatureEdit, 'String','0')
    uiwait(msgbox('     Give A Valid Number', 'Error', 'error'))
    return
end

if  str2num(get(handles.ZoneTemperatureEdit, 'String'))<0
    set(handles.ZoneTemperatureEdit, 'String','0')
    uiwait(msgbox('     Give A Valid Number', 'Error', 'error'))
    return
end

handles.CDI.Tolerances.Ztemp = str2double(get(handles.ZoneTemperatureEdit, 'String'));

set(handles.ZoneTemperatureEdit, 'Enable', 'off');
set(handles.ZoneTemperatureEdit, 'Enable', 'on');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ZoneTemperatureEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ZoneTemperatureEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PathOpeningsEdit_Callback(hObject, eventdata, handles)
% hObject    handle to PathOpeningsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PathOpeningsEdit as text
%        str2double(get(hObject,'String')) returns contents of PathOpeningsEdit as a double

if  isempty(get(handles.PathOpeningsEdit, 'String'))
    set(handles.PathOpeningsEdit, 'String','0')
    uiwait(msgbox('     Give A Valid Number', 'Error', 'error'))
    return
end

if  isempty(str2num(get(handles.PathOpeningsEdit, 'String')))
    set(handles.PathOpeningsEdit, 'String','0')
    uiwait(msgbox('     Give A Valid Number', 'Error', 'error'))
    return
end

if  str2num(get(handles.PathOpeningsEdit, 'String'))<0 || (str2double(get(handles.PathOpeningsEdit, 'String'))>100)
    set(handles.PathOpeningsEdit, 'String','0')
    uiwait(msgbox('Path Opening Tolerances must be 0-100 %', 'Error', 'error'))
    return
end

handles.CDI.Tolerances.PathsOpenings = str2double(get(handles.PathOpeningsEdit, 'String'));

set(handles.PathOpeningsEdit, 'Enable', 'off');
set(handles.PathOpeningsEdit, 'Enable', 'on');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function PathOpeningsEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PathOpeningsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MaxIterationEdit_Callback(hObject, eventdata, handles)
% hObject    handle to MaxIterationEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MaxIterationEdit as text
%        str2double(get(hObject,'String')) returns contents of MaxIterationEdit as a double

if  isempty(get(handles.MaxIterationEdit, 'String'))
    set(handles.MaxIterationEdit, 'String','1')
    uiwait(msgbox('     Give A Valid Number', 'Error', 'error'))
    return
end

if  isempty(str2num(get(handles.MaxIterationEdit, 'String')))
    set(handles.MaxIterationEdit, 'String','1')
    uiwait(msgbox('     Give A Valid Number', 'Error', 'error'))
    return
end

if  (str2num(get(handles.MaxIterationEdit, 'String'))<1) || ~isequal(mod(str2num(get(handles.MaxIterationEdit, 'String')),1),0)
    set(handles.MaxIterationEdit, 'String','1')
    uiwait(msgbox('Give a positive integer number', 'Error', 'error'))
    return
end

handles.CDI.Tolerances.Iterations = str2double(get(handles.MaxIterationEdit, 'String'));

set(handles.MaxIterationEdit, 'Enable', 'off');
set(handles.MaxIterationEdit, 'Enable', 'on');
guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function MaxIterationEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxIterationEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data1 = get(handles.uitable1, 'Data');
data2 = get(handles.uitable2, 'Data');
data3 = get(handles.uitable3, 'Data');

% Here the system parameters if the system is centralized they are saved in handles.CDI whereas 
% if the system is considered distributed they are saved into
% handles.CDI.sybsystem{i}. 
if handles.CDI.ActiveDistributed                  
        
    for i= 1:handles.CDI.nSub
        handles.CDI.SubsystemsData{i}.UncertaintiesBound = data1(i,1);
        handles.CDI.SubsystemsData{i}.UncertaintiesBound2 = data1(i,2);
        handles.CDI.SubsystemsData{i}.Ex0 = cell2mat(data2(i,2));
        handles.CDI.SubsystemsData{i}.Ez0 = cell2mat(data2(i,3));
        handles.CDI.SubsystemsData{i}.LearningRate = cell2mat(data2(i,4));
        handles.CDI.SubsystemsData{i}.Theta = cell2mat(data2(i,5));
        handles.CDI.SubsystemsData{i}.InitialSourceEstimation = cell2mat(data2(i,6));
        handles.CDI.SubsystemsData{i}.NoiseBound = data3(i,1);


    end
else
    handles.CDI.UncertaintiesBound = data1(1,1);
    
    handles.CDI.Ex0 = cell2mat(data2(1,2));
    handles.CDI.Ez0 = cell2mat(data2(1,3));
    handles.CDI.LearningRate = cell2mat(data2(1,4));
    handles.CDI.Theta = cell2mat(data2(1,5));
    handles.CDI.InitialSourceEstimation = cell2mat(data2(1,6));

    handles.CDI.NoiseBound = data3(1,1);
    
end

guidata(hObject, handles);
uiresume
% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.CDI = handles.CDI0;
guidata(hObject, handles);
uiresume




function ScenarioFileEdit_Callback(hObject, eventdata, handles)
% hObject    handle to ScenarioFileEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ScenarioFileEdit as text
%        str2double(get(hObject,'String')) returns contents of ScenarioFileEdit as a double


% --- Executes during object creation, after setting all properties.
function ScenarioFileEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ScenarioFileEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Compute.
function Compute_Callback(hObject, eventdata, handles)
% hObject    handle to Compute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.CDIParametersGUI3.Pointer='watch';

CDI = handles.CDI;
B = handles.B;

if CDI.ActiveDistributed
    switch CDI.choice
        case 1
            progressbar2('Calculating Uncertainty Bounds'); 

            for i=1:CDI.Tolerances.Iterations
                Openings = B.Openings;
                for j=1:B.nPaths
                    Openings(j) = 1 + unifrnd(-CDI.Tolerances.PathsOpenings,CDI.Tolerances.PathsOpenings)/100;
                end
                ZoneTemperature = B.Temp + unifrnd(-CDI.Tolerances.Ztemp,CDI.Tolerances.Ztemp,1,B.nZones);

                WindDirection = B.WindDirection + unifrnd(-CDI.Tolerances.Wd,CDI.Tolerances.Wd);
                if WindDirection < 0 % wind direction must be between 0 - 360 deg
                    WindDirection = 360 + WindDirection;
                end

                WindSpeed = B.WindSpeed + unifrnd(-CDI.Tolerances.Ws,CDI.Tolerances.Ws);
                pause(0.8)
                [Amat,~,~] = computeAmatrix(B,WindDirection,...
                                                   WindSpeed,...
                                                   B.AmbientTemperature,...
                                                   B.AmbientPressure,...
                                                   B.v,...
                                                   ZoneTemperature,...
                                                   Openings);                               
                DA = CDI.Nominal - Amat;
                for j=1:CDI.nSub
                    indx = 1:B.nZones;
                    indx(CDI.Subsystems{1,j})=[];
                    Da(j,i) = norm(DA(CDI.Subsystems{1,j},CDI.Subsystems{1,j}));
                    Dh(j,i) = norm(DA(CDI.Subsystems{1,j},indx));
                end
                if isempty(findobj('Tag','ProgressBar'))
                    handles.CDIParametersGUI3.Pointer='arrow';
                    return
                end
                progressbar2(i / CDI.Tolerances.Iterations)
            end
            for j=1:CDI.nSub
                CDI.SubsystemsData{1,j}.UncertaintiesBound = max(Da(j,:));
                data1(j,1) = max(Da(j,:));
                CDI.SubsystemsData{1,j}.UncertaintiesBound2 = max(Dh(j,:));
                data1(j,2) = max(Dh(j,:));
            end
            set(handles.uitable1,'data',data1);

        case 2
            if  isempty(get(handles.ScenarioFileEdit, 'String'))
                uiwait(msgbox('Give mat file', 'Error', 'error'))
                handles.CDIParametersGUI3.Pointer='arrow';
                return
           end 

           if ~exist(CDI.MatricesFile,'file')
               uiwait(msgbox('      File No Exist', 'Error', 'error'))
               handles.CDIParametersGUI3.Pointer='arrow';
               return
           end
           
           load(CDI.MatricesFile,'-mat');
           nScnr = prod(cell2mat(P.FlowSamples)); % # of flow scenarios
           sz = length(CDI.MatricesFile);

           for i = 1:nScnr
               clear File
               File = [CDI.MatricesFile(1:sz-1),'c',num2str(i)];
               if ~exist(File,'file')
                   uiwait(msgbox(['      The file "', File, '" no exist'], 'Error', 'error'))
                   handles.CDIParametersGUI3.Pointer='arrow';
                   return
               end

               load(File,'-mat'); % load the A-matrix file 

               if size(CDI.Nominal)~= size(C.A)
                   uiwait(msgbox('Dimension of Mat File is incorrect'))
                   handles.CDIParametersGUI3.Pointer='arrow';
                   return
               end          

               DA = CDI.Nominal - C.A;
               for j=1:CDI.nSub
                   indx = 1:B.nZones;
                   indx(CDI.Subsystems{1,j})=[];
                   Da(j,i) = norm(DA(CDI.Subsystems{1,j},CDI.Subsystems{1,j}));
                   Dh(j,i) = norm(DA(CDI.Subsystems{1,j},indx));
               end
               
           end
           for j=1:CDI.nSub
               CDI.SubsystemsData{1,j}.UncertaintiesBound = max(Da(j,:));
               data1(j,1) = max(Da(j,:));
               CDI.SubsystemsData{1,j}.UncertaintiesBound2 = max(Dh(j,:)); 
               data1(j,2) = max(Dh(j,:));
           end
           set(handles.uitable1,'data',data1);
    end    
else
    switch CDI.choice
        case 1
            progressbar2('Calculating Uncertainty Bounds'); 

            for i=1:CDI.Tolerances.Iterations
                
                Openings = B.Openings;
                for j=1:B.nPaths
                    Openings(j) = 1 + unifrnd(-CDI.Tolerances.PathsOpenings,CDI.Tolerances.PathsOpenings)/100;
                end
                ZoneTemperature = B.Temp + unifrnd(-CDI.Tolerances.Ztemp,CDI.Tolerances.Ztemp,1,B.nZones);

                WindDirection = B.WindDirection + unifrnd(-CDI.Tolerances.Wd,CDI.Tolerances.Wd);
                if WindDirection < 0 % wind direction must be between 0 - 360 deg
                    WindDirection = 360 + WindDirection;
                end

                WindSpeed = B.WindSpeed + unifrnd(-CDI.Tolerances.Ws,CDI.Tolerances.Ws);
%                 pause(0.5) %% Not needed pause
                [Amat Qext Flows] = computeAmatrix(B,WindDirection,...
                                                   WindSpeed,...
                                                   B.AmbientTemperature,...
                                                   B.AmbientPressure,...
                                                   B.v,...
                                                   ZoneTemperature,...
                                                   Openings);

                DA(i) = norm(CDI.Nominal - Amat);
                if isempty(findobj('Tag','ProgressBar'))
                    handles.CDIParametersGUI3.Pointer='arrow';
                    return
                end
                progressbar2(i / CDI.Tolerances.Iterations)
            end
            
            CDI.UncertaintiesBound = max(DA);
            data1(1,1) = max(DA);
            set(handles.uitable1,'data',data1);
        case 2
            if  isempty(get(handles.ScenarioFileEdit, 'String'))
                uiwait(msgbox('Give mat file', 'Error', 'error'))
                handles.CDIParametersGUI3.Pointer='arrow';
                return
           end 

           if ~exist(CDI.MatricesFile,'file')
               uiwait(msgbox('      File No Exist', 'Error', 'error'))
               handles.CDIParametersGUI3.Pointer='arrow';
               return
           end
           
           load(CDI.MatricesFile,'-mat');
           nScnr = prod(cell2mat(P.FlowSamples)); % # of flow scenarios
           sz = length(CDI.MatricesFile);

           for i = 1:nScnr
               clear File
               File = [CDI.MatricesFile(1:sz-1),'c',num2str(i)];
               if ~exist(File,'file')
                   uiwait(msgbox(['      The file "', File, '" no exist'], 'Error', 'error'))
                   handles.CDIParametersGUI3.Pointer='arrow';
                   return
               end

               load(File,'-mat'); % load the A-matrix file 

               if size(CDI.Nominal)~= size(C.A)
                   uiwait(msgbox('Dimension of Mat File is incorrect'))
                   handles.CDIParametersGUI3.Pointer='arrow';
                   return
               end          

               DA(i) = norm(CDI.Nominal - C.A);
           end
           CDI.UncertaintiesBound = max(DA);
           data1(1,1) = max(DA);
           set(handles.uitable1,'data',data1);
    end
       
end

% In case the handles.file0 is empty from the initialization of the gui
if isempty(handles.file0)
 C=strsplit(handles.ScenarioFileEdit.String,'\RESULTS');
handles.file0=C{2};
end
     
C=strsplit(handles.ScenarioFileEdit.String,handles.file0);
pathname=C{1};

file0=handles.file0;
save([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');
save([pwd,'\RESULTS\','File0.File'],'file0','-mat');


handles.CDI = CDI;
guidata(hObject, handles);
handles.CDIParametersGUI3.Pointer='arrow';

% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in uitable2.
function uitable2_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable2 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in uitable3.
function uitable3_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable3 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in RunCDI_Button.
function RunCDI_Button_Callback(hObject, eventdata, handles)
% hObject    handle to RunCDI_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.ScenarioFileRunCDI.String)
     uiwait(msgbox('     Please Select a Scenario File', 'Error', 'error'))
     handles.CDIParametersGUI3.Pointer='arrow';
    return
else
    
    load([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');
    if ~strcmp(pathname,[pwd,'\RESULTS\'])
        pathname=[pwd,'\RESULTS\'];
        save([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');
    end
    if exist('File0.File','file')==2 
        load([pwd,'\RESULTS\','File0.File'],'-mat');
        C=strsplit(file0,'.');
        if length(C)<2
            file0=[file0 '.0'];
        end
        handles.file0=file0(1:end-2);
        if exist([pwd,'\RESULTS\',[handles.file0 '.0']],'file')==2
            if ~isempty(handles.file0) 
                 load([pwd,'\RESULTS\',handles.file0 '.0'],'-mat');
                handles.ScenarioFileRunCDI.String=[handles.file0 '.0'];
                handles.P=P;
                hanldes.B=B;
            else

            end
        else
            B.ProjectName=[];
            errordlg('Scenario File cannot be found','File Error');
            return
        end
    else
        file0=[];
    end
end
data1 = get(handles.uitable1, 'Data');
data2 = get(handles.uitable2, 'Data');
data3 = get(handles.uitable3, 'Data');


if isempty(file0)
    errordlg('Scenario File cannot be found','File Error');
   return
end

% Here the system parameters if the system is centralized they are saved in handles.CDI whereas 
% if the system is considered distributed they are saved into
% handles.CDI.sybsystem{i}. 
if handles.CDI.ActiveDistributed                  
        
    for i= 1:handles.CDI.nSub
        handles.CDI.SubsystemsData{i}.UncertaintiesBound = data1(i,1);
        handles.CDI.SubsystemsData{i}.UncertaintiesBound2 = data1(i,2);
        handles.CDI.SubsystemsData{i}.Ex0 = cell2mat(data2(i,2));
        handles.CDI.SubsystemsData{i}.Ez0 = cell2mat(data2(i,3));
        handles.CDI.SubsystemsData{i}.LearningRate = cell2mat(data2(i,4));
        handles.CDI.SubsystemsData{i}.Theta = cell2mat(data2(i,5));
        handles.CDI.SubsystemsData{i}.InitialSourceEstimation = cell2mat(data2(i,6));
        handles.CDI.SubsystemsData{i}.NoiseBound = data3(i,1);

    end
    handles.CDI0 = handles.CDI;
    handles.B = handles.B;
    % Run Distributed CDI
    exitflag=RunMultipleDistributedCDI(handles);
    if  exitflag==-1
%         warndlg('Some results may have allready been saved.','!! Warning !!')
        handles.CDIParametersGUI3.Pointer='arrow';
        return
    end
    % Exitflag==2 -> error oqqured during execution
    if exitflag==-2
      handles.CDIParametersGUI3.Pointer='arrow';
      return
    end
    [im, map, alpha] = imread('Green_tick.png');
    f=msgbox(['The CDI simulation is completed. The results have been saved in  "\Results\', file0(1:end-2),'_Distributed.cdi#".'],'Success','custom',im, map);
    f.Children(2).Children.AlphaData=alpha;
%     f.Children
    uiwait(f)

    
else
    handles.CDI.UncertaintiesBound = data1(1,1);
    
    handles.CDI.Ex0 = cell2mat(data2(1,2));
    handles.CDI.Ez0 = cell2mat(data2(1,3));
    handles.CDI.LearningRate = cell2mat(data2(1,4));
    handles.CDI.Theta = cell2mat(data2(1,5));
    handles.CDI.InitialSourceEstimation = cell2mat(data2(1,6));

    handles.CDI.NoiseBound = data3(1,1);
    
    handles.CDI0 = handles.CDI;
    handles.B = handles.B;
    
    % Run Centralized CDI
    exitflag=RunMultipleCDI(handles);
     if  exitflag==-1
%          warndlg('Some results may have allready been saved','!! Warning !!')
        handles.CDIParametersGUI3.Pointer='arrow';
        return
     end
    if exitflag==-2
      handles.CDIParametersGUI3.Pointer='arrow';
      return
    end
   [im, map, alpha] = imread('Green_tick.png');
%    im=imread('Green_tick.png');
    f=msgbox(['The CDI simulation is completed. The results have been saved in  "\Results\', file0(1:end-2),'_Centralized.cdi#".'],'Success','custom',im, map);
    f.Children(2).Children.AlphaData=alpha;
%     f.Children
    uiwait(f)
    
end

guidata(hObject, handles);


uiresume


% --- Executes on button press in LoadScenarioFileRunCDI_Button.
function LoadScenarioFileRunCDI_Button_Callback(hObject, eventdata, handles)
% hObject    handle to LoadScenarioFileRunCDI_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    [file0,pathNM] = uigetfile([pwd,'\RESULTS\','*.0'],'Select the MATLAB *.0 file');
   
    if length(pathNM)~=1
        pathname=pathNM;
    end
    
   
    if isnumeric(file0(1:end-2))
        file0=[];
    end
    
    if ~isempty((file0)) 
        save([pwd,'\RESULTS\','File0.File'],'file0','-mat');
        load([pathname,file0(1:end-2),'.0'],'-mat');
        handles.file0=file0(1:end-2);
        if ~strcmp(handles.B.ProjectName,B.ProjectName)
            set(handles.Start,'enable','off');
            msgbox(['        Wrong File "',file0(1:end-2),'.0"'],'Error','modal');
            set(handles.FileText,'String','')
        else
%             set(handles.Start,'enable','on');
            set(handles.ScenarioFileRunCDI,'String',[handles.file0,'.0'])
             % Enable Run button
            handles.RunCDI_Button.Enable='on';
            handles.RunCDI_Button.BackgroundColor=[0 1 0];
        end
        handles.P=P;
        hanldes.B=B;
        
        % Update handles structure
        guidata(hObject, handles);
    end
    save([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');
    
      ScenarioFile=strsplit(handles.ScenarioFileEdit.String,'.');
    if ~strcmp([pathNM,file0(1:end-2)],ScenarioFile{1})
        uiwait(warndlg('The selected scenario file does not correspond to the ScenarioFile File selected above for the uncertainty calculation.','!! Warning !!','modal'))
    end


% --- Executes when user attempts to close CDIParametersGUI3.
function CDIParametersGUI3_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to CDIParametersGUI3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, call UIRESUME
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end



function WindSpeedNominalValue_Callback(hObject, eventdata, handles)
% hObject    handle to WindSpeedNominalValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WindSpeedNominalValue as text
%        str2double(get(hObject,'String')) returns contents of WindSpeedNominalValue as a double


% --- Executes during object creation, after setting all properties.
function WindSpeedNominalValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WindSpeedNominalValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ZoneTemperatureNominalValue_Callback(hObject, eventdata, handles)
% hObject    handle to ZoneTemperatureNominalValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ZoneTemperatureNominalValue as text
%        str2double(get(hObject,'String')) returns contents of ZoneTemperatureNominalValue as a double


% --- Executes during object creation, after setting all properties.
function ZoneTemperatureNominalValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ZoneTemperatureNominalValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WindDirectionNominalValue_Callback(hObject, eventdata, handles)
% hObject    handle to WindDirectionNominalValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WindDirectionNominalValue as text
%        str2double(get(hObject,'String')) returns contents of WindDirectionNominalValue as a double


% --- Executes during object creation, after setting all properties.
function WindDirectionNominalValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WindDirectionNominalValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PathOpeningsNominalValue_Callback(hObject, eventdata, handles)
% hObject    handle to PathOpeningsNominalValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PathOpeningsNominalValue as text
%        str2double(get(hObject,'String')) returns contents of PathOpeningsNominalValue as a double


% --- Executes during object creation, after setting all properties.
function PathOpeningsNominalValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PathOpeningsNominalValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
