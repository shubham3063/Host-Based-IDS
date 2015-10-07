missNormal = TestNormalMismatch;
missNormal(missNormal<thresh) = 0;
FalseAlarmRate = length(find(missNormal>0)) / length(missNormal);

% ConfMatTestNormal = confusionmat(zeros(size(TestNormalMismatch)),TestNormalMismatch);
%%
missAttack = TestAttackMismatch;
missAttack(missAttack<thresh) = 0;
DetectionRate = length(find(missAttack>0)) / length(missAttack);
% ConfMatTestAttack = confusionmat(ones(size(missAttack)),missAttack)

%%
Plot_Data{iterPlotData} = [K, thresh, DetectionRate, FalseAlarmRate];
iterPlotData = iterPlotData + 1;
save('Plot_Data.mat','Plot_Data');