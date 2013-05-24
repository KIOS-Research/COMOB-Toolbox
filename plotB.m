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

function plotB(X,fig,Level,Decision)
    
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
        if(Data1(i,1)==23)||(Data1(i,1)==25)||(Data1(i,1)==128)||(Data1(i,1)==129)
            j=j+1;
            Data2(j,:)= Data1(i,1:4);
        end
        if(Data1(i,1)==5)
            m=m+1;
            Data3(m,:)= Data1(i,1:4);
        end
    end

    axes(fig)
    cla
    
    if  exist('Data','var')
    
         col = Data(1,2);
         row = Data(1,3);      
         
         hold on
         for i = 2:length(Data)
             if row == Data(i,3)
                 if (Data(i,1) == 15) || (Data(i,1) == 16) || (Data(i,1) == 20)
                     X = col:0.01:Data(i,2);
                     plot( X, ones(length(X),1).*row,'.','LineWidth',3,'MarkerSize',4)
                 end
             elseif (Data(i,1) == 22) || (Data(i,1) == 21) || (Data(i,1) == 19)
             else
                 row = Data(i,3);
                 col = Data(i,2);
             end
         end
     
         C = sortrows(Data,2);
         col = C(1,2);
         row = C(1,3);
             
         for i = 2:length(C)
             if col == C(i,2)
                 if (C(i,1) == 17) || (C(i,1) == 16)|| (C(i,1) == 21)
                     Y = row:0.01:C(i,3);
                     plot( ones(length(Y),1).*col, Y,'.','LineWidth',3,'MarkerSize',4)
                 end
             elseif (C(i,1) == 22) || (C(i,1) == 20) || (C(i,1) == 18)
             else
                 row = C(i,3);
                 col = C(i,2);
             end
         end
    end
    
    if  exist('Data2','var')
        s=size(Data2);
        for i = 1:s(1)
            plot(Data2(i,2), Data2(i,3), 'o','LineWidth',4,'MarkerSize',3)
            text(Data2(i,2)+0.5, Data2(i,3), ['P',num2str(Data2(i,4))])
        end
    end
    
    if  exist('Data3','var')
        s=size(Data3);
        for i = 1:s(1)
            plot(Data3(i,2), Data3(i,3), '--rs', 'LineWidth',2,'MarkerEdgeColor','k')
            text(Data3(i,2), Data3(i,3), ['\leftarrow Z',num2str(Data3(i,4))])
            if find(Decision(i))
                plot(Data3(i,2), Data3(i,3), 'o', 'LineWidth',7,'MarkerSize',7,'MarkerEdgeColor','r')
            end
        end
    end
    
   set(gca,'YDir','reverse', 'YMinorGrid', 'off', 'XLim' , [0 xlim], 'YLim', [0 ylim])
end
