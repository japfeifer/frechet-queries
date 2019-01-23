function v = VectorFlipBits(v1,numBits)

    % uniformly randomly sample coordinates in the vector, without replacement
    [value,idx] = datasample(v1,numBits,'Replace',false);
    
    % flip the bits for those coordinates
    v1(idx) = v1(idx) * -1;
    v = v1;
end