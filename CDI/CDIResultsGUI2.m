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
function varargout = CDIResultsGUI2(varargin)
% CDIRESULTSGUI2 MATLAB code for CDIResultsGUI2.fig
%      CDIRESULTSGUI2, by itself, creates a new CDIRESULTSGUI2 or raises the existing
%      singleton*.
%
%      H = CDIRESULTSGUI2 returns the handle to a new CDIRESULTSGUI2 or the handle to
%      the existing singleton*.
%
%      CDIRESULTSGUI2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CDIRESULTSGUI2.M with the given input arguments.
%
%      CDIRESULTSGUI2('Property','Value',...) creates a new CDIRESULTSGUI2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CDIResultsGUI2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CDIResultsGUI2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CDIResultsGUI2

% Last Modified by GUIDE v2.5 09-Jan-2018 14:21:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CDIResultsGUI2_OpeningFcn, ...
                   'gui_OutputFcn',  @CDIResultsGUI2_OutputFcn, ...
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


% --- Executes just before CDIResultsGUI2 is made visible.
function CDIResultsGUI2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CDIResultsGUI2 (see VARARGIN)
set(0,'defaultAxesFontSize',14)

% Choose default command line output for CDIResultsGUI2
handles.output = hObject;
temp_handle=findobj('Tag','MatlabContamToolbox');
temp_handle.Pointer='watch';
drawnow;

if isfield(varargin{1},'fileR')
    load([varargin{1}.pathName,varargin{1}.file0],'-mat');
    load([varargin{1}.pathName,varargin{1}.fileR],'-mat');
    handles.B = B;
    handles.P = P;
    handles.CDI = CDI;
    handles.file0 = varargin{1}.file0(1:end-2);
    
    set(handles.ScenariosFileText,'String',[handles.file0,'.0'])
    set(handles.LoadCDI,'enable','on'); 
    set(handles.CDIFileText,'String',varargin{1}.fileR)
    set(handles.ScenarioPopup,'enable','on');
    set(handles.ScenarioPopup,'String',1:length(CDI.R));
    set(handles.ResultsInformationListbox,'Foregroundcolor','b');
    set(handles.ResultsInformationListbox,'fontsize',8);
    
    [Path Name Extension] =  fileparts(varargin{1}.fileR);
    SceNum = regexp(Extension,'\d+','match');
    if CDI.nSub ~= 0
        
        switch handles.P.Method
            case 'grid'
                idx = handles.P.ScenariosFlowIndex(str2double(SceNum{1}),:);
                idx2 = handles.P.ScenariosContamIndex(1,:);                    
            case 'random'
                idx = handles.P.ScenariosFlowIndex(str2double(SceNum{1}),:);
                idx2 = handles.P.ScenariosContamIndex(str2double(SceNum{1}),:); 
        end
        

        w=[{'********************************* '};{'Scenario Data'};{'********************************* '}];
        w=[w;{' '};{'Weather Data:'};{'---------------------------------------- '};{' '}];            
        w=[w;{[' Wind Direction: ',num2str(handles.P.FlowParamScenarios{1}(idx(1))), ' ^{o}']}];
        w=[w;{[' Wind Speed: ',num2str(handles.P.FlowParamScenarios{2}(idx(2))), ' m/s']}; {' '}];
        w=[w;{'Source Data:'};{'---------------------------------------- '};{' '}];
        w=[w;{['Number of contaminant sources: ',num2str(length(handles.P.SourceLocationScenarios{idx2(4)}))]}];

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
        
        w=[w;{'********************************* '};{'Distributed CDI Data'};{'********************************* '};{' '}];

        w=[w;{' '};{'Assumed Nominal Weather Data:'};{'---------------------------------------- '};{' '}]; 
        w=[w;{['Wind Direction: ',num2str(handles.P.WindDirection), ' ^{o}']}];
        w=[w;{['Wind Speed: ',num2str(handles.P.WindSpeed), ' m/s']}; {' '}];

        w=[w;{['Number of subsystems: ', num2str(CDI.nSub)]};{' '}];
        w=[w;{' '}];

        for i=1:CDI.nSub
            w=[w;{['Subsystem ', num2str(i), ' data:']};{'---------------------------------------- '}];
            ZN = [];
            for j = 1:length(CDI.SubsystemZones{i})
                ZN = [ZN, 'Z',num2str(CDI.SubsystemZones{i}(j)), '   '];                        
            end
            w=[w;{['Zones: ', ZN]};{' '}];

            w=[w;{' '};{'Bound Data:'};{'---------------------------------------- '};{' '}]; 
            w=[w;{['Uncertainties bound:  DA = ',num2str(CDI.Param.UncertaintiesBoundDA{i}), ',   DH = ',num2str(CDI.Param.UncertaintiesBoundDH{i})]}];
            w=[w;{['Noise bound:  w = ', num2str(CDI.Param.NoiseBound{i})]};{' '}];



            if ~isempty(CDI.R{1}.DetectionTime{i})
                %Detection Time
                DT = CDI.R{1}.DetectionTime{i};
                min = (DT - fix(DT))*60;
                sec = (min - fix(min))*60;
                DT = sprintf('%02d:%02d:%02d',fix(DT),fix(min),fix(sec));

                %Detection Delay
                DD = CDI.R{1}.DetectionDelay{i};
                min = (DD - fix(DD))*60;
                sec = (min - fix(min))*60;
                DD = sprintf('%02d:%02d:%02d',fix(DD),fix(min),fix(sec));
                
                w=[w;{' '};{'Detection Data:'};{'---------------------------------------- '};{' '}]; 
                w=[w;{['Detection Decision: YES --> ', CDI.R{1}.DetectionRate{i}]}];
                w=[w;{['Detection Time: ', DT]}];
                w=[w;{['Detection Delay: ', DD]};{' '}];
                
                switch CDI.R{1}.IsolationRate{i}
                    case {'True Positive', 'False Positive'}
                        %Isolation Time
                        IT = CDI.R{1}.IsolationTime{i};
                        min = (IT - fix(IT))*60;
                        sec = (min - fix(min))*60;
                        IT = sprintf('%02d:%02d:%02d',fix(IT),fix(min),fix(sec));

                        %Isolation Delay
                        ID = CDI.R{1}.IsolationDelay{i};
                        min = (ID - fix(ID))*60;
                        sec = (min - fix(min))*60;
                        ID = sprintf('%02d:%02d:%02d',fix(ID),fix(min),fix(sec));                

                        w=[w;{' '};{'Isolation Data:'};{'---------------------------------------- '};{' '}]; 
                        w=[w;{['Isolation Decision: YES --> ', CDI.R{1}.IsolationRate{i}]}];
                        w=[w;{['Isolation Time: ', IT]}];
                        w=[w;{['Isolation Delay: ', ID]}];
                        
                        if ~isempty(CDI.R{1}.IsolationDecision{i})
                            IDec = [];
                            for j=1:length(CDI.R{1}.IsolationDecision{i})
                                k = CDI.R{1}.IsolationDecision{i}(j);
                                IDec = [IDec, ' Z' num2str(CDI.SubsystemZones{i}(k)), '   '];                            
                            end
                        else
                            IDec = '';
                        end
                        w=[w;{['Isolation Candidate Zones: ', IDec]}];
                        w=[w;{['Source Estimation: ', num2str(CDI.R{1}.SourceEstimation{i}), ' g/h']}];
                        
                    case 'False Negative'
                        w=[w;{' '};{'Isolation Data:'};{'---------------------------------------- '};{' '}]; 
                        w=[w;{['Isolation Decision: NO --> ', CDI.R{1}.IsolationRate{i}]}];
                        if ~isempty(CDI.R{1}.IsolationDecision{i})
                            IDec = [];
                            for j=1:length(CDI.R{1}.IsolationDecision{i})
                                k = CDI.R{1}.IsolationDecision{i}(j);
                                IDec = [IDec, ' Z' num2str(CDI.SubsystemZones{i}(k)), '   '];                            
                            end
                        else
                            IDec = '';
                        end
                        w=[w;{['Isolation Candidate Zones: ', IDec]}];
                        
                end
                   
                    
                
            else
                w=[w;{' '};{'Detection Data:'};{'---------------------------------------- '};{' '}]; 
                w=[w;{'Detection Decision: NO'}];
            end

            w=[w;{' '}];
        end

        set(handles.ResultsInformationListbox,'Value',1,'ListboxTop', 1);
        set(handles.ResultsInformationListbox,'String',w);


        set(handles.SubsystemsPopup,'enable','on');            
        set(handles.SubsystemsPopup,'String',1:CDI.nSub);

        k = 1;
        for i=1:length(CDI.SubsystemZones{1})
            if max(find(handles.B.Sensors == CDI.SubsystemZones{1}(i)))
                handles.chooseZoneDetection(k) = true;
                handles.chooseZoneIsolation(k) = true;
                k = k + 1;
            end
        end

        if ~isempty(CDI.R{1,1}.DetectionTime{1})                 

            set(handles.IsolatorPopup, 'String', 1:length(CDI.SubsystemZones{1})); 
%             set(handles.Save,'enable','on');
            set(handles.DetectionZones,'enable','on');
            set(handles.IsolationZones,'enable','on');
            set(handles.PlotDetection,'enable','on');
            set(handles.PlotIsolation,'enable','on');                     
            set(handles.IsolatorPopup, 'enable', 'on');    
            set(handles.DetectionThresholdCheck, 'enable', 'on', 'value', 1);
            set(handles.DetectionResidualCheck, 'enable', 'on', 'value', 1);
            set(handles.ThresholdResidualRadio, 'enable', 'on', 'value', 1);
            set(handles.IsolationThresholdCheck, 'enable', 'on', 'value', 1);
            set(handles.IsolationResidualCheck, 'enable', 'on', 'value', 1);
            set(handles.SourceEstimationRadio, 'enable', 'on', 'value', 0);
        else
%             set(handles.Save,'enable','on');
            set(handles.DetectionZones,'enable','on');
            set(handles.IsolationZones,'enable','off');
            set(handles.PlotDetection,'enable','on');
            set(handles.PlotIsolation,'enable','off');                     
            set(handles.IsolatorPopup, 'enable', 'off');    
            set(handles.DetectionThresholdCheck, 'enable', 'on', 'value', 1);
            set(handles.DetectionResidualCheck, 'enable', 'on', 'value', 1);
            set(handles.ThresholdResidualRadio, 'enable', 'off');
            set(handles.IsolationThresholdCheck, 'enable', 'off');
            set(handles.IsolationResidualCheck, 'enable', 'off');
            set(handles.SourceEstimationRadio, 'enable', 'off');                    
        end
        
        
        
    else
        
        switch handles.P.Method
            case 'grid'
                idx = handles.P.ScenariosFlowIndex(str2double(SceNum{1}),:);
                idx2 = handles.P.ScenariosContamIndex(1,:);                    
            case 'random'
                idx = handles.P.ScenariosFlowIndex(str2double(SceNum{1}),:);
                idx2 = handles.P.ScenariosContamIndex(str2double(SceNum{1}),:); 
        end
        

        w=[{'********************************* '};{'Scenario Data'};{'********************************* '}];
        w=[w;{' '};{'Weather Data:'};{'---------------------------------------- '};{' '}];            
        w=[w;{['Wind Direction: ',num2str(handles.P.FlowParamScenarios{1}(idx(1))), ' ^{o}']}];
        w=[w;{['Wind Speed: ',num2str(handles.P.FlowParamScenarios{2}(idx(2))), ' m/s']}; {' '}];
        w=[w;{'Source Data:'};{'---------------------------------------- '};{' '}];
        w=[w;{['Number of contaminant sources: ',num2str(length(handles.P.SourceLocationScenarios{idx2(4)}))]}];

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

        w=[w;{'********************************* '};{'CDI Data'};{'********************************* '};{' '}];

        w=[w;{' '};{'Assumed Nominal Weather Data:'};{'---------------------------------------- '};{' '}]; 
        w=[w;{['Wind Direction: ',num2str(handles.P.WindDirection), ' ^{o}']}];
        w=[w;{['Wind Speed: ',num2str(handles.P.WindSpeed), ' m/s']}; {' '}];


        set(handles.SubsystemsPopup,'enable','off');
        for i=1:handles.B.nS
            handles.chooseZoneDetection(i) = true;
            handles.chooseZoneIsolation(i) = true;
        end


        if ~isempty(CDI.R{1}.DetectionTime)

            %Detection Time
            DT = CDI.R{1}.DetectionTime;
            min = (DT - fix(DT))*60;
            sec = (min - fix(min))*60;
            DT = sprintf('%02d:%02d:%02d',fix(DT),fix(min),fix(sec));

            %Detection Delay
            DD = CDI.R{1}.DetectionDelay;
            min = (DD - fix(DD))*60;
            sec = (min - fix(min))*60;
            DD = sprintf('%02d:%02d:%02d',fix(DD),fix(min),fix(sec));
            
            w=[w;{' '};{'Detection Data:'};{'---------------------------------------- '};{' '}]; 
            w=[w;{['Detection Decision: YES --> ', CDI.R{1}.DetectionRate]}];
            w=[w;{['Detection Time: ', DT]}];
            w=[w;{['Detection Delay: ', DD]};{' '}];
            
            switch CDI.R{1}.IsolationRate
                case {'True Positive', 'False Positive'}
                    %Isolation Time
                    IT = CDI.R{1}.IsolationTime;
                    min = (IT - fix(IT))*60;
                    sec = (min - fix(min))*60;
                    IT = sprintf('%02d:%02d:%02d',fix(IT),fix(min),fix(sec));

                    %Isolation Delay
                    ID = CDI.R{1}.IsolationDelay;
                    min = (ID - fix(ID))*60;
                    sec = (min - fix(min))*60;
                    ID = sprintf('%02d:%02d:%02d',fix(ID),fix(min),fix(sec));


                    w=[w;{' '};{'Isolation Data:'};{'---------------------------------------- '};{' '}]; 
                    w=[w;{['Isolation Decision: YES --> ', CDI.R{1}.IsolationRate]}];
                    w=[w;{['Isolation Time: ', IT]}];
                    w=[w;{['Isolation Delay: ', ID]}];
                    if ~isempty(CDI.R{1}.IsolationDecision)
                        IDec = [];
                        for j=1:length(CDI.R{1}.IsolationDecision)                
                            IDec = [IDec, ' Z' num2str(CDI.R{1}.IsolationDecision(j)), '   '];                            
                        end
                    else
                        IDec = '';
                    end
                    w=[w;{['Isolation Candidate Zones: ', IDec]}];
                    w=[w;{['Source Estimation: ', num2str(CDI.R{1}.SourceEstimation), ' g/h']}];
                    
                case 'False Negative'
                    w=[w;{' '};{'Isolation Data:'};{'---------------------------------------- '};{' '}]; 
                    w=[w;{['Isolation Decision: NO --> ', CDI.R{1}.IsolationRate]}];
                    if ~isempty(CDI.R{1}.IsolationDecision)
                        IDec = [];
                        for j=1:length(CDI.R{1}.IsolationDecision)                
                            IDec = [IDec, ' Z' num2str(CDI.R{1}.IsolationDecision(j)), '   '];                            
                        end
                    else
                        IDec = '';
                    end
                    w=[w;{['Isolation Candidate Zones: ', IDec]}];
            end                           

            set(handles.IsolatorPopup, 'String', 1:handles.B.nZones);
%             set(handles.Save,'enable','on');
            set(handles.DetectionZones,'enable','on');
            set(handles.IsolationZones,'enable','on');
            set(handles.PlotDetection,'enable','on');
            set(handles.PlotIsolation,'enable','on');                     
            set(handles.IsolatorPopup, 'enable', 'on');    
            set(handles.DetectionThresholdCheck, 'enable', 'on', 'value', 1);
            set(handles.DetectionResidualCheck, 'enable', 'on', 'value', 1);
            set(handles.ThresholdResidualRadio, 'enable', 'on', 'value', 1);
            set(handles.IsolationThresholdCheck, 'enable', 'on', 'value', 1);
            set(handles.IsolationResidualCheck, 'enable', 'on', 'value', 1);
            set(handles.SourceEstimationRadio, 'enable', 'on', 'value', 0);
        else

            w=[w;{' '};{'Detection Data:'};{'---------------------------------------- '};{' '}]; 
            w=[w;{'Detection Decision: NO'}];

%             set(handles.Save,'enable','on');
            set(handles.DetectionZones,'enable','on');
            set(handles.IsolationZones,'enable','off');
            set(handles.PlotDetection,'enable','on');
            set(handles.PlotIsolation,'enable','off');                     
            set(handles.IsolatorPopup, 'enable', 'off');    
            set(handles.DetectionThresholdCheck, 'enable', 'on', 'value', 1);
            set(handles.DetectionResidualCheck, 'enable', 'on', 'value', 1);
            set(handles.ThresholdResidualRadio, 'enable', 'off');
            set(handles.IsolationThresholdCheck, 'enable', 'off');
            set(handles.IsolationResidualCheck, 'enable', 'off');
            set(handles.SourceEstimationRadio, 'enable', 'off');
        end
        w=[w;{' '}];

        set(handles.ResultsInformationListbox,'Value',1,'ListboxTop', 1);
        set(handles.ResultsInformationListbox,'String',w); 
                  
        
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
        set(handles.LoadCDI,'enable','on'); 
        if exist([pathname,handles.file0,'_Distributed.cdi1'],'file')==2 || exist([pathname,handles.file0,'_Centralized.cdi1'],'file')==2
            if ~isempty([handles.file0,'_Distributed.cdi1']) || ~isempty([handles.file0,'_Centralized.cdi1'])
                
                if exist([pathname,handles.file0,'_Centralized.cdi1'],'file')==2 && ~isempty([handles.file0,'_Centralized.cdi1'])
                    load([pathname,handles.file0,'_Centralized.cdi1'],'-mat');
                    set(handles.CDIFileText,'String',[handles.file0,'_Centralized.cdi1'])

                else
                    load([pathname,handles.file0,'_Distributed.cdi1'],'-mat');
                    set(handles.CDIFileText,'String',[handles.file0,'_Distributed.cdi1'])
                end
                handles.CDI = CDI;
%                 set(handles.CDIFileText,'String',[handles.file0,'.cdi1'])
                set(handles.ScenarioPopup,'enable','on');
                set(handles.ScenarioPopup,'String',1:length(CDI.R));

    %             [Path Name Extension] =  fileparts(fileCDI);
    %             SceNum = regexp(Extension,'\d+','match');
                set(handles.ResultsInformationListbox,'Foregroundcolor','b');
                set(handles.ResultsInformationListbox,'fontsize',8);
                
                % Depending on which result file is loaded then the
                % subsystems number equals to zero or > 0
                if CDI.nSub ~= 0
                    
                    
                    fillScenarioResultsPanel (pathname, [handles.file0 '_Distributed'],handles.ScerarioResultsPanel,handles.P);


                    idx = handles.P.ScenariosFlowIndex(1,:);
                    idx2 = handles.P.ScenariosContamIndex(1,:);

                    w=[{'********************************* '};{'Scenario Data'};{'********************************* '}];
                    w=[w;{' '};{'Weather Data:'};{'---------------------------------------- '};{' '}];            
                    w=[w;{[' Wind Direction: ',num2str(handles.P.FlowParamScenarios{1}(idx(1))), ' ^{o}']}];
                    w=[w;{[' Wind Speed: ',num2str(handles.P.FlowParamScenarios{2}(idx(2))), ' m/s']}; {' '}];
                    w=[w;{'Source Data:'};{'---------------------------------------- '};{' '}];
                    w=[w;{['Number of contaminant sources: ',num2str(length(handles.P.SourceLocationScenarios{idx2(4)}))]}];

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

                    w=[w;{'********************************* '};{'Distributed CDI Data'};{'********************************* '};{' '}];

                    w=[w;{' '};{'Assumed Nominal Weather Data:'};{'---------------------------------------- '};{' '}]; 
                    w=[w;{['Wind Direction: ',num2str(handles.P.WindDirection), ' ^{o}']}];
                    w=[w;{['Wind Speed: ',num2str(handles.P.WindSpeed), ' m/s']}; {' '}];

                    w=[w;{['Number of subsystems: ', num2str(CDI.nSub)]};{' '}];
                    w=[w;{' '}];

                    for i=1:CDI.nSub
                        w=[w;{['Subsystem ', num2str(i), ' data:']};{'---------------------------------------- '}];
                        ZN = [];
                        for j = 1:length(CDI.SubsystemZones{i})
                            ZN = [ZN, 'Z',num2str(CDI.SubsystemZones{i}(j)), '   '];                        
                        end
                        w=[w;{['Zones: ', ZN]};{' '}];

                        w=[w;{' '};{'Bound Data:'};{'---------------------------------------- '};{' '}]; 
                        w=[w;{['Uncertainties bound:  DA = ',num2str(CDI.Param.UncertaintiesBoundDA{i}), ',   DH = ',num2str(CDI.Param.UncertaintiesBoundDH{i})]}];
                        w=[w;{['Noise bound:  w = ', num2str(CDI.Param.NoiseBound{i})]};{' '}];



                        if ~isempty(CDI.R{1}.DetectionTime{i})
                            %Detection Time
                            DT = CDI.R{1}.DetectionTime{i};
                            min = (DT - fix(DT))*60;
                            sec = (min - fix(min))*60;
                            DT = sprintf('%02d:%02d:%02d',fix(DT),fix(min),fix(sec));

                            %Detection Delay
                            DD = CDI.R{1}.DetectionDelay{i};
                            min = (DD - fix(DD))*60;
                            sec = (min - fix(min))*60;
                            DD = sprintf('%02d:%02d:%02d',fix(DD),fix(min),fix(sec));
                            
                            w=[w;{' '};{'Detection Data:'};{'---------------------------------------- '};{' '}]; 
                            w=[w;{['Detection Decision: YES --> ', CDI.R{1}.DetectionRate{i}]}];
                            w=[w;{['Detection Time: ', DT]}];
                            w=[w;{['Detection Delay: ', DD]};{' '}];
                            
                            switch CDI.R{1}.IsolationRate{i}
                                case {'True Positive', 'False Positive'}
                                    %Isolation Time
                                    IT = CDI.R{1}.IsolationTime{i};
                                    min = (IT - fix(IT))*60;
                                    sec = (min - fix(min))*60;
                                    IT = sprintf('%02d:%02d:%02d',fix(IT),fix(min),fix(sec));

                                    %Isolation Delay
                                    ID = CDI.R{1}.IsolationDelay{i};
                                    min = (ID - fix(ID))*60;
                                    sec = (min - fix(min))*60;
                                    ID = sprintf('%02d:%02d:%02d',fix(ID),fix(min),fix(sec));

                                    w=[w;{' '};{'Isolation Data:'};{'---------------------------------------- '};{' '}]; 
                                    w=[w;{['Isolation Decision: YES -- > ', CDI.R{1}.IsolationRate{i}]}];
                                    w=[w;{['Isolation Time: ', IT]}];
                                    w=[w;{['Isolation Delay: ', ID]}];
                                    if ~isempty(CDI.R{1}.IsolationDecision{i})
                                        IDec = [];
                                        for j=1:length(CDI.R{1}.IsolationDecision{i})
                                            k = CDI.R{1}.IsolationDecision{i}(j);
                                            IDec = [IDec, ' Z' num2str(CDI.SubsystemZones{i}(k)), '   '];                            
                                        end
                                    else
                                        IDec = '';
                                    end
                                    w=[w;{['Isolation Candidate Zones: ', IDec]}];
                                    w=[w;{['Source Estimation: ', num2str(CDI.R{1}.SourceEstimation{i}), ' g/h']}];
                                    
                                case 'False Negative'
                                    w=[w;{' '};{'Isolation Data:'};{'---------------------------------------- '};{' '}]; 
                                    w=[w;{['Isolation Decision: NO -- > ', CDI.R{1}.IsolationRate{i}]}];
                                    if ~isempty(CDI.R{1}.IsolationDecision{i})
                                        IDec = [];
                                        for j=1:length(CDI.R{1}.IsolationDecision{i})
                                            k = CDI.R{1}.IsolationDecision{i}(j);
                                            IDec = [IDec, ' Z' num2str(CDI.SubsystemZones{i}(k)), '   '];                            
                                        end
                                    else
                                        IDec = '';
                                    end
                                    w=[w;{['Isolation Candidate Zones: ', IDec]}];                                    
                            end
                                        
                            
                            
                        else
                            w=[w;{' '};{'Detection Data:'};{'---------------------------------------- '};{' '}]; 
                            w=[w;{'Detection Decision: NO'}];
                        end

                        w=[w;{' '}];
                    end

                    set(handles.ResultsInformationListbox,'Value',1,'ListboxTop', 1);
                    set(handles.ResultsInformationListbox,'String',w);

                    set(handles.SubsystemsPopup,'enable','on');            
                    set(handles.SubsystemsPopup,'String',1:CDI.nSub);

                    k = 1;
                    for i=1:length(CDI.SubsystemZones{1})
                        if max(find(handles.B.Sensors == CDI.SubsystemZones{1}(i)))
                            handles.chooseZoneDetection(k) = true;
                            handles.chooseZoneIsolation(k) = true;
                            k = k + 1;
                        end
                    end

                    if ~isempty(CDI.R{1,1}.DetectionTime{1})  
    %                     %Detection Time
    %                     DT = CDI.R{1,1}.DetectionTime{1};
    %                     min = (DT - fix(DT))*60;
    %                     sec = (min - fix(min))*60;
    %                     set(handles.DetectionTimeEdit, 'String',...
    %                         sprintf('%02d:%02d:%02d',fix(DT),fix(min),fix(sec)));
    %                     
    %                     %Isolation Time
    %                     IT = CDI.R{1,1}.IsolationTime{1};
    %                     min = (IT - fix(IT))*60;
    %                     sec = (min - fix(min))*60;
    %                     set(handles.IsolationTimeEdit, 'String',...
    %                         sprintf('%02d:%02d:%02d',fix(IT),fix(min),fix(sec)));                

                        set(handles.IsolatorPopup, 'String', 1:length(CDI.SubsystemZones{1})); 
%                         set(handles.Save,'enable','on');
    %                     set(handles.DetectionTimeEdit, 'enable', 'inactive')
    %                     set(handles.IsolationTimeEdit, 'enable', 'inactive')
                        set(handles.DetectionZones,'enable','on');
                        set(handles.IsolationZones,'enable','on');
                        set(handles.PlotDetection,'enable','on');
                        set(handles.PlotIsolation,'enable','on');                     
                        set(handles.IsolatorPopup, 'enable', 'on');    
                        set(handles.DetectionThresholdCheck, 'enable', 'on', 'value', 1);
                        set(handles.DetectionResidualCheck, 'enable', 'on', 'value', 1);
                        set(handles.ThresholdResidualRadio, 'enable', 'on', 'value', 1);
                        set(handles.IsolationThresholdCheck, 'enable', 'on', 'value', 1);
                        set(handles.IsolationResidualCheck, 'enable', 'on', 'value', 1);
                        set(handles.SourceEstimationRadio, 'enable', 'on', 'value', 0);
                    else
%                         set(handles.Save,'enable','on');
    %                     set(handles.DetectionTimeEdit, 'enable', 'off')
    %                     set(handles.IsolationTimeEdit, 'enable', 'off')
                        set(handles.DetectionZones,'enable','on');
                        set(handles.IsolationZones,'enable','off');
                        set(handles.PlotDetection,'enable','on');
                        set(handles.PlotIsolation,'enable','off');                     
                        set(handles.IsolatorPopup, 'enable', 'off');    
                        set(handles.DetectionThresholdCheck, 'enable', 'on', 'value', 1);
                        set(handles.DetectionResidualCheck, 'enable', 'on', 'value', 1);
                        set(handles.ThresholdResidualRadio, 'enable', 'off');
                        set(handles.IsolationThresholdCheck, 'enable', 'off');
                        set(handles.IsolationResidualCheck, 'enable', 'off');
                        set(handles.SourceEstimationRadio, 'enable', 'off');                    
                    end

                else
                    
                    
                     fillScenarioResultsPanel (pathname, [handles.file0 '_Centralized'],handles.ScerarioResultsPanel,handles.P);

                    idx = handles.P.ScenariosFlowIndex(1,:);
                    idx2 = handles.P.ScenariosContamIndex(1,:);

                    w=[{'********************************* '};{'Scenario Data'};{'********************************* '}];
                    w=[w;{' '};{'Weather Data:'};{'---------------------------------------- '};{' '}];            
                    w=[w;{['Wind Direction: ',num2str(handles.P.FlowParamScenarios{1}(idx(1))), ' ^{o}']}];
                    w=[w;{['Wind Speed: ',num2str(handles.P.FlowParamScenarios{2}(idx(2))), ' m/s']}; {' '}];
                    w=[w;{'Source Data:'};{'---------------------------------------- '};{' '}];
                    w=[w;{['Number of contaminant sources: ',num2str(length(handles.P.SourceLocationScenarios{idx2(4)}))]}];

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

                    w=[w;{'********************************* '};{'CDI Data'};{'********************************* '};{' '}];

                    w=[w;{' '};{'Assumed Nominal Weather Data:'};{'---------------------------------------- '};{' '}]; 
                    w=[w;{['Wind Direction: ',num2str(handles.P.WindDirection), ' ^{o}']}];
                    w=[w;{['Wind Speed: ',num2str(handles.P.WindSpeed), ' m/s']}; {' '}];


                    set(handles.SubsystemsPopup,'enable','off');
                    for i=1:handles.B.nS
                        handles.chooseZoneDetection(i) = true;
                        handles.chooseZoneIsolation(i) = true;
                    end


                    if ~isempty(CDI.R{1,1}.DetectionTime)

                        %Detection Time
                        DT = CDI.R{1}.DetectionTime;
                        min = (DT - fix(DT))*60;
                        sec = (min - fix(min))*60;
                        DT = sprintf('%02d:%02d:%02d',fix(DT),fix(min),fix(sec));

                        %Detection Delay
                        DD = CDI.R{1}.DetectionDelay;
                        min = (DD - fix(DD))*60;
                        sec = (min - fix(min))*60;
                        DD = sprintf('%02d:%02d:%02d',fix(DD),fix(min),fix(sec));
                        
                        w=[w;{' '};{'Detection Data:'};{'---------------------------------------- '};{' '}]; 
                        w=[w;{['Detection Decision: YES --> ', CDI.R{1}.DetectionRate]}];
                        w=[w;{['Detection Time: ', DT]}];
                        w=[w;{['Detection Delay: ', DD]};{' '}];
                        
                        switch CDI.R{1}.IsolationRate
                                case {'True Positive', 'False Positive'}
                                    %Isolation Time
                                    IT = CDI.R{1}.IsolationTime;
                                    min = (IT - fix(IT))*60;
                                    sec = (min - fix(min))*60;
                                    IT = sprintf('%02d:%02d:%02d',fix(IT),fix(min),fix(sec));

                                    %Isolation Delay
                                    ID = CDI.R{1}.IsolationDelay;
                                    min = (ID - fix(ID))*60;
                                    sec = (min - fix(min))*60;
                                    ID = sprintf('%02d:%02d:%02d',fix(ID),fix(min),fix(sec));


                                    w=[w;{' '};{'Isolation Data:'};{'---------------------------------------- '};{' '}]; 
                                    w=[w;{['Isolation Decision: YES --> ', CDI.R{1}.IsolationRate]}];
                                    w=[w;{['Isolation Time: ', IT]}];
                                    w=[w;{['Isolation Delay: ', ID]}];
                                    if ~isempty(CDI.R{1}.IsolationDecision)
                                        IDec = [];
                                        for j=1:length(CDI.R{1}.IsolationDecision)                
                                            IDec = [IDec, ' Z' num2str(CDI.R{1}.IsolationDecision(j)), '   '];                            
                                        end
                                    else
                                        IDec = '';
                                    end
                                    w=[w;{['Isolation Candidate Zones: ', IDec]}];
                                    w=[w;{['Source Estimation: ', num2str(CDI.R{1}.SourceEstimation), ' g/h']}];
                                    
                                case 'False Negative'
                                    w=[w;{' '};{'Isolation Data:'};{'---------------------------------------- '};{' '}]; 
                                    w=[w;{['Isolation Decision: NO --> ', CDI.R{1}.IsolationRate]}];
                                    if ~isempty(CDI.R{1}.IsolationDecision)
                                        IDec = [];
                                        for j=1:length(CDI.R{1}.IsolationDecision)                
                                            IDec = [IDec, ' Z' num2str(CDI.R{1}.IsolationDecision(j)), '   '];                            
                                        end
                                    else
                                        IDec = '';
                                    end
                                    w=[w;{['Isolation Candidate Zones: ', IDec]}];
                        end
                        



    %                     %Detection Time
    %                     TD = CDI.R{1,1}.DetectionTime;
    %                     min = (TD - fix(TD))*60;
    %                     sec = (min - fix(min))*60;
    %                     set(handles.DetectionTimeEdit, 'String',...
    %                         sprintf('%02d:%02d:%02d',fix(TD),fix(min),fix(sec)));
    % 
    %                     %Isolation Time
    %                     TI = CDI.R{1,1}.IsolationTime;
    %                     min = (TI - fix(TI))*60;
    %                     sec = (min - fix(min))*60;
    %                     set(handles.IsolationTimeEdit, 'String',...
    %                         sprintf('%02d:%02d:%02d',fix(TI),fix(min),fix(sec)));                

                        set(handles.IsolatorPopup, 'String', 1:handles.B.nZones);
%                         set(handles.Save,'enable','on');
    %                     set(handles.DetectionTimeEdit, 'enable', 'inactive')
    %                     set(handles.IsolationTimeEdit, 'enable', 'inactive')
                        set(handles.DetectionZones,'enable','on');
                        set(handles.IsolationZones,'enable','on');
                        set(handles.PlotDetection,'enable','on');
                        set(handles.PlotIsolation,'enable','on');                     
                        set(handles.IsolatorPopup, 'enable', 'on');    
                        set(handles.DetectionThresholdCheck, 'enable', 'on');
                        set(handles.DetectionResidualCheck, 'enable', 'on');
                        set(handles.ThresholdResidualRadio, 'enable', 'on');
                        set(handles.IsolationThresholdCheck, 'enable', 'on');
                        set(handles.IsolationResidualCheck, 'enable', 'on');
                        set(handles.SourceEstimationRadio, 'enable', 'on');
                    else

                        w=[w;{' '};{'Detection Data:'};{'---------------------------------------- '};{' '}]; 
                        w=[w;{'Detection Decision: NO'}];

%                         set(handles.Save,'enable','on');
    %                     set(handles.DetectionTimeEdit, 'enable', 'off')
    %                     set(handles.IsolationTimeEdit, 'enable', 'off')
                        set(handles.DetectionZones,'enable','on');
                        set(handles.IsolationZones,'enable','off');
                        set(handles.PlotDetection,'enable','on');
                        set(handles.PlotIsolation,'enable','off');                     
                        set(handles.IsolatorPopup, 'enable', 'off');    
                        set(handles.DetectionThresholdCheck, 'enable', 'on');
                        set(handles.DetectionResidualCheck, 'enable', 'on');
                        set(handles.ThresholdResidualRadio, 'enable', 'off');
                        set(handles.IsolationThresholdCheck, 'enable', 'off');
                        set(handles.IsolationResidualCheck, 'enable', 'off');
                        set(handles.SourceEstimationRadio, 'enable', 'off');
                    end
                    w=[w;{' '}];

                    set(handles.ResultsInformationListbox,'Value',1,'ListboxTop', 1);
                    set(handles.ResultsInformationListbox,'String',w); 

                end
                set(handles.DetectionThresholdCheck, 'Value', true);
                set(handles.DetectionResidualCheck, 'Value', true);
                set(handles.ThresholdResidualRadio, 'Value', 1);
                set(handles.IsolationThresholdCheck, 'Value', true);
                set(handles.IsolationResidualCheck, 'Value', true);
                set(handles.SourceEstimationRadio, 'Value', 0);

            else
                set(handles.ScenarioPopup,'enable','off');
%                 set(handles.Save,'enable','off');
    %             set(handles.DetectionTimeEdit, 'enable', 'off')
    %             set(handles.IsolationTimeEdit, 'enable', 'off')
                set(handles.DetectionZones,'enable','off');
                set(handles.IsolationZones,'enable','off');
                set(handles.PlotDetection,'enable','off');
                set(handles.PlotIsolation,'enable','off'); 
                set(handles.SubsystemsPopup,'enable','off'); 
                set(handles.IsolatorPopup, 'enable', 'off');    
                set(handles.DetectionThresholdCheck, 'enable', 'off');
                set(handles.DetectionResidualCheck, 'enable', 'off');
                set(handles.ThresholdResidualRadio, 'enable', 'off');
                set(handles.IsolationThresholdCheck, 'enable', 'off');
                set(handles.IsolationResidualCheck, 'enable', 'off');
                set(handles.SourceEstimationRadio, 'enable', 'off');
            

            end
        else
            set(handles.ScenarioPopup,'enable','off');
%             set(handles.Save,'enable','off');
%             set(handles.DetectionTimeEdit, 'enable', 'off')
%             set(handles.IsolationTimeEdit, 'enable', 'off')
            set(handles.DetectionZones,'enable','off');
            set(handles.IsolationZones,'enable','off');
            set(handles.PlotDetection,'enable','off');
            set(handles.PlotIsolation,'enable','off'); 
            set(handles.SubsystemsPopup,'enable','off'); 
            set(handles.IsolatorPopup, 'enable', 'off');    
            set(handles.DetectionThresholdCheck, 'enable', 'off');
            set(handles.DetectionResidualCheck, 'enable', 'off');
            set(handles.ThresholdResidualRadio, 'enable', 'off');
            set(handles.IsolationThresholdCheck, 'enable', 'off');
            set(handles.IsolationResidualCheck, 'enable', 'off');
            set(handles.SourceEstimationRadio, 'enable', 'off');            
        end
    else
       set(handles.LoadCDI,'enable','off');   
    end
end



% Update handles structure
guidata(hObject, handles);

temp_handle.Pointer='arrow';
clear temp_handle


uiwait

% UIWAIT makes CDIResultsGUI2 wait for user response (see UIRESUME)
% uiwait(handles.CDIResultsGUI2);
function fillScenarioResultsPanel (pathname,file0,ResultsPanel,P)
 % This function is used for loading all the scenarios into each tab of the scenario results table   
        % Find all scenario files from folder
    
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        handles.CDIResultsGUI2.Pointer='watch';
        drawnow;

    % Find all scenario files from folder
    fileNames=dir([pathname,file0,'.cdi*']);
    
    for i =1:size(P.ScenariosFlowIndex,1)
        ScenarioFileNames{i}=[file0 '.cdi' num2str(i)];
    end
    
    % If tabgroup exists then delete its childres else create it
    if ~isempty(ResultsPanel.Children)
        % If the scenarios are allready loaded then return
        C1 = strsplit(ResultsPanel.Children.Children(1).Title,'.cdi');
        if strcmp(C1{1},file0)
            return
        end
        % Delete tabs and not tabgroup for performance
        if ~isempty(ResultsPanel.Children.Children(1).Children)
            for i=1:length(ResultsPanel.Children.Children)
                delete(ResultsPanel.Children.Children(i).Children)
            end
            delete(ResultsPanel.Children.Children)
        else
            delete(ResultsPanel.Children.Children)
        end
        tgroup=ResultsPanel.Children;
    else
        tgroup = uitabgroup('Parent',ResultsPanel);

    end
    
    tgroup.Position(3:4)=[1,1];
    
    for i=1:length(ScenarioFileNames)
        
        
        SceNum{1}=num2str(i);
        
        if ~exist([pathname,ScenarioFileNames{i}], 'file')
            uiwait(warndlg('Either some or all result files are missing','!! Warning !!','modal'))
            return
        end
        load([pathname,ScenarioFileNames{i}],'-mat');
        % After loading the CDI file we check whether is the distributed or the centralized
        % case from the number of subsystems
        
        if CDI.nSub==0
            max_iteration=1;
        else
            max_iteration=CDI.nSub;
        end
%         for c=1:max_iteration
            %%%%%%%%%%%%%%%%%%%%%%%% Plot results in matrix tab form
            %%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%
            %%% Here i need to check that if many scenarios are loaded
            %%% the tabs appear OK on the panel
            tab{i} = uitab('Parent',tgroup, 'Title', ScenarioFileNames{i});
           
            RowNames={};
            for j=1: size(P.ScenariosContamIndex,1)
                RowNames{j}= ['Sc. ' num2str(j)];
            end

           
            
            if CDI.nSub==0
                ScenarioResultsDisplayTable = uitable(tab{i});
%                 ScenarioResultsDisplayTable.CellSelectionCallback=@ScenarioResultsDisplayTable_CellSelectionCallback;
    %             ScenarioResultsDisplayTable.KeyPressFcn=@ResultsTable_KeyPressFcn
                ScenarioResultsDisplayTable.Data=cell(1,1);
                ScenarioResultsDisplayTable.Units='normalized';
                ScenarioResultsDisplayTable.Position=[0 0 1 1];
            
                ScenarioResultsDisplayTable.ColumnName={' Wind Direction (degrees) ';' WindSpeed (m/s) '; ' Number of sources ';...
                                                        ' Source Location ';' Source Generation Rate (g/hr) '; ' Release Time (hr)';'Duration (hr)';...
                                                        'Detection Time (hr)';'Detection Delay (hr)';'Detection Decision';'Isolation Time (hr)';'Isolation Delay (hr)';...
                                                        'Isolation Decision';'Isolation Zone';'Source Estimation'};
                ScenarioResultsDisplayTable.ColumnFormat = {'char', 'char','char', 'char','char', 'char','char','char', 'char','char', 'char','char', 'char','char'};

                ScenarioResultsDisplayTable.RowName=RowNames;
                ScenarioResultsDisplayTable.ColumnWidth='auto';

                % ScenarioResultsDisplayTable.RearrangeableColumns='off'; % If the user is allowed to sellect anything from the table this property must be turned off
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

                    
                    if strcmp(CDI.R{j}.DetectionRate,'True Alarm')
                        DetectionDecision='YES';
                        DetectionTime=CDI.R{j}.DetectionTime;
                        DetectionDelay=CDI.R{j}.DetectionDelay;
                    else
                        DetectionDecision='NO';
                        DetectionTime=[];
                        DetectionDelay=[];
                    end
                    
                    if strcmp(CDI.R{j}.IsolationRate,'True Positive')
                        IsolationDecision='YES';
                        IsolationZone=['Z' num2str(CDI.R{j}.IsolationDecision)];
                        IsolationTime=CDI.R{j}.IsolationTime;
                        IsolationDelay=CDI.R{j}.IsolationDelay;
                    else
                        IsolationDecision='NO';
                        IsolationZone=[];
                        IsolationTime=[];
                        IsolationDelay=[];
                    end
%                     IsolationRate=CDI.R{j}.IsolationRate;
                    SourceEstimation=CDI.R{j}.SourceEstimation;
%                     tab2new = uitab('Parent',tab{1}, 'Title', ScenarioFileNames{i});

                    ScenarioResultsDisplayTable.Data(j,1:15)={P.FlowParamScenarios{1}(idx(1)),P.FlowParamScenarios{2}(idx(2)),P.SourcesMax...
                                                                   SL,SR,RT,DT,DetectionTime,DetectionDelay,DetectionDecision,IsolationTime,...
                                                                   IsolationDelay,IsolationDecision,IsolationZone,SourceEstimation};
                end
            else
                
                tgroup2 = uitabgroup('Parent',tab{i});
                for c=1:CDI.nSub

                    tab2{c} = uitab('Parent',tgroup2, 'Title', ['Subsystem ' num2str(c)]);

                    ScenarioResultsDisplayTable = uitable(tab2{c});
%                     ScenarioResultsDisplayTable.CellSelectionCallback=@ScenarioResultsDisplayTable_CellSelectionCallback;
    %             ScenarioResultsDisplayTable.KeyPressFcn=@ResultsTable_KeyPressFcn
                    ScenarioResultsDisplayTable.Data=cell(1,1);
                    ScenarioResultsDisplayTable.Units='normalized';
                    ScenarioResultsDisplayTable.Position=[0 0 0.99 0.99];
                    subColumnNames=[];
                
                    
                    ScenarioResultsDisplayTable.ColumnName={' Zones ';' Wind Direction (degrees) ';' WindSpeed (m/s) '; ' Number of sources ';...
                                                        ' Source Location ';' Source Generation Rate (g/hr) '; ' Release Time (hr)';'Duration (hr)';...
                                                        'Detection Time (hr)';'Detection Delay (hr)';'Detection Decision';'Isolation Time (hr)';'Isolation Delay (hr)';...
                                                        'Isolation Decision';'Isolation Zone';'Source Estimation'};
                    ScenarioResultsDisplayTable.ColumnFormat = {'char','char', 'char','char', 'char','char', 'char','char','char', 'char','char', 'char','char', 'char','char'};

                    ScenarioResultsDisplayTable.RowName=RowNames;
                    ScenarioResultsDisplayTable.ColumnWidth='auto';

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

                        
                        if strcmp(CDI.R{j}.DetectionRate{c},'True Alarm')
                            DetectionDecision='YES';
                            DetectionTime=CDI.R{j}.DetectionTime{c};
                            DetectionDelay=CDI.R{j}.DetectionDelay{c};
                        else
                            DetectionDecision='NO';
                            DetectionTime=[];
                            DetectionDelay=[];
                        end
%                         DetectionRate=CDI.R{j}.DetectionRate{c};
                        
                        if strcmp(CDI.R{j}.IsolationRate{c},'True Positive')
                            IsolationDecision='YES';
                            IsolationZone=['Z' num2str(CDI.R{j}.IsolationDecision{c})];
                            IsolationTime=CDI.R{j}.IsolationTime{c};
                            IsolationDelay=CDI.R{j}.IsolationDelay{c};
                        else
                            IsolationDecision='NO';
                            IsolationZone=[];
                            IsolationTime=[];
                            IsolationDelay=[];
                        end
%                         IsolationRate=CDI.R{j}.IsolationRate{c};
                        SourceEstimation=CDI.R{j}.SourceEstimation{c};
                        
                        zone_names={'['};
                        for k=1:length(CDI.SubsystemZones{c})
                            if k~=length(CDI.SubsystemZones{c})
                             s_temp=sprintf('Z%d,',CDI.SubsystemZones{c}(k));
                            else
                               s_temp=sprintf('Z%d]',CDI.SubsystemZones{c}(k));
                            end
                             zone_names=strcat(zone_names,s_temp);   
                        end
                        ScenarioResultsDisplayTable.Data(j,1)=zone_names(1);
                        ScenarioResultsDisplayTable.Data(j,2:16)={P.FlowParamScenarios{1}(idx(1)),P.FlowParamScenarios{2}(idx(2)),P.SourcesMax...
                                                                       SL,SR,RT,DT,DetectionTime,DetectionDelay,DetectionDecision,IsolationTime,...
                                                                       IsolationDelay,IsolationDecision,IsolationZone,SourceEstimation};
                    end
                end
                
            end
%                 subColumnNames=[];
%                 for c=1:CDI.nSub
%                 
%                     subColumnNames=[subColumnNames;['Subsystem | ' num2str(c)]]
%                     
%                 end
%                 ScenarioResultsDisplayTable.ColumnName={' Wind Direction |(degrees) ';' Wind Speed | (m/s) '; ' Number of |sources ';...
%                                                         ' Source | Location ';' Source Generation | Rate (g/hr) '; ' Release Time | (hr)';'Duration | (hr)';...
%                                                         subColumnNames};
%                  ScenarioResultsDisplayTable.ColumnFormat = {'char', 'char','char', 'char','char', 'char','char'};
% 
%                 ScenarioResultsDisplayTable.RowName=[' ',RowNames];
%                 ScenarioResultsDisplayTable.ColumnWidth='auto';                                   
%                 for c=1:CDI.nSub
%                         colergen = @(color,Col1,Col2,Col3,Col4,Col5,Col6,Col7,Col8) ['<html><table cellspacing=0 cellpadding=2 table border=1 frame=hsides rules=lcolumns width=1000 bgcolor=',color,...
%                             '><TR><TD>',Col1,'</TD><TD>',Col2,'</TD><TD>',Col3,'</TD><TD>',Col4,'</TD><TD>',Col5,'</TD><TD>',Col6,...
%                             '</TD><TD>',Col7,'</TD><TD>',Col8,'</TD></TR></table></html>'];
% 
%                     ScenarioResultsDisplayTable.Data(1,7+c)={colergen('#F0F0F0','Zones','Detection Time (hr)','Detection Delay (hr)','Detection Rate','Isolation Time (hr)',...
%                                                                 'Isolation Delay (hr)','Isolation Rate','Source Estimation')};
%                     ScenarioResultsDisplayTable.ColumnEditable(7+c)=0;
%                     ScenarioResultsDisplayTable.ColumnWidth={'auto','auto','auto','auto','auto','auto','auto',1000,1000};
% %                     ScenarioResultsDisplayTable.RowStriping{7+c}=;
%                 end
% %                     SubsystemResultsTable.Data={'alexis','pavlos','christina'}
% %                                                         'Detection Time (hr)';'Detection Delay (hr)';'Detection Rate';'Isolation Time (hr)';'Isolation Delay (hr)';...
% %                                                         'Isolation Rate';'Source Estimation'};
%                 ScenarioResultsDisplayTable.ColumnFormat = {'char', 'char','char', 'char','char', 'char','char'};
% 
% %                 ScenarioResultsDisplayTable.RowName=RowNames;
% %                 ScenarioResultsDisplayTable.ColumnWidth='auto';
% 
%                 % ScenarioResultsDisplayTable.RearrangeableColumns='off'; % If the user is allowed to sellect anything from the table this property must be turned off
%                 for j=1:size(P.ScenariosContamIndex,1)
%                     idx = P.ScenariosFlowIndex(str2double(SceNum{1}),:);
%                     idx2 = P.ScenariosContamIndex(j,:);
%                     SL=[];SR=[];RT=[];DT=[];
%                     for k = 1:length(P.SourceLocationScenarios{idx2(4)}) % For loop in case of multible sources
%                         SL = [SL, 'Z',num2str(P.SourceLocationScenarios{idx2(4)}(1)), '  '];
%                         SR = [SR, num2str(P.SourceParamScenarios{1}(idx2(1))), '  '];
%                         RT = [RT, num2str(P.SourceParamScenarios{2}(idx2(2))), '  '];
%                         DT = [DT, num2str(P.SourceParamScenarios{3}(idx2(3))), '  '];
%                     end
% 
%                     DetectionTime=CDI.R{j}.DetectionTime;
%                     DetectionDelay=CDI.R{j}.DetectionDelay;
%                     DetectionRate=CDI.R{j}.DetectionRate;
%                     IsolationTime=CDI.R{j}.IsolationTime;
%                     IsolationDelay=CDI.R{j}.IsolationDelay;
%                     IsolationRate=CDI.R{j}.IsolationRate;
%                     SourceEstimation=CDI.R{j}.SourceEstimation;
% 
%                     ScenarioResultsDisplayTable.Data(j,1:14)={P.FlowParamScenarios{1}(idx(1)),P.FlowParamScenarios{2}(idx(2)),P.SourcesMax...
%                                                                    SL,SR,RT,DT,DetectionTime,DetectionDelay,DetectionRate,IsolationTime,...
%                                                                    IsolationDelay,IsolationRate,SourceEstimation};
%                 end
%                 
%             end
%             end
    end
    handles.CDIResultsGUI2.Pointer='arrow';

% --- Outputs from this function are returned to the command line.
function varargout = CDIResultsGUI2_OutputFcn(hObject, eventdata, handles) 
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
        set(handles.LoadCDI,'enable','off');
        uiwait(msgbox(['        Wrong File "',pathfile0,'.0"'],'Error','modal'));
        set(handles.ScenariosFileText,'String','')
        set(handles.CDIFileText,'String', ' ')
%         set(handles.Save,'enable','off');
        set(handles.DetectionZones,'enable','off');        
        set(handles.IsolationZones,'enable','off');
        set(handles.PlotDetection,'enable','off');
        set(handles.PlotIsolation,'enable','off'); 
        set(handles.ScenarioPopup,'enable','off', 'String', ' ');
        set(handles.SubsystemsPopup,'enable','off', 'String', ' '); 
        set(handles.IsolatorPopup, 'enable', 'off', 'String', ' ');    
        set(handles.DetectionThresholdCheck, 'enable', 'off');
        set(handles.DetectionResidualCheck, 'enable', 'off');
        set(handles.ThresholdResidualRadio, 'enable', 'off');
        set(handles.IsolationThresholdCheck, 'enable', 'off');
        set(handles.IsolationResidualCheck, 'enable', 'off');
        set(handles.SourceEstimationRadio, 'enable', 'off');
    else
        set(handles.LoadCDI,'enable','on');
%         set(handles.Save,'enable','off');
        set(handles.DetectionZones,'enable','off');        
        set(handles.IsolationZones,'enable','off');
        set(handles.PlotDetection,'enable','off');
        set(handles.PlotIsolation,'enable','off'); 
        set(handles.ScenarioPopup,'enable','off', 'String', ' ');
        set(handles.SubsystemsPopup,'enable','off', 'String', ' '); 
        set(handles.IsolatorPopup, 'enable', 'off', 'String', ' ');    
        set(handles.DetectionThresholdCheck, 'enable', 'off');
        set(handles.DetectionResidualCheck, 'enable', 'off');
        set(handles.ThresholdResidualRadio, 'enable', 'off');
        set(handles.IsolationThresholdCheck, 'enable', 'off');
        set(handles.IsolationResidualCheck, 'enable', 'off');
        set(handles.SourceEstimationRadio, 'enable', 'off');
%         set(handles.DetectionTimeEdit, 'enable', 'off', 'String', ' ')
%         set(handles.IsolationTimeEdit, 'enable', 'off', 'String', ' ')
        set(handles.CDIFileText,'String', ' ')
        set(handles.ScenariosFileText,'String',[file0,'.0']);
    end
    handles.P=P;
    handles.B=B;
    % Update handles structure
    guidata(hObject, handles);
end


function ScenariosFileEdit_Callback(hObject, eventdata, handles)
% hObject    handle to ScenariosFileText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ScenariosFileText as text
%        str2double(get(hObject,'String')) returns contents of ScenariosFileText as a double


% --- Executes during object creation, after setting all properties.
function ScenariosFileText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ScenariosFileText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LoadCDI.
function LoadCDI_Callback(hObject, eventdata, handles)
% hObject    handle to LoadCDI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.CDIResultsGUI2.Pointer='watch';
drawnow;

[fileCDI,pathName] = uigetfile([pwd,'\RESULTS\*.cdi*'],'Select the MATLAB *.cdi* file');
pathfileCDI=[pathName,fileCDI];
pathfileCDI=pathfileCDI(1:end-2);

% handles.CDIResultsGUI2.Pointer
if isnumeric(pathfileCDI)
    pathfileCDI=[];
end

if ~isempty((pathfileCDI)) 
    load([pathName,fileCDI],'-mat');
     handles.fileCDI=fileCDI;
    handles.chooseZoneDetection = [];
    handles.chooseZoneIsolation = [];
    C = strsplit(handles.fileCDI,'.cdi');

    if ~strcmp(handles.file0,C{1}(1:end-12))
%         set(handles.Solve,'enable','off');
        uiwait(msgbox(['        Wrong File "',pathName,fileCDI,'"'],'Error','modal'));
        set(handles.CDIFileText,'String',' ')
        set(handles.ScenarioPopup,'enable','off', 'String', ' ');
%         set(handles.Save,'enable','off');
%         set(handles.DetectionTimeEdit, 'enable', 'off', 'String', ' ')
%         set(handles.IsolationTimeEdit, 'enable', 'off', 'String', ' ')
        set(handles.DetectionZones,'enable','off');
        set(handles.IsolationZones,'enable','off');
        set(handles.PlotDetection,'enable','off');
        set(handles.PlotIsolation,'enable','off'); 
        set(handles.SubsystemsPopup,'enable','off', 'String', ' '); 
        set(handles.IsolatorPopup, 'enable', 'off', 'String', ' ');    
        set(handles.DetectionThresholdCheck, 'enable', 'off');
        set(handles.DetectionResidualCheck, 'enable', 'off');
        set(handles.ThresholdResidualRadio, 'enable', 'off');
        set(handles.IsolationThresholdCheck, 'enable', 'off');
        set(handles.IsolationResidualCheck, 'enable', 'off');
        set(handles.SourceEstimationRadio, 'enable', 'off');
            handles.CDIResultsGUI2.Pointer='arrow';

        return
    else
%         set(handles.Solve,'enable','on');
        set(handles.CDIFileText,'String',fileCDI);
        set(handles.ScenarioPopup,'enable','on');
        set(handles.ScenarioPopup,'String',1:length(CDI.R));
        set(handles.ScenarioPopup,'Value',1);
               
        
        [Path Name Extension] =  fileparts(fileCDI);
        SceNum = regexp(Extension,'\d+','match');
        set(handles.ResultsInformationListbox,'Foregroundcolor','b');
        set(handles.ResultsInformationListbox,'fontsize',8);
        
        
        if CDI.nSub ~= 0
            fillScenarioResultsPanel (pathName, [handles.file0 '_Distributed'],handles.ScerarioResultsPanel,handles.P);

            switch handles.P.Method
                case 'grid'
                    idx = handles.P.ScenariosFlowIndex(str2double(SceNum{1}),:);
                    idx2 = handles.P.ScenariosContamIndex(1,:);                    
                case 'random'
                    idx = handles.P.ScenariosFlowIndex(str2double(SceNum{1}),:);
                    idx2 = handles.P.ScenariosContamIndex(str2double(SceNum{1}),:); 
            end
            
%             idx = handles.P.ScenariosFlowIndex(str2double(SceNum{1}),:);
%             idx2 = handles.P.ScenariosContamIndex(1,:);

            w=[{'********************************* '};{'Scenario Data'};{'********************************* '}];
            w=[w;{' '};{'Weather Data:'};{'---------------------------------------- '};{' '}];            
            w=[w;{['Wind Direction: ',num2str(handles.P.FlowParamScenarios{1}(idx(1))), ' ^{o}']}];
            w=[w;{['Wind Speed: ',num2str(handles.P.FlowParamScenarios{2}(idx(2))), ' m/s']}; {' '}];
            w=[w;{'Source Data:'};{'---------------------------------------- '};{' '}];
            w=[w;{['Number of contaminant sources: ',num2str(length(handles.P.SourceLocationScenarios{idx2(4)}))]}];

            SL = []; SR = []; RT = []; DT = [];
            for i = 1:length(handles.P.SourceLocationScenarios{idx2(4)})
                SL = [SL, 'Z',num2str(handles.P.SourceLocationScenarios{idx2(4)}(i)), '   '];
                SR = [SR, num2str(handles.P.SourceParamScenarios{1}(idx2(1))),' g/hr   '];
                RT = [RT, num2str(handles.P.SourceParamScenarios{2}(idx2(2))), ' hr   '];
                DT = [DT, num2str(handles.P.SourceParamScenarios{2}(idx2(2))), ' hr   '];
            end

            w=[w;{['Source location: ', SL]}];
            w=[w;{['Source genaration rate : ', SR]}];
            w=[w;{['Release time: ', RT]}];
            w=[w;{['Duration Time: ', DT]};{' '}];

            w=[w;{'********************************* '};{'Distributed CDI Data'};{'********************************* '};{' '}];

            w=[w;{' '};{'Assumed Nominal Weather Data:'};{'---------------------------------------- '};{' '}]; 
            w=[w;{['Wind Direction: ',num2str(handles.P.WindDirection), ' ^{o}']}];
            w=[w;{['Wind Speed: ',num2str(handles.P.WindSpeed), ' m/s']}; {' '}];

            w=[w;{['Number of subsystems: ', num2str(CDI.nSub)]};{' '}];
            w=[w;{' '}];

            for i=1:CDI.nSub
                w=[w;{['Subsystem ', num2str(i), ' data:']};{'---------------------------------------- '}];
                ZN = [];
                for j = 1:length(CDI.SubsystemZones{i})
                    ZN = [ZN, 'Z',num2str(CDI.SubsystemZones{i}(j)), '   '];                        
                end
                w=[w;{['Zones: ', ZN]};{' '}];

                w=[w;{' '};{'Bound Data:'};{'---------------------------------------- '};{' '}]; 
                w=[w;{['Uncertainties bound:  DA = ',num2str(CDI.Param.UncertaintiesBoundDA{i}), ',   DH = ',num2str(CDI.Param.UncertaintiesBoundDH{i})]}];
                w=[w;{['Noise bound:  w = ', num2str(CDI.Param.NoiseBound{i})]};{' '}];



                if ~isempty(CDI.R{1}.DetectionTime{i})
                    %Detection Time
                    DT = CDI.R{1}.DetectionTime{i};
                    min = (DT - fix(DT))*60;
                    sec = (min - fix(min))*60;
                    DT = sprintf('%02d:%02d:%02d',fix(DT),fix(min),fix(sec));

                    %Detection Delay
                    DD = CDI.R{1}.DetectionDelay{i};
                    min = (DD - fix(DD))*60;
                    sec = (min - fix(min))*60;
                    DD = sprintf('%02d:%02d:%02d',fix(DD),fix(min),fix(sec));
                    
                    switch CDI.R{1}.IsolationRate{i}
                        case {'True Positive', 'False Positive'}
                                    
                            %Isolation Time
                            IT = CDI.R{1}.IsolationTime{i};
                            min = (IT - fix(IT))*60;
                            sec = (min - fix(min))*60;
                            IT = sprintf('%02d:%02d:%02d',fix(IT),fix(min),fix(sec));

                            %Isolation Delay
                            ID = CDI.R{1}.IsolationDelay{i};
                            min = (ID - fix(ID))*60;
                            sec = (min - fix(min))*60;
                            ID = sprintf('%02d:%02d:%02d',fix(ID),fix(min),fix(sec));

                            w=[w;{' '};{'Detection Data:'};{'---------------------------------------- '};{' '}]; 
                            w=[w;{['Detection Decision: YES --> ', CDI.R{1}.DetectionRate{i}]}];
                            w=[w;{['Detection Time: ', DT]}];
                            w=[w;{['Detection Delay: ', DD]};{' '}];

                            w=[w;{' '};{'Isolation Data:'};{'---------------------------------------- '};{' '}]; 
                            w=[w;{['Isolation Decision: ', CDI.R{1}.IsolationRate{i}]}];
                            w=[w;{['Isolation Time: ', IT]}];
                            w=[w;{['Isolation Delay: ', ID]}];
                            if ~isempty(CDI.R{1}.IsolationDecision{i})
                                IDec = [];
                                for j=1:length(CDI.R{1}.IsolationDecision{i})
                                    k = CDI.R{1}.IsolationDecision{i}(j);
                                    IDec = [IDec, ' Z' num2str(CDI.SubsystemZones{i}(k)), '   '];                            
                                end
                            else
                                IDec = '';
                            end
                            w=[w;{['Isolation Candidate Zones: ', IDec]}];
                            w=[w;{['Source Estimation: ', num2str(CDI.R{1}.SourceEstimation{i}), ' g/h']}];
                        case 'False Negative'
                            w=[w;{' '};{'Isolation Data:'};{'---------------------------------------- '};{' '}]; 
                            w=[w;{['Isolation Decision: NO -- > ', CDI.R{1}.IsolationRate{i}]}];
                            if ~isempty(CDI.R{1}.IsolationDecision{i})
                                IDec = [];
                                for j=1:length(CDI.R{1}.IsolationDecision{i})
                                    k = CDI.R{1}.IsolationDecision{i}(j);
                                    IDec = [IDec, ' Z' num2str(CDI.SubsystemZones{i}(k)), '   '];                            
                                end
                            else
                                IDec = '';
                            end
                            w=[w;{['Isolation Candidate Zones: ', IDec]}];                       
                            
                    end
                else
                    w=[w;{' '};{'Detection Data:'};{'---------------------------------------- '};{' '}]; 
                    w=[w;{'Detection Decision: NO'}];
                end

                w=[w;{' '}];
            end

            set(handles.ResultsInformationListbox,'Value',1,'ListboxTop', 1);
            set(handles.ResultsInformationListbox,'String',w);

            
            set(handles.SubsystemsPopup,'enable','on');            
            set(handles.SubsystemsPopup,'String',1:CDI.nSub);
            set(handles.SubsystemsPopup,'Value',1);

            k = 1;
            for i=1:length(CDI.SubsystemZones{1})
                if max(find(handles.B.Sensors == CDI.SubsystemZones{1}(i)))
                    handles.chooseZoneDetection(k) = true;
                    handles.chooseZoneIsolation(k) = true;
                    k = k + 1;
                end
            end

            if ~isempty(CDI.R{1,1}.DetectionTime{1})  
%                 %Detection Time
%                 DT = CDI.R{1,1}.DetectionTime{1};
%                 min = (DT - fix(DT))*60;
%                 sec = (min - fix(min))*60;
%                 set(handles.DetectionTimeEdit, 'String',...
%                     sprintf('%02d:%02d:%02d',fix(DT),fix(min),fix(sec)));
% 
%                 %Isolation Time
%                 IT = CDI.R{1,1}.IsolationTime{1};
%                 min = (IT - fix(IT))*60;
%                 sec = (min - fix(min))*60;
%                 set(handles.IsolationTimeEdit, 'String',...
%                     sprintf('%02d:%02d:%02d',fix(IT),fix(min),fix(sec)));                

                set(handles.IsolatorPopup, 'String', 1:length(CDI.SubsystemZones{1}));                
%                 set(handles.Save,'enable','on');
%                 set(handles.DetectionTimeEdit, 'enable', 'inactive')
%                 set(handles.IsolationTimeEdit, 'enable', 'inactive')
                set(handles.DetectionZones,'enable','on');
                set(handles.IsolationZones,'enable','on');
                set(handles.PlotDetection,'enable','on');
                set(handles.PlotIsolation,'enable','on');                     
                set(handles.IsolatorPopup, 'enable', 'on');    
                set(handles.DetectionThresholdCheck, 'enable', 'on');
                set(handles.DetectionResidualCheck, 'enable', 'on');
                set(handles.ThresholdResidualRadio, 'enable', 'on');
                set(handles.IsolationThresholdCheck, 'enable', 'on');
                set(handles.IsolationResidualCheck, 'enable', 'on');
                set(handles.SourceEstimationRadio, 'enable', 'on');
            else
%                 set(handles.Save,'enable','on');
%                 set(handles.DetectionTimeEdit, 'enable', 'off', 'String', ' ')
%                 set(handles.IsolationTimeEdit, 'enable', 'off', 'String', ' ')
                set(handles.DetectionZones,'enable','on');
                set(handles.IsolationZones,'enable','off');
                set(handles.PlotDetection,'enable','on');
                set(handles.PlotIsolation,'enable','off');                     
                set(handles.IsolatorPopup, 'enable', 'off');    
                set(handles.DetectionThresholdCheck, 'enable', 'on');
                set(handles.DetectionResidualCheck, 'enable', 'on');
                set(handles.ThresholdResidualRadio, 'enable', 'off');
                set(handles.IsolationThresholdCheck, 'enable', 'off');
                set(handles.IsolationResidualCheck, 'enable', 'off');
                set(handles.SourceEstimationRadio, 'enable', 'off');

            end

        else
            fillScenarioResultsPanel (pathName, [handles.file0 '_Centralized'],handles.ScerarioResultsPanel,handles.P);

            switch handles.P.Method
                case 'grid'
                    idx = handles.P.ScenariosFlowIndex(str2double(SceNum{1}),:);
                    idx2 = handles.P.ScenariosContamIndex(1,:);                    
                case 'random'
                    idx = handles.P.ScenariosFlowIndex(str2double(SceNum{1}),:);
                    idx2 = handles.P.ScenariosContamIndex(str2double(SceNum{1}),:); 
            end
            
%             idx = handles.P.ScenariosFlowIndex(str2double(SceNum{1}),:);
%             idx2 = handles.P.ScenariosContamIndex(1,:);

            w=[{'********************************* '};{'Scenario Data'};{'********************************* '}];
            w=[w;{' '};{'Weather Data:'};{'---------------------------------------- '};{' '}];            
            w=[w;{['Wind Direction: ',num2str(handles.P.FlowParamScenarios{1}(idx(1))), ' ^{o}']}];
            w=[w;{['Wind Speed: ',num2str(handles.P.FlowParamScenarios{2}(idx(2))), ' m/s']}; {' '}];
            w=[w;{'Source Data:'};{'---------------------------------------- '};{' '}];
            w=[w;{['Number of contaminant sources: ',num2str(length(handles.P.SourceLocationScenarios{idx2(4)}))]}];

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

            w=[w;{'********************************* '};{'CDI Data'};{'********************************* '};{' '}];

            w=[w;{' '};{'Assumed Nominal Weather Data:'};{'---------------------------------------- '};{' '}]; 
            w=[w;{['Wind Direction: ',num2str(handles.P.WindDirection), ' ^{o}']}];
            w=[w;{['Wind Speed: ',num2str(handles.P.WindSpeed), ' m/s']}; {' '}];
            
            
            w=[w;{' '};{'Bound Data:'};{'---------------------------------------- '};{' '}]; 
            w=[w;{['Uncertainties bound:  DA = ',num2str(CDI.Param.UncertaintiesBound)]}];
            w=[w;{['Noise bound:  w = ', num2str(CDI.Param.NoiseBound)]};{' '}];


            if ~isempty(CDI.R{1}.DetectionTime)
                %Detection Time
                DT = CDI.R{1}.DetectionTime;
                min = (DT - fix(DT))*60;
                sec = (min - fix(min))*60;
                DT = sprintf('%02d:%02d:%02d',fix(DT),fix(min),fix(sec));

                %Detection Delay
                DD = CDI.R{1}.DetectionDelay;
                min = (DD - fix(DD))*60;
                sec = (min - fix(min))*60;
                DD = sprintf('%02d:%02d:%02d',fix(DD),fix(min),fix(sec));
                
                switch CDI.R{1}.IsolationRate
                    case {'True Positive', 'False Positive'}

                        %Isolation Time
                        IT = CDI.R{1}.IsolationTime;
                        min = (IT - fix(IT))*60;
                        sec = (min - fix(min))*60;
                        IT = sprintf('%02d:%02d:%02d',fix(IT),fix(min),fix(sec));

                        %Isolation Delay
                        ID = CDI.R{1}.IsolationDelay;
                        min = (ID - fix(ID))*60;
                        sec = (min - fix(min))*60;
                        ID = sprintf('%02d:%02d:%02d',fix(ID),fix(min),fix(sec));

                        w=[w;{' '};{'Detection Data:'};{'---------------------------------------- '};{' '}]; 
                        w=[w;{['Detection Decision: YES --> ', CDI.R{1}.DetectionRate]}];
                        w=[w;{['Detection Time: ', DT]}];
                        w=[w;{['Detection Delay: ', DD]};{' '}];

                        w=[w;{' '};{'Isolation Data:'};{'---------------------------------------- '};{' '}]; 
                        w=[w;{['Isolation Decision: ', CDI.R{1}.IsolationRate]}];
                        w=[w;{['Isolation Time: ', IT]}];
                        w=[w;{['Isolation Delay: ', ID]}];
                        if ~isempty(CDI.R{1}.IsolationDecision)
                            IDec = [];
                            for j=1:length(CDI.R{1}.IsolationDecision)                
                                IDec = [IDec, ' Z' num2str(CDI.R{1}.IsolationDecision(j)), '   '];                            
                            end
                        else
                            IDec = '';
                        end
                        w=[w;{['Isolation Candidate Zones: ', IDec]}];
                        w=[w;{['Source Estimation: ', num2str(CDI.R{1}.SourceEstimation), ' g/h']}];
                    case 'False Negative'
                        w=[w;{' '};{'Isolation Data:'};{'---------------------------------------- '};{' '}]; 
                        w=[w;{['Isolation Decision: NO --> ', CDI.R{1}.IsolationRate]}];
                        if ~isempty(CDI.R{1}.IsolationDecision)
                            IDec = [];
                            for j=1:length(CDI.R{1}.IsolationDecision)                
                                IDec = [IDec, ' Z' num2str(CDI.R{1}.IsolationDecision(j)), '   '];                            
                            end
                        else
                            IDec = '';
                        end
                        w=[w;{['Isolation Candidate Zones: ', IDec]}];
                end
                
                set(handles.IsolatorPopup, 'String', 1:handles.B.nZones);                
%                 set(handles.Save,'enable','on');
%                 set(handles.DetectionTimeEdit, 'enable', 'inactive')
%                 set(handles.IsolationTimeEdit, 'enable', 'inactive')
                set(handles.DetectionZones,'enable','on');
                set(handles.IsolationZones,'enable','on');
                set(handles.PlotDetection,'enable','on');
                set(handles.PlotIsolation,'enable','on');                     
                set(handles.IsolatorPopup, 'enable', 'on');    
                set(handles.DetectionThresholdCheck, 'enable', 'on');
                set(handles.DetectionResidualCheck, 'enable', 'on');
                set(handles.ThresholdResidualRadio, 'enable', 'on');
                set(handles.IsolationThresholdCheck, 'enable', 'on');
                set(handles.IsolationResidualCheck, 'enable', 'on');
                set(handles.SourceEstimationRadio, 'enable', 'on');
                
            else
                w=[w;{' '};{'Detection Data:'};{'---------------------------------------- '};{' '}]; 
                w=[w;{'Detection Decision: NO'}];
                
%                 set(handles.Save,'enable','on');
%                 set(handles.DetectionTimeEdit, 'enable', 'off', 'String', ' ')
%                 set(handles.IsolationTimeEdit, 'enable', 'off', 'String', ' ')
                set(handles.DetectionZones,'enable','on');
                set(handles.IsolationZones,'enable','off');
                set(handles.PlotDetection,'enable','on');
                set(handles.PlotIsolation,'enable','off');                     
                set(handles.IsolatorPopup, 'enable', 'off', 'String', ' ');    
                set(handles.DetectionThresholdCheck, 'enable', 'on');
                set(handles.DetectionResidualCheck, 'enable', 'on');
                set(handles.ThresholdResidualRadio, 'enable', 'off');
                set(handles.IsolationThresholdCheck, 'enable', 'off');
                set(handles.IsolationResidualCheck, 'enable', 'off');
                set(handles.SourceEstimationRadio, 'enable', 'off');
            end

            w=[w;{' '}];
            
            set(handles.ResultsInformationListbox,'Value',1,'ListboxTop', 1);
            set(handles.ResultsInformationListbox,'String',w);              
            
            set(handles.SubsystemsPopup,'enable','off');
            for i=1:handles.B.nS
                handles.chooseZoneDetection(i) = true;
                handles.chooseZoneIsolation(i) = true;
            end


%             if ~isempty(CDI.R{1,1}.DetectionTime)
%                 %Detection Time
%                 TD = CDI.R{1,1}.DetectionTime;
%                 min = (TD - fix(TD))*60;
%                 sec = (min - fix(min))*60;
%                 set(handles.DetectionTimeEdit, 'String',...
%                     sprintf('%02d:%02d:%02d',fix(TD),fix(min),fix(sec)));
% 
%                 %Isolation Time
%                 TI = CDI.R{1,1}.IsolationTime;
%                 min = (TI - fix(TI))*60;
%                 sec = (min - fix(min))*60;
%                 set(handles.IsolationTimeEdit, 'String',...
%                     sprintf('%02d:%02d:%02d',fix(TI),fix(min),fix(sec)));                
% 
%                 set(handles.IsolatorPopup, 'String', 1:handles.B.nZones);                
%                 set(handles.Save,'enable','on');
%                 set(handles.DetectionTimeEdit, 'enable', 'inactive')
%                 set(handles.IsolationTimeEdit, 'enable', 'inactive')
%                 set(handles.DetectionZones,'enable','on');
%                 set(handles.IsolationZones,'enable','on');
%                 set(handles.PlotDetection,'enable','on');
%                 set(handles.PlotIsolation,'enable','on');                     
%                 set(handles.IsolatorPopup, 'enable', 'on');    
%                 set(handles.DetectionThresholdCheck, 'enable', 'on');
%                 set(handles.DetectionResidualCheck, 'enable', 'on');
%                 set(handles.ThresholdResidualRadio, 'enable', 'on');
%                 set(handles.IsolationThresholdCheck, 'enable', 'on');
%                 set(handles.IsolationResidualCheck, 'enable', 'on');
%                 set(handles.SourceEstimationRadio, 'enable', 'on');
%             else
%                 set(handles.Save,'enable','on');
%                 set(handles.DetectionTimeEdit, 'enable', 'off', 'String', ' ')
%                 set(handles.IsolationTimeEdit, 'enable', 'off', 'String', ' ')
%                 set(handles.DetectionZones,'enable','on');
%                 set(handles.IsolationZones,'enable','off');
%                 set(handles.PlotDetection,'enable','on');
%                 set(handles.PlotIsolation,'enable','off');                     
%                 set(handles.IsolatorPopup, 'enable', 'off', 'String', ' ');    
%                 set(handles.DetectionThresholdCheck, 'enable', 'on');
%                 set(handles.DetectionResidualCheck, 'enable', 'on');
%                 set(handles.ThresholdResidualRadio, 'enable', 'off');
%                 set(handles.IsolationThresholdCheck, 'enable', 'off');
%                 set(handles.IsolationResidualCheck, 'enable', 'off');
%                 set(handles.SourceEstimationRadio, 'enable', 'off');
%             end
        end
        set(handles.DetectionThresholdCheck, 'Value', true);
        set(handles.DetectionResidualCheck, 'Value', true);
        set(handles.ThresholdResidualRadio, 'Value', 1);
        set(handles.IsolationThresholdCheck, 'Value', true);
        set(handles.IsolationResidualCheck, 'Value', true);
        set(handles.SourceEstimationRadio, 'Value', 0);         
        
    
    end
    
    
    handles.CDI = CDI;
    % Update handles structure
    guidata(hObject, handles);
end
    handles.CDIResultsGUI2.Pointer='arrow';




function CDIFileEdit_Callback(hObject, eventdata, handles)
% hObject    handle to CDIFileText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CDIFileText as text
%        str2double(get(hObject,'String')) returns contents of CDIFileText as a double


% --- Executes during object creation, after setting all properties.
function CDIFileText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CDIFileText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ScenarioPopup.
function ScenarioPopup_Callback(hObject, eventdata, handles)
% hObject    handle to ScenarioPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ScenarioPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ScenarioPopup

Sce = get(handles.ScenarioPopup,'Value');
CDI = handles.CDI;
fileR = get(handles.CDIFileText,'String');
[Path Name Extension] =  fileparts(fileR);
SceNum = regexp(Extension,'\d+','match');
set(handles.ResultsInformationListbox,'Foregroundcolor','b');
set(handles.ResultsInformationListbox,'fontsize',8);

if CDI.nSub == 0
    idx = handles.P.ScenariosFlowIndex(str2double(SceNum{1}),:);
    idx2 = handles.P.ScenariosContamIndex(Sce,:);

    w=[{'********************************* '};{'Scenario Data'};{'********************************* '}];
    w=[w;{' '};{'Weather Data:'};{'---------------------------------------- '};{' '}];            
    w=[w;{['Wind Direction: ',num2str(handles.P.FlowParamScenarios{1}(idx(1))), ' ^{o}']}];
    w=[w;{['Wind Speed: ',num2str(handles.P.FlowParamScenarios{2}(idx(2))), ' m/s']}; {' '}];
    w=[w;{'Source Data:'};{'---------------------------------------- '};{' '}];
    w=[w;{['Number of contaminant sources: ',num2str(length(handles.P.SourceLocationScenarios{idx2(4)}))]}];

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

    w=[w;{'********************************* '};{'CDI Data'};{'********************************* '};{' '}];
    
    w=[w;{' '};{'Assumed Nominal Weather Data:'};{'---------------------------------------- '};{' '}]; 
    w=[w;{['Wind Direction: ',num2str(handles.P.WindDirection), ' ^{o}']}];
    w=[w;{['Wind Speed: ',num2str(handles.P.WindSpeed), ' m/s']}; {' '}];
    
    w=[w;{' '};{'Bound Data:'};{'---------------------------------------- '};{' '}]; 
    w=[w;{['Uncertainties bound:  DA = ',num2str(CDI.Param.UncertaintiesBound)]}];
    w=[w;{['Noise bound:  w = ', num2str(CDI.Param.NoiseBound)]};{' '}];
    
    
    if ~isempty(CDI.R{Sce}.DetectionTime)
        %Detection Time
        DT = CDI.R{Sce}.DetectionTime;
        min = (DT - fix(DT))*60;
        sec = (min - fix(min))*60;
        DT = sprintf('%02d:%02d:%02d',fix(DT),fix(min),fix(sec));

        %Detection Delay
        DD = CDI.R{Sce}.DetectionDelay;
        min = (DD - fix(DD))*60;
        sec = (min - fix(min))*60;
        DD = sprintf('%02d:%02d:%02d',fix(DD),fix(min),fix(sec));

               
        w=[w;{' '};{'Detection Data:'};{'---------------------------------------- '};{' '}]; 
        w=[w;{['Detection Decision: YES --> ', CDI.R{Sce}.DetectionRate]}];
        w=[w;{['Detection Time: ', DT]}];
        w=[w;{['Detection Delay: ', DD]};{' '}];
        
        switch CDI.R{Sce}.IsolationRate
                case {'True Positive', 'False Positive'}
        
                    %Isolation Time
                    IT = CDI.R{Sce}.IsolationTime;
                    min = (IT - fix(IT))*60;
                    sec = (min - fix(min))*60;
                    IT = sprintf('%02d:%02d:%02d',fix(IT),fix(min),fix(sec));

                    %Isolation Delay
                    ID = CDI.R{Sce}.IsolationDelay;
                    min = (ID - fix(ID))*60;
                    sec = (min - fix(min))*60;
                    ID = sprintf('%02d:%02d:%02d',fix(ID),fix(min),fix(sec));

                    w=[w;{' '};{'Isolation Data:'};{'---------------------------------------- '};{' '}]; 
                    w=[w;{['Isolation Decision: ', CDI.R{Sce}.IsolationRate]}];
                    w=[w;{['Isolation Time: ', IT]}];
                    w=[w;{['Isolation Delay: ', ID]}];
                    if ~isempty(CDI.R{Sce}.IsolationDecision)
                        IDec = [];
                        for j=1:length(CDI.R{Sce}.IsolationDecision)                
                            IDec = [IDec, ' Z' num2str(CDI.R{Sce}.IsolationDecision(j)), '   '];                            
                        end
                    else
                        IDec = '';
                    end
                    w=[w;{['Isolation Candidate Zones: ', IDec]}];
                    w=[w;{['Source Estimation: ', num2str(CDI.R{Sce}.SourceEstimation), ' g/h' ]}];
                case 'False Negative'
                    w=[w;{' '};{'Isolation Data:'};{'---------------------------------------- '};{' '}]; 
                    w=[w;{['Isolation Decision: NO --> ', CDI.R{Sce}.IsolationRate]}];
                    if ~isempty(CDI.R{Sce}.IsolationDecision)
                        IDec = [];
                        for j=1:length(CDI.R{Sce}.IsolationDecision)                
                            IDec = [IDec, ' Z' num2str(CDI.R{Sce}.IsolationDecision(j)), '   '];                            
                        end
                    else
                        IDec = '';
                    end
                    w=[w;{['Isolation Candidate Zones: ', IDec]}];
        end
    else
        w=[w;{' '};{'Detection Data:'};{'---------------------------------------- '};{' '}]; 
        w=[w;{'Detection Decision: NO'}];
    end

    w=[w;{' '}];    
        
    set(handles.ResultsInformationListbox,'Value',1,'ListboxTop', 1);
    set(handles.ResultsInformationListbox,'String',w);     
else

    idx = handles.P.ScenariosFlowIndex(str2double(SceNum{1}),:);
    idx2 = handles.P.ScenariosContamIndex(Sce,:);

    w=[{'********************************* '};{'Scenario Data'};{'********************************* '}];
    w=[w;{' '};{'Weather Data:'};{'---------------------------------------- '};{' '}];            
    w=[w;{[' Wind Direction: ',num2str(handles.P.FlowParamScenarios{1}(idx(1))), ' ^{o}']}];
    w=[w;{[' Wind Speed: ',num2str(handles.P.FlowParamScenarios{2}(idx(2))), ' m/s']}; {' '}];
    w=[w;{'Source Data:'};{'---------------------------------------- '};{' '}];
    w=[w;{['Number of contaminant sources: ',num2str(length(handles.P.SourceLocationScenarios{idx2(4)}))]}];

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

    w=[w;{'********************************* '};{'Distributed CDI Data'};{'********************************* '};{' '}];
    
    w=[w;{' '};{'Assumed Nominal Weather Data:'};{'---------------------------------------- '};{' '}]; 
    w=[w;{['Wind Direction: ',num2str(handles.P.WindDirection), ' ^{o}']}];
    w=[w;{['Wind Speed: ',num2str(handles.P.WindSpeed), ' m/s']}; {' '}];
    
    w=[w;{['Number of subsystems: ', num2str(CDI.nSub)]};{' '}];
    w=[w;{' '}];
    
    for i=1:CDI.nSub
        w=[w;{['Subsystem ', num2str(i), ' data:']};{'---------------------------------------- '}];
        ZN = [];
        for j = 1:length(CDI.SubsystemZones{i})
            ZN = [ZN, 'Z',num2str(CDI.SubsystemZones{i}(j)), '   '];                        
        end
        w=[w;{['Zones: ', ZN]};{' '}];
        
        w=[w;{' '};{'Bound Data:'};{'---------------------------------------- '};{' '}]; 
        w=[w;{['Uncertainties bound:  DA = ',num2str(CDI.Param.UncertaintiesBoundDA{i}), ',   DH = ',num2str(CDI.Param.UncertaintiesBoundDH{i})]}];
        w=[w;{['Noise bound:  w = ', num2str(CDI.Param.NoiseBound{i})]};{' '}];



        if ~isempty(CDI.R{Sce}.DetectionTime{i})
            %Detection Time
            DT = CDI.R{Sce}.DetectionTime{i};
            min = (DT - fix(DT))*60;
            sec = (min - fix(min))*60;
            DT = sprintf('%02d:%02d:%02d',fix(DT),fix(min),fix(sec));

            %Detection Delay
            DD = CDI.R{Sce}.DetectionDelay{i};
            min = (DD - fix(DD))*60;
            sec = (min - fix(min))*60;
            DD = sprintf('%02d:%02d:%02d',fix(DD),fix(min),fix(sec));

                      
            w=[w;{' '};{'Detection Data:'};{'---------------------------------------- '};{' '}]; 
            w=[w;{['Detection Decision: YES --> ', CDI.R{Sce}.DetectionRate{i}]}];
            w=[w;{['Detection Time: ', DT]}];
            w=[w;{['Detection Delay: ', DD]};{' '}];
            
            switch CDI.R{Sce}.IsolationRate{i}
                case {'True Positive', 'False Positive'}            
                    %Isolation Time
                    IT = CDI.R{Sce}.IsolationTime{i};
                    min = (IT - fix(IT))*60;
                    sec = (min - fix(min))*60;
                    IT = sprintf('%02d:%02d:%02d',fix(IT),fix(min),fix(sec));

                    %Isolation Delay
                    ID = CDI.R{Sce}.IsolationDelay{i};
                    min = (ID - fix(ID))*60;
                    sec = (min - fix(min))*60;
                    ID = sprintf('%02d:%02d:%02d',fix(ID),fix(min),fix(sec));

                    w=[w;{' '};{'Isolation Data:'};{'---------------------------------------- '};{' '}]; 
                    w=[w;{['Isolation Decision: ', CDI.R{Sce}.IsolationRate{i}]}];
                    w=[w;{['Isolation Time: ', IT]}];
                    w=[w;{['Isolation Delay: ', ID]}];
                    if ~isempty(CDI.R{Sce}.IsolationDecision{i})
                        IDec = [];
                        for j=1:length(CDI.R{Sce}.IsolationDecision{i})
                            k = CDI.R{Sce}.IsolationDecision{i}(j);
                            IDec = [IDec, ' Z' num2str(CDI.SubsystemZones{i}(k)), '   '];                            
                        end
                    else
                        IDec = '';
                    end
                    w=[w;{['Isolation Candidate Zones: ', IDec]}];
                    w=[w;{['Source Estimation: ', num2str(CDI.R{Sce}.SourceEstimation{i}), ' g/h']}];
                    
                case 'False Negative'
                        w=[w;{' '};{'Isolation Data:'};{'---------------------------------------- '};{' '}]; 
                        w=[w;{['Isolation Decision: NO -- > ', CDI.R{Sce}.IsolationRate{i}]}];
                        if ~isempty(CDI.R{Sce}.IsolationDecision{i})
                            IDec = [];
                            for j=1:length(CDI.R{Sce}.IsolationDecision{i})
                                k = CDI.R{Sce}.IsolationDecision{i}(j);
                                IDec = [IDec, ' Z' num2str(CDI.SubsystemZones{i}(k)), '   '];                            
                            end
                        else
                            IDec = '';
                        end
                        w=[w;{['Isolation Candidate Zones: ', IDec]}];             
                    
                    
            end
        else
            w=[w;{' '};{'Detection Data:'};{'---------------------------------------- '};{' '}]; 
            w=[w;{'Detection Decision: NO'}];
        end

        w=[w;{' '}];
    end

    set(handles.ResultsInformationListbox,'Value',1,'ListboxTop', 1);
    set(handles.ResultsInformationListbox,'String',w);
end


handles.chooseZoneDetection = [];
handles.chooseZoneIsolation = []; 
if CDI.nSub ~= 0
    set(handles.SubsystemsPopup,'enable','on');            
    set(handles.SubsystemsPopup,'String',1:CDI.nSub);

    k = 1;
    for i=1:length(CDI.SubsystemZones{1})
        if max(find(handles.B.Sensors == CDI.SubsystemZones{1}(i)))
            handles.chooseZoneDetection(k) = true;
            handles.chooseZoneIsolation(k) = true;
            k = k + 1;
        end
    end

    if ~isempty(CDI.R{1,Sce}.DetectionTime{1})  
%         %Detection Time
%         DT = CDI.R{1,Sce}.DetectionTime{1};
%         min = (DT - fix(DT))*60;
%         sec = (min - fix(min))*60;
%         set(handles.DetectionTimeEdit, 'String',...
%             sprintf('%02d:%02d:%02d',fix(DT),fix(min),fix(sec)));
% 
%         %Isolation Time
%         IT = CDI.R{1,Sce}.IsolationTime{1};
%         min = (IT - fix(IT))*60;
%         sec = (min - fix(min))*60;
%         set(handles.IsolationTimeEdit, 'String',...
%             sprintf('%02d:%02d:%02d',fix(IT),fix(min),fix(sec)));                

        set(handles.IsolatorPopup, 'String', 1:length(CDI.SubsystemZones{1})); 
%         set(handles.Save,'enable','on');
%         set(handles.DetectionTimeEdit, 'enable', 'inactive')
%         set(handles.IsolationTimeEdit, 'enable', 'inactive')
        set(handles.DetectionZones,'enable','on');
        set(handles.IsolationZones,'enable','on');
        set(handles.PlotDetection,'enable','on');
        set(handles.PlotIsolation,'enable','on');                     
        set(handles.IsolatorPopup, 'enable', 'on');    
        set(handles.DetectionThresholdCheck, 'enable', 'on');
        set(handles.DetectionResidualCheck, 'enable', 'on');
        set(handles.ThresholdResidualRadio, 'enable', 'on', 'value', 1);
        set(handles.IsolationThresholdCheck, 'enable', 'on');
        set(handles.IsolationResidualCheck, 'enable', 'on');
        set(handles.SourceEstimationRadio, 'enable', 'on', 'value', 0);
    else
%         set(handles.Save,'enable','on');
%         set(handles.DetectionTimeEdit, 'enable', 'off','String',' ')
%         set(handles.IsolationTimeEdit, 'enable', 'off','String',' ')
        set(handles.DetectionZones,'enable','on');
        set(handles.IsolationZones,'enable','off');
        set(handles.PlotDetection,'enable','on');
        set(handles.PlotIsolation,'enable','off');                     
        set(handles.IsolatorPopup, 'enable', 'off');    
        set(handles.DetectionThresholdCheck, 'enable', 'on');
        set(handles.DetectionResidualCheck, 'enable', 'on');
        set(handles.ThresholdResidualRadio, 'enable', 'off');
        set(handles.IsolationThresholdCheck, 'enable', 'off');
        set(handles.IsolationResidualCheck, 'enable', 'off');
        set(handles.SourceEstimationRadio, 'enable', 'off');                    
    end

else
    set(handles.SubsystemsPopup,'enable','off');
    for i=1:handles.B.nS
        handles.chooseZoneDetection(i) = true;
        handles.chooseZoneIsolation(i) = true;
    end


    if ~isempty(CDI.R{1,Sce}.DetectionTime)
%         %Detection Time
%         TD = CDI.R{1,Sce}.DetectionTime;
%         min = (TD - fix(TD))*60;
%         sec = (min - fix(min))*60;
%         set(handles.DetectionTimeEdit, 'String',...
%             sprintf('%02d:%02d:%02d',fix(TD),fix(min),fix(sec)));
% 
%         %Isolation Time
%         TI = CDI.R{1,Sce}.IsolationTime;
%         min = (TI - fix(TI))*60;
%         sec = (min - fix(min))*60;
%         set(handles.IsolationTimeEdit, 'String',...
%             sprintf('%02d:%02d:%02d',fix(TI),fix(min),fix(sec)));                

        set(handles.IsolatorPopup, 'String', 1:handles.B.nZones);
%         set(handles.Save,'enable','on');
%         set(handles.DetectionTimeEdit, 'enable', 'inactive')
%         set(handles.IsolationTimeEdit, 'enable', 'inactive')
        set(handles.DetectionZones,'enable','on');
        set(handles.IsolationZones,'enable','on');
        set(handles.PlotDetection,'enable','on');
        set(handles.PlotIsolation,'enable','on');                     
        set(handles.IsolatorPopup, 'enable', 'on');    
        set(handles.DetectionThresholdCheck, 'enable', 'on');
        set(handles.DetectionResidualCheck, 'enable', 'on');
        set(handles.ThresholdResidualRadio, 'enable', 'on', 'value', 1);
        set(handles.IsolationThresholdCheck, 'enable', 'on');
        set(handles.IsolationResidualCheck, 'enable', 'on');
        set(handles.SourceEstimationRadio, 'enable', 'on', 'value', 0);        
    else
%         set(handles.Save,'enable','on');
%         set(handles.DetectionTimeEdit, 'enable', 'off','String',' ')
%         set(handles.IsolationTimeEdit, 'enable', 'off','String',' ')
        set(handles.DetectionZones,'enable','on');
        set(handles.IsolationZones,'enable','off');
        set(handles.PlotDetection,'enable','on');
        set(handles.PlotIsolation,'enable','off');                     
        set(handles.IsolatorPopup, 'enable', 'off');    
        set(handles.DetectionThresholdCheck, 'enable', 'on');
        set(handles.DetectionResidualCheck, 'enable', 'on');
        set(handles.ThresholdResidualRadio, 'enable', 'off');
        set(handles.IsolationThresholdCheck, 'enable', 'off');
        set(handles.IsolationResidualCheck, 'enable', 'off');
        set(handles.SourceEstimationRadio, 'enable', 'off');
    end
end
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


% --- Executes on selection change in SubsystemsPopup.
function SubsystemsPopup_Callback(hObject, eventdata, handles)
% hObject    handle to SubsystemsPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SubsystemsPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SubsystemsPopup

Sub = get(handles.SubsystemsPopup,'Value');
Sce = get(handles.ScenarioPopup,'Value');
CDI = handles.CDI;

handles.chooseZoneDetection = [];
handles.chooseZoneIsolation = [];    
k = 1;
for i=1:length(CDI.SubsystemZones{Sub})
    if max(find(handles.B.Sensors == CDI.SubsystemZones{Sub}(i)))
        handles.chooseZoneDetection(k) = true;
        handles.chooseZoneIsolation(k) = true;
        k = k + 1;
    end
end

if ~isempty(CDI.R{1,Sce}.DetectionTime{Sub})  
%     %Detection Time
%     DT = CDI.R{1,Sce}.DetectionTime{Sub};
%     min = (DT - fix(DT))*60;
%     sec = (min - fix(min))*60;
%     set(handles.DetectionTimeEdit, 'String',...
%         sprintf('%02d:%02d:%02d',fix(DT),fix(min),fix(sec)));
% 
%     %Isolation Time
%     IT = CDI.R{1,Sce}.IsolationTime{Sub};
%     min = (IT - fix(IT))*60;
%     sec = (min - fix(min))*60;
%     set(handles.IsolationTimeEdit, 'String',...
%         sprintf('%02d:%02d:%02d',fix(IT),fix(min),fix(sec)));                

    set(handles.IsolatorPopup, 'String', 1:length(CDI.SubsystemZones{Sub}));                
%     set(handles.Save,'enable','on');
%     set(handles.DetectionTimeEdit, 'enable', 'inactive')
%     set(handles.IsolationTimeEdit, 'enable', 'inactive')
    set(handles.DetectionZones,'enable','on');
    set(handles.IsolationZones,'enable','on');
    set(handles.PlotDetection,'enable','on');
    set(handles.PlotIsolation,'enable','on');                     
    set(handles.IsolatorPopup, 'enable', 'on');    
    set(handles.DetectionThresholdCheck, 'enable', 'on');
    set(handles.DetectionResidualCheck, 'enable', 'on');
    set(handles.ThresholdResidualRadio, 'enable', 'on', 'value', 1);
    set(handles.IsolationThresholdCheck, 'enable', 'on');
    set(handles.IsolationResidualCheck, 'enable', 'on');
    set(handles.SourceEstimationRadio, 'enable', 'on', 'value', 0);
else
%     set(handles.Save,'enable','on');
%     set(handles.DetectionTimeEdit, 'enable', 'off','String',' ')
%     set(handles.IsolationTimeEdit, 'enable', 'off','String',' ')
    set(handles.DetectionZones,'enable','on');
    set(handles.IsolationZones,'enable','off');
    set(handles.PlotDetection,'enable','on');
    set(handles.PlotIsolation,'enable','off');                     
    set(handles.IsolatorPopup, 'enable', 'off');    
    set(handles.DetectionThresholdCheck, 'enable', 'on');
    set(handles.DetectionResidualCheck, 'enable', 'on');
    set(handles.ThresholdResidualRadio, 'enable', 'off');
    set(handles.IsolationThresholdCheck, 'enable', 'off');
    set(handles.IsolationResidualCheck, 'enable', 'off');
    set(handles.SourceEstimationRadio, 'enable', 'off');

end
% Update handles structure
 guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function SubsystemsPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SubsystemsPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiresume
% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiresume
% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Sce = get(handles.ScenarioPopup,'Value');
CDI = handles.CDI.R{Sce};
CDI.Time = handles.P.t;

uisave('CDI', [pwd, '/RESULTS/CDI'])

% --- Executes on selection change in IsolatorPopup.
function IsolatorPopup_Callback(hObject, eventdata, handles)
% hObject    handle to IsolatorPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns IsolatorPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from IsolatorPopup


% --- Executes during object creation, after setting all properties.
function IsolatorPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IsolatorPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ThresholdResidualRadio.
function ThresholdResidualRadio_Callback(hObject, eventdata, handles)
% hObject    handle to ThresholdResidualRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ThresholdResidualRadio
val = get(handles.ThresholdResidualRadio, 'Value');
    if val == 1
        set(handles.SourceEstimationRadio, 'Value', 0);
        set(handles.IsolationResidualCheck, 'Enable', 'on');
        set(handles.IsolationThresholdCheck, 'Enable', 'on');
        set(handles.IsolationZones, 'Enable', 'on');
    end
    
guidata(hObject, handles);


% --- Executes on button press in SourceEstimationRadio.
function SourceEstimationRadio_Callback(hObject, eventdata, handles)
% hObject    handle to SourceEstimationRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SourceEstimationRadio

val = get(handles.SourceEstimationRadio, 'Value');
    if val == 1
        set(handles.ThresholdResidualRadio, 'Value', 0);
        set(handles.IsolationResidualCheck, 'Enable', 'off');
        set(handles.IsolationThresholdCheck, 'Enable', 'off');
        set(handles.IsolationZones, 'Enable', 'off');
    end
    
guidata(hObject, handles);

% --- Executes on button press in IsolationZones.
function IsolationZones_Callback(hObject, eventdata, handles)
% hObject    handle to IsolationZones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hf = findall(0,'Tag','SelectZones');
if ~isempty(hf)
    return
end

CDI = handles.CDI;

if CDI.nSub ~= 0
    Sub = get(handles.SubsystemsPopup,'Value');
    k = 1;
    for i = 1:length(CDI.SubsystemZones{Sub})
        if max(find(handles.B.Sensors == CDI.SubsystemZones{Sub}(i))) 
            arguments.ZoneName{k} = handles.B.ZoneName{CDI.SubsystemZones{Sub}(i)};
            k = k + 1;
        end
    end
    arguments.chooseZone  = handles.chooseZoneIsolation;  
    
    [A B]= SelectZones(arguments);
    
    handles.chooseZoneIsolation = B.chooseZone;
else
    for i = 1:length(handles.B.Sensors)
        arguments.ZoneName{i} = handles.B.ZoneName{handles.B.Sensors(i)};
    end
        
    arguments.chooseZone  = handles.chooseZoneIsolation;
    
    [A B]= SelectZones(arguments);
    
    handles.chooseZoneIsolation = B.chooseZone;
end
    guidata(hObject, handles);

% --- Executes on button press in PlotIsolation.
function PlotIsolation_Callback(hObject, eventdata, handles)
% hObject    handle to PlotIsolation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



Isolator = get(handles.IsolatorPopup, 'Value');
CDI = handles.CDI;
Sce = get(handles.ScenarioPopup,'Value');



if CDI.nSub ~= 0
    Sub = get(handles.SubsystemsPopup,'Value');
    if get(handles.SourceEstimationRadio, 'Value')    
        figure('Name', [num2str(Isolator),' Contaminant Source Estimation for Subsystem ' num2str(Sub)])
        plot(CDI.R{Sce}.IsolationTimeseries{Sub}, CDI.R{Sce}.AdaptiveSourceEstimation{Sub}{Isolator},'LineWidth',3)        
        ylabel('[g/hr]')
        xlabel('Time [hr]')
    else
        Val = [get(handles.IsolationThresholdCheck, 'Value'), get(handles.IsolationResidualCheck, 'Value')];
        if ~max(Val)&&~get(handles.SourceEstimationRadio, 'Value')
            msgbox('Select Detection Threshold or Residual', 'Error', 'error')
            return
        end
        
        if isempty(find(handles.chooseZoneIsolation))
            msgbox('Select Zones', 'Error', 'error')
            return 
        end
        
        switch mat2str(Val)
            case '[1 1]'
                zones = find(handles.chooseZoneIsolation);
                idx = CDI.SubsystemZones{Sub}(find(ismember(CDI.SubsystemZones{Sub},handles.B.Sensors)));
                figure('Name', [num2str(Isolator),' Contaminant Isolation Estimator for Subsystem ', num2str(Sub)])
                if length(zones)==1
                    hold on
                    plot(CDI.R{Sce}.IsolationTimeseries{Sub}, CDI.R{Sce}.IsolationResidual{Sub}{Isolator}(zones,:),'r','LineWidth',3)
                    plot(CDI.R{Sce}.IsolationTimeseries{Sub}, CDI.R{Sce}.IsolationThreshold{Sub}{Isolator}(:,zones),'--','LineWidth',3)
                    title(sprintf('Z%d',idx(zones)))
                    xlabel('Time [hr]')
                    ylim([-0.5 max([CDI.R{Sce}.IsolationResidual{Sub}{Isolator}(zones,:), CDI.R{Sce}.IsolationThreshold{Sub}{Isolator}(:,zones)'])+0.5])
                    legend('Residual', 'Threshold', 'Location', 'Best')
                else
                    for i=1:length(zones)
                        subplot(round(length(zones)/2),2,i)
                        hold on
                        plot(CDI.R{Sce}.IsolationTimeseries{Sub}, CDI.R{Sce}.IsolationResidual{Sub}{Isolator}(zones(i),:),'r','LineWidth',3)
                        plot(CDI.R{Sce}.IsolationTimeseries{Sub}, CDI.R{Sce}.IsolationThreshold{Sub}{Isolator}(:,zones(i)),'--','LineWidth',3)
                        title(sprintf('Z%d',idx(zones(i))))
                        xlabel('Time [hr]')
                        ylim([-0.5 max([CDI.R{Sce}.IsolationResidual{Sub}{Isolator}(zones(i),:), CDI.R{Sce}.IsolationThreshold{Sub}{Isolator}(:,zones(i))'])+0.5])
                    end
                    legend('Residual', 'Threshold', 'Location', 'Best')
                end
            case '[1 0]'
                zones = find(handles.chooseZoneIsolation);
                idx = CDI.SubsystemZones{Sub}(find(ismember(CDI.SubsystemZones{Sub},handles.B.Sensors)));
                figure('Name', [num2str(Isolator),' Isolation Threshold for Subsystem ', num2str(Sub)])         
                plot(CDI.R{Sce}.IsolationTimeseries{Sub}, CDI.R{Sce}.IsolationThreshold{Sub}{Isolator}(:,zones),'--','LineWidth',3)        
                xlabel('Time [hr]') 
                for i=1:length(zones)
                    LabelNames{i} = ['Z',num2str(idx(zones(i)))];
                end
                legend(LabelNames, 'Location', 'Best')
            case '[0 1]'
                zones = find(handles.chooseZoneIsolation);
                idx = CDI.SubsystemZones{Sub}(find(ismember(CDI.SubsystemZones{Sub},handles.B.Sensors)));
                figure('Name', [num2str(Isolator),' Isolation Residual for Subsystem ', num2str(Sub)])         
                plot(CDI.R{Sce}.IsolationTimeseries{Sub}, CDI.R{Sce}.IsolationResidual{Sub}{Isolator}(zones,:),'LineWidth',3)        
                xlabel('Time [hr]') 
                for i=1:length(zones)
                    LabelNames{i} = ['Z',num2str(idx(zones(i)))];
                end
                legend(LabelNames, 'Location', 'Best')
        end
        
    end   
    
else
    
    if get(handles.SourceEstimationRadio, 'Value')    
        figure('Name', [num2str(Isolator),' Contaminant Source Estimation'])
        plot(CDI.R{Sce}.IsolationTimeseries, CDI.R{Sce}.AdaptiveSourceEstimation{Isolator},'LineWidth',3)        
        ylabel('[g/hr]')
        xlabel('Time [hr]')
    else
        Val = [get(handles.IsolationThresholdCheck, 'Value'), get(handles.IsolationResidualCheck, 'Value')];
        if ~max(Val)&&~get(handles.SourceEstimationRadio, 'Value')
            msgbox('Select Detection Threshold or Residual', 'Error', 'error')
            return
        end

        if isempty(find(handles.chooseZoneIsolation))
            msgbox('Select Zones', 'Error', 'error')
            return 
        end
        switch mat2str(Val)
            case '[1 1]'
                zones = find(handles.chooseZoneIsolation);
                figure('Name', [num2str(Isolator),' Contaminant Isolation Estimator'])
                if length(zones)==1
                    hold on
                    plot(CDI.R{Sce}.IsolationTimeseries, CDI.R{Sce}.IsolationResidual{Isolator}(zones,:),'r','LineWidth',3)
                    plot(CDI.R{Sce}.IsolationTimeseries, CDI.R{Sce}.IsolationThreshold{Isolator}(:,zones),'--','LineWidth',3)
                    title(sprintf('Z%d',handles.B.Sensors(zones)))
                    xlabel('Time [hr]')
                    ylim([-0.5 max([CDI.R{Sce}.IsolationResidual{Isolator}(zones,:), CDI.R{Sce}.IsolationThreshold{Isolator}(:,zones)'])+0.5])
                    legend('Residual', 'Threshold', 'Location', 'Best')
                else
                    for i=1:length(zones)
                        subplot(round(length(zones)/2),2,i)
                        hold on
                        plot(CDI.R{Sce}.IsolationTimeseries, CDI.R{Sce}.IsolationResidual{Isolator}(zones(i),:),'r','LineWidth',3)
                        plot(CDI.R{Sce}.IsolationTimeseries, CDI.R{Sce}.IsolationThreshold{Isolator}(:,zones(i)),'--','LineWidth',3)
                        title(sprintf('Z%d',handles.B.Sensors(zones(i))))
                        xlabel('Time [hr]')
                        ylim([-0.5 max([CDI.R{Sce}.IsolationResidual{Isolator}(zones(i),:), CDI.R{Sce}.IsolationThreshold{Isolator}(:,zones(i))'])+0.5])
                    end
                    legend('Residual', 'Threshold', 'Location', 'Best')
                end
            case '[1 0]'
                zones = find(handles.chooseZoneIsolation);
                figure('Name', [num2str(Isolator),' Isolation Threshold'])         
                plot(CDI.R{Sce}.IsolationTimeseries, CDI.R{Sce}.IsolationThreshold{Isolator}(:,zones),'--','LineWidth',3)        
                xlabel('Time [hr]') 
                for i=1:length(zones)
                    LabelNames{i} = ['Z',num2str(handles.B.Sensors(zones(i)))];
                end
                legend(LabelNames, 'Location', 'Best')
            case '[0 1]'
                zones = find(handles.chooseZoneIsolation);
                figure('Name', [num2str(Isolator),' Isolation Residual '])         
                plot(CDI.R{Sce}.IsolationTimeseries, CDI.R{Sce}.IsolationResidual{Isolator}(zones,:),'LineWidth',3)        
                xlabel('Time [hr]') 
                for i=1:length(zones)
                    LabelNames{i} = ['Z',num2str(handles.B.Sensors(zones(i)))];
                end
                legend(LabelNames, 'Location', 'Best')

        end
    end
    
end




% --- Executes on button press in IsolationThresholdCheck.
function IsolationThresholdCheck_Callback(hObject, eventdata, handles)
% hObject    handle to IsolationThresholdCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of IsolationThresholdCheck


% --- Executes on button press in IsolationResidualCheck.
function IsolationResidualCheck_Callback(hObject, eventdata, handles)
% hObject    handle to IsolationResidualCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of IsolationResidualCheck



function IsolationTimeEdit_Callback(hObject, eventdata, handles)
% hObject    handle to IsolationTimeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IsolationTimeEdit as text
%        str2double(get(hObject,'String')) returns contents of IsolationTimeEdit as a double


% --- Executes during object creation, after setting all properties.
function IsolationTimeEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IsolationTimeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DetectionTimeEdit_Callback(hObject, eventdata, handles)
% hObject    handle to DetectionTimeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DetectionTimeEdit as text
%        str2double(get(hObject,'String')) returns contents of DetectionTimeEdit as a double


% --- Executes during object creation, after setting all properties.
function DetectionTimeEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DetectionTimeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DetectionZones.
function DetectionZones_Callback(hObject, eventdata, handles)
% hObject    handle to DetectionZones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hf = findall(0,'Tag','SelectZones');
if ~isempty(hf)
    return
end

CDI = handles.CDI;

if CDI.nSub ~= 0
    Sub = get(handles.SubsystemsPopup,'Value');
    k = 1;
    for i = 1:length(CDI.SubsystemZones{Sub})
        if max(find(handles.B.Sensors == CDI.SubsystemZones{Sub}(i))) 
            arguments.ZoneName{k} = handles.B.ZoneName{CDI.SubsystemZones{Sub}(i)};
            k = k + 1;
        end
    end
    arguments.chooseZone  = handles.chooseZoneDetection;    
    [A B]= SelectZones(arguments);

    % uiwait(SelectZones)
    handles.chooseZoneDetection = B.chooseZone;
else
    for i = 1:length(handles.B.Sensors)
        arguments.ZoneName{i} = handles.B.ZoneName{handles.B.Sensors(i)};
    end
    arguments.chooseZone  = handles.chooseZoneDetection;

    [A B]= SelectZones(arguments);

    % uiwait(SelectZones)
    handles.chooseZoneDetection = B.chooseZone;
end
guidata(hObject, handles);


% --- Executes on button press in PlotDetection.
function PlotDetection_Callback(hObject, eventdata, handles)
% hObject    handle to PlotDetection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Val = [get(handles.DetectionThresholdCheck, 'Value'), get(handles.DetectionResidualCheck, 'Value')];
if ~max(Val)
    msgbox('Select Detection Threshold or Residual', 'Error', 'error')
    return
end

if isempty(find(handles.chooseZoneDetection))
    msgbox('Select Zones', 'Error', 'error')
    return 
end


Sce = get(handles.ScenarioPopup,'Value');
CDI = handles.CDI;
P = handles.P;

if CDI.nSub ~= 0
    Sub = get(handles.SubsystemsPopup,'Value');    
    switch mat2str(Val)
        case '[1 1]'
            zones = find(handles.chooseZoneDetection);
            idx = CDI.SubsystemZones{Sub}(find(ismember(CDI.SubsystemZones{Sub},handles.B.Sensors)));
            figure('Name', 'Contaminant Detection Estimator')
            if length(zones)==1
                hold on
                plot(P.t, CDI.R{Sce}.DetectionResidual{Sub}(zones,:),'r','LineWidth',3)
                plot(P.t, CDI.R{Sce}.DetectionThreshold{Sub}(:,zones),'--','LineWidth',3)
                title(sprintf('Z%d',idx(zones)))
                xlabel('Time [hr]')
                ylim([-0.5 max([CDI.R{Sce}.DetectionResidual{Sub}(zones,:), CDI.R{Sce}.DetectionThreshold{Sub}(:,zones)'])+0.5])
                legend('Residual', 'Threshold', 'Location', 'Best')
            else
                for i=1:length(zones)
                    subplot(round(length(zones)/2),2,i)
                    hold on
                    plot(P.t, CDI.R{Sce}.DetectionResidual{Sub}(zones(i),:),'r','LineWidth',3)
                    plot(P.t, CDI.R{Sce}.DetectionThreshold{Sub}(:,zones(i)),'--','LineWidth',3)
                    title(sprintf('Z%d',idx(zones(i))))
                    xlabel('Time [hr]')
                    ylim([-0.5 max([CDI.R{Sce}.DetectionResidual{Sub}(zones(i),:), CDI.R{Sce}.DetectionThreshold{Sub}(:,zones(i))'])+0.5])
                end
                legend('Residual', 'Threshold', 'Location', 'Best')
            end           
        case '[1 0]'
            zones = find(handles.chooseZoneDetection);
            idx = CDI.SubsystemZones{Sub}(find(ismember(CDI.SubsystemZones{Sub},handles.B.Sensors)));
            figure('Name', 'Detection Threshold')         
            plot(P.t, CDI.R{Sce}.DetectionThreshold{Sub}(:,zones),'--','LineWidth',3)        
            xlabel('Time [hr]') 
            for i=1:length(zones)
                LabelNames{i} = ['Z',num2str(idx(zones(i)))];
            end
            legend(LabelNames, 'Location', 'Best')            
        case '[0 1]' 
            zones = find(handles.chooseZoneDetection);
            idx = CDI.SubsystemZones{Sub}(find(ismember(CDI.SubsystemZones{Sub},handles.B.Sensors)));
            figure('Name', 'Detection Residual')         
            plot(P.t, CDI.R{Sce}.DetectionResidual{Sub}(zones,:),'LineWidth',3)        
            xlabel('Time [hr]') 
            for i=1:length(zones)
                LabelNames{i} = ['Z',num2str(idx(zones(i)))];
            end
            legend(LabelNames, 'Location', 'Best')            
    end
    
    
    
else    
    switch mat2str(Val)
        case '[1 1]'
            zones = find(handles.chooseZoneDetection);
            figure('Name', 'Contaminant Detection Estimator')
            if length(zones)==1
                hold on
                plot(P.t, CDI.R{Sce}.DetectionResidual(zones,:),'r','LineWidth',3)
                plot(P.t, CDI.R{Sce}.DetectionThreshold(:,zones),'--','LineWidth',3)
                title(sprintf('Z%d',handles.B.Sensors(zones)))
                xlabel('Time [hr]')
                ylim([-0.5 max([CDI.R{Sce}.DetectionResidual(zones,:), CDI.R{Sce}.DetectionThreshold(:,zones)'])+0.5])
                legend('Residual', 'Threshold', 'Location', 'Best')
            else
                for i=1:length(zones)
                    subplot(round(length(zones)/2),2,i)
                    hold on
                    plot(P.t, CDI.R{Sce}.DetectionResidual(zones(i),:),'r','LineWidth',3)
                    plot(P.t, CDI.R{Sce}.DetectionThreshold(:,zones(i)),'--','LineWidth',3)
                    title(sprintf('Z%d',handles.B.Sensors(zones(i))))
                    xlabel('Time [hr]')
                    ylim([-0.5 max([CDI.R{Sce}.DetectionResidual(zones(i),:), CDI.R{Sce}.DetectionThreshold(:,zones(i))'])+0.5])
                end
                legend('Residual', 'Threshold', 'Location', 'Best')
            end
        case '[1 0]'
            zones = find(handles.chooseZoneDetection);
            figure('Name', 'Detection Threshold')         
            plot(P.t, CDI.R{Sce}.DetectionThreshold(:,zones),'--','LineWidth',3)        
            xlabel('Time [hr]') 
            for i=1:length(zones)
                LabelNames{i} = ['Z',num2str(handles.B.Sensors(zones(i)))];
            end
            legend(LabelNames, 'Location', 'Best')        
        case '[0 1]'
            zones = find(handles.chooseZoneDetection);
            figure('Name', 'Detection Residual')         
            plot(P.t, CDI.R{Sce}.DetectionResidual(zones,:),'LineWidth',3)        
            xlabel('Time [hr]') 
            for i=1:length(zones)
                LabelNames{i} = ['Z',num2str(handles.B.Sensors(zones(i)))];
            end
            legend(LabelNames, 'Location', 'Best')
    end
end

% --- Executes on button press in DetectionThresholdCheck.
function DetectionThresholdCheck_Callback(hObject, eventdata, handles)
% hObject    handle to DetectionThresholdCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DetectionThresholdCheck


% --- Executes on button press in DetectionResidualCheck.
function DetectionResidualCheck_Callback(hObject, eventdata, handles)
% hObject    handle to DetectionResidualCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DetectionResidualCheck


% --- Executes when user attempts to close CDIResultsGUI2.
function CDIResultsGUI2_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to CDIResultsGUI2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
% delete(hObject);
uiresume


% --- Executes on selection change in ResultsInformationListbox.
function ResultsInformationListbox_Callback(hObject, eventdata, handles)
% hObject    handle to ResultsInformationListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ResultsInformationListbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ResultsInformationListbox


function ScenarioResultsDisplayTable_CellSelectionCallback(Selection, eventdata)

1+1   
%%% We need to put an if statement which sais that if it is allready selected then do nothing !!!!    
if size(eventdata.Indices,1)==1    
     jUIScrollPane = findjobj(eventdata.Source);
    % 
    jUITable = jUIScrollPane.getViewport.getView;
    jUITable.setRowSelectionAllowed(true);
    % jUITable.setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);
%     jUITable.getSelectionModel().addSelectionInterval(9, 3);
%     jUITable.setRowSelectionInterval(10, 3);
%     scrollPanel.getVerticalScrollBar().setValue(0);
%      jUITable.changeSelection(eventdata.Indices(1,1),1, false, true);
    jUITable.changeSelection(eventdata.Indices(1,1)-1,length(eventdata.Source.ColumnFormat), false, true);
end



% --- Executes during object creation, after setting all properties.
function ResultsInformationListbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ResultsInformationListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ExportAll_Button.
function ExportAll_Button_Callback(hObject, eventdata, handles)
% hObject    handle to ExportAll_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Load data of the scenario tab that is currently sellected. (A matrix, Flows and the contaminant time series)
    SellectedScenario=handles.ScenariosFileText.String;
    
    file_temp=strsplit(SellectedScenario,'.');

    ScenariosFileNames=dir([pwd,'\RESULTS\',file_temp{1},'.c*']);
if ~isempty(handles.CDIFileText.String)
    file_temp=strsplit(handles.CDIFileText.String,'.cdi');
    ResultsFileNames=dir([pwd,'\RESULTS\',file_temp{1},'.cdi*']);
     for k=1:size(ResultsFileNames,1)
         SimulationResults.(['Scenario_' num2str(k)])={};
     end
   %Progressbar initialization
    progressbar2('Constructing Table');
    
 for k=1:size(ResultsFileNames,1)
        LoadedScenario=load([pwd,'\RESULTS\',ScenariosFileNames(1).name],'-mat');
        LoadedResult=load([pwd,'\RESULTS\',ResultsFileNames(1).name],'-mat');

        SceNum = k;

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
    SimulationResults.(['Scenario_' num2str(k)])=table({'Measurement Units';'Simulation Parameters';'State Space';'Environmental Parameters';'Building Parameters';'Contaminant Source';'Concentration Time Series';'CDI'});

    T_VariableNames{1}=['Data'];
    
    %Initialize Contaminant Time Series Table
        TimeSeries_Zone_Names=[];
        count=1;
        for kk=handles.B.Sensors'
            TimeSeries_Zone_Names{count}=['Z' num2str(kk)];
            count=count+1;
        end
        Time=handles.P.t;
        concentration=array2table(Time','VariableNames',{'Time'});
      
    
    

    % Construction of structure and Table

    for i=1:SimulationNum
        %CDI Results Table Construction
        if LoadedResult.CDI.nSub~=0
            for jj=1:LoadedResult.CDI.nSub
                     TimeSeries_Row_Names={};
                    TimeSeries_Row_Names{1}='Time';
                    count=2;

                for kk=1:length(LoadedResult.CDI.SubsystemZones{jj})
                    TimeSeries_Row_Names{count}=['Z' num2str(LoadedResult.CDI.SubsystemZones{jj}(kk) )];
                    count=count+1;
                end
                DetectionTimeSeries=handles.P.t;
                IsolationTimeSeries=LoadedResult.CDI.R{1, i}.IsolationTimeseries{1, jj};
                
                %Detection and Isolation Parameters and initial conditions
                CDI.(['Subsystem_' num2str(jj)]).UncertaintyBound_DA=LoadedResult.CDI.Param.UncertaintiesBoundDA{1, jj};
                CDI.(['Subsystem_' num2str(jj)]).UncertaintyBound_DH=LoadedResult.CDI.Param.UncertaintiesBoundDH{1, jj};
                CDI.(['Subsystem_' num2str(jj)]).NoiseBound=LoadedResult.CDI.Param.NoiseBound{1, jj}; 
                CDI.(['Subsystem_' num2str(jj)]).InitialDetectionThreshold=LoadedResult.CDI.Param.Ex0{1, jj};
                CDI.(['Subsystem_' num2str(jj)]).InitialIsolationThreshold=LoadedResult.CDI.Param.Ez0{1, jj};
                CDI.(['Subsystem_' num2str(jj)]).LearningRate=LoadedResult.CDI.Param.LearningRate{1, jj};
                CDI.(['Subsystem_' num2str(jj)]).InitialSourceEstimation=LoadedResult.CDI.Param.InitialSourceEstimation{1, jj};
                CDI.(['Subsystem_' num2str(jj)]).Theta=LoadedResult.CDI.Param.Theta{1, jj};

                
                %Detection Data
                CDI.(['Subsystem_' num2str(jj)]).DetectionThreshold=array2table([DetectionTimeSeries',LoadedResult.CDI.R{1, i}.DetectionThreshold{1, jj}],'VariableNames',TimeSeries_Row_Names);
                CDI.(['Subsystem_' num2str(jj)]).DetectionResidual=array2table([DetectionTimeSeries',LoadedResult.CDI.R{1, i}.DetectionResidual{1, jj}'],'VariableNames',TimeSeries_Row_Names);
                CDI.(['Subsystem_' num2str(jj)]).DetectionTime=LoadedResult.CDI.R{1, i}.DetectionTime{1, jj};
                CDI.(['Subsystem_' num2str(jj)]).DetectionDelay=LoadedResult.CDI.R{1, i}.DetectionDelay{1, jj};
                CDI.(['Subsystem_' num2str(jj)]).DetectionDecision=LoadedResult.CDI.R{1, i}.DetectionRate{1, jj};

                %Isolation Data
                if ~isempty(IsolationTimeSeries)
                    for kk=1:length(LoadedResult.CDI.SubsystemZones{jj})
                        temp=array2table([IsolationTimeSeries',LoadedResult.CDI.R{1, i}.IsolationThreshold{1,jj}{1, kk}],'VariableNames',TimeSeries_Row_Names);
                        CDI.(['Subsystem_' num2str(jj)]).IsolationThreshold(1,kk)=table({temp});

                        temp=array2table([IsolationTimeSeries',LoadedResult.CDI.R{1, i}.IsolationResidual{1,jj}{1, kk}'],'VariableNames',TimeSeries_Row_Names);
                        CDI.(['Subsystem_' num2str(jj)]).IsolationResidual(1,kk)=table({temp});
                        temp=array2table([IsolationTimeSeries',LoadedResult.CDI.R{1, i}.IsolationLogic{1,jj}{1, kk}'],'VariableNames',{'Time';'BinaryLogic'});
                        CDI.(['Subsystem_' num2str(jj)]).IsolationLogic(1,kk)=table({temp});
                    end
                    CDI.(['Subsystem_' num2str(jj)]).IsolationThreshold.Properties.VariableNames=TimeSeries_Row_Names(2:end);
                    CDI.(['Subsystem_' num2str(jj)]).IsolationResidual.Properties.VariableNames=TimeSeries_Row_Names(2:end);
                    CDI.(['Subsystem_' num2str(jj)]).AdaptiveSourceEstimation=array2table([IsolationTimeSeries',LoadedResult.CDI.R{1, i}.AdaptiveSourceEstimation{1,jj}{1, kk}],...
                                                                                            'VariableNames',{'Time';'Estimation'});
                else
                    CDI.(['Subsystem_' num2str(jj)]).IsolationThreshold=array2table([],'VariableNames',{});
                    CDI.(['Subsystem_' num2str(jj)]).IsolationResidual=array2table([],'VariableNames',{});
                    CDI.(['Subsystem_' num2str(jj)]).IsolationLogic=array2table([],'VariableNames',{});
                end

                if ~isempty(LoadedResult.CDI.R{1, i}.IsolationDecision{1, jj})
                    CDI.(['Subsystem_' num2str(jj)]).IsolationZone=['Z' num2str(LoadedResult.CDI.R{1, i}.IsolationDecision{1, jj})];
                else
                    CDI.(['Subsystem_' num2str(jj)]).IsolationZone=[];
                end
                CDI.(['Subsystem_' num2str(jj)]).IsolationTime=LoadedResult.CDI.R{1, i}.IsolationTime{1, jj};
                CDI.(['Subsystem_' num2str(jj)]).IsolationDelay=LoadedResult.CDI.R{1, i}.IsolationDelay{1, jj};
                CDI.(['Subsystem_' num2str(jj)]).IsolationDecision=LoadedResult.CDI.R{1, i}.IsolationRate{1, jj};
                CDI.(['Subsystem_' num2str(jj)]).SourceEstimation=LoadedResult.CDI.R{1, i}.SourceEstimation{1, jj};

            end
        else
                TimeSeries_Row_Names={};
                              
%                 for kk=1:length(LoadedResult.CDI.SubsystemZones{jj})
                    TimeSeries_Row_Names=['Time',TimeSeries_Zone_Names];
%                     count=count+1;
%                 end
                DetectionTimeSeries=handles.P.t;
                IsolationTimeSeries=LoadedResult.CDI.R{1, i}.IsolationTimeseries;
                
                %Detection and Isolation Parameters and initial conditions
                CDI.UncertaintyBound=LoadedResult.CDI.Param.UncertaintiesBound;
                CDI.NoiseBound=LoadedResult.CDI.Param.NoiseBound; 
                CDI.InitialDetectionThreshold=LoadedResult.CDI.Param.Ex0;
                CDI.InitialIsolationThreshold=LoadedResult.CDI.Param.Ez0;
                CDI.LearningRate=LoadedResult.CDI.Param.LearningRate;
                CDI.InitialSourceEstimation=LoadedResult.CDI.Param.InitialSourceEstimation;
                CDI.Theta=LoadedResult.CDI.Param.Theta;
                
                %Detection Data
                CDI.DetectionThreshold=array2table([DetectionTimeSeries',LoadedResult.CDI.R{1, i}.DetectionThreshold],'VariableNames',TimeSeries_Row_Names);
                CDI.DetectionResidual=array2table([DetectionTimeSeries',LoadedResult.CDI.R{1, i}.DetectionResidual'],'VariableNames',TimeSeries_Row_Names);
                CDI.DetectionTime=LoadedResult.CDI.R{1, i}.DetectionTime;
                CDI.DetectionDelay=LoadedResult.CDI.R{1, i}.DetectionDelay;
                CDI.DetectionDecision=LoadedResult.CDI.R{1, i}.DetectionRate;

                %Isolation Data
                if ~isempty(IsolationTimeSeries)
                    for kk=1:handles.B.nZones
                        temp=array2table([IsolationTimeSeries',LoadedResult.CDI.R{1, i}.IsolationThreshold{1, kk}],'VariableNames',TimeSeries_Row_Names);
                        CDI.IsolationThreshold(1,kk)=table({temp});

                        temp=array2table([IsolationTimeSeries',LoadedResult.CDI.R{1, i}.IsolationResidual{1, kk}'],'VariableNames',TimeSeries_Row_Names);
                        CDI.IsolationResidual(1,kk)=table({temp});
                        temp=array2table([IsolationTimeSeries',LoadedResult.CDI.R{1, i}.IsolationLogic{1, kk}'],'VariableNames',{'Time';'BinaryLogic'});
                        CDI.IsolationLogic(1,kk)=table({temp});
                    end
                     CDI.IsolationThreshold.Properties.VariableNames=TimeSeries_Row_Names(2:end);
                    CDI.IsolationResidual.Properties.VariableNames=TimeSeries_Row_Names(2:end);
                    CDI.AdaptiveSourceEstimation=array2table([IsolationTimeSeries',LoadedResult.CDI.R{1, i}.AdaptiveSourceEstimation{1, kk}],...
                                                                                            'VariableNames',{'Time';'Estimation'});
                else
                    CDI.IsolationThreshold=array2table([],'VariableNames',{});
                    CDI.IsolationResidual=array2table([],'VariableNames',{});
                    CDI.IsolationLogic=array2table([],'VariableNames',{});
                end

                if ~isempty(LoadedResult.CDI.R{1, i}.IsolationDecision)
                    CDI.IsolationZone=['Z' num2str(LoadedResult.CDI.R{1, i}.IsolationDecision)];
                else
                    CDI.IsolationZone=[];
                end
                CDI.IsolationTime=LoadedResult.CDI.R{1, i}.IsolationTime;
                CDI.IsolationDelay=LoadedResult.CDI.R{1, i}.IsolationDelay;
                CDI.IsolationDecision=LoadedResult.CDI.R{1, i}.IsolationRate;
                CDI.SourceEstimation=LoadedResult.CDI.R{1, i}.SourceEstimation;
            
            
        end

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
        
        Simulation{i}.MeasurementUnits(end+1,:)=[{'Detection Threshold'},{'kg/m^3'}];
        Simulation{i}.MeasurementUnits(end+1,:)=[{'Detection Residual'},{'kg/m^3'}];
        Simulation{i}.MeasurementUnits(end+1,:)=[{'Detection Time'},{'hours'}];
        Simulation{i}.MeasurementUnits(end+1,:)=[{'Detection Delay'},{'hours'}];
        Simulation{i}.MeasurementUnits(end+1,:)=[{'Isolation Threshold'},{'kg/m^3'}];
        Simulation{i}.MeasurementUnits(end+1,:)=[{'Isolation Residual'},{'kg/m^3'}];
        Simulation{i}.MeasurementUnits(end+1,:)=[{'Isolation Time'},{'hours'}];
        Simulation{i}.MeasurementUnits(end+1,:)=[{'Isolation Delay'},{'hours'}];
        Simulation{i}.MeasurementUnits(end+1,:)=[{'Initial Source Estimation'},{'g/m^3'}];
        Simulation{i}.MeasurementUnits(end+1,:)=[{'Source Estimation'},{'g/m^3'}];
        

        

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
        Simulation{i}.ContaminantSource.Location=['Z' num2str(handles.P.SourceLocationScenarios{handles.P.ScenariosContamIndex(i,4)})];

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
        concentration.Properties.VariableNames(2:end)=TimeSeries_Zone_Names;
        Simulation{i}.ConcentrationTimeSeries=concentration;
         % Construct table
         SimulationResults.(['Scenario_' num2str(k)])(:,i+1)=table({Simulation{i}.MeasurementUnits;Simulation{i}.SimulationParameters;Simulation{i}.StateSpace;Simulation{i}.EnvironmentalParameters;Simulation{i}.BuildingParameters; Simulation{i}.ContaminantSource;concentration;CDI});
         % Construct struct for Table column names
         T_VariableNames{i+1}=['Simulation_' num2str(i)];

         

    end
    %%%%%%%%%%%%%%%%% Progress bar %%%%%%%%%%%%%%%%%%%%%
          if isempty(findobj('Tag','ProgressBar'))
            exitflag=-1;
            return
          end
         progressbar2(k/size(ResultsFileNames,1)); 
 end
% Give names to Table Columns
     for k=1:size(ResultsFileNames,1)
        SimulationResults.(['Scenario_' num2str(k)]).Properties.VariableNames=T_VariableNames;
     end
     
     
assignin('base','SimulationResults',SimulationResults);
% assignin('base','Simulation',Simulation);
openvar('SimulationResults')
uiresume
else
   errordlg('No CDI file has been loaded.','File Error');
end
