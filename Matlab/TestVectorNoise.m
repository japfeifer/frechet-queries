numVec = 100000;
coordSz = 10000;
setRes1 = [];

v1 = [];
v1(1,1:coordSz) = 1;

% v1 =  VectorCreate(coordSz);

for i = 1:numVec
    v2 = VectorCreate(coordSz);
    dist = VectorCosDist(v1,v2);
    setRes1 = [setRes1 dist];
end

figure;
h1 = histogram(setRes1,'BinWidth',0.001);
hold off