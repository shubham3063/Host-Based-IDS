% SumTrainNormal = length(TrainNormal)+ sum(TrainNormal);
% SumTrainAttack = length(TrainAttack)+ sum(TrainAttack);
Test = [TestNormal; TestAttack];
TestClass = zeros(size(TestNormal,1) + size(TestAttack,1),1);
TestClass(size(TestNormal,1)+1 :end) = 1;
PredictedClass = zeros(size(TestClass));
PriorNormal = 1;%size(TrainNormal,1)/(size(TrainNormal,1)+size(TrainAttack,1));
PriorAttack = 1;%size(TrainAttack,1)/(size(TrainNormal,1)+size(TrainAttack,1));
MinTrainNormal = min(TrainNormal(:,2));
MinTrainAttack = min(TrainAttack(:,2));
p1 = zeros(size(Test,1),1);
for i=1:size(Test,1)
    p1(i) = ComputeLikelihood(TrainNormal,Test{i},PriorNormal,MinTrainNormal);
%     p2 = ComputeLikelihood(TrainAttack,Test{i},PriorAttack,MinTrainAttack);
%     sprintf('%d %f\n',i,p1)
    if p1(i)>0.5
        PredictedClass(i) = 0;
    else
        PredictedClass(i) = 1;
    end
end
%%
C = confusionmat(TestClass,PredictedClass)
length(find(TestClass==PredictedClass))/length(TestClass)
