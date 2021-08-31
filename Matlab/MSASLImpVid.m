% Load MS-ASL video files, run openpose to extract 2D joint data, and save
% the resulting json files.

function MSASLImpVid(aslDir,aslFile,resDir,resFile,resDir2,openposeDir,vidDir,maxClassId,netRes,handRes)
    
    h = waitbar(0, 'Process video');
    tic;

    % get number of lines in input file
    fileid = fopen([aslDir aslFile]); % input file
    res={};
    while ~feof(fileid)
      res{end+1,1} = fgetl(fileid);
    end
    fclose(fileid);
    numLines = numel(res) - 1;

    fileid = fopen([aslDir aslFile]); % input file
    fid = fopen([resDir resFile],'w'); % output log file
    
    vId = 1;
    seqId = 1;

    while 1 == 1 
        X = ['Process video: ',num2str(vId),'/',num2str(numLines),' seqId:',num2str(seqId)];
        X = strrep(X,'\','/');
        waitbar(vId/numLines, h, X);
    
        line = fgetl(fileid);
        if line == -1 % end of file
            break
        elseif size(line,2) == 1
            if line == ']' % end of file
                break
            end
        end
        
%         if seqId == 6
%             break
%         end
        
        if line(1) == '['
            line = line(2:end);
        end
        if line(end) == ','
            line = line(1:end-1);
        end
        
        value = jsondecode(line);
        
        if value.label < maxClassId % only process up to a max class Id
            vFile = value.url(strfind(value.url,'=')+1:end);
            vidFile = [vidDir vFile];
            fprintf(fid,'%d\t',vId);
            fprintf(fid,'%s\t',value.clean_text);
            fprintf(fid,'%d\t',value.label);
            fprintf(fid,'%d\t',value.signer_id);
            fprintf(fid,'%s\t',vFile);
            fprintf(fid,'%.3f\t',value.start_time);
            fprintf(fid,'%.3f\t',value.end_time);
            fprintf(fid,'%.3f\t',value.fps);
            fprintf(fid,'%d\t',value.start);
            fprintf(fid,'%d\t',value.end);
            fprintf(fid,'%d\t',value.width);
            fprintf(fid,'%d\t',value.height);
            fprintf(fid,'[%.17f, %.17f, %.17f, %.17f]\t',value.box(1),value.box(2),value.box(3),value.box(4));
            if isfile(vidFile) % only process seq that have a video file
                mkdir([resDir2 num2str(vId)]);
                c = ['cd ' openposeDir ' &&' ...
                     ' OpenPoseDemo.exe --video ' vidFile ...
                     ' --body 1 --hand 1 --number_people_max 1 --model_pose COCO' ...
                     ' --net_resolution ' netRes ' --hand_net_resolution ' handRes ...
                     ' --frame_first ' num2str(value.start) ' --frame_last ' num2str(value.end) ...
                     ' --render_pose 0 --display 0' ...
                     ' --write_json ' resDir2 num2str(vId) ];
                status = system(c);
                if status == 0
                    fprintf(fid,'%s\n',['Success!']);
                else
                    fprintf(fid,'%s\n',['WARNING: Openpose Failed']);
                end
            else
                fprintf(fid,'%s\n',['WARNING: Missing Download']);
            end
            seqId = seqId + 1;
        end   
        vId = vId + 1;
    end
    fclose(fid);
    fclose(fileid);
    close(h);
    timeElapsed = toc;
    
end