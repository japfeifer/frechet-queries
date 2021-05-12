

function [stIdx,enIdx] = GetSubTrajLookAhead(stIdx,enIdx,fromLevel,toLevel)

    global inpTrajPtr

    for i = fromLevel:toLevel-1
        stIdx = inpTrajPtr(stIdx,i);
        enIdx = inpTrajPtr(enIdx,i);
    end

end