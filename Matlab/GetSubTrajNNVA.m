


function [alpha,totCellCheck,subStart,subEnd,maxc] = GetSubTrajNNVA(subStr,level,Q,lb,typeQ,eVal,maxc,lenQ,Qid)

    global decimalPrecision inP inpTrajVert inpTrajErr inpTrajPtr
    
    [C,maxc] = GetSubTrajCandGroups(subStr,maxc); % get the initial candidates
    totCellCheck = 0;
    totCellCheck = totCellCheck + size(C,1);
    for i = level:lb  % from current parent level down to leaf level
        alpha = Inf;
        err = inpTrajErr(i) + 0.0000001;
        if size(C,1) == 0
            error('set C is empty');
        end
        if i == lb
            cand2check = [1:size(C,1)]';
            numFreLoops = Inf;
        else
            if size(C,1) == 1
                cand2check = [1];
                numFreLoops = i*2; 
            else
                num2check = min(ceil(log2(size(C,1))),2);
                cand2check = [datasample([1:size(C,1)],num2check,'Replace',false)]';
                numFreLoops = i*2;
            end
        end
        
        for j = 1:size(cand2check,1) % for each c in C, get VA dist and track smallest dist
            idxP = [inpTrajVert(C(cand2check(j,1),1):C(cand2check(j,1),2),i)]';
            P = inP(idxP,:);
            [dist,numCellCheck,z,zRev] = SubContFrechetFastVA(P,Q,decimalPrecision,alpha,numFreLoops,Qid);
            totCellCheck = totCellCheck + numCellCheck;
            if dist < alpha % save smallest alpha. also save start/end vertex since we may be at leaf level and can return results
                alpha = dist;
                idxOffset = C(cand2check(j,1),1) - 1; % need an offset to P, since P is most likely a sub-traj
                szCut = size(z,1);
                if szCut > 0
                    subStart = z(szCut,2) + idxOffset;
                    subEnd = z(1,2) + idxOffset + 1; % a +1 is added since end is a freespace cell and not a vertex
                end
                if eVal > 0 && alpha - err > 0 % we have additive or multiplicative error. Check if we can stop
                    ls = alpha + err; 
                    rs = alpha - err;
                    if typeQ == 2 && ls/rs <= eVal  % multiplicative error
                        return
                    elseif typeQ == 1 && ls-rs <= eVal % additive error
                        return
                    end 
                end
            end
        end
        
        if i < lb % at parent level, get candidates for next lower level
            numRes = 1;
            currLen = alpha + err;
            newC(1:size(C)*10,1:2) = 0; % preallocate memory for speed
            for j = 1:size(C,1) % for each c in C, get new candidates.  sub-traj DP search with alpha + r(l)
                idxP = [inpTrajVert(C(j,1):C(j,2),i)]';
                P = inP(idxP,:);
                spList = GetFreespaceStartPts(P,Q,currLen); % get the start points on freespace diagram right edge
                totCellCheck = totCellCheck + size(P,1);
                idxOffset = C(j,1) - 1; % need an offest to P, since P is most likely a sub-traj
                for k = 1:size(spList,1) % for each start point, check if there is a VA path
                    [answ,numCellCheck,z,zRev] = SubContFrechetFastVACheck(P,Q,currLen,spList(k,1),spList(k,2));
                    totCellCheck = totCellCheck + numCellCheck;
                    if answ == 1 % there is a VA aligned path
                        szCut = size(z,1);
                        subStart = z(szCut,2) + idxOffset;
                        subEnd = z(1,2) + idxOffset + 1; % a +1 is added since end is a freespace cell and not a vertex
                        % we do not want to insert "duplicates", i.e. sub-traj with same endpoint
                        if newC(1,1) == 0 % it is not a "duplicate", insert
                            newC(numRes,1:2) = [subStart subEnd];
                            numRes = numRes + 1;
                        elseif newC(1,1) > 0 && newC(numRes-1,2) ~= subEnd % it is not a "duplicate", insert
                            newC(numRes,1:2) = [subStart subEnd];
                            numRes = numRes + 1;
                        end
                    end
                end
            end
            C = newC(newC(:,1)>0,:);  % discard pre-allocated space that was unused, and set to C for next iteration
            % update C to candidate ids for next level down in HST
            for j = 1:size(C,1)
                C(j,1) = inpTrajPtr(C(j,1),i);
                C(j,2) = inpTrajPtr(C(j,2),i);
            end
            [C,maxc] = GetSubTrajCandGroups(C,maxc); % group candidates
            totCellCheck = totCellCheck + size(C,1);
        end
    end
end