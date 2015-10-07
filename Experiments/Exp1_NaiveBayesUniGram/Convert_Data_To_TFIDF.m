clear
load ../ExtractedDataMatlab
nWords = 1079;
nTrainingFraction = 0.3; % fraction of test samples
Training_tf = ones(size(Training,1),nWords);
for i=1:size(Training,1)
    for j=1:length(Training{i})
        Training_tf(i,Training{i}(j)) = Training_tf(i,Training{i}(j)) + 1;        
    end    
end
ntest = floor(size(Training_tf,1) * nTrainingFraction);
randInd = randperm(size(Training_tf,1));
TestNormal  = Training_tf(randInd(1:ntest),:);
TrainNormal = Training_tf(randInd(ntest+1:end),:);

TrainNormal = sum(TrainNormal);
TrainNormal = TrainNormal ./ sqrt(dot(TrainNormal ,TrainNormal ));

%%
AttackSeq_tf = ones(size(AttackSeq,1),nWords);
for i=1:size(AttackSeq,1)
    for j=1:length(AttackSeq{i})
        AttackSeq_tf(i,AttackSeq{i}(j)) = AttackSeq_tf(i,AttackSeq{i}(j)) + 1;        
    end    
end
ntest = floor(size(AttackSeq_tf,1) * nTrainingFraction);
randInd = randperm(size(AttackSeq_tf,1));
TestAttack  = AttackSeq_tf(randInd(1:ntest),:);
TrainAttack = AttackSeq_tf(randInd(ntest+1:end),:);

TrainAttack = sum(TrainAttack);
TrainAttack = TrainAttack ./ sqrt(dot(TrainAttack,TrainAttack));

clearvars -except TrainNormal TestNormal TrainAttack TestAttack
Naivebayes_Sequence_Classification

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

    
