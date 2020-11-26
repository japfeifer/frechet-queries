function mapValue = ReadDistMap(id1,id2)
    global distMap

    key = strcat(sprintf('%010d',id1), sprintf('%010d',id2));
    if isKey(distMap,key) == true
        mapValue = distMap(key);
    else
        mapValue = [];
    end
end