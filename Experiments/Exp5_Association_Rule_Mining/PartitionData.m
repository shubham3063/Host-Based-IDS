function [Train,Test] =  PartitionData(Data,TestFraction)
TF = Data;
ntest = floor(size(TF,1) * TestFraction);
randInd = randperm(length(TF));
Test  = TF(randInd(1:ntest),:);
Train = [];
if ntest<size(TF,1)
    Train = TF(randInd(ntest+1:end),:);
end