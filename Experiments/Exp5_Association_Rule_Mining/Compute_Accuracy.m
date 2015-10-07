probNormal = PredictedProbTestNormal;
probNormal(probNormal > thresh) = 0;
FalseAlarmRate = length(find(probNormal))/length(probNormal);

probAttack = PredictedProbTestAttack;
probAttack(probAttack > thresh) = 0;
DetectionRate = length(find(probAttack)) / length(probAttack);


Plot_Data{iterPlotData} = [Parameters(K,1),Parameters(K,2),Parameters(K,3)...
    , thresh, DetectionRate, FalseAlarmRate];
iterPlotData = iterPlotData + 1;
save('Plot_Data.mat','Plot_Data');