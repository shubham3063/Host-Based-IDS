%%
Training_tf = zeros(size(TrainNormalSamples,1),nWords);
for i=1:size(TrainNormalSamples,1)
    for j=1:size(TrainNormalSamples{i},1)
        if TrainNormalSamples{i}(j,1)>340
            break;
        end
%         Training_tf(i,Training{i}(j)) = Training_tf(i,Training{i}(j)) + 1;        
        Training_tf(i,TrainNormalSamples{i}(j,1)) = 1;
    end    
end

% minSup = 0.3;
minConf = 0.1;
% nRules = 5000;
sortFlag = 1;
[Rules FreqItemsets Support Confidence] = ...
    findRules(Training_tf, minSup, minConf, nRules, sortFlag);%, labels, fname);

if length(Rules{1}(:)) < nRules
    nRules = length(Rules{1}(:));
end

%% Combine the rules into one table and remove duplicate rules
NewRules = cell(nRules,1);
maxsize = -1;
for i=1:nRules
%     for j=1:length(Rules{1}(i))
%         temp = Rules{1}(i);
%         NewRules{i}(j) = Rules{1}(i)
    NewRules{i} = cell2mat([Rules{1}(i) Rules{2}(i)]);
    maxsize = max(maxsize,length(NewRules{i}));
end

Rules1 = zeros(nRules,maxsize);
for i=1:nRules
    for j=1:length(NewRules{i})
        Rules1(i,j) = NewRules{i}(j);
    end
    Rules1(i,:) = sort(Rules1(i,:),'descend');
end
[Rules1 M ~] = unique(Rules1,'rows','first');
nRules = size(Rules1,1);


%% Add statistics of rules

UniqueRulesId = (nWords*(nWords+1)+1 : nWords*(nWords+1)+ nRules)';
TrainRules = [UniqueRulesId Support(M)./sum(Support(M))];
TrainNormal = [TrainNormal1 ; TrainRules];

%%

tatf = zeros(length(TestAttack),nWords);
for i=1:length(TestAttack)
    for j=1:size(TestAttack{i},1)
        if TestAttack{i}(j) > nWords
            break;
        end
        tatf(i,TestAttack{i}(j,1)) = TestAttack{i}(j,2);
    end
end
%% Test Attack Sequences

for i=1:length(TestAttack)
    AppendRule = zeros(nRules,1);
    for k=1:nRules
        flag=0;
        for r=1:maxsize
            if Rules1(k,r)==0
                break;
            end
            if tatf(i,Rules1(k,r))==0
                flag=1;
                break;
            end
        end
        if flag==0
            AppendRule(k)=associationWeight;
        end
    end
    TestAttack{i} = [TestAttack{i}; [UniqueRulesId AppendRule]];
end

%% Test Normal sequences
for i=1:length(TestNormal)
    AppendRule = zeros(nRules,1);
    for k=1:nRules
        flag=0;
        for r=1:maxsize
            if Rules1(k,r)==0
                break;
            end
            if Training_tf(i,Rules1(k,r))==0
                flag=1;
                break;
            end
        end
        if flag==0
            AppendRule(k)=associationWeight;
        end
    end
    TestNormal{i} = [TestNormal{i}; [UniqueRulesId AppendRule]];
end
% Naivebayes_Sequence_Classification