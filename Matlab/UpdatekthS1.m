
function UpdatekthS1(kNum)

    global Bk S1

    if size(S1,1) > kNum % only update kthBestUB once we have k initial results
        S1 = sortrows(S1,7,'ascend');
        Bk = S1(kNum,7);  % get kth best UB
        S1 = S1(1:kNum,:);  % only keep kNum UB's in the list
    end

end