% Same as TestVectorSet2, but change set size to 15 and 
% subtact the last 5 vectors from the set vAdd.

numVec = 200;
coordSz = 10000;
setSz = 15;
numSub = 5;

% create a set of vectors
vList = [];
vList(numVec,coordSz) = 0;
for i = 1:numVec
    v = VectorCreate(coordSz);
    vList(i,:) = v;
end

% add vectors in set together
for i = 1:setSz
    if i==1
        vAdd = vList(i,:);
    else
        vAdd = VectorAdd(vAdd,vList(i,:));
    end
end
vAdd = VectorAddFinish(vAdd);

% subtract the last numSub from set vAdd
for i = setSz-numSub+1:setSz
    vAdd = VectorSub(vAdd,vList(i,:));
end
vAdd = VectorAddFinish(vAdd);

% initialize all-ones vector
vOnes = [];
vOnes(1,1:coordSz) = 1;

% check if elements are in set vAdd using COS dist
h = waitbar(0, 'Check elements Search');
setRes = [];
for i = 1:numVec
    v1 = vList(i,:); % get the i-th vector in list
    vMul = VectorMult(v1,vAdd);
    
    bestDist = -1;
    bestID = 0;
    for j = 1:numVec % search vectors and find closest one
        dist = VectorCosDist(vMul,vList(j,:));
        if dist > bestDist
            bestDist = dist;
            bestID = j;
        end
    end
    
    onesDist = VectorCosDist(vMul,vOnes);
    
    if onesDist > bestDist % then this element is in set
        setRes = [setRes; 1 0];
    else
        setRes = [setRes; 0 1];
    end
    
    if mod(i,10) == 0
        X = ['Check elements Search: ',num2str(i)];
        waitbar(i/numVec, h, X);
    end
end
close(h);

Pos = sum(setRes(1:setSz-numSub,:));
Neg = sum(setRes(setSz-numSub+1:numVec,:));

disp(['-------------------']);
disp(['True Positive: ',num2str(Pos(1,1))]);
disp(['False Positive: ',num2str(Pos(1,2))]);
disp(['True Negative: ',num2str(Neg(1,2))]); 
disp(['False Negative: ',num2str(Neg(1,1))]);

