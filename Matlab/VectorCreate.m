function v = VectorCreate(numCoord)

    v = int8(randi(2,1,numCoord)); % randomly generate numCoord of 1's and 2's
    v(v == 2) = v(v == 2) - 3; % change 2's to -1's

end