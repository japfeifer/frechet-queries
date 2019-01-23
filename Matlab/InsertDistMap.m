
function InsertDistMap(id1,id2,currDist)
    global distMap trajDistMatrix

    key = strcat(sprintf('%010d',id1), sprintf('%010d',id2));
    distMap(key) = currDist;

    tmpList = cell2mat(trajDistMatrix(id1,1));
    tmpList = [tmpList;id2];
    trajDistMatrix(id1,1) = mat2cell(tmpList,size(tmpList,1),size(tmpList,2));

end


