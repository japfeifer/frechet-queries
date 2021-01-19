% import the Beijing taxi data
% This is different than the ImportTaxiData.mat file as this one attempts to
% split up the trajectories into smaller ones if the location of the taxi
% cab is unchanged for more than 30 minutes.  This should provide slightly
% better trajectories for doing queries.

% After this script is run, then run simplification:
% TrajSimpAll; 
% trajOrigData = trajData;
% trajData = trajSimpData;
%
% Then run: CutTaxiData

tic;

h = waitbar(0, 'Import Taxi Data');

trajData = {[]};
trajCount = 0;
    
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
        t1 = datetime(taxiData.textdata(:,2),'Format','yyyy-MM-dd HH:mm:ss'); % eg. 2008-02-23 15:36:08
        v1 = taxiData.data(:,:);
        
        prevX = 0;
        prevY = 0;
        cTraj = [];
        doneTraj = false;
        numSec = 0;

        % loop thru each vertex and occasionally stamp out a traj
        for i = 1:size(v1,1)
            currX = v1(i,1);
            currY = v1(i,2);
            cTime = t1(i,1);
            if currX ~= prevX || currY ~= prevY % X or Y position is different
                if doneTraj == true % stamp out traj and start new one
                    % only save traj with 5 or more vertices
                    if size(cTraj,1) >= 5
                        trajCount = trajCount + 1;
                        trajData(trajCount,1) = mat2cell(cTraj,size(cTraj,1),size(cTraj,2));
                    end
                    cTraj = [prevX prevY]; % seed new traj with prev X,Y pos
                end
                prevTime = cTime;
                cTraj = [cTraj; currX currY];
                doneTraj = false;
            elseif doneTraj == false
                % X & Y pos are the same, see if time is far enough apart
                numSec = etime(datevec(cTime),datevec(prevTime));
                if numSec >= 1800 % 30 minutes
                    doneTraj = true;
                end
            end
            prevX = currX;
            prevY = currY;
        end
        % stamp out last traj
        trajCount = trajCount + 1;
        trajData(trajCount,1) = mat2cell(cTraj,size(cTraj,1),size(cTraj,2));
    end
    
    X = ['Import Taxi Data: ',num2str(k),'/',num2str(size(fileList,1))];
    waitbar(k/size(fileList,1), h, X);

end

close(h);
timeElapsed = toc;
