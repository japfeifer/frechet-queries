% graph histograms for cosine distance between vMul and vOnes for
% elements in the set and not in the set.

numVec = 200;
coordSz = 2000;
setSz = 100;

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
