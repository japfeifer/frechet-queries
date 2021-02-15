% Verify the BallSimp results in the Simp Tree
% For each level, for each segment, the (simplified) segment should be either:
% 1) length <= error for that level, or
% 2) length > error for that level and underlying non-simp vertices a single edge

cnt = 0;
for i = 1:size(inpTrajSz,2) % for each level
    for j = 1: inpTrajSz(i) - 1 % for each segment in this level
        idx1 = inpTrajVert(j,i);
        idx2 = inpTrajVert(j+1,i);
        dist = CalcPointDist(inP(idx1,:),inP(idx2,:));
        err = inpTrajErr(i);
        cnt = cnt + 1;
        if dist > err
            if idx2 > idx1 + 1
                disp(['level: ',num2str(i),'   idx1: ',num2str(idx1),'   idx2: ',num2str(idx2)]);
                disp(['dist: ',num2str(dist,10),'   err: ',num2str(err,10)]);
                error('simplified segment length > error, and underlying non-simp vertices has > 1 segment');
            end
        end
    end
end