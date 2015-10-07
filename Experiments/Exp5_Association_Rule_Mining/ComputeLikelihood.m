function likelihood = ComputeLikelihood(Train,Test,Prior,MinTrain)

dHitTrain = find(ismember(Train(:,1),Test(:,1)));
dHit = find(ismember(Test(:,1),Train(:,1)));
dMiss = find(~ismember(Test(:,1),Train(:,1)));
Train1 = zeros(length(dHit)+length(dMiss),1);
Train1(dHit) = Train(dHitTrain,2);
Train1(dMiss) = MinTrain;
likelihood = Prior * sum(Test(:,2) .* log(1+Train1(:)));
end