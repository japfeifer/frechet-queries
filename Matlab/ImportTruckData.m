% import the truck data

filename = 'Trucks.txt';
delimiterIn = ';';
headerlinesIn = 0;
trucksData = importdata(filename,delimiterIn,headerlinesIn);

% massage data to new format
trajData = {[]};
currTraj = [];
trajCount = 1;
dataSize = size(trucksData.textdata,1);

for i = 1:dataSize
    currData = trucksData.data(i,1:2);
    if i==1   
        prevObjectID = str2num(cell2mat(trucksData.textdata(i,1)));
        prevTruckID = str2num(cell2mat(trucksData.textdata(i,2)));
        prevTruckDate = convertCharsToStrings(cell2mat(trucksData.textdata(i,3)));
        currTraj = currData;
    else
        currObjectID = str2num(cell2mat(trucksData.textdata(i,1)));
        currTruckID = str2num(cell2mat(trucksData.textdata(i,2)));
        currTruckDate = convertCharsToStrings(cell2mat(trucksData.textdata(i,3)));
        if (currObjectID ~= prevObjectID) || (currTruckID ~= prevTruckID) || ...
           (currTruckDate ~= prevTruckDate)
            trajData(trajCount,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
            trajCount = trajCount + 1;
            currTraj = [trucksData.data(i,1) trucksData.data(i,2)];
        else
            currTraj = [currTraj; currData];
        end
        prevObjectID = currObjectID;
        prevTruckID = currTruckID;    
        prevTruckDate = currTruckDate;
    end   
end
trajData(trajCount,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
