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
function B = readPRJ(ProjectPath,ProjectName)
    % The function readPRJ is responsible to read CONTAM project file and 
    % save the data as text type in the structure variable X according to 
    % the sections that described in the CONTAM Guide.
    
    % INPUT ARGUMENT:
    %   file: It includes the file's directory and the filename.
    %   e.g. C:\Users\...\MatlabContamToolbox\Project\Holmes.prj

    fid = fopen([ProjectPath,ProjectName], 'r');

    % Section 1: Project, Weather, Simulation, and Output Controls
    X.project{1} = fgetl(fid);
    i = 1;
    while strcmp(X.project{i},'-999')~=1
        i = i +1;
        X.project{i} = fgetl(fid);
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

  
    
    
    B.X = X;
    
    % save the Project Name and Path in structure B
    B.ProjectName = ProjectName; 
    B.ProjectPath = ProjectPath;
    
    
    if exist('Project.File','file')==2
        load Project.File -mat
        file0=[];
        save('Project.File','file0','-mat')
    end    
    pathname = [pwd,'\RESULTS\'];
    save([pwd,'\RESULTS\','pathname.File'],'pathname','-mat');
    
    
    % To find the weather data 
    i=1;
    while strcmp(X.project{i},'! Ta       Pb      Ws    Wd    rh  day u..')~=1
        i=i+1;
    end
    i=i+1;
    
    % Weather Data
    out = textscan(X.project{i},'%s','delimiter',' ','multipleDelimsAsOne',1);
    B.AmbientTemperature = str2double(out{1}{1})-273.15; % Kelvin to Celcius
    B.AmbientPressure = str2double(out{1}{2}); % pressure (Pa)
    B.WindSpeed = str2double(out{1}{3}); % m/s
    B.WindDirection = str2double(out{1}{4}); % degree
    
    % Zone Data 
    for i=3:(length(X.ZonesData)-1)
        out = textscan(X.ZonesData{i},'%s','delimiter',' ','multipleDelimsAsOne',1);
        V(i-2)=str2double(out{1}{8}); % Zone Volumes
        B.Temp(i-2) = str2double(out{1}{9})-273.15; % Kelvin to Celcius
        B.ZoneName{i-2} = out{1}{11}; % Zone names
        if str2double(X.InitialZoneConcentrations{1}(1))>0 
            out = textscan(X.InitialZoneConcentrations{i},...
                          '%s','delimiter',' ','multipleDelimsAsOne',1);
            B.x0(i-2)= str2double(out{1}{2});
        else
            B.x0(i-2)= 0;
        end
    end
    B.v=V; % Zone Volumes
    B.V=diag(V); % create a diagonal matrix with the zone volumes
    B.nZones=length(V); % # of zones
    B.Zones=1:B.nZones; % zone ID numbers
    
    % To find the inverse matrix of zone volumes
    b1= zeros(B.nZones);
    for i=1:B.nZones
      if B.V(i,i)~=0;
        b1(i,i)= 1/B.V(i,i);
      else
        b1(i,i)= B.V(i,i);
      end
    end
    % B.B=inv(B.V);
    
    % For state space equation
    B.A=zeros(B.nZones); % set the dimension of state transition A-matrix   
    B.B=b1; % inverse matrix of zone volumes B-matrix   
    B.C=eye(B.nZones); % C-Matrix for Sensor location
    B.D=zeros(B.nZones);     
    
    [row, col] = find(B.C);
    B.nS = length(row); % number of sensors 
    B.Sensors = col; % ID of zones that include sensor
    
    B.xext = 0; % external concentration
    B.Noise = 0; % uniform random noise
    
    out = textscan(X.LevelIconData{1},'%s','delimiter',' ','multipleDelimsAsOne',1);
    B.nLevel = str2double(out{1}{1}); % # of levels (floors of the building)
    B.LevelCounter = 1; % ID of the current level that is diplayed 
    
    for lv = 1:B.nLevel
        B.Level(lv).s = 0; % if there isn't any contaminant source set 0
    end
    
    out = textscan(X.AirflowPaths{1},'%s','delimiter',' ','multipleDelimsAsOne',1);
    B.nPaths=str2double(out{1}{1}); % # of Paths
    B.Openings= ones(1,B.nPaths);
    
    % To remove the extra paths of AHU
    for i=3:(length(X.AirflowPaths)-1)
            out = textscan(X.AirflowPaths{i},...
                           '%s','delimiter',' ','multipleDelimsAsOne',1);
            flags = str2double(out{1}{2});
        if (flags==16) || (flags==32) || (flags==64) % flags for the AHU paths
           B.nPaths=B.nPaths-1;
        end
    end   

    % fill table for path
    B.opn = '';
    for i=1:B.nPaths
        B.opn{i,1}=['Path', num2str(i)]; % Path ID
        B.opn{i,2}= 'Open'; % Path statu
        B.Flows(i)=0; % Path airflow rate
    end
    
    for i=1:B.nZones 
        B.clr{i} = 'w'; % color for the zone area
        B.Decomposition(i,:) = [0 0 0]; % To decompose the building
    end