
clear
load ../ExtractedDataMatlab

nWords = 1079;
TestFraction = 0.3; % fraction of test samples
nTraining = size(Training,1);
% TrainingTF = cell(nTraining ,1);
%%
[NormalTF,TrainNormal,TestNormal]= Featurize_Bigram(Training,TestFraction,nWords);

%%
[AttackTF,TrainAttack,TestAttack]= Featurize_Bigram(AttackSeq,TestFraction,nWords);
Naivebayes_Sequence_Classification
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

    
