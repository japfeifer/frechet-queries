function [fcTmp2,bestTotDist] = GetBestSeqCluster(fc,seq)

    numSubSeq = size(fc,1);
    tmpIdx = 1:numSubSeq;  tmpIdx = tmpIdx';
    tmpZero = zeros(numSubSeq,1);
    fcTmp = [tmpIdx fc tmpZero];
    bestTotDist = Inf;
    bestCenter = 0;
    for i = 1:numSubSeq
        totDist = 0;
        P = seq(fcTmp(i,2):fcTmp(i,3) , :); % cluster center curve
        for j = 1:numSubSeq
            if i ~= j % do not compare sub seq to itself
                Q = seq(fcTmp(j,2):fcTmp(j,3) , :); % non-center curve
                curDist = DiscreteFrechetDist(P,Q);
%                 curDist = dtw(P',Q'); % dtw distance
                totDist = totDist + curDist;
                if totDist > bestTotDist % this center totDist is too large
                    break
                end
                fcTmp(j,4) = curDist;
            else
                fcTmp(j,4) = 0;
            end
        end
        if totDist < bestTotDist % best cluster center so far
            fcTmp2 = fcTmp;
            bestCenter = i;
            bestTotDist = totDist;
        end
    end
    fcTmp2 = sortrows(fcTmp2,[2]); % sort by start frames
    
end