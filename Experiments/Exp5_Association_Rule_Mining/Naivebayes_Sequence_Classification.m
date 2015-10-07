function [PredictedProbability] = Naivebayes_Sequence_Classification(TrainNormal,Test)
% SumTrainAttack = length(TrainAttack)+ sum(TrainAttack);
% Test = TestNormal;%TestAttack;%[TestNormal; TestAttack];
% TestClass = zeros(size(TestNormal,1) + size(TestAttack,1),1);
% TestClass(size(TestNormal,1)+1 :end) = 1;

PriorNormal = 1;%size(TrainNormal,1)/(size(TrainNormal,1)+size(TrainAttack,1));
% PriorAttack = 1;%size(TrainAttack,1)/(size(TrainNormal,1)+size(TrainAttack,1));
MinTrainNormal = min(TrainNormal(:,2));
% MinTrainAttack = min(TrainAttack(:,2));
PredictedProbability = zeros(size(Test,1),1);
% PredictedClass = zeros(size(Test,1));
for i=1:size(Test,1)
    PredictedProbability(i) = ComputeLikelihood(TrainNormal,Test{i},PriorNormal,MinTrainNormal);
end

% display('Attack')
% mean(PredProbabilityAttack) 
% std(PredProbabilityAttack)
% 
% display('Normal')
% mean(PredProbabilityNormal)
% std(PredProbabilityNormal)



%%
% C = confusionmat(TestClass,PredictedClass)
% length(find(TestClass==PredictedClass))/length(TestClass)
