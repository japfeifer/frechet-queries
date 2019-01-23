% import pet cats Australia data

tic;
filename = 'PetCatsAustralia.csv';
delimiterIn = ',';
headerlinesIn = 1;
PCData = importdata(filename);

% massage data to new format
trajData = {[]};
currTraj = [];
trajCount = 1;
dataSize = size(PCData,1);

for i = 2:dataSize     
    currRec = split(PCData(i),",");
    currID = convertCharsToStrings(str2num(cell2mat(currRec(11))));
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
