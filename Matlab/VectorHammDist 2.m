function dist = VectorHammDist(v1,v2)

    vTmp = v1 ~= v2; % flag coordinates that are not equal
    dist = sum(vTmp) / size(vTmp,2); % add up coordinates that are not equal, divide by number of total coordinates

end