% insert an "at rest" pose frame at the beginning and end of the sequence

function seq = KinTransAtRest(seq)

    pNECK = [0 0 0];
    pTORS = [0 -0.551 0];
    pLSHO = [-0.167459126294322  -0.064040708344537  -0.049519982789499];
    pLELB = [-0.245673472066393  -0.296482171295136  -0.012675954551101];
    pLWST = [-0.231801686327238  -0.534986178232172  -0.066975238481790];
    pLHND = [-0.201148051437068  -0.600352030748395  -0.077776164036922];
    pRSHO = [0.167459126294322  -0.064040708344537  -0.049519982789499];
    pRELB = [0.245673472066393  -0.296482171295136  -0.012675954551101];
    pRWST = [0.231801686327238  -0.534986178232172  -0.066975238481790];
    pRHND = [0.201148051437068  -0.600352030748395  -0.077776164036922];
    atRest = [pNECK pTORS pRSHO pRELB pRWST pRHND pLSHO pLELB pLWST pLHND];
    
    seq = [atRest; seq; atRest];

end