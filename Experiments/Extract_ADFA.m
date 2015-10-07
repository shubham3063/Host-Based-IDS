
cd Training_Data_Master\

files = dir;
files(1:2) = [];
Training = cell(size(files,1),1);

for i = 1:length(files)
    fid = fopen(files(i).name);
    Training{i} = fscanf(fid,'%d');
    fclose(fid);
end
cd ..
%%
cd Validation_Data_Master
files = dir;
files(1:3) = [];
Validation = cell(size(files,1),1);
for i = 1:length(files)
    fid = fopen(files(i).name);
    Validation{i} = fscanf(fid,'%d');
    fclose(fid);
end
cd ..
%%
cd Attack_Data_Master
AttackSeq = cell(686,1);
AttackClass = zeros(686,1);
attackDir = dir;
attackDir(1:2) = [];
prevName = cell(10,1);
cnt = 0;
i=1;
for d = 1: length(attackDir)
    currName = regexp(attackDir(d).name,'_','split');
    if ~strcmp(currName(1),prevName(1))
        cnt = cnt+1;
        prevName = regexp(attackDir(d).name,'_','split');
    end
    cd(attackDir(d).name);
    files = dir;
    files(1:2)=[];
    for f = 1:length(files)
        fid = fopen(files(f).name);
        AttackSeq{i} = fscanf(fid,'%d');
        AttackClass(i) = cnt;
        i=i+1;
        fclose(fid);
    end
    cd ..
end

cd ..


%%
clearvars -except AttackClass AttackSeq Training Validation



