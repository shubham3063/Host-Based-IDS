
% Evaluate Mismatches for Normal Test Data -> False Alarm Rate
[TestNormalMismatch, ~] = ...
    Evaluate_Mismatch(TestNormal,TrainNormal,thresh,0);

%%
% Evaluate Mismatches for Attack Test Data -> Detection Rate
[TestAttackMismatch, ~] = ...
    Evaluate_Mismatch(TestAttack,TrainNormal,thresh, 1);

