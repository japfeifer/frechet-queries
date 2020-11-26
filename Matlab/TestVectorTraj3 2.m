tic
coordSz = 10000;

% disc vectors
D1 = VectorCreate(coordSz);
D2 = VectorCreate(coordSz);
D3 = VectorCreate(coordSz);
D4 = VectorCreate(coordSz);
D5 = VectorCreate(coordSz);
D6 = VectorCreate(coordSz);
DD = VectorCreate(coordSz); % dummy vector

% encode T1
T1a = VectorAdd(D1,D2);
T1a = VectorAdd(T1a,DD);
T1a = VectorAddFinish(T1a);
T1 = VectorRot(T1a,4,1);
T1 = VectorMult(T1,VectorRot(D3,3,1));
T1 = VectorMult(T1,VectorRot(D4,2,1));
T1 = VectorMult(T1,VectorRot(D5,1,1));
T1 = VectorMult(T1,D6);

% encode Q1
Q1a = VectorAdd(D1,D2);
Q1a = VectorAdd(Q1a,DD);
Q1a = VectorAddFinish(Q1a);
Q1 = VectorRot(Q1a,4,1);
Q1 = VectorMult(Q1,VectorRot(D3,3,1));
Q1 = VectorMult(Q1,VectorRot(D4,2,1));
Q1 = VectorMult(Q1,VectorRot(D5,1,1));
Q1 = VectorMult(Q1,D6);

% encode Q2
Q2 = VectorMult(VectorRot(D1,4,1),VectorRot(D3,3,1));
Q2 = VectorMult(Q2,VectorRot(D4,2,1));
Q2 = VectorMult(Q2,VectorRot(D5,1,1));
Q2 = VectorMult(Q2,D6);

% encode Q3
Q3 = VectorMult(VectorRot(D2,4,1),VectorRot(D3,3,1));
Q3 = VectorMult(Q3,VectorRot(D4,2,1));
Q3 = VectorMult(Q3,VectorRot(D5,1,1));
Q3 = VectorMult(Q3,D6);

% encode Q4
Q4 = VectorMult(VectorRot(D1,5,1),VectorRot(D2,4,1));
Q4 = VectorMult(Q4,VectorRot(D3,3,1));
Q4 = VectorMult(Q4,VectorRot(D4,2,1));
Q4 = VectorMult(Q4,VectorRot(D5,1,1));
Q4 = VectorMult(Q4,D6);

% compare vectors
disp(['----------------']);
disp(['Q1 to T1: ',num2str(VectorCosDist(Q1,T1))]);
disp(['Q2 to T1: ',num2str(VectorCosDist(Q2,T1))]);
disp(['Q3 to T1: ',num2str(VectorCosDist(Q3,T1))]);
disp(['Q4 to T1: ',num2str(VectorCosDist(Q4,T1))]);



