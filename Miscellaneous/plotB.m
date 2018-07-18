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

function  [SizeB x y cmp ZoneID] = plotB(X,fig,fig2,Level,Decomposition,clr,WD,C,ZID, PID)
    
    out = textscan(X.project{4},'%s','delimiter',' ','multipleDelimsAsOne',1);
    ylim = str2double(out{1}{1}); % Total sketchpad height
    xlim = str2double(out{1}{2}); % Total sketchpad width
    
    if ylim < 80
        ylim = 80;
        fcty = 1;
    else        
        fcty = round(80/ylim,2);  % Scaling factor for y coordinates
        ylim = 80;
    end
    
    if xlim < 100
        xlim = 100;
        fctx = 1;
    else        
        fctx = round(100/xlim,2); % Scaling factor for x coordinates
        xlim = 100;
    end
    
    j =1; i=5;
    while (j ~= Level)
        while (strcmp(X.LevelIconData{i},'!icn col row  #')~=1)
            i=i+1;    
        end
        j = j + 1;
        i = i + 1;
    end
       
    clear out
    % Separate values starting from column 5 of X.LevelIconData 
    out = textscan(X.LevelIconData{i},'%s','delimiter',' ','multipleDelimsAsOne',1);
    % Separate the data for each element and change its type from string to num
    while (length(out{1})==4)
        Data1(i-4,1) = str2double(out{1}{1})'; % icon type – see ‘special symbols’ in contam.h (I2)
        Data1(i-4,2) = str2double(out{1}{2})'; % row position on the SketchPad
        Data1(i-4,3) = str2double(out{1}{3});  % column position on the SketchPad
        Data1(i-4,4) = str2double(out{1}{4});  % zone, path, duct, etc., number
        i = i+1;
        out = textscan(X.LevelIconData{i},'%s','delimiter',' ','multipleDelimsAsOne',1);
    end

    k=0;
    j=0;
    m=0;
    n=0;
    for i = 1:length(Data1)
            % 14: Upper left corner, 15: Upper right corner, 16: Lower right corner, 17: Lower left  corner, 18: Left 'T' junction, 19: Upper 'T' junction, 20: Right 'T' junction, 21: Lower 'T' junction, 22: Cross junction  
        if (Data1(i,1)==14)||(Data1(i,1)==15)||(Data1(i,1)==16)||(Data1(i,1)==17)||(Data1(i,1)==18)||(Data1(i,1)==19)||(Data1(i,1)==20)||(Data1(i,1)==21)||(Data1(i,1)==22)
            k=k+1;
            Data(k,:)= Data1(i,1:3);
        end
            % 23: External Wall Crawl vent , 25: Inside door , 30: Exhaust fan , 31: , 128: Air supply vent , 129: Air Return 
        if(Data1(i,1)==23)||(Data1(i,1)==25)||(Data1(i,1)==30)||(Data1(i,1)==31)||(Data1(i,1)==128)||(Data1(i,1)==129)
            j=j+1;
            Data2(j,:)= Data1(i,1:4);
        end
            % 5: Zone Icon  , 6:
        if(Data1(i,1)==5)||(Data1(i,1)==6)
            m=m+1;
            Data3(m,:)= Data1(i,1:4);
        end
            % 130: AirHandling Unit supply/return valumes 
        if(Data1(i,1)==130)
            n=n+1;
            Data5(n,:)= Data1(i,1:4);
        end
    end

    axes(fig)
    cla
    
    xmax = 0;
    xmin = xlim;
    ymax = 0;
    ymin = ylim;
   
    if  exist('Data','var')
        s=size(Data3);
        for z =1:s(1);
            err = 1; er = 0;
            col = Data3(z,2); % Column of zone icon
            row = Data3(z,3); % Row of zone icon
            
            r = find(Data(:,3) < row); % find index of all elements above the first zone icon
%             c=find(Data(1:max(r),2) < col)
            c = find(Data(r,2) < col); % find the elements left of the icon  %% Changed from original
%             find(Data())
%            l= max(find(Data(c,2)==max(Data(c,2))))
            l = max(c); 
            while err
                err = 0;
                clear Data4
%                 if isempty(l)
%                     hold on;
%                     break
%                 end
                Data4(1,:) = Data(l,:);

                if (Data4(1,1)==14)||(Data4(1,1)==17)||(Data4(1,1)==18)||(Data4(1,1)==19)||(Data4(1,1)==21)||(Data4(1,1)==22)
                    dir = 1; % right
                elseif (Data4(1,1)==15)
                    dir = 2; % left
                elseif (Data4(1,1)==16)||(Data4(1,1)==20)
                    dir = 3; % up
                end

                clear col row
                col = 0; row = 0; flag=0;
                i = 2;
                % The while loop starts from a corner and continues until a
                % full rectangle is found (4 corners). Depending on the
                % corner found in each iteration it choses to move either
                % right/left/up/down for finding the next closest corner
                while (Data4(1,2) ~= col)||(Data4(1,3)~=row) % Stop when return to the begining or exit the rectangle
                    switch dir
                        case 1 % right
                            row = Data4(i-1,3);              
                            l = min(find((Data(:,3)==row)&(Data(:,2) > Data4(i-1,2)))); % find the closest element to the right of the same row 
                            col = Data(l,2); % save the column of the closest element to the right
                            Data4(i,:)= Data(l,:);
                            % find the type of the closest to the right element
                            if (Data4(i,1)==16)
                                 dir = 3;
                            elseif (Data4(i,1)==15)||(Data4(i,1)==19)||(Data4(i,1)==20)||(Data4(i,1)==22)
                                dir = 4;
                            elseif (Data4(i,1)==21)
                                    dir = 1;
                            end
                        case 2 % left
                            row = Data4(i-1,3);
                            l = max(find((Data(:,3)==row)&(Data(:,2) < Data4(i-1,2))));
                            col = Data(l,2);
                            Data4(i,:)= Data(l,:);
                            if (Data4(i,1)==17)||(Data4(i,1)==18)||(Data4(i,1)==21)||(Data4(i,1)==22)
                                dir = 3;
                            elseif (Data4(i,1)==14)
                                dir = 4;
                            elseif (Data4(i,1)==19)
                                dir = 2;
                            end
                        case 3 % up
                            col = Data4(i-1,2);              
                            l = max(find((Data(:,2)==col)&(Data(:,3) < Data4(i-1,3))));
                            row = Data(l,3);
                            Data4(i,:)= Data(l,:);
                            if (Data4(i,1)==14)||(Data4(i,1)==18)||(Data4(i,1)==19)||(Data4(i,1)==22)
                                    dir = 1;                                
%                                 dir = 1;
                            elseif (Data4(i,1)==15)
                                dir = 2;
                            elseif (Data4(i,1)==20)
                                dir = 3;
                            end
                        case 4 % down
                            col = Data4(i-1,2);              
                            l = min(find((Data(:,2)==col)&(Data(:,3) > Data4(i-1,3))));
                            row = Data(l,3);
                            Data4(i,:)= Data(l,:);
                            if (Data4(i,1)==17)
                                dir = 1;
                            elseif (Data4(i,1)==16)||(Data4(i,1)==20)||(Data4(i,1)==21)||(Data4(i,1)==22)
                                dir = 2;
                            elseif (Data4(i,1)==18)
                                dir = 4;
                            end
                    end
                    i = i + 1;        
                end

                clear X1 Y1
                X1= 1*Data4(:,2); % multiply by x scaling factor
                Y1= 1*Data4(:,3); % multiply by y scaling factor
                x{z} = X1;
                y{z} = Y1;
                if max(X1) > xmax
                    xmax = max(X1);
                end

                if max(Y1) > ymax
                    ymax = max(Y1);
                end

                if min(X1) < xmin
                    xmin = min(X1);
                end

                if min(Y1) < ymin
                    ymin = min(Y1);
                end

                if z>1 % z shows the number of rectangles
                    for i = 1:z-1
                         % A problem appeared when the same exact rectangle
                        % at z==83 was found. If we continue without err=1
                        % everything is fine

                        if inpolygon(X1,Y1,x{i},y{i}) % checks if points X1,Y1 are in allready found polygons ,x{i},y{i}               
                                err = 1;
                        end
                    end 
                    % Check if the valid polygon found contains the
                    % investigated zone. If not, then continue to find
                    % polygons.
                    if ~inpolygon(Data3(z,2),Data3(z,3),x{z},y{z})
                        err=1;
                    end
                    % if the polygon found includes all the zones then
                    % move to the next one
                    if  nnz(inpolygon(Data3(:,2),Data3(:,3),x{z},y{z}))>=length(Data3)
                        err=1;
                    end
                    if err 
                        er = er + 1;
                        l = max(c(1:end-er));
                    else
                        h(z)=fill(fctx*X1,fcty*Y1,clr{Data3(z,4)},'edgecolor','b','LineWidth',2);
                        hold all
                        err = 0;
                    end
                else
                    % draws a polygon indicated by points X1 and Y1 with
                    % color 'clr{Data3(z,4)}'
                    h(z)=fill(fctx*X1,fcty*Y1,clr{Data3(z,4)},'edgecolor','b','LineWidth',2);
                    hold all
%                     err = 0;
                end
            end
        end
        set(h,'hittest','off');
        SizeB = [xmin, xmax, ymin, ymax];
    else
        SizeB = [0, 0, 0, 0];
        x = [];
        y = [];
    end
    
    if  exist('Data2','var')
        s=size(Data2);
        for i = 1:s(1)
    % 23: External Wall Crawl vent , 25: Inside door , 30: Exhaust fan , 31: , 128: Air supply vent , 129: Air Return 

            plot(fctx*Data2(i,2), fcty*Data2(i,3), 'kd','LineWidth',1,'MarkerSize',5,'MarkerFaceColor',[1 1 1])
            if PID
                text(fctx*(Data2(i,2)+0.5), fcty*(Data2(i,3)-0.5), ['P',num2str(Data2(i,4))])
            end
        end
    end
    
    zn = [];
   
   [ns nz] = size(C);
   for i = 1:ns
       zn = [zn, find(C(i,:))];
   end
   
   if  exist('Data3','var')      
        s=size(Data3);
        for i = 1:s(1)
            if any(zn==Data3(i,4))                        
                plot(fctx*Data3(i,2), fcty*Data3(i,3), '--ks', 'LineWidth',1,'MarkerFaceColor',Decomposition(Data3(i,4),:), 'MarkerEdgeColor',Decomposition(Data3(i,4),:))
            else
                plot(fctx*Data3(i,2), fcty*Data3(i,3), '--ks', 'LineWidth',2,'MarkerEdgeColor',Decomposition(Data3(i,4),:), 'MarkerSize',fctx*9)
            end
            if ZID
                text(fctx*Data3(i,2), fcty*Data3(i,3), ['\leftarrow Z',num2str(Data3(i,4))])
            end
            if isfield(X,'Sim')
               if any(X.Sim{1}(:)== Data3(i,4))
                  plot(fctx*Data3(i,2), fcty*Data3(i,3), 'o','MarkerFaceColor','r','MarkerSize',14,'MarkerEdgeColor','r');
                  mins = (X.Sim{3}(1) - fix(X.Sim{3}(1)))*60;
                  sec = (mins - fix(mins))*60; 
                  text(fctx*Data3(i,2), fcty*(Data3(i,3)-0.5), ['\downarrow ',num2str(X.Sim{2}(1)), sprintf(' g/hr at %02d:%02d:%02d !!!',fix(X.Sim{3}(1)),fix(mins),fix(sec))])
               end
            end
        end
        ZoneID = Data3;
   else
        ZoneID = [];
   end
   
%    if  exist('Data3','var')      
%         s=size(Data3);
%         for i = 1:s(1)
%             switch Decomposition(i)
%                 case 0
%                     if any(zn==i)                        
%                         plot(fctx*Data3(i,2), fcty*Data3(i,3), '--ks', 'LineWidth',1,'MarkerFaceColor','k', 'MarkerEdgeColor','k')
%                     else
%                         plot(fctx*Data3(i,2), fcty*Data3(i,3), '--ks', 'LineWidth',2,'MarkerEdgeColor','k', 'MarkerSize',fctx*9)
%                     end
%         %                     plot(Data3(i,2), Data3(i,3), 'k', 'LineWidth',40)
%                     if ZID
%                         text(fctx*Data3(i,2), fcty*Data3(i,3), ['\leftarrow Z',num2str(Data3(i,4))])
%                     end
%                 case 1
%                     if any(zn==i)
%                         plot(fctx*Data3(i,2), fcty*Data3(i,3), 's', 'LineWidth',1,'MarkerFaceColor',[1 204/255 0], 'MarkerEdgeColor',[1 204/255 0])
%                     else
%                         plot(fctx*Data3(i,2), fcty*Data3(i,3), 's', 'LineWidth',2,'MarkerEdgeColor',[1 204/255 0], 'MarkerSize',fctx*9)
%                     end
%                     if ZID
%                         text(fctx*Data3(i,2), fcty*Data3(i,3), ['\leftarrow Z',num2str(Data3(i,4))])
%                     end
%                 case 2
%                     if any(zn==i)
%                         plot(fctx*Data3(i,2), fcty*Data3(i,3), 's', 'LineWidth',1,'MarkerFaceColor',[153/255 153/255 0], 'MarkerEdgeColor',[153/255 153/255 0])
%                     else
%                         plot(fctx*Data3(i,2), fcty*Data3(i,3), 's', 'LineWidth',2,'MarkerEdgeColor',[153/255 153/255 0], 'MarkerSize',fctx*9)
%                     end
%                     if ZID
%                         text(fctx*Data3(i,2), fcty*Data3(i,3), ['\leftarrow Z',num2str(Data3(i,4))])
%                     end
%                 case 3
%                     if any(zn==i)
%                         plot(fctx*Data3(i,2), fcty*Data3(i,3), 's', 'LineWidth',1,'MarkerFaceColor',[0 153/255 0], 'MarkerEdgeColor',[0 153/255 0])
%                     else
%                         plot(fctx*Data3(i,2), fcty*Data3(i,3), 's', 'LineWidth',2,'MarkerEdgeColor',[0 153/255 0], 'MarkerSize',fctx*9)
%                     end
%                     if ZID
%                         text(fctx*Data3(i,2), fcty*Data3(i,3), ['\leftarrow Z',num2str(Data3(i,4))])
%                     end
%             end
%         end
%    end
   
   if exist('Data5','var')
       
       k = 1;
       for i=3:(length(X.ZonesData)-1)
            out = textscan(X.ZonesData{i},'%s','delimiter',' ','multipleDelimsAsOne',1);
            if 10 == str2double(out{1}{2}); % Zone flag (AHU)
                id(k,1)=str2double(out{1}{1}); % Zone ID (AHU)
                id(k,2)= round(k/2);
                k=k+1;
            end
       end
       
       s=size(Data5);
       for j = 1:s(1)
           r = find(id(:,2)==j);
           for i = 1:2
                if any(zn==id(r(i),1))                        
                    plot(fctx*Data5(j,2), fcty*(Data5(j,3) + (i-1)), '--ks', 'LineWidth',1,'MarkerFaceColor',Decomposition(id(r(i),1),:), 'MarkerEdgeColor',Decomposition(id(r(i),1),:))
                else
                    plot(fctx*Data5(j,2), fcty*(Data5(j,3) + (i-1)), '--ks', 'LineWidth',2,'MarkerEdgeColor',Decomposition(id(r(i),1),:), 'MarkerSize',fctx*9)
                end
                if ZID
                    text(fctx*Data5(j,2), fcty*(Data5(j,3) + (i-1)), ['\leftarrow Z',num2str(id(r(i),1))])
                end
           end
       end
   end
   
   
%    if exist('Data3','var') 
%         ZoneID = Data3;
%    else
%         ZoneID = [];   
%    end
   
   set(gca,'YDir','reverse', 'YMinorGrid', 'off', 'XLim' , [0 xlim], 'YLim', [0 ylim], 'Xtick', [], 'Ytick', [])
   
%    axes(fig2)
%    cla
   cla(fig2)
   cmp = comprose(xlim-3.5,6,4,2,WD,8,'LineWidth',0.3,'FaceColor',.5*[1,1,1],'Parent', fig);
%    cmp = comprose(1,1,4,2,WD,8,'LineWidth',0.3,'FaceColor',.5*[1,1,1]);
end
