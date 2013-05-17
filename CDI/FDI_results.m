function varargout = FDI_results(varargin)
% FDI_RESULTS MATLAB code for FDI_results.fig
%      FDI_RESULTS, by itself, creates a new FDI_RESULTS or raises the existing
%      singleton*.
%
%      H = FDI_RESULTS returns the handle to a new FDI_RESULTS or the handle to
%      the existing singleton*.
%
%      FDI_RESULTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FDI_RESULTS.M with the given input arguments.
%
%      FDI_RESULTS('Property','Value',...) creates a new FDI_RESULTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FDI_results_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FDI_results_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FDI_results

% Last Modified by GUIDE v2.5 27-Apr-2013 19:28:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FDI_results_OpeningFcn, ...
                   'gui_OutputFcn',  @FDI_results_OutputFcn, ...
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


% --- Executes just before FDI_results is made visible.
function FDI_results_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FDI_results (see VARARGIN)

% Choose default command line output for FDI_results
    handles.output = hObject;
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    SomeDataShared=getappdata(HandleMainGUI,'SharedData');
        
    handles.F = SomeDataShared{1};
    handles.B = SomeDataShared{2};
    handles.t = SomeDataShared{3};
    for i=1:handles.B.nZones
        handles.chooseZoneDetection(i) = false;
        handles.chooseZoneIsolation(i) = false;
    end
    %Detection Time
    min = handles.F.DetectionTime - fix(handles.F.DetectionTime);
    sec = min - fix(min);
    set(handles.edit1, 'String', sprintf('%02d:%02d:%02d',fix(handles.F.DetectionTime),fix(min*60),fix(sec*60)));
    
    %Isolation Time
    min = handles.F.IsolationTime - fix(handles.F.IsolationTime);
    sec = min - fix(min);
    set(handles.edit2, 'String', sprintf('%02d:%02d:%02d',fix(handles.F.IsolationTime),fix(min*60),fix(sec*60)));
    
%     set(handles.edit2, 'String', num2str(handles.F.IsolationTime));
    [s1 s2 s3] = size(handles.F.IsolationResidual);
    set(handles.Isolator, 'String', 1:s3);    
    set(handles.DetectionThreshold, 'Value', true);
    set(handles.DetectionResidual, 'Value', true);
    set(handles.IsolationThresholdResidual, 'Value', 1);
    set(handles.IsolationResidual, 'Value', true);
    set(handles.IsolationThreshold, 'Value', true);
    set(handles.SourceEstimation, 'Value', 0);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FDI_results wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FDI_results_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close

% --- Executes on button press in cancel.
function cancel_Callback(hObject, eventdata, handles)
% hObject    handle to cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ChooseZones.
function ChooseZones_Callback(hObject, eventdata, handles)
% hObject    handle to ChooseZones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    for i=1:handles.B.nZones
        data{i,1} = handles.B.ZoneName{i};
        data{i,2}= handles.chooseZoneDetection(i);
    end
    data{1,3} = 'Select Zones';
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    setappdata(HandleMainGUI,'SharedData', data); 

    change_release
    uiwait(change_release)
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    SomeDataShared=getappdata(HandleMainGUI,'SharedData');
    for i=1:handles.B.nZones
        handles.chooseZoneDetection(i)=SomeDataShared{i,2} ;
    end
guidata(hObject, handles);
% --- Executes on button press in PlotDetection.
function PlotDetection_Callback(hObject, eventdata, handles)
% hObject    handle to PlotDetection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if get(handles.DetectionThreshold, 'Value')||get(handles.DetectionResidual, 'Value')
        k=0;
        find(handles.chooseZoneDetection);
        for i=1:handles.B.nZones
            if handles.chooseZoneDetection(i)
                k=1;
%                 zones = zones + 1;
            end
        end
        if (k==0)
            msgbox('Select Zones', 'Error', 'error')
            return
        end
        
        if get(handles.DetectionThreshold, 'Value')&~get(handles.DetectionResidual, 'Value')
            zones = find(handles.chooseZoneDetection);
%             k = 1;
            set(figure, 'Name', 'Detection Results');
            if length(zones)==1
                plot(handles.t, handles.F.DetectionThreshold(:,zones),'--')
                title(sprintf('CDE at Zone %d.%s',zones,handles.B.ZoneName{zones}))
                xlabel('Time (h)')
                legend('Threshold', 'Location', 'Best')                
            else
                for i=1:length(zones)
                    subplot(round(length(zones)/2),2,i)
                    plot(handles.t, handles.F.DetectionThreshold(:,zones(i)),'--')
                    title(sprintf('CDE at Zone %d.%s',zones(i),handles.B.ZoneName{zones(i)}))
                    xlabel('Time (h)')
                end
                legend('Threshold', 'Location', 'Best')
            end
            
%             for i=1:length(zones)
%                 if mod(i,2)
%                     axes('position',[0.05, (round(length(zones)/2)-k)/round(length(zones)/2), (1/length(zones)), (1/length(zones))])
%                     
%                 else
%                     axes('position',[0.6, (round(length(zones)/2)-k)/round(length(zones)/2),(1/length(zones)), (1/length(zones))])
%                     k = k + 1;
%                 end
%             end
        end
        
        if ~get(handles.DetectionThreshold, 'Value')&get(handles.DetectionResidual, 'Value')
            zones = find(handles.chooseZoneDetection);
            set(figure, 'Name', 'Detection Results');
            if length(zones)==1
                plot(handles.t, handles.F.DetectionResidual(:,zones),'r')
                title(sprintf('CDE at Zone %d.%s',zones,handles.B.ZoneName{zones}))
                xlabel('Time (h)')
                legend('Residual', 'Location', 'Best') 
            else
                for i=1:length(zones)
                    subplot(round(length(zones)/2),2,i)
                    plot(handles.t, handles.F.DetectionResidual(:,zones(i)),'r')
                    title(sprintf('CDE at Zone %d.%s',zones(i),handles.B.ZoneName{zones(i)}))
                    xlabel('Time (h)')
                end
                legend('Residual', 'Location', 'Best')
            end
            
        end
         
        if get(handles.DetectionThreshold, 'Value')&get(handles.DetectionResidual, 'Value')
            zones = find(handles.chooseZoneDetection);
            set(figure, 'Name', 'Detection Results');
            if length(zones)==1
                hold on
                plot(handles.t, handles.F.DetectionResidual(:,zones),'r')
                plot(handles.t, handles.F.DetectionThreshold(:,zones),'--')
                title(sprintf('CDE at Zone %d.%s',zones,handles.B.ZoneName{zones}))
                xlabel('Time (h)')
                legend('Residual', 'Threshold', 'Location', 'Best') 
            else
                for i=1:length(zones)
                    subplot(round(length(zones)/2),2,i)
                    hold on
                    plot(handles.t, handles.F.DetectionResidual(:,zones(i)),'r')
                    plot(handles.t, handles.F.DetectionThreshold(:,zones(i)),'--')
                    title(sprintf('CDE at Zone %d.%s',zones(i),handles.B.ZoneName{zones(i)}))
                    xlabel('Time (h)')
                end
                legend('Residual', 'Threshold', 'Location', 'Best')
            end
            
        end
    else
        msgbox('Select Detection Threshold or Residual', 'Error', 'error')
        return
    end


% --- Executes on selection change in Isolator.
function Isolator_Callback(hObject, eventdata, handles)
% hObject    handle to Isolator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Isolator contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Isolator


% --- Executes during object creation, after setting all properties.
function Isolator_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Isolator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ChooseZonesIsolation.
function ChooseZonesIsolation_Callback(hObject, eventdata, handles)
% hObject    handle to ChooseZonesIsolation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    for i=1:handles.B.nZones
        data{i,1} = handles.B.ZoneName{i};
        data{i,2}= handles.chooseZoneIsolation(i);
    end
    data{1,3} = 'Select Zones';
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    setappdata(HandleMainGUI,'SharedData', data); 

    change_release
    uiwait(change_release)
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    SomeDataShared=getappdata(HandleMainGUI,'SharedData');
    for i=1:handles.B.nZones
        handles.chooseZoneIsolation(i)=SomeDataShared{i,2} ;
    end
guidata(hObject, handles);

% --- Executes on button press in PlotIsolation.
function PlotIsolation_Callback(hObject, eventdata, handles)
% hObject    handle to PlotIsolation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if get(handles.IsolationThresholdResidual, 'Value')||get(handles.SourceEstimation, 'Value')
        k=0;
        for i=1:handles.B.nZones
            if handles.chooseZoneIsolation(i)
                k=1;
            end
        end
        if (k==0)
            msgbox('Select Zones', 'Error', 'error')
            return
        end
        
        Isolator = get(handles.Isolator, 'Value');
        DT = find(handles.t==handles.F.DetectionTime);
        if get(handles.IsolationThresholdResidual, 'Value')&~get(handles.IsolationResidual, 'Value')&get(handles.IsolationThreshold, 'Value')
            zones = find(handles.chooseZoneIsolation);
            set(figure, 'Name', 'Isolation Results');
            if length(zones)==1
                plot(handles.t(DT:end), handles.F.IsolationThreshold(zones,:,Isolator),'--')
                title(sprintf('CIE%d at Zone %d.%s',Isolator ,zones,handles.B.ZoneName{zones}))
                xlabel('Time (h)')
                legend('Threshold', 'Location', 'Best')                
            else
                for i=1:length(zones)
                    subplot(round(length(zones)/2),2,i)
                    plot(handles.t(DT:end), handles.F.IsolationThreshold(zones(i),:,Isolator),'--')
                    title(sprintf('CIE%d at Zone %d.%s',Isolator ,zones(i),handles.B.ZoneName{zones(i)}))
                    xlabel('Time (h)')
                end
                legend('Threshold', 'Location', 'Best')
            end
            
        end
        
        if ~get(handles.IsolationThreshold, 'Value')&get(handles.IsolationResidual, 'Value')&get(handles.IsolationThresholdResidual, 'Value')
            zones = find(handles.chooseZoneIsolation);
            set(figure, 'Name', 'Isolation Results');
            if length(zones)==1
                plot(handles.t(DT:end), handles.F.IsolationResidual(zones,:,Isolator),'r')
                title(sprintf('CIE%d at Zone %d.%s',Isolator ,zones,handles.B.ZoneName{zones}))
                xlabel('Time (h)')
                legend('Residual', 'Location', 'Best')                
            else
                for i=1:length(zones)
                    subplot(round(length(zones)/2),2,i)
                    plot(handles.t(DT:end), handles.F.IsolationResidual(zones(i),:,Isolator),'r')
                    title(sprintf('CIE%d at Zone %d.%s',Isolator ,zones(i),handles.B.ZoneName{zones(i)}))
                    xlabel('Time (h)')
                end
                legend('Residual', 'Location', 'Best')
            end
            
        end
        
        if get(handles.IsolationThreshold, 'Value')&get(handles.IsolationResidual, 'Value')&get(handles.IsolationThresholdResidual, 'Value')
            zones = find(handles.chooseZoneIsolation);
            set(figure, 'Name', 'Isolation Results');
            if length(zones)==1
                hold on                
                plot(handles.t(DT:end), handles.F.IsolationResidual(zones,:,Isolator),'r')
                plot(handles.t(DT:end), handles.F.IsolationThreshold(zones,:,Isolator),'--')
                title(sprintf('CIE%d at Zone %d.%s',Isolator, zones,handles.B.ZoneName{zones}))
                xlabel('Time (h)')
                legend('Residual', 'Threshold', 'Location', 'Best')                
            else
                for i=1:length(zones)
                    subplot(round(length(zones)/2),2,i)
                    hold on
                    plot(handles.t(DT:end), handles.F.IsolationResidual(zones(i),:,Isolator),'r')
                    plot(handles.t(DT:end), handles.F.IsolationThreshold(zones(i),:,Isolator),'--')
                    title(sprintf('CIE%d at Zone %d.%s',Isolator, zones(i),handles.B.ZoneName{zones(i)}))
                    xlabel('Time (h)')
                end
                legend('Residual', 'Threshold', 'Location', 'Best')
            end
            
        end
        
        if get(handles.SourceEstimation, 'Value')
            zones = find(handles.chooseZoneIsolation);
            set(figure, 'Name', 'Isolation Results');
            if length(zones)==1                                
                plot(handles.t(DT:end), handles.F.SourceEstimation(:,zones))
                title(sprintf('CIE%d. Source Estimation at %s',zones,handles.B.ZoneName{zones}))
                xlabel('Time (h)')
                legend('Source Estimation', 'Location', 'Best')                
            else
                for i=1:length(zones)
                    subplot(round(length(zones)/2),2,i)                    
                    plot(handles.t(DT:end), handles.F.SourceEstimation(:,zones(i)))
                    title(sprintf('CIE%d. Source Estimation at %s',zones(i),handles.B.ZoneName{zones(i)}))
                    xlabel('Time (h)')
                end
                legend('Source Estimation', 'Location', 'Best')
            end
            
        end
    else
        msgbox('Select Isolation Threshold or Residual', 'Error', 'error')
        return
    end

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in DetectionThreshold.
function DetectionThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to DetectionThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DetectionThreshold


% --- Executes on button press in DetectionResidual.
function DetectionResidual_Callback(hObject, eventdata, handles)
% hObject    handle to DetectionResidual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DetectionResidual


% --- Executes on button press in IsolationThresholdResidual.
function IsolationThresholdResidual_Callback(hObject, eventdata, handles)
% hObject    handle to IsolationThresholdResidual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of IsolationThresholdResidual
    val = get(handles.IsolationThresholdResidual, 'Value');
    if val == 1
        set(handles.SourceEstimation, 'Value', 0);
        set(handles.IsolationResidual, 'Enable', 'on');
        set(handles.IsolationThreshold, 'Enable', 'on');
    end
guidata(hObject, handles);

% --- Executes on button press in IsolationResidual.
function IsolationResidual_Callback(hObject, eventdata, handles)
% hObject    handle to IsolationResidual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of IsolationResidual
%     val = get(handles.IsolationResidual, 'Value');
%     if val == 1
%         set(handles.SourceEstimation, 'Value', 0);
%     end
    
% --- Executes on button press in IsolationThreshold.
function IsolationThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to IsolationThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of IsolationThreshold

% --- Executes on button press in SourceEstimation.
function SourceEstimation_Callback(hObject, eventdata, handles)
% hObject    handle to SourceEstimation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SourceEstimation
    val = get(handles.SourceEstimation, 'Value');
    if val == 1
        set(handles.IsolationThresholdResidual, 'Value', 0);
        set(handles.IsolationResidual, 'Enable', 'off');
        set(handles.IsolationThreshold, 'Enable', 'off');
    end
guidata(hObject, handles);


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    FDI.DetectionThreshold =handles.F.DetectionThreshold;
    FDI.DetectionResidual=handles.F.DetectionResidual;
    FDI.IsolationThreshold=handles.F.IsolationThreshold;
    FDI.IsolationResidual=handles.F.IsolationResidual;
    FDI.SourceEstimation=handles.F.SourceEstimation;

uisave('FDI', 'FDI')



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
