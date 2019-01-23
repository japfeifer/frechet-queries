% import the Shipping Vessel data

trajData = {[]};
shipType = 'Mississippi';  % can be 'Mississippi' or 'Yangtze'
trajCount = 1;
    
% get a list of all the files
fileList = dir('ShippingVesselData/**/*.txt');

% create a traj for each file
for k = 1:size(fileList,1) 
    
    % only process for a certain shipping vessel type
    if isempty(strfind(fileList(k).folder,shipType)) == false
    
        % create the file name
        fileName = fileList(k).name;
        dirName = fileList(k).folder;
        dirFileName = strcat(dirName,'/',fileName);

        % import the data
        ShipData = importdata(dirFileName);

        % massage data to new format

        if convertCharsToStrings(shipType) == "Mississippi"
            currTraj = ShipData(:,2:3);
        else
            currTraj = ShipData(:,1:2);
        end

        trajData(trajCount,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
        trajCount = trajCount + 1;
    end
end

