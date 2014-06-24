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

function [Amat Qext Flows] = computeAmatrix(B,WindDirection, WindSpeed, AmbientTemperature, AmbientPressure, ZonesVolume, ZoneTemperature, Openings)
         
    for i=3:(length(B.X.AirflowPaths)-1)
        out = textscan(B.X.AirflowPaths{i},'%s','delimiter',' ','multipleDelimsAsOne',1);
        pzn(i-2)=str2double(out{1}{3});
        pzm(i-2)=str2double(out{1}{4});
    end
    nPaths = length(pzn);
    
    if exist('tmp.prj','file')==2
        delete('tmp.prj')
    end
    save tmp.prj
    pause(0.8)
    fid = fopen('tmp.prj','wt');
    fprintf(fid,'\n \n \n \n \n \n');
    fclose(fid);
    clear fid
    
    fid = fopen('tmp.prj', 'wt');
    
    i = 1;
    while strcmp(B.X.project{i},'! Ta       Pb      Ws    Wd    rh  day u..')~=1
        fprintf(fid, '%s\n', B.X.project{i});
        i=i+1;
    end
    fprintf(fid, '%s\n', B.X.project{i});
    i=i+1;
    out = textscan(B.X.project{i},'%s','delimiter',' ','multipleDelimsAsOne',1);
    fprintf(fid, '%7.3f %f %.3f %.2f %s %s %s %s %s %s ! steady simulation\n', AmbientTemperature+273.15, AmbientPressure, WindSpeed, WindDirection, out{1}{5:10});
    i=i+1;
    while strcmp(B.X.project{i},'-999')~=1
        fprintf(fid, '%s\n', B.X.project{i});
        i=i+1;
    end
    fprintf(fid, '%s\n', B.X.project{i});

    for i = 1:length(B.X.SpeciesContaminants)
        fprintf(fid, '%s\n', B.X.SpeciesContaminants{i});          
    end

    for i = 1:length(B.X.LevelIconData)
        fprintf(fid, '%s\n', B.X.LevelIconData{i});          
    end

    for i = 1:length(B.X.DaySchedules	)
        fprintf(fid, '%s\n', B.X.DaySchedules{i});                   
    end

    for i = 1:length(B.X.WeekSchedules)
        fprintf(fid, '%s\n', B.X.WeekSchedules{i});           
    end

    for i = 1:length(B.X.WindPressureProfiles)
        fprintf(fid, '%s\n', B.X.WindPressureProfiles{i});           
    end

    for i = 1:length(B.X.KineticReactions)
        fprintf(fid, '%s\n', B.X.KineticReactions{i});           
    end

    for i = 1:length(B.X.FilterElements)
        fprintf(fid, '%s\n', B.X.FilterElements{i});           
    end

    for i = 1:length(B.X.Filters)
        fprintf(fid, '%s\n', B.X.Filters{i});          
    end

    for i = 1:length(B.X.SourceSinkElements)
        fprintf(fid, '%s\n', B.X.SourceSinkElements{i});           
    end

    for i = 1:length(B.X.AirflowElements)
        fprintf(fid, '%s\n', B.X.AirflowElements{i});           
    end

    for i = 1:length(B.X.DuctElements)
        fprintf(fid, '%s\n', B.X.DuctElements{i});          
    end

    for i = 1:length(B.X.ControlSuperElements)
        fprintf(fid, '%s\n', B.X.ControlSuperElements{i});           
    end

    for i = 1:length(B.X.ControlNodes)
        fprintf(fid, '%s\n', B.X.ControlNodes{i});           
    end

    for i = 1:length(B.X.AHS)
        fprintf(fid, '%s\n', B.X.AHS{i});           
    end
 
    fprintf(fid, '%s\n', B.X.ZonesData{1});
    fprintf(fid, '%s\n', B.X.ZonesData{2});
    
    i = 3;      
    while strcmp(B.X.ZonesData{i},'-999')~=1
        out = textscan(B.X.ZonesData{i},'%s','delimiter',' ','multipleDelimsAsOne',1);
        fprintf(fid, '%4s %2s %3s %3s %3s %3s  %s %.2f %6.2f %s %s %s %s %s %s %s %s %s\n',out{1}{1:7}, ZonesVolume(i-2), ZoneTemperature(i-2)+273.15, out{1}{10:17},'0');
        i=i+1;
    end
    fprintf(fid, '%s\n', B.X.ZonesData{i});
        
    for i = 1:length(B.X.InitialZoneConcentrations)
        fprintf(fid, '%s\n', B.X.InitialZoneConcentrations{i});          
    end 
    
    fprintf(fid, '%s\n', B.X.AirflowPaths{1});
    fprintf(fid, '%s\n', B.X.AirflowPaths{2});
    
    i = 3;      
    while strcmp(B.X.AirflowPaths{i},'-999')~=1
        out = textscan(B.X.AirflowPaths{i},'%s','delimiter',' ','multipleDelimsAsOne',1);
        fprintf(fid, '%4s %4s %3s %3s %3s %3s  %3s %3s %3s %3s %3s %s %s %s %f %s %s %s %s %s %s %s %s %s %s %s %s %s\n',out{1}{1:14}, str2double(out{1}{15})*Openings(i-2), out{1}{16:27},'0');
        i=i+1;
    end
    fprintf(fid, '%s\n', B.X.AirflowPaths{i});   

    for i = 1:length(B.X.DuctJunctions)
        fprintf(fid, '%s\n', B.X.DuctJunctions{i});           
    end

    for i = 1:length(B.X.InitialJunctionConcentrations)
        fprintf(fid, '%s\n', B.X.InitialJunctionConcentrations{i});           
    end

    for i = 1:length(B.X.DuctSegments)
        fprintf(fid, '%s\n', B.X.DuctSegments{i});           
    end

    for i = 1:length(B.X.SourceSinks)
        fprintf(fid, '%s\n', B.X.SourceSinks{i});           
    end

    for i = 1:length(B.X.OccupancySchedules)
        fprintf(fid, '%s\n', B.X.OccupancySchedules{i});          
    end

    for i = 1:length(B.X.Exposures)
        fprintf(fid, '%s\n', B.X.Exposures{i});          
    end

    for i = 1:length(B.X.Annotations)
        fprintf(fid, '%s\n', B.X.Annotations{i});           
    end

    fprintf(fid,'* end project file.\n'); 
    fclose(fid);
    clear fid
    
%     !ContamX3.exe tmp.prj
    !contam-x-31.exe tmp.prj
    pause(0.1)
    save tmpn.txt
    fid = fopen('tmpn.txt','wt');
    fprintf(fid,'n \nn \ny \n1-%d \n', nPaths);
    fclose(fid);
    clear fid
    
    !simread3.exe tmp.sim <tmpn.txt
    pause(0.1)
    fid=fopen('tmp.lfr', 'r');
    Data = textscan(fid,'%s %s %d %f %f %f', 'headerLines',1);
    fclose(fid);
    clear fid
    paths = Data{5};
    Flows = paths(1:nPaths)'*3600/1.2041; % kg/s to m^3/h
        
    Qext=zeros(B.nZones,1);
    Q=zeros(B.nZones);
    for i=1:nPaths
        if (pzn(i)== -1)
            if (Flows(1,i)<0)
                Q(pzm(i),pzm(i))= Q(pzm(i),pzm(i))+ Flows(1,i);                
            else
                Qext(pzm(i),1)=Qext(pzm(i),1)+Flows(1,i);
            end
        else
            if (pzm(i)== -1)
                if(Flows(1,i)>0)
                    Q(pzn(i),pzn(i))= Q(pzn(i),pzn(i))- Flows(1,i);                    
                else
                    Qext(pzn(i),1)=Qext(pzn(i),1)-Flows(1,i);
                end
            else
                if (Flows(1,i)<0)
                    Q(pzn(i),pzm(i))= Q(pzn(i),pzm(i))+ abs(Flows(1,i));
                    Q(pzm(i),pzm(i))= Q(pzm(i),pzm(i))+ Flows(1,i);
                else
                    Q(pzn(i),pzn(i))= Q(pzn(i),pzn(i))- Flows(1,i);
                    Q(pzm(i),pzn(i))= Q(pzm(i),pzn(i))+ Flows(1,i);
                end
            end
        end
    end
    
    V=diag(ZonesVolume);
    b1= zeros(B.nZones);
    for i=1:B.nZones
       if V(i,i)~=0;
         b1(i,i)= 1/V(i,i);
       else
         b1(i,i)= V(i,i);
       end
    end
    
    Amat=b1*Q;
    delete('tmp.prj')
    delete('tmp.csm')
    delete('tmp.xlog')
    delete('tmp.sim')
    delete('tmp.log')
    delete('tmp.lfr')
    delete('tmp.xrf')
    delete('simread3.log')
    delete('tmpn.txt')
end