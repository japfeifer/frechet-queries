for i=1:size(CompMoveData,1)
    traj = cell2mat(CompMoveData(i,4));
    cnt = 0;
    for j=1:size(traj,2)
        for k=1:size(traj,1)
            if traj(k,j) == 0
                cnt = cnt + 1;
            end
        end
    end
    if cnt > 30
        disp(['row: ',num2str(i), ' cnt: ',num2str(cnt)]);
    end
end