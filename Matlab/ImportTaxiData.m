% import the Beijing taxi data

tic;
trajData = {[]};
trajCount = 1;
    
% get a list of all the files
fileList = dir('TaxiData/**/*.txt');

% create a traj for each file
for k = 1:size(fileList,1) 
    
    % create the file name
    fileName = fileList(k).name;
    dirName = fileList(k).folder;
    dirFileName = strcat(dirName,'/',fileName);
    
    % import the data
    taxiData = importdata(dirFileName);

    % massage data to new format
    if isempty(taxiData) == false  % some files are empty so don't process those ones
        currTraj = taxiData.data(:,:);
        trajData(trajCount,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
        trajCount = trajCount + 1;
    end

end
timeElapsed = toc;
