function  [Rules FreqItemsets]  = demoAssociationAnalysis( )
% This file demonstrates how the FindRules method works for finding
% association analysis from a set of transactions
% 
% load a matrix of transactions, where each row represents one
% transaction.
% 
% For this demo we are going to use Zachary's karate network
% of friendships among 34 students of the club.
% In this example transactions are replaced with the adjacency matrix
% representing connections in the network, where
% row i represents the friendship profile of individual i,
% 1s indicating friendship and 0s no friendship.
% 
% In this context an association rule Student1, Student2 -> Student3 will
% mean that students that are friends with Student1 and Student2 are very
% likely to be friends with Student3 as well, therefore can be used to find
% missing links in the network.
% 
% Note: Although the karate network is undirected (if a is connected to be 
% then be is connected to a), the direction of the resulting rules are
% important (a -> b means students who are friends with a are also friends
% with b, but not the other way around)

load Karate
minSup = 0.1;
minConf = 0.7;
nRules = 100;
sortFlag = 1;
fname = 'KarateRules';
for s = 1:size(Karate,1)
    labels{s} = ['Student' num2str(s)];
end

[Rules FreqItemsets] = findRules(Karate, minSup, minConf, nRules, sortFlag, labels, fname);
disp(['See the file named ' fname '.txt for the association rules']);
end

