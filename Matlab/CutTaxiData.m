trajCutData = {[]};
cnt = 1;
for i = 1:size(trajData,1)
% for i = 1:500
    tmpTraj = cell2mat(trajData(i,1));
    currTraj = [];
    for j = 1:size(tmpTraj,1)
        currTraj = [currTraj; tmpTraj(j,:)];
        if size(currTraj,1) >= 10
            trajCutData(cnt,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
            cnt = cnt + 1;
            currTraj = [];
        end
    end
    if size(currTraj,1) >= 2 && size(currTraj,1) < 10
        trajCutData(cnt,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
        cnt = cnt + 1;
    end
    currTraj = [];
end