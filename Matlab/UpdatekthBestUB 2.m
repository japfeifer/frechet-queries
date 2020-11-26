% this function should be replaced with a max-heap at some point as the
% sort is much less efficient than a heap in this case

function UpdatekthBestUB(kNum)

    global Bk S1 kUBList

    if size(S1,1) > kNum % only update kthBestUB once we have k initial results
        
        kUBList = sort(kUBList);    % sort asc
        Bk = kUBList(kNum);  % get kth best UB
        kUBList = kUBList(1:kNum);  % only keep kNum UB's in the list
        
    end

end