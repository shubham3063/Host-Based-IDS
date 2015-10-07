
[~,TrainNormal,ValidationNormal]= ...
    Featurize_Size_K_Window(Training,K,TestFraction,0);

[~,ValidationNormal,TestNormal] = Featurize_Size_K_Window(ValidationNormal,K,TestFraction,1);

% Using entire data of Attack as test data
[AttackDB,TrainAttack,TestAttack]= Featurize_Size_K_Window(AttackSeq,K,1,0);
