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

function SolveSensorPlacement(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if isstruct(varargin{1}) 
        file0=varargin{1}.file0;
        solutionMethod=varargin{1}.pp.solutionMethod; % 0 is exhaustive, 1 is evolutionary based
        PopulationSize_Data=varargin{1}.pp.PopulationSize_Data;
        ParetoFraction_Data=varargin{1}.pp.ParetoFraction_Data;
        Generations_Data=varargin{1}.pp.Generations_Data;
        numberOfSensors=str2num(varargin{1}.pp.numberOfSensors);
        load([pwd,'\SPLACE\RESULTS\','pathname.File'],'pathname','-mat');
    else
        file0=varargin{1};
        %numberOfSensors=1:B.CountNodes; % EDITABLE,
        solutionMethod=0; % 0 is exhaustive, 1 is evolutionary based
        PopulationSize_Data=1000;
        ParetoFraction_Data=0.5;
        Generations_Data=50;
        numberOfSensors=1:14;
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    load([pathname,file0,'.0'],'-mat')
    load([pathname,file0,'.w'],'-mat')
    
    disp('Solve Sensor Placement')
    switch solutionMethod
        case 0
            F1=[];
            F2=[];
            k=1;
            Y.x=[];
            Y.F=[];
                
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if isstruct(varargin{1}) 
                    [v.figure1,v.axes2,v.text_progress]=SolveLoadGui;
                    v.str='Solve with exhaustive method..';
                    for j=numberOfSensors 
                        X = combnk(B.Zones,j);
                        total(j)=size(X,1);
                    end
                    total=sum(total);pp=1;
                end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            for j=numberOfSensors
                mean2=0;
                max2=0;
                X=combnk(B.Zones,j);
                for i=1:size(X,1)
                    mean2(i)=mean(min(W.w(:,X(i,:)),[],2));
                    max2(i)=max(min(W.w(:,X(i,:)),[],2));
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    if isstruct(varargin{1}) 
                        if mod(pp,100)==1
                            nload=pp/total;
                            v.color=char('red');
                            progressbar(v,nload);
                        end
                        pp=pp+1;
                    end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                     
                end
                y=[mean2; max2]';
                PS{j}=paretofront(y);
                
                %because the pareto front does not return solutions with
                %the same values
                tmp=find(PS{j}==1);
                for l=1:length(tmp)
                    for ll=2:size(X,1)
                        if sum((y(tmp(l),:)-y(ll,:)).^2)<10^-20
                            PS{j}(ll)=1;
                        end
                    end
                end
                sols=find(PS{j}==1);
                Y.xIndex{k}=X(sols,:);
                for i=1:size(Y.xIndex{k},1)
                    x=logical(zeros(1,14));
                    x(Y.xIndex{k}(i,:))=1;
                    Y.x=[Y.x; x];
                end
                y=[j*ones(size(y,1),1) y];
                Y.F=[Y.F; y(sols,:)];
                k=k+1;
            end
            save([pathname,file0,'.y0'],'Y', '-mat');
            %%%%%%%%%%%%%%%%
            if isstruct(varargin{1}) 
                close(v.figure1);
            end
            %%%%%%%%%%%%%%%%
        case 1
            if exist('gamultiobj','file')==2
                [x,fval,exitflag,output,population,score]=multiObjectiveOptimization(W,length(numberOfSensors),PopulationSize_Data,ParetoFraction_Data,Generations_Data);
                %remove zero solutions
                zeroidx=find(sum(x,2)==0);
                x(zeroidx,:)=[];
                fval(zeroidx,:)=[];
                [Y.x uniqx]=unique(x,'rows');
                Y.F=fval(uniqx,:);
                Y.xIndex=cell(1,max(Y.F(:,1)));
                for i=1:size(Y.x,1)
                    Y.xIndex{Y.F(i,1)}(size(Y.xIndex{Y.F(i,1)},1)+1,:)=find(Y.x(i,:));
                end               
            else
                disp('GAMULTIOBJ is not currenty installed in MATLAB')
            end
            save([pathname,file0,'.y1'],'Y', '-mat');
    end    
end


function [x,fval,exitflag,output,population,score] = multiObjectiveOptimization(W,nvars,PopulationSize_Data,ParetoFraction_Data,Generations_Data)
    % This is an auto generated M-file from Optimization Tool.
    % Start with the default options
    options = gaoptimset;
    % Modify options setting
    options = gaoptimset(options,'PopulationType', 'bitstring');
    options = gaoptimset(options,'PopulationSize', PopulationSize_Data);
    options = gaoptimset(options,'ParetoFraction', ParetoFraction_Data);
    options = gaoptimset(options,'Generations', Generations_Data);
    options = gaoptimset(options,'CreationFcn', @gacreationuniform);
    options = gaoptimset(options,'CrossoverFcn', @crossovertwopoint);
    options = gaoptimset(options,'MutationFcn', {  @mutationuniform [] });
    options = gaoptimset(options,'Display', 'iter');
    options = gaoptimset(options,'PlotFcns', { @gaplotpareto });
    options = gaoptimset(options,'OutputFcns', { [] });
    [x,fval,exitflag,output,population,score] = ...
    gamultiobj(@(x)multiobjectiveFunctions(x,W),nvars,[],[],[],[],[],[],options);
end

function f = multiobjectiveFunctions(x,W)
    %global W
    %disp(x)
    if sum(x)~=0
        f(1)=sum(x);
        f(2)=mean(min(W.w(:,find(x)),[],2));
        f(3)=max(min(W.w(:,find(x)),[],2));
    else
        %f=[inf inf 0];
        f=[0 inf inf];
    end
end
