% export train and test datasets to MMSkeleton format 
% for format see https://github.com/open-mmlab/mmskeleton/blob/master/doc/CUSTOM_DATASET.md

for i=1:size(trainSet,1)

    currSeqID = cell2mat(trainSet(i,1));
    currLabelID = cell2mat(trainSet(i,2));
    currSeq = cell2mat(trainSet(i,3));
    numFrame = size(currSeq,1);
    numJoints = size(currSeq,2) / 3;

    fileName = strcat('Export\Train\train',num2str(currSeqID),'.json');
    
    %write header to file
    fid = fopen(fileName,'w');
    currText = '{';
    fprintf(fid,'%s\n',currText);
    currText = '    "info":';
    fprintf(fid,'%s\n',currText);
    currText = '        {';
    fprintf(fid,'%s\n',currText);
    currText = ['            "video_name": "train',num2str(currSeqID),'.mp4",'];
    fprintf(fid,'%s\n',currText);
    currText = '            "resolution": [340, 256],';
    fprintf(fid,'%s\n',currText);
    currText = ['            "num_frame": ',num2str(numFrame),','];
    fprintf(fid,'%s\n',currText);
    currText = ['            "num_keypoints": ',num2str(numJoints),','];
    fprintf(fid,'%s\n',currText);    
    currText = '            "keypoint_channels": ["x", "y", "z", "score"],';
    fprintf(fid,'%s\n',currText);
    currText = '            "version": "1.0"';
    fprintf(fid,'%s\n',currText);
    currText = '        },';
    fprintf(fid,'%s\n',currText);
    currText = '    "annotations":';
    fprintf(fid,'%s\n',currText);
    currText = '        [';
    fprintf(fid,'%s\n',currText);
    
    for j = 1:numFrame
        currText = '            {';
        fprintf(fid,'%s\n',currText);
        currText = ['                "frame_index": ',num2str(j-1),','];
        fprintf(fid,'%s\n',currText);
        currText = ['                "id": ',num2str(j-1),','];
        fprintf(fid,'%s\n',currText);
        currText = '                "person_id": null,';
        fprintf(fid,'%s\n',currText);
        
        currText = '                "keypoints": [';
        for k = 1:numJoints
            idx1 = k*3-2; idx2 = k*3-1; idx3 = k*3;
            currText = [currText,'[',num2str(currSeq(j,idx1)),', ',num2str(currSeq(j,idx2)),', ',num2str(currSeq(j,idx3)),', 1], '];
        end
        currText = [currText,']'];
        fprintf(fid,'%s\n',currText);
        
        currText = '            },';
        fprintf(fid,'%s\n',currText);
    end
    
    currText = '        ],';
    fprintf(fid,'%s\n',currText);
    currText = ['    "category_id": ',num2str(currLabelID - 1),','];
    fprintf(fid,'%s\n',currText);
    currText = '}';
    fprintf(fid,'%s\n',currText);
    
    fclose(fid);
end

for i=1:size(querySet,1)

    currSeqID = cell2mat(querySet(i,1));
    currLabelID = cell2mat(querySet(i,2));
    currSeq = cell2mat(querySet(i,3));
    numFrame = size(currSeq,1);
    numJoints = size(currSeq,2) / 3;

    fileName = strcat('Export\Test\test',num2str(currSeqID),'.json');
    
    %write header to file
    fid = fopen(fileName,'w');
    currText = '{';
    fprintf(fid,'%s\n',currText);
    currText = '    "info":';
    fprintf(fid,'%s\n',currText);
    currText = '        {';
    fprintf(fid,'%s\n',currText);
    currText = ['            "video_name": "test',num2str(currSeqID),'.mp4",'];
    fprintf(fid,'%s\n',currText);
    currText = '            "resolution": [340, 256],';
    fprintf(fid,'%s\n',currText);
    currText = ['            "num_frame": ',num2str(numFrame),','];
    fprintf(fid,'%s\n',currText);
    currText = ['            "num_keypoints": ',num2str(numJoints),','];
    fprintf(fid,'%s\n',currText); 
    currText = '            "keypoint_channels": ["x", "y", "z", "score"],';
    fprintf(fid,'%s\n',currText);
    currText = '            "version": "1.0"';
    fprintf(fid,'%s\n',currText);
    currText = '        },';
    fprintf(fid,'%s\n',currText);
    currText = '    "annotations":';
    fprintf(fid,'%s\n',currText);
    currText = '        [';
    fprintf(fid,'%s\n',currText);
    
    for j = 1:numFrame
        currText = '            {';
        fprintf(fid,'%s\n',currText);
        currText = ['                "frame_index": ',num2str(j-1),','];
        fprintf(fid,'%s\n',currText);
        currText = ['                "id": ',num2str(j-1),','];
        fprintf(fid,'%s\n',currText);
        currText = '                "person_id": null,';
        fprintf(fid,'%s\n',currText);
        
        currText = '                "keypoints": [';
        for k = 1:numJoints
            idx1 = k*3-2; idx2 = k*3-1; idx3 = k*3;
            currText = [currText,'[',num2str(currSeq(j,idx1)),', ',num2str(currSeq(j,idx2)),', ',num2str(currSeq(j,idx3)),', 1], '];
        end
        currText = [currText,']'];
        fprintf(fid,'%s\n',currText);
        
        currText = '            },';
        fprintf(fid,'%s\n',currText);
    end
    
    currText = '        ],';
    fprintf(fid,'%s\n',currText);
    currText = ['    "category_id": ',num2str(currLabelID - 1),','];
    fprintf(fid,'%s\n',currText);
    currText = '}';
    fprintf(fid,'%s\n',currText);
    
    fclose(fid);
end

% {
%     "info":
%         {
%             "video_name": "skateboarding.mp4",
%             "resolution": [340, 256],
%             "num_frame": 300,
%             "num_keypoints": 17,
%             "keypoint_channels": ["x", "y", "score"],
%             "version": "1.0"
%         },
%     "annotations":
%         [
%             {
%                 "frame_index": 0,
%                 "id": 0,
%                 "person_id": null,
%                 "keypoints": [[x, y, score], [x, y, score], ...]
%             },
%             ...
%         ],
%     "category_id": 0,
% }