% import trawling bat data

tic;
filename = 'trawlingbat2015.csv';
delimiterIn = ',';
headerlinesIn = 1;
TBData = importdata(filename);

% massage data to new format
trajData = {[]};
currTraj = [];
trajCount = 1;
dataSize = size(TBData,1);

for i = 2:dataSize     
    currRec = split(TBData(i),",");
    currID = str2num(cell2mat(strrep(currRec(9),'"','')));
    currX = str2num(cell2mat(currRec(4)));
    currY = str2num(cell2mat(currRec(5)));
    
    if i==2 % first row   
        prevObjectID = currID;
        currTraj = [currX currY];
    else
        if (currID ~= prevObjectID)
            trajData(trajCount,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
            trajCount = trajCount + 1;
            currTraj = [currX currY];
        else
            currTraj = [currTraj; currX currY];
        end
        prevObjectID = currID;
    end   
end
trajData(trajCount,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));

timeElapsed = toc;
