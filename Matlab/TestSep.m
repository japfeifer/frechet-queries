

function TestSep(subStr)

    global inpSep
    
    inpSep = [];
    
    for i=1:size(subStr,1) % for each candidate, insert into inpSep
        InsInpSep(subStr(i,:));
    end

end