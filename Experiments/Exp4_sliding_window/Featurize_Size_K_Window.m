function [DB,Train,Test] = Featurize_Size_K_Window(Data,K,TestFraction,RetainTrainingCell)
% Input: 
% Data = Cell array of all sequences
% K = Sliding window size
% TestFraction = Fraction of data to be separated randomly into Test data
%
% Output:
% DB = cell array of all the sequences each divided into K sized windows
% Train = Consolidated K sized sequences 
% Test  = Fraction of DB as determined by TestFraction
nData = size(Data,1);
DB = cell(nData ,1);
for i=1:nData        
%   Size of window is the number of K sized sequences to be extracted from
%   ith Data sequence
    window = zeros(length(Data{i})-K+1,K);
    for j=1:length(Data{i})-K+1
%       Extract K-Sized Window of system calls
        window(j,:) = Data{i}(j:j+K-1);
    end
    DB{i} = window;
end

% Seperate the data into training and testing sequences based on test
% fraction.
ntest = floor(size(DB,1) * TestFraction);
randInd = randperm(length(DB));
Test = DB(randInd(1:ntest),:);
Train = [];
if ntest < size(DB,1)
    Train1 = DB(randInd(ntest+1:end),:);
    if RetainTrainingCell == 1
        Train = Train1;
        return
    end
    % Retain only the Unique K-sized sequences
    Train1 = unique(sortrows(cell2mat(Train1),1),'rows');
    syscalls = unique(Train1(:,1));
    Train = cell(syscalls(end),1);
    next = 1;
    while next<=size(Train1,1)
        ind = find(Train1(:,1)==Train1(next,1));
        Train{Train1(next,1)} = Train1(ind,:);
        next = ind(end)+1;
    end
end



% Count of unique bigrams
% k = 1;
% for i=1:size(Train1,1)
%     if Train(k,1) ~= Train1(i,1)
%         k=k+1;
%     end
%     Train(k,2) = Train(k,2) + Train1(i,2);
% end
% WordsSumTrain = sum(Train(:,2));
% Train(:,2) = Train(:,2)./WordsSumTrain;


% %       Unigrams
%         temp = Data{i}(j);
%         ind = find(window(1,:)==temp);
%         if ~isempty(ind)
%             window(2,ind) = window(2,ind)+1;
%         else
%             window(1,k) = temp;
%             window(2,k) = 1;
%             k=k+1;
%         end
%         
%         if j==length(Data{i})
%             break;
%         end
% %       Bigrams
%         temp = Data{i}(j)*nWords + Data{i}(j+1);
%         ind = find(window(1,:)==temp);
%         if ~isempty(ind)
%             window(2,ind) = window(2,ind)+1;
%         else
%             window(1,k) = temp;
%             window(2,k) = 1;
%             k=k+1;
%         end
%     end    
%     
%     window = sortrows(window',1);
%     window(~all(window,2),:)=[];
%     DB{i} = window;