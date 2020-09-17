
function inputSz = GetInputSize()

    global inputSet

    inputSz = 0;
    for i = 1:size(inputSet,1)
        for j = 3:size(inputSet,2)
            P = cell2mat(inputSet(i,j));
            if isempty(P) == false
                inputSz = inputSz + 1;
            end
        end
    end

end