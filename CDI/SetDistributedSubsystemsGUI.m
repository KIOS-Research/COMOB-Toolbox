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
function varargout = SetDistributedSubsystemsGUI(varargin)
% SETDISTRIBUTEDSUBSYSTEMSGUI MATLAB code for SetDistributedSubsystemsGUI.fig
%      SETDISTRIBUTEDSUBSYSTEMSGUI, by itself, creates a new SETDISTRIBUTEDSUBSYSTEMSGUI or raises the existing
%      singleton*.
%
%      H = SETDISTRIBUTEDSUBSYSTEMSGUI returns the handle to a new SETDISTRIBUTEDSUBSYSTEMSGUI or the handle to
%      the existing singleton*.
%
%      SETDISTRIBUTEDSUBSYSTEMSGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETDISTRIBUTEDSUBSYSTEMSGUI.M with the given input arguments.
%
%      SETDISTRIBUTEDSUBSYSTEMSGUI('Property','Value',...) creates a new SETDISTRIBUTEDSUBSYSTEMSGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SetDistributedSubsystemsGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SetDistributedSubsystemsGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SetDistributedSubsystemsGUI

% Last Modified by GUIDE v2.5 07-Nov-2017 17:13:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SetDistributedSubsystemsGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @SetDistributedSubsystemsGUI_OutputFcn, ...
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


% --- Executes just before SetDistributedSubsystemsGUI is made visible.
function SetDistributedSubsystemsGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SetDistributedSubsystemsGUI (see VARARGIN)

% Choose default command line output for SetDistributedSubsystemsGUI
handles.output = hObject;

handles.CDI = varargin{1}.CDI;
handles.B = varargin{1}.B;
handles.AllPossiblePartitions=varargin{1}.AllPossiblePartitions;
% Flag that indicates whether the subsystems have been saved(1) or not(0)
handles.SaveSubFlag=0;

if ~isempty(handles.CDI.Subsystems{1})
    set(handles.NumberSystemsEdit,'String',length(handles.CDI.Subsystems))
    for i = 1:length(handles.CDI.Subsystems)
        data{i,1} = i;
        data{i,2} = mat2str(handles.CDI.Subsystems{i});         
    end
    set(handles.uitable1, 'Data', data);
else
    set(handles.NumberSystemsEdit,'String',num2str(2))
    handles.CDI.nSub = 2;
    for i = 1:handles.CDI.nSub
        data{i,1} = i;
        data{i,2} = '';         
    end
    set(handles.uitable1, 'Data', data);
end

if isfield(handles,'AllPossiblePartitions')
    if length(handles.AllPossiblePartitions)>=str2num(handles.NumberSystemsEdit.String)
       handles.listbox1.String=handles.AllPossiblePartitions{str2num(handles.NumberSystemsEdit.String)};
    end
end

% Select Distributed automatically
if ~handles.CDI.ActiveDistributed
    handles.CDI.ActiveDistributed = 1;    
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SetDistributedSubsystemsGUI wait for user response (see UIRESUME)
% uiwait(handles.SetDistributedSubsystemsGUI);
uiwait

% --- Outputs from this function are returned to the command line.
function varargout = SetDistributedSubsystemsGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = handles.output;
varargout{2}.CDI = handles.CDI;
varargout{2}.B = handles.B;
varargout{3}= handles.AllPossiblePartitions;

delete(hObject);

% --- Executes on button press in ActiveDistributedRadio.
function ActiveDistributedRadio_Callback(hObject, eventdata, handles)
% hObject    handle to ActiveDistributedRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ActiveDistributedRadio
if get(handles.ActiveDistributedRadio,'Value')
    handles.CDI.ActiveDistributed = 1;
    set(handles.NumberSystemsEdit, 'Enable', 'on')
    set(handles.uitable1, 'Enable', 'on');
else
    handles.CDI.ActiveDistributed = 0;
    set(handles.NumberSystemsEdit, 'Enable', 'off')
    set(handles.uitable1, 'Enable', 'off');
end

% Update handles structure
guidata(hObject, handles);

function NumberSystemsEdit_Callback(hObject, eventdata, handles)
% hObject    handle to NumberSystemsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumberSystemsEdit as text
%        str2double(get(hObject,'String')) returns contents of NumberSystemsEdit as a double

str = get(handles.NumberSystemsEdit,'String');
 if all(ismember(str,'0123456789'))
     if str2double(str)<=handles.B.nZones && str2double(str)>= 2
         handles.CDI.nSub = str2double(str);
      
         for i = 1:handles.CDI.nSub
             data{i,1} = i;
             data{i,2} = '';
             row_names{i}=['Subsystem ' num2str(i)];
         end
         set(handles.uitable1, 'Data', data);
         handles.uitable1.RowName=row_names;
         if isfield(handles,'AllPossiblePartitions')
            if length(handles.AllPossiblePartitions)>=str2num(handles.NumberSystemsEdit.String)
               handles.listbox1.String=handles.AllPossiblePartitions{str2num(handles.NumberSystemsEdit.String)};
            else
               handles.listbox1.String='Possible Partitions';
            end
        end
        
             
     else
         set(handles.NumberSystemsEdit,'String','');
         uiwait(msgbox('Give a Number greater than 2 and less than number of Zones', 'Error', 'error'))
         return
     end
 else
     set(handles.NumberSystemsEdit,'String','');
     uiwait(msgbox('Give a valid number', 'Error', 'error'))
     return
 end

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function NumberSystemsEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumberSystemsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on "Save Selection" button press in OK.
function SaveSelection_Callback(hObject, eventdata, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.CDI.ActiveDistributed
    
    data = get(handles.uitable1, 'Data');

    for i = 1:length(data)
        if isempty(str2num(data{i,2}))
            uiwait(msgbox(sprintf('Specify the Zones for Subsystem %d',i), 'Error', 'error'))
            return       
        end   
    end

    checkZones = [];
    for i = 1:length(data)
        handles.CDI.Subsystems{i}=[];
        Zones = str2num(data{i,2});
        for j = 1:length(Zones)
            handles.CDI.Subsystems{i}(1,j) = Zones(j);
        end
        checkZones = [checkZones handles.CDI.Subsystems{i}(1,:)];

        ClrOrder(i,:) = rand(1,3);
        while ~(size(ClrOrder,1)==size(fix(unique(ClrOrder*1000,'rows')),1))    
            ClrOrder(i,:) = rand(1,3);
        end
        handles.B.Decomposition(handles.CDI.Subsystems{i}(1,:),:) = ones(length(Zones),1)*ClrOrder(i,:);
        handles.CDI.SubsystemsData{i} = handles.CDI.SubsystemsData{1};
    end

    if ~(length(checkZones)==length(unique(checkZones)))
        uiwait(msgbox('A Zone must be unique in a Subsystem', 'Error', 'error'))
        return   
    end

    if ~(length(checkZones)==handles.B.nZones)
       uiwait(msgbox('Each Zone should correspond to a Subsystem', 'Error', 'error'))
       return     
    end
    handles.SaveSubFlag=1;
else
    for i=1:handles.B.nZones         
        handles.B.Decomposition(i,:) = [0 0 0]; 
    end
end


% Update handles structure
guidata(hObject, handles);

uiresume

% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles.CDI.Subsystems{1})
    handles.CDI.nSub = 0;
    % Update handles structure
    guidata(hObject, handles);
end

uiresume


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

data0 = get(handles.uitable1, 'Data');
data = get(handles.uitable1, 'Data');

for i = 1:length(data)
    if isempty(str2num(data{i,2}))
        data{i,2}='';        
    end   
end

for i = 1:length(data)
    if ~isempty(str2num(data{i,2}))
        if min(~mod(str2num(data{i,2}),1)) && min(str2num(data{i,2})>0) 
        else
            data{i,2}='';
            set(handles.uitable1, 'Data', data);
            msgbox('Give a positive integer number', 'Error', 'error')
            return
        end        
    else
        if ~isempty(data0{i,2})
            set(handles.uitable1, 'Data', data);
            msgbox('Give a valid number', 'Error', 'error')
            return
        end
    end   
end


% --- Executes when user attempts to close SetDistributedSubsystemsGUI.
function SetDistributedSubsystemsGUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to SetDistributedSubsystemsGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.SaveSubFlag==0
    choice = questdlg('No subsystem configuration has been saved. Do you wish to continue?','Warning!','Yes','No','No');
% Handle response
    switch choice
        case 'Yes'
            if isempty(handles.CDI.Subsystems{1})
                handles.CDI.nSub = 0;
                % Update handles structure
                guidata(hObject, handles);
            end
            uiresume
        case 'No'
            return
    end
else
    if isempty(handles.CDI.Subsystems{1})
        handles.CDI.nSub = 0;
        % Update handles structure
        guidata(hObject, handles);
    end
   uiresume
end
% Hint: delete(hObject) closes the figure




% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.listbox1.Value;

s=handles.listbox1.String{handles.listbox1.Value};
ind_temp=find(s==' ');
s=s(ind_temp(1):end);

C = strsplit(s,' ; ');

for i=1:handles.CDI.nSub
    str=str2num(C{i});
    data{i,1} = i;
    data{i,2} = mat2str(str);
%     handles.CDI.Subsystems{i} = str;
end
% for i = 1:handles.CDI.nSub
%         
%                  
%     end
    set(handles.uitable1, 'Data', data);

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ComputeAllPartitioningSolutions_button.
function ComputeAllPartitioningSolutions_button_Callback(hObject, eventdata, handles)
% hObject    handle to ComputeAllPartitioningSolutions_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 handles.SetDistributedSubsystemsGUI.Pointer='watch';
         
         % compute valid partitioning solutions
         [p,exitflag]=SetPartition(length(handles.B.A),handles.CDI.nSub,handles.B.A);
         
         handles.SetDistributedSubsystemsGUI.Pointer='arrow';
         if exitflag==-1
             return;
         end
         
         list_data={};
         for i=1:length(p)
              s_ini=[];
              s=[];
             for j=1:length(p{i})
                 s_temp=[];
                 for k=1:length(p{i}{j})-1
                    s_temp=[s_temp sprintf('%d,',p{i}{j}(k))];
                 end
                s=[s_ini '[' s_temp num2str(p{i}{j}(end)) ']'];
                if j~=length(p{i})
                    s=[s ' ; '];
                end
                s_ini=s;
             end
             s=['P' num2str(i) ': ' s];
             list_data{i}=[s];
         end

          handles.listbox1.String=list_data;
          
         handles.AllPossiblePartitions{str2num(handles.NumberSystemsEdit.String)}=list_data;
guidata(hObject, handles);

          
         
