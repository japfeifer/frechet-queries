

function currBestErr = GetSimpTreeErr(P,nSimp,polyExp,simpType,dispFlg)

    switch nargin
    case 2
        polyExp = 2; % polylog exponent
        simpType = 1;
        dispFlg = 0;
    case 3
        simpType = 1;
        dispFlg = 0;
    case 4
        dispFlg = 0;
    end

    n = size(P,1); % number of P vertices
    totLen = 0; % get total length of curve P
    for i = 1:size(P,1) - 1
        totLen = totLen + CalcPointDist(P(i,:),P(i+1,:));
    end
    maxSimpLen = totLen / nSimp; % max length that P' segement can be

    % Compute P', where |P'| is approx equal to nSimp, and Driemel simplification error is minimized.
    % I.e., for a polylog n number of iterations, compute the Driemel simplification of P to P' using an error
    % between 0 and maxSimpLen (random binary search in this interval).

    numIter = floor(log2(n) * polyExp); % determine the polylog n number of iterations for the random binary search
    minVal = 0; % minimum simp value
    maxVal = maxSimpLen; % maximum simp value
    PSimp = []; % P'
    isFirstSame = 1;
    rngSeed = 1; % random seed value
    rng(rngSeed); % reset random seed so experiments are reproducable

    if dispFlg == 1
        disp(['--------------------']);
        disp(['n: ',num2str(n),' nSimp: ',num2str(nSimp),' maxSimpLen: ',num2str(maxSimpLen),' numIter: ',num2str(numIter)]);
    end

    for i = 1:numIter
        currErr = minVal + (maxVal - minVal)*rand; % uniformly distributed random real in the interval [minVal,minVal]
        if simpType == 1
            currPSimp = LinearSimp(P,currErr); % call Driemel linear-time simplification algorithm
        else
            currPSimp = BallSimp(P,currErr); % call Intra-ball linear-time simplification algorithm
        end
        szCurrPSimp = size(currPSimp,1); % |P'|
        if i == 1
            currBestErr = currErr;
            currBestSz = szCurrPSimp;
        end
        if dispFlg == 1
            disp(['i: ',num2str(i),' szCurrPSimp: ',num2str(szCurrPSimp),' currErr: ',num2str(currErr),...
                ' minVal: ',num2str(minVal),' maxVal: ',num2str(maxVal),...
                ' currBestErr: ',num2str(currBestErr),' currBestSz: ',num2str(currBestSz)]);
        end
        if i == 1 % first iteration, this P' is currently best
            PSimp = currPSimp;
            currBestErr = currErr;
            currBestSz = szCurrPSimp;
        else % check if this iteration P' should be set to current best P'
            if szCurrPSimp == nSimp  % current |P'| is same as preferred |P'|
                if currErr < currBestErr || isFirstSame == 1 % current P' has smaller error
                    PSimp = currPSimp;
                    currBestErr = currErr;
                    currBestSz = szCurrPSimp;
                end
                isFirstSame = 0;
            elseif abs(szCurrPSimp - nSimp) < abs(currBestSz - nSimp) % current |P'| is closer to preferred |P'|
                PSimp = currPSimp;
                currBestErr = currErr;
                currBestSz = szCurrPSimp;
            elseif abs(szCurrPSimp - nSimp) == abs(currBestSz - nSimp) % current |P'| is same num vertices away from preferred |P'| as currBest |P'|
                if currErr < currBestErr % current P' has smaller error
                    PSimp = currPSimp;
                    currBestErr = currErr;
                    currBestSz = szCurrPSimp;
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
        disp(['Final currBestErr: ',num2str(currBestErr),' currBestSz: ',num2str(currBestSz)]);
    end

end