function dMedian = MedianDTW(P,Q)

    [d,ix,iy] = dtw(P',Q','euclidean');
    szix = size(ix,1);
    dList(1:szix) = 0;
    for i = 1:szix
        dList(i) = CalcPointDist(P(ix(i),:),Q(iy(i),:));
    end

    dMedian = median(dList);
end