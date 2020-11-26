% Test searching for elements in a set, using cosine distance.
% Create 100 vectors, each with 10,000 vector coordinates.


tic

numVec = 100;
coordSz = 10000;
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
        v100 = vList(i,:);
    else
        v100 = VectorAdd(v100,vList(i,:));
    end
end
v100 = VectorAddFinish(v100);

% create smaller sets

% first 10 elements
for i = 1:10
       if i==1
        v10 = vList(i,:);
    else
        v10 = VectorAdd(v10,vList(i,:));
    end 
end
v10 = VectorAddFinish(v10);

% first 20 elements
for i = 1:20
       if i==1
        v20 = vList(i,:);
    else
        v20 = VectorAdd(v20,vList(i,:));
    end 
end
v20 = VectorAddFinish(v20);

% first 30 elements
for i = 1:30
       if i==1
        v30 = vList(i,:);
    else
        v30 = VectorAdd(v30,vList(i,:));
    end 
end
v30 = VectorAddFinish(v30);

% first 40 elements
for i = 1:40
       if i==1
        v40 = vList(i,:);
    else
        v40 = VectorAdd(v40,vList(i,:));
    end 
end
v40 = VectorAddFinish(v40);

% first 50 elements
for i = 1:50
       if i==1
        v50 = vList(i,:);
    else
        v50 = VectorAdd(v50,vList(i,:));
    end 
end
v50 = VectorAddFinish(v50);

% first 60 elements
for i = 1:60
       if i==1
        v60 = vList(i,:);
    else
        v60 = VectorAdd(v60,vList(i,:));
    end 
end
v60 = VectorAddFinish(v60);

% first 70 elements
for i = 1:70
       if i==1
        v70 = vList(i,:);
    else
        v70 = VectorAdd(v70,vList(i,:));
    end 
end
v70 = VectorAddFinish(v70);

% first 80 elements
for i = 1:80
       if i==1
        v80 = vList(i,:);
    else
        v80 = VectorAdd(v80,vList(i,:));
    end 
end
v80 = VectorAddFinish(v80);

% first 90 elements
for i = 1:90
       if i==1
        v90 = vList(i,:);
    else
        v90 = VectorAdd(v90,vList(i,:));
    end 
end
v90 = VectorAddFinish(v90);

dist10 = VectorCosDist(v10,v100);
dist20 = VectorCosDist(v20,v100);
dist30 = VectorCosDist(v30,v100);
dist40 = VectorCosDist(v40,v100);
dist50 = VectorCosDist(v50,v100);
dist60 = VectorCosDist(v60,v100);
dist70 = VectorCosDist(v70,v100);
dist80 = VectorCosDist(v80,v100);
dist90 = VectorCosDist(v90,v100);
dist100 = VectorCosDist(v100,v100);

disp(['dist10: ',num2str(dist10)]);
disp(['dist20: ',num2str(dist20)]);
disp(['dist30: ',num2str(dist30)]);
disp(['dist40: ',num2str(dist40)]);
disp(['dist50: ',num2str(dist50)]);
disp(['dist60: ',num2str(dist60)]);
disp(['dist70: ',num2str(dist70)]);
disp(['dist80: ',num2str(dist80)]);
disp(['dist90: ',num2str(dist90)]);
disp(['dist100: ',num2str(dist100)]);

timeElapsed = toc;
