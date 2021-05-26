

function [C,maxc] = GetSubTrajCandGroups(subStr,maxc)

    C(1:500,1:2) = 0; % preallocate some memory for speed
    subStr = sortrows(subStr,[1 2],{'ascend' 'descend'}); % sort by LB then UB
    idx = 1;
    for i = 1:size(subStr,1)
        if i == 1
            C(idx,1:2) = [subStr(i,1) subStr(i,2)]; % seed first group
        else
            if subStr(i,1) > C(idx,2) + 1 % new group
                idx = idx + 1;
                C(idx,1:2) = [subStr(i,1) subStr(i,2)];
            elseif subStr(i,2) > C(idx,2) % update end vertex on current group
                C(idx,2) = subStr(i,2);
            end
        end
    end
    C = C(C(:,1)>0,:);  % discard pre-allocated space that was unused
    for i = 1:size(C,1) % get maxc
        if C(i,2) - C(i,1) + 1 > maxc
            maxc = C(i,2) - C(i,1) + 1;
        end
    end
end