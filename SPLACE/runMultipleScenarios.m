function runMultipleScenarios(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if isstruct(varargin{1}) 
        file0=varargin{1}.file0;
        P=varargin{1}.P;
        B=varargin{1}.B;
    else
        file0=varargin{1};
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    load([file0,'.0'],'-mat');
    disp('Run Multiple Scenarios')
    %    P.FlowParameters={'WindDirection', 'WindSpeed','AmbientTemperature',...
    %    'ZonesVolume', 'ZoneTemperature','PathOpenings'};
    for i=1:size(P.ScenariosFlowIndex,1)
        WD = P.FlowParamScenarios{1}(P.ScenariosFlowIndex(i,1));
        WS = P.FlowParamScenarios{2}(P.ScenariosFlowIndex(i,2));
        AT = P.FlowParamScenarios{3}(P.ScenariosFlowIndex(i,3));
        ZV = P.FlowParamScenarios{4}(P.ScenariosFlowIndex(i,4),:);
        ZT = P.FlowParamScenarios{5}(P.ScenariosFlowIndex(i,5),:);
        O =  P.FlowParamScenarios{6}(P.ScenariosFlowIndex(i,6),:);
        Amat{i}=computeAmatrix(B,WD, WS, AT, ZV, ZT, O);
    end
    clc
    
    disp('Compute Quality')
    
    Dt=P.TimeStep;
    
    %Cfile= ['C', datestr(now,'-yyyy-mm-dd-HH-MM.')];
    
    k=1;
    for l=1:size(Amat,2)
        C.A=Amat{l};
        for i=1:size(P.ScenariosContamIndex,1)
            sys=ss(Amat{l},B.B,B.C,B.D);
            uint=zeros(B.nZones,length(P.t));
            rate=P.SourceParamScenarios{1}(P.ScenariosContamIndex(i,1));
            dur=P.SourceParamScenarios{2}(P.ScenariosContamIndex(i,2));
            loc=P.SourceLocationScenarios{P.ScenariosContamIndex(i,3)};
            uint(loc',1:floor(dur/Dt))=rate;
            u=uint;
            xinit=B.x0'.*ones(B.nZones,1);
            C.x{i}=lsim(sys,u,P.t,xinit);
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if isstruct(varargin{1}) 
                if mod(k,100)==1
                    nload=k/(size(P.ScenariosContamIndex,1)*size(Amat,2)); 
                    varargin{1}.color=char('red');
                    progressbar(varargin{1},nload)
                end
                k=k+1;
            end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
        save([file0,'.c',num2str(l)],'C', '-mat');
        clear C;
    end
end

function Amat = computeAmatrix(B,WindDirection, WindSpeed, AmbientTemperature, ZonesVolume, ZoneTemperature, Openings)
         
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
    while ~exist('tmp.prj','file')
    end
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
    fprintf(fid, '%7.3f %s %.3f %.2f %s %s %s %s %s %s ! steady simulation\n', AmbientTemperature+273.15, out{1}{2}, WindSpeed, WindDirection, out{1}{5:10});
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
    
    !ContamX3.exe tmp.prj
    
    save tmpn.txt
    fid = fopen('tmpn.txt','wt');
    fprintf(fid,'n \nn \ny \n1-%d \n', nPaths);
    fclose(fid);
    clear fid
    
    !simread3.exe tmp.sim <tmpn.txt
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

    Amat=B.B*Q;
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