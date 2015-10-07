
nWords = 340;
% TestFraction = 0.5; % fraction of test samples
nTraining = size(Training,1);
% TrainingTF = cell(nTraining ,1);
%%
[NormalTF,TrainNormal,TrainNormalSamples,TestNormal]= ...
    Train_Bigram(Training,TestFraction,nWords);
% TrainNormal(:,2) = TrainNormal(:,2) ./ sqrt(dot(TrainNormal(:,2) ,TrainNormal(:,2)));
% SumTrainNormal = sum(TrainNormal(:,2));
% TrainNormal(:,2) = TrainNormal(:,2) ./ SumTrainNormal;

TrainNormal1 = TrainNormal; % Copy


%%
[AttackTF,TrainAttack,TrainAttackSamples,TestAttack]= Train_Bigram(AttackSeq,0.95,nWords);

AddAssociationRulesToTest
% Naivebayes_Sequence_Classification
%%
% Anomaly_NaiveBayes

%%
% Validation_tf = ones(size(Validation,1),nWords);
% for i=1:size(Validation,1)
%     for j=1:length(Validation{i})
%         Validation_tf(i,Validation{i}(j)) = Validation_tf(i,Validation{i}(j)) + 1;        
%     end    
% end
% ValidationVirtual = sum(Validation_tf);
% ValidationVirtual = ValidationVirtual ./ sqrt(dot(ValidationVirtual,ValidationVirtual));
% 

    
