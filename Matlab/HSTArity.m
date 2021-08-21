% Compute HST arity

aList = [];
aList(1:size(inP,1)*30,1) = 0;
cnt = 1;
for i = 1:size(inpTrajPtr,2)
    for j = 1:inpTrajSz(i) - 1
        idx1 = inpTrajPtr(j,i);
        idx2 = inpTrajPtr(j+1,i);
        if i == 1
            x = idx2 - idx1 + 1;
            aList(cnt,1) = x;
            cnt = cnt + 1;
        else
            foundFlg = 0;
%             a = find(inpTrajPtr(:,i-1) == idx1);
            a = FindInpTrajPtr(i-1,idx1);
            if a > 0
%             if size(a,1) > 0
                if inpTrajPtr(a+1,i-1) == idx2
                    foundFlg = 1;
                end
            end
            if foundFlg == 0 % count this
                x = idx2 - idx1 + 1;
                aList(cnt,1) = x;
                cnt = cnt + 1;
            end
        end
    end
end

aList = aList(1:cnt-1,1);
disp(['HST Mean Arity: ',num2str(mean(aList))]);
disp(['HST Min Arity: ',num2str(min(aList))]);
disp(['HST Max Arity: ',num2str(max(aList))]);
disp(['HST Std Arity: ',num2str(std(aList))]);
