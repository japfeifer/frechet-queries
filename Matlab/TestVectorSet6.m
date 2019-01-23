% Same as TestVectorSet2, but randomly flip 10 bits for every vector
% So, flip bits in vList, vAdd, vOnes, and vMul

numVec = 200;
coordSz = 10000;
setSz = 100;
bitsFlip = 1000;

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

% initialize all-ones vector
vOnes = [];
vOnes(1,1:coordSz) = 1;

% flip bits of vectors vList, vAdd, vOnes
for i = 1:numVec
    vList(i,:) = VectorFlipBits(vList(i,:),bitsFlip);
end
vAdd = VectorFlipBits(vAdd,bitsFlip);
vOnes = VectorFlipBits(vOnes,bitsFlip);

% check if elements are in set vAdd using COS dist
h = waitbar(0, 'Check elements Search');
setRes = [];
for i = 1:numVec
    v1 = vList(i,:); % get the i-th vector in list
    vMul = VectorMult(v1,vAdd);
    
    % flip bits of vector vMul
    vMul = VectorFlipBits(vMul,bitsFlip);
    
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

Pos = sum(setRes(1:setSz,:));
Neg = sum(setRes(setSz+1:numVec,:));

disp(['-------------------']);
disp(['True Positive: ',num2str(Pos(1,1))]);
disp(['False Positive: ',num2str(Pos(1,2))]);
disp(['True Negative: ',num2str(Neg(1,2))]); 
disp(['False Negative: ',num2str(Neg(1,1))]);

% get the COS dist between vMul and vOnes for elements in the set
setRes1 = [];
for i = 1:setSz
    v1 = vList(i,:); % get the i-th vector in list
    vMul = VectorMult(v1,vAdd);
    onesDist = VectorCosDist(vMul,vOnes);
    setRes1 = [setRes1 onesDist];
end

% get the COS dist between vMul and vOnes for elements in the set
setRes2 = [];
for i = setSz+1:numVec
    v1 = vList(i,:); % get the i-th vector in list
    vMul = VectorMult(v1,vAdd);
    onesDist = VectorCosDist(vMul,vOnes);
    setRes2 = [setRes2 onesDist];
end

figure;
h1 = histogram(setRes1,'Normalization','probability','BinWidth',0.005);
hold on
h2 = histogram(setRes2,'Normalization','probability','BinWidth',0.005);
hold off


