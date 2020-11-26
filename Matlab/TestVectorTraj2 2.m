tic
coordSz = 10000;

% disc vectors
D1 = VectorCreate(coordSz);
D2 = VectorCreate(coordSz);
D3 = VectorCreate(coordSz);
D4 = VectorCreate(coordSz);
D5 = VectorCreate(coordSz);
D6 = VectorCreate(coordSz);
D7 = VectorCreate(coordSz);
D8 = VectorCreate(coordSz);
D9 = VectorCreate(coordSz);
D10 = VectorCreate(coordSz);
D11 = VectorCreate(coordSz);
D12 = VectorCreate(coordSz);
D13 = VectorCreate(coordSz);
D14 = VectorCreate(coordSz);
D15 = VectorCreate(coordSz);
D16 = VectorCreate(coordSz);
D17 = VectorCreate(coordSz);
D18 = VectorCreate(coordSz);
D19 = VectorCreate(coordSz);
D20 = VectorCreate(coordSz);
D21 = VectorCreate(coordSz);
D22 = VectorCreate(coordSz);
D23 = VectorCreate(coordSz);
D24 = VectorCreate(coordSz);
D25 = VectorCreate(coordSz);
D26 = VectorCreate(coordSz);
D27 = VectorCreate(coordSz);
D28 = VectorCreate(coordSz);
D29 = VectorCreate(coordSz);
D30 = VectorCreate(coordSz);
D31 = VectorCreate(coordSz);
D32 = VectorCreate(coordSz);
D33 = VectorCreate(coordSz);
D34 = VectorCreate(coordSz);
D35 = VectorCreate(coordSz);
D36 = VectorCreate(coordSz);
D37 = VectorCreate(coordSz);
D38 = VectorCreate(coordSz);
D39 = VectorCreate(coordSz);
D40 = VectorCreate(coordSz);
D41 = VectorCreate(coordSz);
D42 = VectorCreate(coordSz);
D43 = VectorCreate(coordSz);
D44 = VectorCreate(coordSz);
D45 = VectorCreate(coordSz);
D46 = VectorCreate(coordSz);
D47 = VectorCreate(coordSz);
D48 = VectorCreate(coordSz);
D49 = VectorCreate(coordSz);
D50 = VectorCreate(coordSz);
D51 = VectorCreate(coordSz);
D52 = VectorCreate(coordSz);
D53 = VectorCreate(coordSz);
D54 = VectorCreate(coordSz);
D55 = VectorCreate(coordSz);
D56 = VectorCreate(coordSz);
D57 = VectorCreate(coordSz);
D58 = VectorCreate(coordSz);
D59 = VectorCreate(coordSz);
D60 = VectorCreate(coordSz);
D61 = VectorCreate(coordSz);
D62 = VectorCreate(coordSz);
D63 = VectorCreate(coordSz);
D64 = VectorCreate(coordSz);
D65 = VectorCreate(coordSz);
D66 = VectorCreate(coordSz);
D67 = VectorCreate(coordSz);
D68 = VectorCreate(coordSz);
D69 = VectorCreate(coordSz);
D70 = VectorCreate(coordSz);
D71 = VectorCreate(coordSz);
D72 = VectorCreate(coordSz);
D73 = VectorCreate(coordSz);
D74 = VectorCreate(coordSz);
D75 = VectorCreate(coordSz);
D76 = VectorCreate(coordSz);
D77 = VectorCreate(coordSz);
D78 = VectorCreate(coordSz);
D79 = VectorCreate(coordSz);
D80 = VectorCreate(coordSz);
D81 = VectorCreate(coordSz);
D82 = VectorCreate(coordSz);
D83 = VectorCreate(coordSz);
D84 = VectorCreate(coordSz);

% encode T1
T1a = VectorMult(VectorRot(D57,10,1),VectorRot(D49,9,1));
T1a = VectorMult(T1a,VectorRot(D41,8,1));
T1a = VectorMult(T1a,VectorRot(D33,7,1));
T1a = VectorMult(T1a,VectorRot(D25,6,1));
T1a = VectorMult(T1a,VectorRot(D17,5,1));
T1a = VectorMult(T1a,VectorRot(D25,4,1));
T1a = VectorMult(T1a,VectorRot(D33,3,1));
T1a = VectorMult(T1a,VectorRot(D41,2,1));
T1a = VectorMult(T1a,VectorRot(D49,1,1));
T1a = VectorMult(T1a,D57);

T1b = VectorMult(VectorRot(D77,4,1),VectorRot(D73,3,1));
T1b = VectorMult(T1b,VectorRot(D69,2,1));
T1b = VectorMult(T1b,VectorRot(D73,1,1));
T1b = VectorMult(T1b,D77);

T1c = VectorMult(VectorRot(D83,2,1),VectorRot(D81,1,1));
T1c = VectorMult(T1c,D83);

T1 = VectorAdd(T1a,T1b);
T1 = VectorAdd(T1,T1c);
T1 = VectorAddFinish(T1);

% encode T2
T2a = VectorMult(VectorRot(D57,5,1),VectorRot(D49,4,1));
T2a = VectorMult(T2a,VectorRot(D41,3,1));
T2a = VectorMult(T2a,VectorRot(D33,2,1));
T2a = VectorMult(T2a,VectorRot(D25,1,1));
T2a = VectorMult(T2a,D17);

T2b = VectorMult(VectorRot(D77,2,1),VectorRot(D73,1,1));
T2b = VectorMult(T2b,D69);

T2c = VectorMult(VectorRot(D83,1,1),D81);

T2 = VectorAdd(T2a,T2b);
T2 = VectorAdd(T2,T2c);
T2 = VectorAddFinish(T2);

% encode T3
T3a = VectorMult(VectorRot(D18,5,1),VectorRot(D26,4,1));
T3a = VectorMult(T3a,VectorRot(D34,3,1));
T3a = VectorMult(T3a,VectorRot(D42,2,1));
T3a = VectorMult(T3a,VectorRot(D50,1,1));
T3a = VectorMult(T3a,D58);

T3b = VectorMult(VectorRot(D69,2,1),VectorRot(D73,1,1));
T3b = VectorMult(T3b,D77);

T3c = VectorMult(VectorRot(D81,1,1),D83);

T3 = VectorAdd(T3a,T3b);
T3 = VectorAdd(T3,T3c);
T3 = VectorAddFinish(T3);

% encode T4
T4a = VectorMult(VectorRot(D58,5,1),VectorRot(D50,4,1));
T4a = VectorMult(T4a,VectorRot(D42,3,1));
T4a = VectorMult(T4a,VectorRot(D34,2,1));
T4a = VectorMult(T4a,VectorRot(D26,1,1));
T4a = VectorMult(T4a,D18);

T4b = VectorMult(VectorRot(D77,2,1),VectorRot(D73,1,1));
T4b = VectorMult(T4b,D69);

T4c = VectorMult(VectorRot(D83,1,1),D81);

T4 = VectorAdd(T4a,T4b);
T4 = VectorAdd(T4,T4c);
T4 = VectorAddFinish(T4);

% encode Q1
Q1a = VectorMult(VectorRot(D58,8,1),VectorRot(D50,7,1));
Q1a = VectorMult(Q1a,VectorRot(D42,6,1));
Q1a = VectorMult(Q1a,VectorRot(D34,5,1));
Q1a = VectorMult(Q1a,VectorRot(D26,4,1));
Q1a = VectorMult(Q1a,VectorRot(D34,3,1));
Q1a = VectorMult(Q1a,VectorRot(D42,2,1));
Q1a = VectorMult(Q1a,VectorRot(D50,1,1));
Q1a = VectorMult(Q1a,D58);

Q1b = VectorMult(VectorRot(D77,4,1),VectorRot(D73,3,1));
Q1b = VectorMult(Q1b,VectorRot(D69,2,1));
Q1b = VectorMult(Q1b,VectorRot(D73,1,1));
Q1b = VectorMult(Q1b,D77);

Q1c = VectorMult(VectorRot(D83,2,1),VectorRot(D81,1,1));
Q1c = VectorMult(Q1c,D83);

Q1 = VectorAdd(Q1a,Q1b);
Q1 = VectorAdd(Q1,Q1c);
Q1 = VectorAddFinish(Q1);

disp(['----------------']);
disp(['Q1 to T1: ',num2str(VectorCosDist(Q1,T1))]);
disp(['Q1 to T2: ',num2str(VectorCosDist(Q1,T2))]);
disp(['Q1 to T3: ',num2str(VectorCosDist(Q1,T3))]);
disp(['Q1 to T4: ',num2str(VectorCosDist(Q1,T4))]);

% encode Q2
Q2a = VectorMult(VectorRot(D58,4,1),VectorRot(D50,3,1));
Q2a = VectorMult(Q2a,VectorRot(D42,2,1));
Q2a = VectorMult(Q2a,VectorRot(D34,1,1));
Q2a = VectorMult(Q2a,D26);

Q2b = VectorMult(VectorRot(D77,2,1),VectorRot(D73,1,1));
Q2b = VectorMult(Q2b,D69);

Q2c = VectorMult(VectorRot(D83,1,1),D81);

Q2 = VectorAdd(Q2a,Q2b);
Q2 = VectorAdd(Q2,Q2c);
Q2 = VectorAddFinish(Q2);

disp(['----------------']);
disp(['Q2 to T1: ',num2str(VectorCosDist(Q2,T1))]);
disp(['Q2 to T2: ',num2str(VectorCosDist(Q2,T2))]);
disp(['Q2 to T3: ',num2str(VectorCosDist(Q2,T3))]);
disp(['Q2 to T4: ',num2str(VectorCosDist(Q2,T4))]);

% encode Q3
Q3a = VectorMult(VectorRot(D25,3,1),VectorRot(D33,2,1));
Q3a = VectorMult(Q3a,VectorRot(D41,1,1));
Q3a = VectorMult(Q3a,D49);

Q3b = VectorMult(VectorRot(D69,2,1),VectorRot(D73,1,1));
Q3b = VectorMult(Q3b,D77);

Q3c = VectorMult(VectorRot(D81,1,1),D83);

Q3 = VectorAdd(Q3a,Q3b);
Q3 = VectorAdd(Q3,Q3c);
Q3 = VectorAddFinish(Q3);

disp(['----------------']);
disp(['Q3 to T1: ',num2str(VectorCosDist(Q3,T1))]);
disp(['Q3 to T2: ',num2str(VectorCosDist(Q3,T2))]);
disp(['Q3 to T3: ',num2str(VectorCosDist(Q3,T3))]);
disp(['Q3 to T4: ',num2str(VectorCosDist(Q3,T4))]);

% encode Q4
Q4a = VectorMult(VectorRot(D26,1,1),D34);

Q4b = VectorMult(VectorRot(D69,1,1),D73);

Q4c = VectorMult(VectorRot(D81,1,1),D83);

Q4 = VectorAdd(Q4a,Q4b);
Q4 = VectorAdd(Q4,Q4c);
Q4 = VectorAddFinish(Q4);

disp(['----------------']);
disp(['Q4 to T1: ',num2str(VectorCosDist(Q4,T1))]);
disp(['Q4 to T2: ',num2str(VectorCosDist(Q4,T2))]);
disp(['Q4 to T3: ',num2str(VectorCosDist(Q4,T3))]);
disp(['Q4 to T4: ',num2str(VectorCosDist(Q4,T4))]);

toc;