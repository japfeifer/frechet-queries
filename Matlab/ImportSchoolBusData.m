% import the school bus data

filename = 'Buses.txt';
delimiterIn = ';';
headerlinesIn = 0;
busesData = importdata(filename,delimiterIn,headerlinesIn);

% massage data to new format
trajData = {[]};
currTraj = [];
trajCount = 1;
dataSize = size(busesData.textdata,1);

for i = 1:dataSize
    currData = busesData.data(i,1:2);
    if i==1   
        prevObjectID = str2num(cell2mat(busesData.textdata(i,1)));
        prevBusID = str2num(cell2mat(busesData.textdata(i,2)));
        prevBusDate = convertCharsToStrings(cell2mat(busesData.textdata(i,3)));
        currTraj = currData;
    else
        currObjectID = str2num(cell2mat(busesData.textdata(i,1)));
        currBusID = str2num(cell2mat(busesData.textdata(i,2)));
        currBusDate = convertCharsToStrings(cell2mat(busesData.textdata(i,3)));
        if (currObjectID ~= prevObjectID) || (currBusID ~= prevBusID) || ...
           (currBusDate ~= prevBusDate)
            trajData(trajCount,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
            trajCount = trajCount + 1;
            currTraj = [busesData.data(i,1) busesData.data(i,2)];
        else
            currTraj = [currTraj; currData];
        end
        prevObjectID = currObjectID;
        prevBusID = currBusID;    
        prevBusDate = currBusDate;
    end   
end
trajData(trajCount,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
