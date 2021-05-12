



function RecSubNNInit(Qid,level,C)

    global numCFD numDP linLBcnt linUBcnt queryStrData Bk PNN

    tSearch = tic;

    timeSearch = 0; 
    numCFD = 0;
    numDP = 0;
    linLBcnt = 0;
    linUBcnt = 0;
    Bk = Inf;
    PNN = [];

    Q = queryStrData(Qid).traj; % query trajectory vertices and coordinates

    % depth-first recursive search on HST
    RecSubNN(Qid,Q,level,C)
    
    timeSearch = toc(tSearch);

    % store results
    queryStrData(Qid).subsvert = PNN(1); % start vertex
    queryStrData(Qid).subevert = PNN(2); % end vertex
    queryStrData(Qid).sublb = Bk; % LB dist
    queryStrData(Qid).subub = Bk; % UB dist
    queryStrData(Qid).subcntlb = linLBcnt;
    queryStrData(Qid).subcntub = linUBcnt;
    queryStrData(Qid).subcntfdp = numDP;
    queryStrData(Qid).subcntcfd = numCFD;
    queryStrData(Qid).subsearchtime = timeSearch;

end