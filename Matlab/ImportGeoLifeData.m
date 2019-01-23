% import the GeoLife data (people tracking)

tic;
h = waitbar(0, 'Running GeoLife Data Import');
trajData = {[]};
    
% get a list of all the files
fileList = dir('GeoLifeData/**/*.plt');
numFiles = size(fileList,1) ;

% create a traj for each file
for k = 1:numFiles
    
    % create the file name
    fileName = fileList(k).name;
    dirName = fileList(k).folder;
    dirFileName = strcat(dirName,'/',fileName);
    
    % import the data
    geoLifeData = importdata(dirFileName);

    % massage data to new format

    currTraj = [];
    dataSize = size(geoLifeData.textdata,1);

    for i=7:2:dataSize  
        currData = [str2num(cell2mat(geoLifeData.textdata(i,1))) ...
                    str2num(cell2mat(geoLifeData.textdata(i,2)))];
        currTraj = [currTraj; currData];
    end

    trajData(k,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));

    waitbar(k/numFiles, h);
end

close(h);
toc;

