


function [alpha,totCellCheck,subStart,subEnd] = Algo1SubNN(Qid)

    global decimalPrecision inP inpTrajVert queryStrData
    
    tSearch = tic;
    timeSearch = 0;
    level = 1;
    minIdx = 1;
    maxIdx = 2;
    
    idxP = [inpTrajVert(minIdx,level) : inpTrajVert(maxIdx,level)]'; % get non-simplified traj at leaf level
    P = inP(idxP,:);
    Q = queryStrData(Qid).traj; % query trajectory vertices and coordinates

    [alpha,totCellCheck,z,zRev] = SubContFrechetFastVA(P,Q,decimalPrecision);
    
    idxOffset = minIdx - 1; % need an offset to P, since P is most likely a sub-traj
    szCut = size(z,1);
    subStart = z(szCut,2) + idxOffset;
    subEnd = z(1,2) + idxOffset + 1; % a +1 is added since end is a freespace cell and not a vertex

    timeSearch = toc(tSearch);

    % store results
    queryStrData(Qid).subsvert = subStart; % start vertex
    queryStrData(Qid).subevert = subEnd; % end vertex
    queryStrData(Qid).sublb = alpha; % LB dist
    queryStrData(Qid).subub = alpha; % UB dist
    queryStrData(Qid).subcntsubtraj = [];
    queryStrData(Qid).subcntlb = 0;
    queryStrData(Qid).subcntub = 0;
    queryStrData(Qid).subcntfdp = 0;
    queryStrData(Qid).subcntcfd = 0;
    queryStrData(Qid).subsearchtime = timeSearch;
    queryStrData(Qid).submemorysz = size(inP,1);
    queryStrData(Qid).subnumoperations = round(totCellCheck / size(inP,1),2);
end