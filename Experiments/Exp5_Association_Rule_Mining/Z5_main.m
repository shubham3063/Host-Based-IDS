% Parameters - Probabilities of all the unigrams and bigrams that depend on
% the data and # of association rules, minimum support and confidence
% and Association weight given to each test sample.
% clear
TestFractionRange = 0.3;
RuleRange = 7000;
SupportRange = 0.5;
associationWeight = 100;
l=1;
clear Parameters;
for i=1:length(TestFractionRange)
    for j=1:length(RuleRange)
        for k=1:length(SupportRange)
            Parameters(l,:) = [TestFractionRange(i) RuleRange(j) SupportRange(k)];
            l = l + 1;
        end
    end
end

% Initialize Vars
incthresh = 1;
Plot_Data = [];
iterPlotData = 1;
load ../ExtractedDataMatlab
% Training = [Training;Validation];
nWords = 340;
load Training_Attack_Seq
% Training  = Featurize_Bigram(Training,nWords);
% AttackSeq = Featurize_Bigram(AttackSeq,nWords);
%%
K=1;
while K<=size(Parameters,1)
    
    TestFraction = Parameters(K,1);
    nRules = Parameters(K,2);
    minSup = Parameters(K,3);
%   Convert data to features- unigrams, bigrams and Association Rules
    Convert_Data_To_TF
    
%   Separate TestNormal into Validation and Test 
    [TestNormal,ValidationNormal] = PartitionData(TestNormal,TestFraction);
    
%   Evaluate the mean and standard deviation using Validation Set
    PredictedProbValidNormal = Naivebayes_Sequence_Classification(TrainNormal,ValidationNormal);

%   Range of Threshold
%   ValidationNormal is a Normal set of sequences. These will be used to evaluate
%   the threshold for Normal deviation from the Normal Training Data

    stdNormal = std(PredictedProbValidNormal);
    meanNormal = mean(PredictedProbValidNormal);
    
%   Parameters -> Threshold(Thresh)
    Thresh_Start = 0;%meanNormal - stdNormal/2;
    Thresh_End = 2*(meanNormal + stdNormal);
    
    if Thresh_Start < 0, Thresh_Start = 0; end
    thresh = Thresh_Start;
    incthresh = (Thresh_End - Thresh_Start)/60;    
    
    PredictedProbTestNormal = Naivebayes_Sequence_Classification(TrainNormal,TestNormal);
    PredictedProbTestAttack = Naivebayes_Sequence_Classification(TrainNormal,TestAttack);
    while thresh <= Thresh_End
        Compute_Accuracy
        thresh = thresh + incthresh;
    end
    K = K+1;
end

%% ROC
% figure,
p = Plot_Data;
p = cell2mat(p');
p = sortrows(p,6);
plot(p(:,6),p(:,5),'g')