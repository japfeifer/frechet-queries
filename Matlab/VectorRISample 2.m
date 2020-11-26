function ri = VectorRISample(numCoord)

    % uniformly randomly sample 20 coordinates in the vector, without replacement
    ri = int16(datasample(1:numCoord,20,'Replace',false));

end