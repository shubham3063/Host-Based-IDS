% Run the Sliding window algorithm on various parameters and plot ROC
% curve i.e. Detection Rate Vs False Alarm Rate

% Fraction of test samples
TestFraction = 0.5;

% Parameter Start Window Size
K=5;

% Initialize Vars
incthresh = 2;
Plot_Data = [];
iterPlotData = 1;
load ../ExtractedDataMatlab
% Training = [Training];

while K<=5    
    
    % Training, Validation and Test Data
    Convert_Data_To_Sliding_Feature
    
    % Range of Threshold
    % ValidationNormal is a Normal set of sequences. These will be used to evaluate
    % the threshold for Normal deviation from the Normal Training Data
    [ValidationNormalMismatch,~] = Evaluate_Mismatch(ValidationNormal,TrainNormal,[],[]);
    stdNormal = std(ValidationNormalMismatch);
    meanNormal = mean(ValidationNormalMismatch);
    
    % Parameters -> Window Size(K), Threshold(Thresh)
    Thresh_Start = 0;%meanNormal - stdNormal/2;
    Thresh_End = 2*(meanNormal + stdNormal);%/2;
    
    if Thresh_Start < 0, Thresh_Start = 0; end
    thresh = Thresh_Start;
    incthresh = (Thresh_End - Thresh_Start)/10;
    Compute_Mismatches
    while thresh <= Thresh_End
        Compute_Accuracy
        thresh = thresh + incthresh;
    end
    K = K+1;
end

%% ROC
p = Plot_Data;
p = cell2mat(p');
p = sortrows(p,4);
plot(p(:,4),p(:,3))



