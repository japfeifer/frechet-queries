function [currBestErr,currBestIdxListP,PSimp,maxSegLenP,maxSegLenPSimp] = DriemelError(P,iterPolyExp,szPolyExp,dispFact,dispFlg)

    switch nargin
    case 1
        iterPolyExp = 1;
        szPolyExp = 0;
        dispFact = 1;
        dispFlg = 0;
    case 2
        szPolyExp = 0;
        dispFact = 1;
        dispFlg = 0;
    case 3
        dispFact = 1;
        dispFlg = 0;
    end
    
    n = size(P,1);

    % get total length of curve P
    totLen = 0;
    for i = 1:size(P,1) - 1
        totLen = totLen + CalcPointDist(P(i,:),P(i+1,:));
    end

    if szPolyExp == 0
        nSimp = floor(sqrt(n)); % compute preferred number of vertices we want for simplified curve P'
    else
        nSimp = floor(sqrt(n * log2(n) * szPolyExp)); % compute preferred number of vertices we want for simplified curve P'
    end
    maxSimpLen = totLen / nSimp; % max lengh that P' segement can be

    % Compute P', where |P'| is approx equal to nSimp, and Driemel simplification error is minimized.
    % I.e., for a polylog n number of iterations, compute the Driemel simplification of P to P' using an error
    % between 0 and maxSimpLen (random binary search in this interval).

    % determine the polylog n number of iterations for the random binary search
    numIter = floor(log2(n) * iterPolyExp);

    minVal = 0; % minimum simp value
    maxVal = maxSimpLen; % maximum simp value
    PSimp = []; % P'
    currBestIdxListP = [];
    isFirstSame = 1;
    rngSeed = 1; % random seed value
    rng(rngSeed); % reset random seed so experiments are reproducable

    if dispFlg == 1
        disp(['--------------------']);
        disp(['n: ',num2str(n),' nSimp: ',num2str(nSimp),' maxSimpLen: ',num2str(maxSimpLen*dispFact),' numIter: ',num2str(numIter)]);
    end
    
    for i = 1:numIter
        currErr = minVal + (maxVal - minVal)*rand; % uniformly distributed random real in the interval [minVal,minVal]
        [currPSimp,idxListP] = DriemelSimp(P,currErr); % call Driemel linear-time simplification algorithm
        szCurrPSimp = size(currPSimp,1); % |P'|
        if i == 1
            currBestErr = currErr;
            currBestSz = szCurrPSimp;
        end
        if dispFlg == 1
            disp(['i: ',num2str(i),' szCurrPSimp: ',num2str(szCurrPSimp),' currErr: ',num2str(currErr*dispFact),...
                ' minVal: ',num2str(minVal*dispFact),' maxVal: ',num2str(maxVal*dispFact),...
                ' currBestErr: ',num2str(currBestErr*dispFact),' currBestSz: ',num2str(currBestSz)]);
        end
        if i == 1 % first iteration, this P' is currently best
            PSimp = currPSimp;
            currBestErr = currErr;
            currBestSz = szCurrPSimp;
            currBestIdxListP = idxListP;
        else % check if this iteration P' should be set to current best P'
            if szCurrPSimp == nSimp  % current |P'| is same as preferred |P'|
                if currErr < currBestErr || isFirstSame == 1 % current P' has smaller error
                    PSimp = currPSimp;
                    currBestErr = currErr;
                    currBestSz = szCurrPSimp;
                    currBestIdxListP = idxListP;
                end
                isFirstSame = 0;
            elseif abs(szCurrPSimp - nSimp) < abs(currBestSz - nSimp) % current |P'| is closer to preferred |P'|
                PSimp = currPSimp;
                currBestErr = currErr;
                currBestSz = szCurrPSimp;
                currBestIdxListP = idxListP;
            elseif abs(szCurrPSimp - nSimp) == abs(currBestSz - nSimp) % current |P'| is same num vertices away from preferred |P'| as currBest |P'|
                if currErr < currBestErr % current P' has smaller error
                    PSimp = currPSimp;
                    currBestErr = currErr;
                    currBestSz = szCurrPSimp;
                    currBestIdxListP = idxListP;
                end
            end
        end
        if szCurrPSimp <= nSimp
            maxVal = currErr;
        else
            minVal = currErr;
        end
    end
    if dispFlg == 1
        disp(['Final currBestErr: ',num2str(currBestErr*dispFact),' currBestSz: ',num2str(currBestSz)]);
    end

    % get length of longest segment in P
    maxSegLenP = 0;
    for i = 1:size(P,1) - 1
        currSegLen = CalcPointDist(P(i,:),P(i+1,:));
        if currSegLen > maxSegLenP
            maxSegLenP = currSegLen;
        end
    end

    % get length of longest segment in P'
    maxSegLenPSimp = 0;
    for i = 1:size(PSimp,1) - 1
        currSegLen = CalcPointDist(PSimp(i,:),PSimp(i+1,:));
        if currSegLen > maxSegLenPSimp
            maxSegLenPSimp = currSegLen;
        end
    end

end
