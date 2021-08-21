% binary search for value in a inpTrajPtr column

function a = FindInpTrajPtr(i,idx)

    global inpTrajPtr inpTrajSz
    
    a = 0;
    stIdx = 1;
    enIdx = inpTrajSz(i);

    while 1 == 1
        ptr = ceil((stIdx + enIdx) / 2);
        
        if inpTrajPtr(ptr,i) == idx
            a = ptr;
            break
        elseif stIdx == enIdx
            break
        end
        
        if inpTrajPtr(ptr,i) < idx
            stIdx = ptr;
        else
            if stIdx + 1 == enIdx
                enIdx = stIdx;
            else
                enIdx = ptr;
            end
        end
        
    end

end