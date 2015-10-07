function [TestMismatch, ConfusionMat] = Evaluate_Mismatch(TestData,TrainNormal,Thresh, IsAttack)
N = size(TestData,1);
TestMismatch = zeros(N,1);
for i=1:N
    cnt=0;
    testseq = TestData{i};
    testseq = unique(testseq,'rows');
    testseq = sortrows(testseq,1);
    next = 1;
    while next<=size(testseq,1)
        syscall = testseq(next,1);
%         dbind = find(TrainNormal(:,1)==syscall);
        testind = find(testseq(:,1)==syscall);
        for j=1:length(testind)
            mismatch=1;
            for k=1:size(TrainNormal{syscall},1)
                if all(TrainNormal{syscall}(k,:)==testseq(testind(j),:))==1
                    mismatch=0;
                    break;
                end
            end
            if mismatch==1
                cnt = cnt + 1;
            end
        end
        next = testind(end)+1;
    end
    TestMismatch(i) = cnt;
end
ConfusionMat = [];
% if ~isempty(Thresh)
%     PredictedAttack = TestMismatch(:)>Thresh;
%     ActualClass = IsAttack .* ones(size(TestMismatch),1);
%     ConfusionMat = confusionmat(PredictedAttack,ActualClass);
% end
