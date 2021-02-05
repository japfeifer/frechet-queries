Qid = 10;
Q = queryStrData(Qid).traj;

disp(['---------------']);
d1 = ContFrechet(inP(queryStrData(Qid).subschain:queryStrData(Qid).subechain , :), Q);
disp(['d1: ',num2str(d1)]);

d2 = ContFrechet(inP(queryStrData(Qid).subsvert:queryStrData(Qid).subevert , :), Q);
disp(['d2: ',num2str(d2)]);

d3 = ContFrechet(inP(1:167 , :), Q);
disp(['d3: ',num2str(d3)]);