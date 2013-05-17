function ComputeImpactMatrices(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if isstruct(varargin{1}) 
        file0=varargin{1}.file0;
        W.SensorThreshold=varargin{1}.SensorThreshold1;  
        W.InhalationRate=varargin{1}.InhalationRate1; 
        W.ZoneOccupancy=varargin{1}.ZoneOccupancy; 
    else
        file0=varargin{1};
        %IMPACT CALCULATION
        W.ZoneOccupancy=[0.5, 0.1, 0.2, 4, 4, 0.2, 0.5, 1 ,...
            1, 0.1 , 0.1, 0.1, 0.2, 1];   
        W.InhalationRate=0.5;  
        W.SensorThreshold=0.75;  
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    load([file0,'.0'],'-mat');
    disp('Compute Impact Matrix')
    U1=W.SensorThreshold;
    Dt=P.TimeStep;
    KMAX=P.SimulationTime;
    h=W.InhalationRate;
    pop=W.ZoneOccupancy;
    T=inf*ones(size(P.ScenariosFlowIndex,1)*size(P.ScenariosContamIndex,1),B.nZones);
    l=1;pp=1;
    for i=1:size(P.ScenariosFlowIndex,1)
        %tmpfile=[Cfile,num2str(i)];
        %disp(tmpfile)
        %load(tmpfile,'-mat');
        load([file0,'.c',num2str(i)],'-mat');
        for k=1:size(P.ScenariosContamIndex,1)
            %c=single(C.x{k})/1000;
            c=(C.x{k});
            for j=B.Zones
                if sum(c(:,j))==0
                else
                    if isempty(find(c(:,j)>=U1, 1 ))
                    else
                        T(l,j)=P.t(find(c(:,j)>=U1, 1 ));
                    end
                end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if isstruct(varargin{1}) 
                    if mod(pp,100)==1
                        nload=pp/(B.nZones*size(P.ScenariosFlowIndex,1)*size(P.ScenariosContamIndex,1)); 
                        varargin{1}.color=char('red');
                        progressbar(varargin{1},nload)
                    end
                    pp=pp+1;
                end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                   
                
            end
            Tindex=T(l,:)/Dt+1;
            Tindex(find(Tindex==Inf))=KMAX/Dt+1;
            Tindex=floor(Tindex);
            for j=1:B.nZones
                W.w(l,j)=(trapz(P.t(1:Tindex(1,j)),c(1:Tindex(1,j),:))*pop')/h;
            end 
            l=l+1;
        end
    end
    save([file0,'.w'],'W', '-mat');
end