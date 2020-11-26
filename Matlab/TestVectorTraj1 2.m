% Test vectors containing trajectory movements

tic

coordSz = 10000;

% up, down, left, right traj vectors
U = VectorCreate(coordSz);
D = VectorCreate(coordSz);
L = VectorCreate(coordSz);
R = VectorCreate(coordSz);

% multiple traj going up/down
UD = VectorAdd(U,D);
UD = VectorAddFinish(UD);

% multiple traj going left/right
LR = VectorAdd(L,R);
LR = VectorAddFinish(LR);

% multiple traj going every direction - up, down, left, right
UDLR = VectorAdd(U,D);
UDLR = VectorAdd(UDLR,L);
UDLR = VectorAdd(UDLR,R);
UDLR = VectorAddFinish(UDLR);

% traj going one direction, then another
LU = VectorMult(VectorRot(L,1,1),U);
RU = VectorMult(VectorRot(R,1,1),U);
LD = VectorMult(VectorRot(L,1,1),D);
RD = VectorMult(VectorRot(R,1,1),D);

% Q1 contains 4 traj going up, one going right
Q1 = VectorAdd(U,U);
Q1 = VectorAdd(Q1,U);
Q1 = VectorAdd(Q1,U);
Q1 = VectorAdd(Q1,R);
Q1 = VectorAddFinish(Q1);
disp(['----------------']);
disp(['Q1 to U: ',num2str(VectorCosDist(Q1,U))]);
disp(['Q1 to D: ',num2str(VectorCosDist(Q1,D))]);
disp(['Q1 to L: ',num2str(VectorCosDist(Q1,L))]);
disp(['Q1 to R: ',num2str(VectorCosDist(Q1,R))]);

% Q2 contains 2 traj going down, one right, one left
Q2 = VectorAdd(D,D);
Q2 = VectorAdd(Q2,R);
Q2 = VectorAdd(Q2,L);
Q2 = VectorAddFinish(Q2);
disp(['----------------']);
disp(['Q2 to U: ',num2str(VectorCosDist(Q2,U))]);
disp(['Q2 to D: ',num2str(VectorCosDist(Q2,D))]);
disp(['Q2 to L: ',num2str(VectorCosDist(Q2,L))]);
disp(['Q2 to R: ',num2str(VectorCosDist(Q2,R))]);

% Q3 contains 4 up, 3 down, 1 right
Q3 = VectorAdd(D,D);
Q3 = VectorAdd(Q3,D);
Q3 = VectorAdd(Q3,U);
Q3 = VectorAdd(Q3,U);
Q3 = VectorAdd(Q3,U);
Q3 = VectorAdd(Q3,U);
Q3 = VectorAdd(Q3,R);
Q3 = VectorAddFinish(Q3);
disp(['----------------']);
disp(['Q3 to U: ',num2str(VectorCosDist(Q3,U))]);
disp(['Q3 to D: ',num2str(VectorCosDist(Q3,D))]);
disp(['Q3 to L: ',num2str(VectorCosDist(Q3,L))]);
disp(['Q3 to R: ',num2str(VectorCosDist(Q3,R))]);
disp(['Q3 to UD: ',num2str(VectorCosDist(Q3,UD))]);
disp(['Q3 to LR: ',num2str(VectorCosDist(Q3,LR))]);
disp(['Q3 to UDLR: ',num2str(VectorCosDist(Q3,UDLR))]);

% Q4 contains 3 up, 2 down, 1 right, 2 left
Q4 = VectorAdd(U,U);
Q4 = VectorAdd(Q4,U);
Q4 = VectorAdd(Q4,D);
Q4 = VectorAdd(Q4,D);
Q4 = VectorAdd(Q4,R);
Q4 = VectorAdd(Q4,L);
Q4 = VectorAdd(Q4,L);
Q4 = VectorAddFinish(Q4);
disp(['----------------']);
disp(['Q4 to UD: ',num2str(VectorCosDist(Q4,UD))]);
disp(['Q4 to LR: ',num2str(VectorCosDist(Q4,LR))]);
disp(['Q4 to UDLR: ',num2str(VectorCosDist(Q4,UDLR))]);

% Q5 - 4 traj LU, 1 traj RU
Q5 = VectorAdd(LU,LU);
Q5 = VectorAdd(Q5,LU);
Q5 = VectorAdd(Q5,LU);
Q5 = VectorAdd(Q5,RU);
Q5 = VectorAddFinish(Q5);
disp(['----------------']);
disp(['Q5 to LU: ',num2str(VectorCosDist(Q5,LU))]);
disp(['Q5 to RU: ',num2str(VectorCosDist(Q5,RU))]);

% sign language test
RF1 = VectorCreate(coordSz); % right finger 1
RF2 = VectorCreate(coordSz); % right finger 2
RF3 = VectorCreate(coordSz); % right finger 3
RF4 = VectorCreate(coordSz); % right finger 4
RTH = VectorCreate(coordSz); % right thumb
RH = VectorCreate(coordSz);  % right hand
LF1 = VectorCreate(coordSz); % left finger 1
LF2 = VectorCreate(coordSz); % left finger 2
LF3 = VectorCreate(coordSz); % left finger 3
LF4 = VectorCreate(coordSz); % left finger 4
LTH = VectorCreate(coordSz); % left thumb
LH = VectorCreate(coordSz);  % left hand
H = VectorCreate(coordSz);   % head

% encode sign for "sleep"
SLEEP = VectorAdd(VectorMult(RF1,D),VectorMult(RF2,D));
SLEEP = VectorAdd(SLEEP,VectorMult(RF3,D));
SLEEP = VectorAdd(SLEEP,VectorMult(RF4,D));
SLEEP = VectorAdd(SLEEP,VectorMult(RTH,U));
SLEEP = VectorAdd(SLEEP,VectorMult(RH,D));
SLEEP = VectorAdd(SLEEP,VectorMult(H,D));
SLEEP = VectorAddFinish(SLEEP);

% Q6 is exact same movement as SLEEP
Q6 = VectorAdd(VectorMult(RF1,D),VectorMult(RF2,D));
Q6 = VectorAdd(Q6,VectorMult(RF3,D));
Q6 = VectorAdd(Q6,VectorMult(RF4,D));
Q6 = VectorAdd(Q6,VectorMult(RTH,U));
Q6 = VectorAdd(Q6,VectorMult(RH,D));
Q6 = VectorAdd(Q6,VectorMult(H,D));
Q6 = VectorAddFinish(Q6);

% Q7 is missing the head movement from SLEEP
Q7 = VectorAdd(VectorMult(RF1,D),VectorMult(RF2,D));
Q7 = VectorAdd(Q7,VectorMult(RF3,D));
Q7 = VectorAdd(Q7,VectorMult(RF4,D));
Q7 = VectorAdd(Q7,VectorMult(RTH,U));
Q7 = VectorAdd(Q7,VectorMult(RH,D));
Q7 = VectorAddFinish(Q7);

% Q8 has a different RF4 movement than SLEEP
Q8 = VectorAdd(VectorMult(RF1,D),VectorMult(RF2,D));
Q8 = VectorAdd(Q8,VectorMult(RF3,D));
Q8 = VectorAdd(Q8,VectorMult(RF4,L));
Q8 = VectorAdd(Q8,VectorMult(RTH,U));
Q8 = VectorAdd(Q8,VectorMult(RH,D));
Q8 = VectorAdd(Q8,VectorMult(H,D));
Q8 = VectorAddFinish(Q8);

% Q9 has very different movements than SLEEP
Q9 = VectorAdd(VectorMult(RF1,D),VectorMult(RF2,L));
Q9 = VectorAdd(Q9,VectorMult(RF3,R));
Q9 = VectorAdd(Q9,VectorMult(RF4,U));
Q9 = VectorAdd(Q9,VectorMult(RTH,L));
Q9 = VectorAdd(Q9,VectorMult(RH,D));
Q9 = VectorAdd(Q9,VectorMult(H,L));
Q9 = VectorAdd(Q9,VectorMult(LH,D));
Q9 = VectorAdd(Q9,VectorMult(LTH,D));
Q9 = VectorAddFinish(Q9);

disp(['----------------']);
disp(['Q6 to SLEEP: ',num2str(VectorCosDist(Q6,SLEEP))]);
disp(['Q7 to SLEEP: ',num2str(VectorCosDist(Q7,SLEEP))]);
disp(['Q8 to SLEEP: ',num2str(VectorCosDist(Q8,SLEEP))]);
disp(['Q9 to SLEEP: ',num2str(VectorCosDist(Q9,SLEEP))]);

toc;
