SumTrainNormal = length(TrainNormal)+ sum(TrainNormal);
SumTrainAttack = length(TrainAttack)+ sum(TrainAttack);
Test = [TestNormal; TestAttack];
TestClass = zeros(size(TestNormal,1) + size(TestAttack,1),1);
TestClass(size(TestNormal,1)+1 :end) = 1;
PredictedClass = zeros(size(TestClass));
PriorNormal = size(TrainNormal,1)/(size(TrainNormal,1)+size(TrainAttack,1));
PriorAttack = size(TrainAttack,1)/(size(TrainNormal,1)+size(TrainAttack,1));
for i=1:size(Test,1)
    ind = find(Test(i,:)>1);
    p1 = PriorNormal * sum(TrainNormal(ind).*log(1+(TrainNormal(ind)./SumTrainNormal)));
    p2 = PriorAttack * sum(TrainAttack(ind).*log(1+(TrainAttack(ind)./SumTrainAttack)));
    if(p1>p2)
        PredictedClass(i)=0;
    else
        PredictedClass(i)=1;
    end
end
C = confusionmat(TestClass,PredictedClass)
length(find(TestClass==PredictedClass))/length(TestClass)
