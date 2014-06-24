%{
 Copyright 2013 KIOS Research Center for Intelligent Systems and Networks, University of Cyprus (www.kios.org.cy)

 Licensed under the EUPL, Version 1.1 or � as soon they will be approved by the European Commission - subsequent versions of the EUPL (the "Licence");
 You may not use this work except in compliance with theLicence.
 You may obtain a copy of the Licence at:

 http://ec.europa.eu/idabc/eupl

 Unless required by applicable law or agreed to in writing, software distributed under the Licence is distributed on an "AS IS" basis,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the Licence for the specific language governing permissions and limitations under the Licence.
%}

function  [SizeB x y cmp] = plotB(X,fig,Level,Decision,clr,WD,C,ZID, PID)
    
    out = textscan(X.project{4},'%s','delimiter',' ','multipleDelimsAsOne',1);
    ylim = str2double(out{1}{1});
    xlim = str2double(out{1}{2});
    
    j =1; i=5;
    while (j ~= Level)
        while (strcmp(X.LevelIconData{i},'!icn col row  #')~=1)
            i=i+1;    
        end
        j = j + 1;
        i = i + 1;
    end
       
    clear out
    out = textscan(X.LevelIconData{i},'%s','delimiter',' ','multipleDelimsAsOne',1);
    while (length(out{1})==4)
        Data1(i-4,1) = str2double(out{1}{1})';
        Data1(i-4,2) = str2double(out{1}{2})';
        Data1(i-4,3) = str2double(out{1}{3});
        Data1(i-4,4) = str2double(out{1}{4});
        i = i+1;
        out = textscan(X.LevelIconData{i},'%s','delimiter',' ','multipleDelimsAsOne',1);
    end

    k=0;
    j=0;
    m=0;
    for i = 1:length(Data1)
        if (Data1(i,1)==14)||(Data1(i,1)==15)||(Data1(i,1)==16)||(Data1(i,1)==17)||(Data1(i,1)==18)||(Data1(i,1)==19)||(Data1(i,1)==20)||(Data1(i,1)==21)||(Data1(i,1)==22)
            k=k+1;
            Data(k,:)= Data1(i,1:3);
        end
        if(Data1(i,1)==23)||(Data1(i,1)==25)||(Data1(i,1)==30)||(Data1(i,1)==31)||(Data1(i,1)==128)||(Data1(i,1)==129)
            j=j+1;
            Data2(j,:)= Data1(i,1:4);
        end
        if(Data1(i,1)==5)||(Data1(i,1)==6)
            m=m+1;
            Data3(m,:)= Data1(i,1:4);
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
            col = Data3(z,2);
            row = Data3(z,3);

            r = find(Data(:,3) < row);
            c = find(Data(1:max(r),2) < col);
            l = max(c);
            while err
                err = 0;
                clear Data4
                Data4(1,:) = Data(l,:);

                if (Data4(1,1)==14)||(Data4(1,1)==17)||(Data4(1,1)==18)||(Data4(1,1)==19)||(Data4(1,1)==21)||(Data4(1,1)==22)
                    dir = 1; % right
                elseif (Data4(1,1)==15)
                    dir = 2; % left
                elseif (Data4(1,1)==16)||(Data4(1,1)==20)
                    dir = 3; % up
                end

                clear col row
                col = 0; row = 0;
                i = 2;
                while (Data4(1,2) ~= col)||(Data4(1,3)~=row)
                    switch dir
                        case 1 % right
                            row = Data4(i-1,3);              
                            l = min(find((Data(:,3)==row)&(Data(:,2) > Data4(i-1,2))));
                            col = Data(l,2);
                            Data4(i,:)= Data(l,:);
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

                clear X Y
                X= Data4(:,2);
                Y= Data4(:,3);
                x{z} = X;
                y{z} = Y;
                if max(X) > xmax
                    xmax = max(X);
                end

                if max(Y) > ymax
                    ymax = max(Y);
                end

                if min(X) < xmin
                    xmin = min(X);
                end

                if min(Y) < ymin
                    ymin = min(Y);
                end

                if z>1
                    for i = 1:z-1                    
                        if inpolygon(X,Y,x{i},y{i})
                           err = 1;
%                         else
%                            err = 0; 
                        end
                    end 

                    if err
                        er = er + 1;
                        l = max(c(1:end-er));                
                    else
                        h(z)=fill(X,Y,clr{Data3(z,4)},'edgecolor','b','LineWidth',2);
                        hold on
%                         err = 0;
                    end
                else
                    h(z)=fill(X,Y,clr{Data3(z,4)},'edgecolor','b','LineWidth',2);
                    hold on
%                     err = 0;
                end
            end
        end
        set(h,'hittest','off');
        SizeB = [xmin, xmax, ymin, ymax];
    else
        SizeB = [0, 0, 0, 0];
        x = 0;
        y = 0;
%          col = Data(1,2);
%          row = Data(1,3);      
%          
%          hold on
%          for i = 2:length(Data)
%              if row == Data(i,3)
%                  if (Data(i,1) == 15) || (Data(i,1) == 16) || (Data(i,1) == 20)
%                      X = col:0.01:Data(i,2);
%                      plot( X, ones(length(X),1).*row,'.','LineWidth',3,'MarkerSize',4)
%                  end
%              elseif (Data(i,1) == 22) || (Data(i,1) == 21) || (Data(i,1) == 19)
%              else
%                  row = Data(i,3);
%                  col = Data(i,2);
%              end
%          end
%      
%          C = sortrows(Data,2);
%          col = C(1,2);
%          row = C(1,3);
%              
%          for i = 2:length(C)
%              if col == C(i,2)
%                  if (C(i,1) == 17) || (C(i,1) == 16)|| (C(i,1) == 21)
%                      Y = row:0.01:C(i,3);
%                      plot( ones(length(Y),1).*col, Y,'.','LineWidth',3,'MarkerSize',4)
%                  end
%              elseif (C(i,1) == 22) || (C(i,1) == 20) || (C(i,1) == 18)
%              else
%                  row = C(i,3);
%                  col = C(i,2);
%              end
%          end
    end
    
    if  exist('Data2','var')
        s=size(Data2);
        for i = 1:s(1)
            plot(Data2(i,2), Data2(i,3), 'o','LineWidth',4,'MarkerSize',3)
            if PID
                text(Data2(i,2)+0.5, Data2(i,3), ['P',num2str(Data2(i,4))])
            end
        end
    end
    
%     if  exist('Data3','var')
%         s=size(Data3);
%         for i = 1:s(1)
%             plot(Data3(i,2), Data3(i,3), '--ks', 'LineWidth',2,'MarkerEdgeColor','k')
%             text(Data3(i,2), Data3(i,3), ['\leftarrow Z',num2str(Data3(i,4))])
%             if find(Decision(i))
%                 plot(Data3(i,2), Data3(i,3), 'o', 'LineWidth',7,'MarkerSize',7,'MarkerEdgeColor','r')
%             end
%         end
%     end

   zn = [];
   
   [ns nz] = size(C);
   for i = 1:ns
       zn = [zn, find(C(i,:))];
   end
   
   if  exist('Data3','var')      
        s=size(Data3);
        for i = 1:s(1)
            switch Decision(i)
                case 0
                    if any(zn==i)                        
                        plot(Data3(i,2), Data3(i,3), '--ks', 'LineWidth',1,'MarkerFaceColor','k', 'MarkerEdgeColor','k')
                    else
                        plot(Data3(i,2), Data3(i,3), '--ks', 'LineWidth',2,'MarkerEdgeColor','k', 'MarkerSize',9)
                    end
        %                     plot(Data3(i,2), Data3(i,3), 'k', 'LineWidth',40)
                    if ZID
                        text(Data3(i,2), Data3(i,3), ['\leftarrow Z',num2str(Data3(i,4))])
                    end
                case 1
                    if any(zn==i)
                        plot(Data3(i,2), Data3(i,3), 's', 'LineWidth',1,'MarkerFaceColor',[1 204/255 0], 'MarkerEdgeColor',[1 204/255 0])
                    else
                        plot(Data3(i,2), Data3(i,3), 's', 'LineWidth',2,'MarkerEdgeColor',[1 204/255 0], 'MarkerSize',9)
                    end
                    if ZID
                        text(Data3(i,2), Data3(i,3), ['\leftarrow Z',num2str(Data3(i,4))])
                    end
                case 2
                    if any(zn==i)
                        plot(Data3(i,2), Data3(i,3), 's', 'LineWidth',1,'MarkerFaceColor',[153/255 153/255 0], 'MarkerEdgeColor',[153/255 153/255 0])
                    else
                        plot(Data3(i,2), Data3(i,3), 's', 'LineWidth',2,'MarkerEdgeColor',[153/255 153/255 0], 'MarkerSize',9)
                    end
                    if ZID
                        text(Data3(i,2), Data3(i,3), ['\leftarrow Z',num2str(Data3(i,4))])
                    end
                case 3
                    if any(zn==i)
                        plot(Data3(i,2), Data3(i,3), 's', 'LineWidth',1,'MarkerFaceColor',[0 153/255 0], 'MarkerEdgeColor',[0 153/255 0])
                    else
                        plot(Data3(i,2), Data3(i,3), 's', 'LineWidth',2,'MarkerEdgeColor',[0 153/255 0], 'MarkerSize',9)
                    end
                    if ZID
                        text(Data3(i,2), Data3(i,3), ['\leftarrow Z',num2str(Data3(i,4))])
                    end
            end
        end
   end
    
   set(gca,'YDir','reverse', 'YMinorGrid', 'off', 'XLim' , [0 xlim], 'YLim', [0 ylim], 'Xtick', [], 'Ytick', [])
   cmp = comprose(xlim-5,5,4,2,WD,8,'LineWidth',0.3,'FaceColor',.5*[1,1,1]);
%    axis off
%    set(axes(fig),'Color','w')
end
