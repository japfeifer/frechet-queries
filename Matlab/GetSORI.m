% function GetSORI
%
% Gets a Random Index (RI) from the hash table (soMap) based on the 
% stabbing order key. If the RI does not exist then it creates one and 
% inserts it into the soMap.

function ri = GetSORI(so)

    global soMap coordSz
    
    % create a key, based on stabbing order
    key = sprintf('N%d',so);
    
    if isKey(soMap,key) == true % the RI exists
        ri = soMap(key); % get the existing ri from soMap
    else % the RI does not exist, so create and insert it into soMap
        ri = VectorRISample(coordSz); % create RI
        soMap(key) = ri; % insert RI into soMap
    end

end