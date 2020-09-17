% function GetVertexRI
%
% Gets a Random Index (RI) from the hash table (vertexMap) based on the 
% stabbing order key. If the RI does not exist then it creates one and 
% inserts it into the soMap.  vertexType is either 'S' for start vertex or
% 'E' for end vertex.

function ri = GetVertexRI(vertex,vertexType)

    global vertexMap coordSz
    
    % create a key, with vertexType then the node ID in parameter vertex
    key = sprintf('%s%d',vertexType,vertex);
    
    if isKey(vertexMap,key) == true % the RI exists
        ri = vertexMap(key); % get the existing ri from vertexMap
    else % the RI does not exist, so create and insert it into vertexMap
        ri = VectorRISample(coordSz); % create RI
        vertexMap(key) = ri; % insert RI into vertexMap
    end

end