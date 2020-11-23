% returns an array of distances from each seq frame to some "origin frame"

function x = GetSeqDist2(seq)
%     origPoint(size(seq,2)) = 0;
    origPoint = mean(seq);
%     origPoint = min(seq);
%     origPoint = max(seq);

    A = [];
    for i=1:size(seq,1)
        dist = CalcPointDist(origPoint,seq(i,:));
        A = [A; dist];
    end
    x = A';

end