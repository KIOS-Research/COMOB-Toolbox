function [list,exitflag] = SetPartition(n, k,Amat)
% Purpose: Set partitioning
% LIST = SetPartition(N)
%   N is an integer
%   Return the cell list of all partitions of the integer set {1:N}.
%   Output LIST is the cell of size (B x 1), where B is Bell number B(n),
%   the number of ways of partitionning. Each list{j} is a partition of the
%   set {1:N}.
%
% LIST = SetPartition(N, K)
%   N and K are integers. Specify the fixed size K of the partitions.
%   Return the cell list of all partitions of the integer set {1:N} in K
%   non-empty subsets.
%   Output LIST is the cell of size (S x 1), where S Stirling number of the
%   second kind S(n,k). Each list{j} is a partition of {1:N} having 
%   exactly K non-empty subsets.
%   LIST is large for N large (of course) and K ~ N/2
%
% User can provide a set with elements different than {1:N} by substitute
% the first input argument (N) with SetElements
%       >> LIST = SetPartition(SetElements, ...)
% where SetElements is an array or cell array of N elements.
%
% USAGE EXAMPLE 1:
%
%     % Find all the length-2 partitions of {1,2,3,4} 
%     p=SetPartition(4,2);
%     % Display
%     fprintf('All the length-2 partitions of {1,2,3,4} are:\n') 
%     for i=1:size(p,1)
%         fprintf('\t')
%         for j=1:length(p{i})
%             s = sprintf('%d,', p{i}{j});
%             s(end)=[];
%             s = sprintf('{%s}', s);
%             if j<length(p{i})
%                 s = sprintf('%s + ', s);
%             end
%             fprintf('%s', s)
%         end
%         fprintf('\n')
%     end
%
% EXAMPLE 2:
%     p=SetPartition({'mouse' 'dog' 'cat'});
%
% Notes:
%   - The result has the same class as N.
%   - The result size growth very steep with respect to N. It advisable to
%     call PARTITION with N <= 11.
%   - Recursive algorithm in a general case (i.e. when only N is provided)
%     Iteration (derecursive loops) when K is specified.
%
% See also Bell, Stirling2nd, nchoosek, ndgrid, perms, DispPartObj,
%          partitions, partdisp (Matt Fig's FEX File ID: #24185)
%
% Author: Bruno Luong <brunoluong@yahoo.com>
% History
%   Original: 16-May-2009
%   17-May-2009: No more sorting + derecurse when K is provided
%   18-May-2009: Fix the bug for N=0, minor improvements
%   23-May-2003: Possibility to partition generic set elements
%   02-Jun-2009: comments change
exitflag=1;
if iscell(n) || ~isscalar(n) % NOTE: isscalar({1}) is TRUE
    % Generic set elements
    elements = reshape(n,1,[]);
    n = size(elements,2); % double
    if nargin>=2 % cast n to the same class of k
        n = feval(class(k), n);
    end
else
    % standard set
    elements = (1:n);
end

n = round(n);

if n<0
    error('Partition requires n>=0: n=%d', n);
end

if nargin<2
    if n==0
        list = {{zeros(0,1)}};
    else
        list = partall(n, elements);
    end
else
    k = round(k);
    % Cast k to the same class of n
    k = feval(class(n), k);
    if k>n
        error('SetPartition requires k<=n: k=%d, n=%d', k, n);
    elseif k<0
        error('SetPartition requires k>=0: k=%d', k);
    elseif k==0
        if n>0
            list = {};
        else %if n==0
            list = {{}};
        end
    else
        [list,exitflag] = partk(n, k, elements,Amat);
    end
end
end % SetPartition


function list = partall(n, elements)
% LIST = PARTALL(N)
%   Return the cell list of all partitions of the integer set {1:n}
%   Output LIST is the cell of size (b x 1), where b is Bell number Bn.
%   Each list{j} is a partition of {1:n}

if n==1
    list = {{elements(n)}};
else
    % Allocate
    bn = Bell(n);
    list = cell(bn, 1);
    
    pos = 0;    
    % recursive call
    lp = partall(n-1, elements);
    for i=1:size(lp,1)
        part_i = insert(lp{i}, n, 1, elements);
        list(pos+(1:size(part_i,1))) = part_i;
        pos = pos + size(part_i,1);
    end
end

end % partall


function [list,exitflag] = partk(n, k, elements,Amat)
% LIST = PARTK(N, K)
%   Return the cell list of all partitions of the integer set {1:n} in k
%   non-empty subsets.
%   Output LIST is the cell of size (s x 1), where s Stirling number of the
%   second kind S(n,k). Each list{j} is a partition of {1:n} having 
%   exactly K non-empty subsets.
exitflag=1;
m = n-k+1;

% L is a temporary buffer, L(kappa) stores partition for nu-elements
% nu will be defined later (see line #162)
L = cell(m,1);

% Initialize single partition
for j=1:m
    L{j} = {{elements(1:j)}};
end

% Compute the array of Stirling numbers
[~,S] = Stirling2nd(n, k);

s_all_partitions=sum(S(k:end,end));

if round( (s_all_partitions*(150*k+n*8))/(1024^3),2) >= 4
    promptMessage = sprintf(['The calculation of all partitioning solutions requires approximately ' num2str(round( (s_all_partitions*(150*k+n*8))/(1024^3),2)) ' GB of memory and several minutes. Do you want to continue?' ]);
    button = questdlg(promptMessage, 'Continue', 'Continue', 'Cancel', 'Continue');
    if strcmpi(button, 'Cancel')
        list={};
        return; % Or break or continue
    end
end
progressbar2('Calculating all possible partitioning solutions','Calculating Next combination'); 
progbar_count=0;

% Derecursive loops
for kappa=2:k
    L{1} = {num2cell(elements(1:kappa))};
    for j=2:m
        progbar_count=progbar_count+1;
        nu = j + kappa - 1;
        
        % Allocate
        list = cell(S(nu,kappa), 1);
        
        pos = 0;
        lp = L{j};
        total_sub_iterations=size(L{j},1)+size(L{j-1},1);
        total_sub_counter=0;
        for i=1:size(lp,1)
            if isempty(findobj('Tag','ProgressBar'))
               exitflag=-1;
               return
            end
            % augmented insertion
            part_i = insert(lp{i}, nu, 2, elements);
            list(pos+(1:size(part_i,1))) = part_i;
            pos = pos + size(part_i,1);
            total_sub_counter=total_sub_counter+1;
            progressbar2((progbar_count/((k-1)*(m-1))),total_sub_counter/total_sub_iterations)

        end
        
        lp = L{j-1};
        for i=1:size(lp,1)
            if isempty(findobj('Tag','ProgressBar'))
               exitflag=-1;
               return
            end
            % same-size insertion
            part_i = insert(lp{i}, nu, 0, elements);
            list(pos+(1:size(part_i,1))) = part_i;
            pos = pos + size(part_i,1);
            total_sub_counter=total_sub_counter+1;
            progressbar2((progbar_count/((k-1)*(m-1))),total_sub_counter/total_sub_iterations)

        end
        
        % Assign the result
        L{j} = list;
        progressbar2((progbar_count/((k-1)*(m-1))))
    end % j-loop
end % kappa-loop

% Final result found in the last position of the buffer
% tic
% addpath('C:\Users\akyria09\Desktop\ConnectivityChecking');
A_new=Amat+Amat';

A_new(logical(eye(size(A_new))))=0;


% clear not needed variables from memory
clear list lp

list_temp=L{m};

clear L
r_num=S(end,end);

promptMessage = ['Eliminate unconnected partitioning solutions?'];
button = questdlg(promptMessage, 'Yes/No', 'Yes', 'No', 'Yes');
if strcmpi(button, 'No')
    list=list_temp;
	return; % Or break or continue
end
if nnz(A_new)~=0
    parfor i=1:r_num
    %      list_temp{2047}
         for j=1:k
             % If the partition is singleton or unconnected then discard it
            if nnz(list_temp{i}{j})==1 || nnz ( (dfs(sparse(A_new(list_temp{i}{j},list_temp{i}{j})),1))+1)~=length(list_temp{i}{j})
                list_temp{i}={};
                break;
            end       
         end
    %      progressbar2(1,i/r_num)
    end
else
    uiwait(msgbox('To eliminated unconnected partitions a Scenario has to be created first.', 'Error', 'error'))
end
    %      progressbar2(1,1)


 % toc
% tic
% list_temp=L{m};
%  parfor i=1:2047
% %      list_temp{2047}
%      for j=1:k
%         if nnz(list_temp{i}{j})==1
%             list_temp{i}={};
%             break;
%         end
%      end
%  end 
%  toc
list=list_temp(~cellfun('isempty',list_temp));
% list = L{m};

end % partk

% Create a new list of partions from one partition of {1,2,...n-1} and {n}
function part_i = insert(part, n, flag, elements)
% flag = 1, perform all possible insertions
%      = 0, insertion that keeps constant size only
%      = 2, insertion that increase by 1 the size only

l = size(part,2);

if flag == 0
    m = l;
elseif flag == 2
    m = 1;
else % flag == 1
    m = l+1;
end
en = elements(n);

% Allocate and pre-filled
part_i = cell(m,1);

if flag<=1
    [part_i{1:l}] = deal(part);
    % Insert N into each individual existing subset
    for j = 1:l
        part_i{j}{j} = [part_i{j}{j} en];
    end
end

% insert {N} as standalone subset
if flag>=1
    part_i{m} = [part {en}];
end

end % insert
