% This code can be run to process the large 10M traj dataset

opengl('save', 'software')
InitGlobalVars;
load(['C:\Users\LocalAdmin\Downloads\moredata\CCT1SyntheticData25.mat']);
CreateTrajStr;
size(trajStrData,2);
ConstructCCTGonzLite;