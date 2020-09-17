% This script parses a sign language XML file from KinTrans into a Matlab
% data structure.
%
% Order of trajectories: 
% 1) shoulder center
% 2) hip
% 3) right shoulder
% 4) right elbow
% 5) right wrist
% 6) right hand
% 7) left shoulder
% 8) left elbow
% 9) left wrist
% 10) left hand

% load the KinTrans XML file into a Matlab struct datatype

fileName = 'KinTransXML/Health.xml';
% fileName = 'KinTransXML/Airport.xml';
% fileName = 'KinTransXML/Bank.xml';
% fileName = 'KinTransXML/Low Number Of Samples.xml';

kinTransStruct = ParseXML(fileName);

% now convert the results from the previous step into a more useable Matlab
% data structure

numSequence = 0;
CompMoveData = {[]};
processClassNames = false;
kinTransWordList = [];

for i = 1:size(kinTransStruct.Children,2) % for each sequence (signed word)
    if strcmp(kinTransStruct.Children(i).Name, 'Sequence') == true % only process the 'Sequence' rows
        if processClassNames == false
            for j = 1:size(kinTransStruct.Children(i).Children(2).Children,2)
                if strcmp(kinTransStruct.Children(i).Children(2).Children(j).Name, 'string') == true
                    kinTransWordList = [kinTransWordList; convertCharsToStrings(kinTransStruct.Children(i).Children(2).Children(j).Children.Data)];
                end
            end
            processClassNames = true;
        end
        numSequence = numSequence + 1;
        sequenceOutput = str2num(kinTransStruct.Children(i).Children(6).Children.Data); % id for the word that is signed
        pathString = kinTransStruct.Children(i).Children(8).Children.Data; % the name KinTrans gave to this version of the signed word
        pathString = pathString(strfind(pathString,'/')+1:end); % only take the text after the '/' character
        tag = pathString(1:strfind(pathString,'.')-1);
        currMovement = [];
        for j = 1:size(kinTransStruct.Children(i).Children(4).Children,2) % for each frame
            if strcmp(kinTransStruct.Children(i).Children(4).Children(j).Name, 'Point3d') == true % only process the 'Point3d' rows
                x1=0; x2=0; scx=0; y1=0; y2=0; scy=0; z1=0; z2=0; scz=0; wx1=0; wy1=0; wz1=0; wx2=0; wy2=0; wz2=0;
                sx1=0; sy1=0; sz1=0; sx2=0; sy2=0; sz2=0; ex1=0; ey1=0; ez1=0; ex2=0; ey2=0; ez2=0; hx=0; hy=0; hz=0;
                
                for k = 1:size(kinTransStruct.Children(i).Children(4).Children(j).Children,2) % for each point coordinate
                    
                    switch kinTransStruct.Children(i).Children(4).Children(j).Children(k).Name
                        case 'X1'
                            x1 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'X2'
                            x2 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'SCX'
                            scx = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'Y1'
                            y1 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'Y2'
                            y2 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'SCY'
                            scy = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'Z1'
                            z1 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'Z2'
                            z2 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'SCZ'
                            scz = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'WX1'
                            wx1 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'WY1'
                            wy1 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'WZ1'
                            wz1 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'WX2'
                            wx2 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'WY2'
                            wy2 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'WZ2'
                            wz2 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'SX1'
                            sx1 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'SY1'
                            sy1 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'SZ1'
                            sz1 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'SX2'
                            sx2 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'SY2'
                            sy2 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'SZ2'
                            sz2 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children.Data);
                        case 'JointsForDefaultPositionDetection'
                            ex1 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children(2).Children.Data);
                            ey1 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children(4).Children.Data);
                            ez1 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children(6).Children.Data);
                            ex2 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children(8).Children.Data);
                            ey2 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children(10).Children.Data);
                            ez2 = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children(12).Children.Data);
                            hx = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children(14).Children.Data);
                            hy = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children(16).Children.Data);
                            hz = str2num(kinTransStruct.Children(i).Children(4).Children(j).Children(k).Children(18).Children.Data);
                    end
                end
                currMovement = [currMovement; scx scy scz hx hy hz sx1 sy1 sz1 ex1 ey1 ez1 wx1 wy1 wz1 x1 y1 z1 sx2 sy2 sz2 ex2 ey2 ez2 wx2 wy2 wz2 x2 y2 z2];
            end
        end

        CompMoveData(numSequence,1) = {char(kinTransWordList(sequenceOutput+1,1))};
        CompMoveData(numSequence,2) = {'unk'};
        CompMoveData(numSequence,3) = num2cell(numSequence);
        CompMoveData(numSequence,4) = mat2cell(currMovement,size(currMovement,1),size(currMovement,2));
        CompMoveData(numSequence,5) = num2cell(0);
        CompMoveData(numSequence,6) = {pathString};
        CompMoveData(numSequence,7) = {tag};
    end
end
