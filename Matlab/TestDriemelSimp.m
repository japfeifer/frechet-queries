% test Driemel simplification of curves

% setup initial variables

% dataName = 'PigeonHomingData';
% Pidx = 4; % index for curve P
% dispFact = 1000; % factor to multiply display values by
% 
% dataName = 'PigeonHomingData';
% Pidx = 25; % index for curve P
% dispFact = 1000; % factor to multiply display values by
% 
% dataName = 'BlackBackedGullsData';
% Pidx = 1; % index for curve P
% dispFact = 1000; % factor to multiply display values by
%
% dataName = 'BlackBackedGullsData';
% Pidx = 119; % index for curve P
% dispFact = 1000; % factor to multiply display values by
%
% dataName = 'FootballData';
% Pidx = 3653; % index for curve P
% dispFact = 1; % factor to multiply display values by
%
% dataName = 'GeoLifeData';
% Pidx = 1523; % index for curve P
% dispFact = 100; % factor to multiply display values by
%
% dataName = 'KrugerBuffaloData';
% Pidx = 2; % index for curve P
% dispFact = 100; % factor to multiply display values by
%
% dataName = 'MaskedBoobiesData';
% Pidx = 118; % index for curve P
% dispFact = 100; % factor to multiply display values by
%
% dataName = 'PetCatsData';
% Pidx = 21; % index for curve P
% dispFact = 10000; % factor to multiply display values by
%
% dataName = 'SchoolBusData';
% Pidx = 51; % index for curve P
% dispFact = 100; % factor to multiply display values by
%
% dataName = 'TaxiData';
% Pidx = 9795; % index for curve P
% dispFact = 100; % factor to multiply display values by
%
% dataName = 'TruckData';
% Pidx = 196; % index for curve P
% dispFact = 100; % factor to multiply display values by


% test other CCT method

% dataName = 'FootballData';
% Pidx = 1; % index for curve P
% dispFact = 1; % factor to multiply display values by
%
% dataName = 'KrugerBuffaloData';
% Pidx = 1; % index for curve P
% dispFact = 100; % factor to multiply display values by
%
% dataName = 'SchoolBusData';
% Pidx = 1; % index for curve P
% dispFact = 100; % factor to multiply display values by
%
dataName = 'TruckData';
Pidx = 17; % index for curve P
dispFact = 100; % factor to multiply display values by

% load data set
CCTType = 'CCT1';
load(['MatlabData/' CCTType dataName '.mat']);
addpath('Continuous Frechet');

% set curve P
P = cell2mat(trajOrigData(Pidx,1));
n = size(P,1);

% get total length of curve P
totLen = 0;
for i = 1:size(P,1) - 1
    totLen = totLen + CalcPointDist(P(i,:),P(i+1,:));
end

nSimp = floor(sqrt(n)); % compute preferred number of vertices we want for simplified curve P'
% nSimp = floor(sqrt(n * log2(n))); % compute preferred number of vertices we want for simplified curve P'
maxSimpLen = totLen / nSimp; % max lengh that P' segement can be

% Compute P', where |P'| is approx equal to nSimp, and Driemel simplification error is minimized.
% I.e., for a polylog n number of iterations, compute the Driemel simplification of P to P' using an error
% between 0 and maxSimpLen (random binary search in this interval).

% determine the polylog n number of iterations for the random binary search
polyExp = 3; % polylog exponent
numIter = floor(log2(n) * polyExp);

minVal = 0; % minimum simp value
maxVal = maxSimpLen; % maximum simp value
PSimp = []; % P'
isFirstSame = 1;
rngSeed = 1; % random seed value
rng(rngSeed); % reset random seed so experiments are reproducable

disp(['--------------------']);
disp(['n: ',num2str(n),' nSimp: ',num2str(nSimp),' maxSimpLen: ',num2str(maxSimpLen*dispFact),' numIter: ',num2str(numIter)]);

for i = 1:numIter
    currErr = minVal + (maxVal - minVal)*rand; % uniformly distributed random real in the interval [minVal,minVal]
    currPSimp = BallSimp(P,currErr); % call Driemel linear-time simplification algorithm
    szCurrPSimp = size(currPSimp,1); % |P'|
    if i == 1
        currBestErr = currErr;
        currBestSz = szCurrPSimp;
    end
    disp(['i: ',num2str(i),' szCurrPSimp: ',num2str(szCurrPSimp),' currErr: ',num2str(currErr*dispFact),...
        ' minVal: ',num2str(minVal*dispFact),' maxVal: ',num2str(maxVal*dispFact),...
        ' currBestErr: ',num2str(currBestErr*dispFact),' currBestSz: ',num2str(currBestSz)]);
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
disp(['Final currBestErr: ',num2str(currBestErr*dispFact),' currBestSz: ',num2str(currBestSz)]);

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

