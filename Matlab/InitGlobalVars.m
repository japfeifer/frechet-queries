clear all;
addpath('Continuous Frechet');
addpath('MexCode');

opengl('save', 'software')

global numCFD numDP clusterNode clusterTrajNode currNodeID trajData totNode h doDFD
global distMap trajDistMatrix queryTraj
global clusterCenterIteration clusterRSize clusterHistCenterMap histPrevCenterRSize 
global tau prunedNodes nodeCheckCnt leafTrajIDList eAdd
global I J lP lQ lPQ bP bQ currBestLowNodeDist prevLowestUpBnd bndTstLst
global currNodeList nextNodeList eMult distCalcCnt
global clusterPointNode clusterPointNodeToID pointPrunedNodes randPts 
global randPtsBallRad soMap coordSz vertexMap ballSet trajHyperVector
global clusterHVNode clusterHVNodeToID stopCheckNodes currBestUpNodeDist
global linLBcnt linUBcnt conLBcnt
global timeConstLB timeLinLB timeLinUB genQueryType reachPercent numDim
global cntConLB cntNF cntBBUB cntADF cntADFR cntADFD cntInClus cntBBUBConst cntBBUBLin cntUBClust
global kthBestUB tmpCCT tmpCCTDepth lowClustRad dendroOverlapList numQueryTraj
global kUBList kNum
global searchStat s1Stat s2Stat resStat allNodesCnt
global numFurthestCFD numSplitCFD szNode trajOverlapNodesCnt trajOverlapList
global Bk Ak S1 S2 rnnSearchResults numInsCFD numInsDP insertTrajData overlapWeight
global mTree mTreeRootId mTreeNodeCapacity mTreePtrList mTreeMaxCol
global trainSet trainSet2 querySet CompMoveData 
global tEncode timeEncode tHV timeHV nodeVisitCnt overrideLM implicitErrorFlg ConstructCCTType
global querySetKFold currHMTrainSet numCoordCurr classifierCurr numTrainDistComp numTestDistComp overrideNTURGBD

global time2 time3 time4 t2 t3 t4 t5 t6 time5Sum time6Sum
global trajStrData queryStrData
global inpTrajVert inpTrajPtr inpTrajErr inpTrajErrF inpTrajSz inP simpLevelCCT inpLen
global sCellCheck sDPCalls sSPVert PNN

global decimalPrecision

decimalPrecision = 1e-8;