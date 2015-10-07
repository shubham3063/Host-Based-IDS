function [TF,Train,Test] = Featurize_HMM(Data,TestFraction,SizeVocabulary)
nWords = SizeVocabulary;
nData = size(Data,1);
TF = cell(nData ,1);
for i=1:nData
    k=1;
    bigram=zeros(2,nData+nWords);
    for j=1:length(Data{i})        
%       Unigrams
        temp = Data{i}(j);
        ind = find(bigram(1,:)==temp);
        if ~isempty(ind)
            bigram(2,ind) = bigram(2,ind)+1;
        else
            bigram(1,k) = temp;
            bigram(2,k) = 1;
            k=k+1;
        end
        
        if j==length(Data{i})
            break;
        end
%       Bigrams
        temp = Data{i}(j)*nWords + Data{i}(j+1);
        ind = find(bigram(1,:)==temp);
        if ~isempty(ind)
            bigram(2,ind) = bigram(2,ind)+1;
        else
            bigram(1,k) = temp;
            bigram(2,k) = 1;
            k=k+1;
        end
    end    
    
    bigram = sortrows(bigram',1);
    bigram(~all(bigram,2),:)=[];
    TF{i} = bigram;
end

% Convert term frequency of each word to Probability for training data =>
% learning the parameters
ntest = floor(size(TF,1) * TestFraction);
randInd = randperm(length(TF));
Test  = TF(randInd(1:ntest),:);
Train1 = TF(randInd(ntest+1:end),:);

Train1 = cell2mat(Train1);
Train1 = sortrows(Train1,1);

Train = zeros(length(unique(Train1(:,1))),2);
Train(:,1) = unique(Train1(:,1));

k = 1;
for i=1:size(Train1,1)
    if Train(k,1) ~= Train1(i,1)
        k=k+1;
    end
    Train(k,2) = Train(k,2) + Train1(i,2);
end
WordsSumTrain = sum(Train(:,2));
Train(:,2) = Train(:,2)./WordsSumTrain;

end
