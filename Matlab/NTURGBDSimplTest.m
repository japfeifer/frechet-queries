% Test how effective simplification is 

h = waitbar(0, 'NTU Fix joints at origin');
% szComp = size(CompMoveData,1);
szComp = 200;
simpRes = [];
simpRes(szComp,2) = 0;
for i = 1:szComp
    currSeq = cell2mat(CompMoveData(i,4));
    simpRes(i,1) = size(currSeq,1);
    reach = TrajReach(currSeq); % get traj reach 
    currSeq2 = TrajSimp(currSeq,reach * 0.05); % simplify sequence to speed up experiment processing
    simpRes(i,2) = size(currSeq2,1);

    if mod(i,10) == 0
        X = ['NTU Fix joints at origin: ',num2str(i),'/',num2str(szComp)];
        waitbar(i/szComp, h, X);
    end
end
close(h);

reduct = sum(simpRes(:,2)) / sum(simpRes(:,1));
origAvgFrame = mean(simpRes(:,1));
simplAvgFrame = mean(simpRes(:,2));
disp(['origAvgFrame: ',num2str(origAvgFrame),' simplAvgFrame: ',num2str(simplAvgFrame),' reduct: ',num2str(reduct)]);