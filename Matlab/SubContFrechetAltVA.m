% compute the sub-traj continuous Frechet distance up to a decimal precision 
% uses the quadratic algo from Alt and Godau
% find answer that is vertex-aligned

function [frechetDist,cnt,stopEarly,foundResult] = SubContFrechetAltVA(P,Q,decPrec,checkStopFlg,typeQ,eVal,err)

    global decimalPrecision
    
    switch nargin
    case 2
        decPrec = decimalPrecision;
        checkStopFlg = 0;
        typeQ = 2;
        eVal = 0;
        err = 0;
    case 3
        checkStopFlg = 0;
        typeQ = 2;
        eVal = 0;
        err = 0;
    end
    
    % get upper/lower bounds
    stopEarly = 0;
    foundResult = 0;
    cnt = 0;
    minBnd = 0;
    maxBnd = GetBestUpperBound(P,Q,0,0,0,minBnd);
    P = LinearSimp(P,0);
    Q = LinearSimp(Q,0);
    revP = fliplr(P')';
    revQ = fliplr(Q')';
    while maxBnd - minBnd > decPrec
        currLen = (minBnd + maxBnd) / 2;
        [answ,numCell,z] = FrechetDecide(P,Q,currLen,0,0,0,0,1);
        cnt = cnt + numCell;
        if answ == 1
            answ = CheckVertexAlt(z); % check if z has vertex
            if answ == 1 % now check reversed P and Q
                [answ,numCell,z] = FrechetDecide(revP,revQ,currLen,0,0,0,0,1);
                cnt = cnt + numCell;
                if answ == 1
                    answ = CheckVertexAlt(z); % check if z has vertex
                end
            end
        end
        if answ == 1
            maxBnd = currLen;
            if checkStopFlg == 1 % see if we can stop by examining the maxBnd, which is an upper bound on alpha
                if eVal > 0 % we have additive or multiplicative error. Check if we can stop
                    ls = currLen + err; 
                    rs = currLen - err;
                    if rs <= 0 % we can stop early since the error is infinite
                        stopEarly = 1;
                        break
                    else
                        if typeQ == 2 && ls/rs > eVal  % multiplicative error
                            stopEarly = 1;
                            break
                        elseif typeQ == 1 && ls-rs > eVal % additive error
                            stopEarly = 1;
                            break
                        end 
                    end
                end
            end
        else
            minBnd = currLen;
            if checkStopFlg == 1
                if eVal > 0 && currLen - err > 0 % we have additive or multiplicative error. Check if we can stop
                    ls = currLen + err; 
                    rs = currLen - err;
                    if typeQ == 2 && ls/rs <= eVal  % multiplicative error
                        foundResult = 1;
                        break
                    elseif typeQ == 1 && ls-rs <= eVal % additive error
                        foundResult = 1;
                        break
                    end 
                end
            end
        end
    end
    frechetDist = (minBnd + maxBnd) / 2;

end
