

function sLen = GetSegLen(P)

    currLen = 0;
    szP = size(P,1);
    sLen(1:szP,1) = 0;
    for i = 2:szP
        currLen = currLen + CalcPointDist(P(i-1,:),P(i,:));
        sLen(i,1) = currLen;
    end

end