% insert an "at rest" pose frame at the beginning and end of the sequence

function newSeq = UCFAtRest(seq)

    pHEAD = [1.77300000000000,217.886000000000,3.85999999999967];
    pNECK = [0,0,0];
    pTORS = [-2.44899999999998,-220.776400000000,-8.67000000000007];
    pLSHO = [-154.954400000000,1.02800000000002,17.5299999999997];
    pLELB = [-226.005800000000,-290.154800000000,22.3699999999999];
    pLHND = [-217.199600000000,-572.216000000000,-104.370000000000];
    pRSHO = [154.955000000000,-1.02699999999999,-17.5400000000004];
    pRELB = [227.852000000000,-301.385100000000,-3.81000000000040];
    pRHND = [194.857000000000,-574.633000000000,-147.840000000000];
    pLHIP = [-108.527700000000,-442.109000000000,-6.64000000000033];
    pLKNE = [-133.239260000000,-872.603000000000,-103.280000000000];
    pLFOT = [-166.517100000000,-1262.74300000000,-144.190000000000];
    pRHIP = [94.0820000000000,-444.514000000000,-29.9800000000000];
    pRKNE = [114.062000000000,-872.450000000000,-138.390000000000];
    pRFOT = [158.700000000000,-1250.68300000000,-151.040000000000];
    atRest = [pHEAD pNECK pTORS pLSHO pLELB pLHND pRSHO pRELB pRHND ...
        pLHIP pLKNE pLFOT pRHIP pRKNE pRFOT];
    
    newSeq = [atRest; seq; atRest];

end