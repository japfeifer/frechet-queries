% import NBA basketball data

tic;
filename = 'NBAseq_all.csv';
NBAData = importdata(filename);

% massage data to new format
trajData = {[]};
currTraj = [];
trajCount = 1;
dataSize = size(NBAData.textdata,1);

for i = 2:dataSize 
    currData = NBAData.data(i-1,2:4);
    if i==2 % first row   
        prevObjectID = convertCharsToStrings(cell2mat(NBAData.textdata(i,2)));
        currTraj = currData;
    else
        currObjectID = convertCharsToStrings(cell2mat(NBAData.textdata(i,2)));
        if (currObjectID ~= prevObjectID)
            trajData(trajCount,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
            trajCount = trajCount + 1;
            currTraj = [NBAData.data(i-1,2) NBAData.data(i-1,3) NBAData.data(i-1,4)];
        else
            currTraj = [currTraj; currData];
        end
        prevObjectID = currObjectID;
    end   
end
trajData(trajCount,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));

timeElapsed = toc;
