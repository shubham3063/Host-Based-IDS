% trans = [0.95,0.05;
%       0.10,0.90];
% emis = [1/6, 1/6, 1/6, 1/6, 1/6, 1/6;
%    1/10, 1/10, 1/10, 1/10, 1/10, 1/2];
% 
% seq1 = hmmgenerate(100,trans,emis);
% seq2 = hmmgenerate(200,trans,emis);
% seqs = {seq1,seq2};
% [estTR,estE] = hmmtrain(seqs,trans,emis);

%%
clear
load ../ExtractedDataMatlab
%%
N = 10; % number of values a hidden state can take
M = 340; % distinct number of system calls that 
          % observational state can take
trans = rand(N); % Transition probability of hidden layer X(t) | X(t-1)
emis = rand([N,M]); % Observation/Emmission Probability Y(t) | X(t)

% Changing the Training set to suit training 
Training = Training';
for i=1:length(Training)
    Training{i} = Training{i}';
end

%%
[estTR,estE] = hmmtrain(Training',trans,emis);
