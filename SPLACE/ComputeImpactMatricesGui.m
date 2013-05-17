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


    if exist([handles.file0,'.0'],'file')
        if ~isempty([handles.file0,'.0']) 
            load([handles.file0,'.0'],'-mat');
        else
            B.filename=handles.B.filename;
        end
    else
        B.filename=[];
    end

    if ~strcmp(handles.B.filename,B.filename)
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

    set(handles.load,'enable','on');
    handles.str='Compute Impact Matrix';
    set(handles.figure1,'name',handles.str);
    % Update handles structure
    guidata(hObject, handles);

    
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
     ZoneTable=[0.5, 0.1, 0.2, 4, 4, 0.2, 0.5, 1 ,...
         1, 0.1 , 0.1, 0.1, 0.2, 1];
    
    set(handles.ZoneTable,'data',ZoneTable);

% --- Outputs from this function are returned to the command line.
function varargout = ComputeImpactMatricesGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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
    
    set(handles.start,'enable','off');
    set(handles.load,'enable','off');
    
    handles.ZoneOccupancy = get(handles.ZoneTable,'data');
    % Update handles structure
    guidata(hObject, handles);
    
    ComputeImpactMatrices(handles)
    msgbox(['        Compute Impact Matrix in file "',handles.file0,'.w"']);

    
    pause(0.1);
    close(handles.str);
    
% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    [file0,pathName] = uigetfile('*.0','Select the MATLAB *.0 file');
    file0=[pathName,file0];
    file0=file0(1:end-2);
    
    if isnumeric(file0)
        file0=[];
    end
    if ~isempty((file0)) 
        load([file0,'.0'],'-mat');
        handles.file0=file0;
        if ~strcmp(handles.B.filename,B.filename) %|| ~exist([handles.file0,'.w'],'file')
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
    
