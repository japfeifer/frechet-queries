% returns an array of distances from each seq frame to the first frame

function x = GetSeqDist(seq)

    A = [];
    for i=1:size(seq,1)
        dist = CalcPointDist(seq(1,:),seq(i,:));
        A = [A; dist];
    end
    x = A';

end