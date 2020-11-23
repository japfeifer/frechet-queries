%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Baraka Maiseli
% Contact: barakamaiseli@yahoo.com
% Date   : 15th March, 2017
% Version: 1.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Determine where your m-file's folder is.
folder = fileparts(which(mfilename)); 
% % Add that folder plus all subfolders to the path.
addpath(genpath(folder));
h = waitbar(0,'Please wait shortly...');
method = 'euclidean';
%%%%%%%%%%%%%%%%%%%%%%%% Original Fish datasets %%%%%%%%%%%%%%%%%%%%%%%%%%%
load('A_Fish_original.mat');
load('B_Fish_original.mat');
K11 = 3.00;
[ hdFish1 ] = computeHD( A, B, method); % Original Hausdorff distance
[ rhdFish1 ] = robustHD( A, B, K11, method); % Robust Hausdorff distance
[ mhdFish1 ] = ModHausdorffDist( A, B ); % Modified Hausdorff distance by Dubuisson and Jain                                        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% Fish datasets with outliers %%%%%%%%%%%%%%%%%%%%%%%%
K12 = 3.00; % Gives rhdFish = 2.0279. (Best option for outliers)
load('A_Fish_outlier.mat');
load('B_Fish_outlier.mat');
[ hdFish2 ] = computeHD( A, B, method); % Original Hausdorff distance
[ rhdFish2 ] = robustHD( A, B, K12, method); % Modified Hausdorff distance
[ mhdFish2 ] = ModHausdorffDist( A, B ); % Modified Hausdorff distance (MHD) by Dubuisson and Jain
rc22 = (abs((mhdFish2 - mhdFish1)/mhdFish1))*100;
rc23 = (abs((rhdFish2 - rhdFish1)/rhdFish1))*100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Original Chinese characters datasets %%%%%%%%%%%%%%%%%%%
load('A_Chinese_original.mat');
load('B_Chinese_original.mat');
K21 = 55; % K2 = 3 gives rhdChinese = 1.9699
[ hdChinese1 ] = computeHD( A, B, method); % Original Hausdorff distance
[ rhdChinese1 ] = robustHD( A, B, K21, method);% Modified Hausdorff distance
[ mhdChinese1 ] = ModHausdorffDist( A, B ); % Modified Hausdorff distance (MHD) by Dubuisson and Jain                                          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Chinese characters with outliers %%%%%%%%%%%%%%%%%%%%%%%
% K22 = 3; % Gives rhdChinese = 2.4039.
K22 = 2.5; % Gives rhdChinese = 2.0024. (Best option for outliers)
load('A_Chinese_outlier.mat');
load('B_Chinese_outlier.mat');
[ hdChinese2 ] = computeHD( A, B, method); % Original Hausdorff distance
[ rhdChinese2 ] = robustHD( A, B, K22, method);% Robust Hausdorff distance
[ mhdChinese2 ] = ModHausdorffDist( A, B ); % Modified Hausdorff distance (MHD) by Dubuisson and Jain
rc32 = (abs((mhdChinese2 - mhdChinese1)/mhdChinese1))*100;
rc33 = (abs((rhdChinese2 - rhdChinese1)/rhdChinese1))*100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% Original Elephant %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% K3 = 3 gives rhdElephant = 6.4851.
K31 = 37; % gives rhdElephant = 6.4974.
load('A_Elephant_original.mat');
load('B_Elephant_original.mat');
[ hdElephant1 ] = computeHD( A, B, method); % Original Hausdorff distance
[ rhdElephant1 ] = robustHD( A, B, K31, method);% Robust Hausdorff distance
[ mhdElephant1 ] = ModHausdorffDist( A, B ); % Modified Hausdorff distance (MHD) by Dubuisson and Jain
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% Elephant with outliers %%%%%%%%%%%%%%%%%%%%%%%%%%
load('A_Elephant_outlier.mat');
load('B_Elephant_outlier.mat');
K32 = 8.20; % K3 = 3 gives rhdElephant = 6.4851.
[ hdElephant2 ] = computeHD( A, B, method); % Original Hausdorff distance
[ rhdElephant2 ] = robustHD( A, B, K32, method);% Modified Hausdorff distance
[ mhdElephant2 ] = ModHausdorffDist( A, B ); % Modified Hausdorff distance (MHD) by Dubuisson and Jain    
rc42 = (abs((mhdElephant2 - mhdElephant1)/mhdElephant1))*100;
rc43 = (abs((rhdElephant2 - rhdElephant1)/rhdElephant1))*100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
waitbar(1/ 3);
%%%%%%%%%%%%%%%%%%%%%%%%%%% Original Butterfly %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% K5 = 3; % Gives rhdButterfly = 32.0786
K51 = 59; % Gives rhdButterfly = 32.1056
load('A_Butterfly_original.mat');
load('B_Butterfly_original.mat');
[ hdButterfly1 ] = computeHD( A, B, method); % Original Hausdorff distance
[ rhdButterfly1 ] = robustHD( A, B, K51, method);% Robust Hausdorff distance
[ mhdButterfly1 ] = ModHausdorffDist( A, B ); % Modified Hausdorff distance (MHD) by Dubuisson and Jain                                              
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Bird with outliers %%%%%%%%%%%%%%%%%%%%%%%%%%%
load('A_Butterfly_outlier.mat');
load('B_Butterfly_outlier.mat');
K52 = 46.00; % K5 = 3 gives rhdButterfly = 31.2055.
[ hdButterfly2 ] = computeHD( A, B, method); % Original Hausdorff distance
[ rhdButterfly2 ] = robustHD( A, B, K52, method);% Modified Hausdorff distance
[ mhdButterfly2 ] = ModHausdorffDist( A, B ); % Modified Hausdorff distance (MHD) by Dubuisson and Jain
rc52 = (abs((mhdButterfly2 - mhdButterfly1)/mhdButterfly1))*100;
rc53 = (abs((rhdButterfly2 - rhdButterfly1)/rhdButterfly1))*100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Original Bird %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('A_Bird_original.mat');
load('B_Bird_original.mat');
K41 = 46; % Gives rhdBird = 35.1459
% K4 = 3;  % Gives rhdBird = 35.1034
[ hdBird1 ] = computeHD( A, B, method); % Original Hausdorff distance
[ rhdBird1 ] = robustHD( A, B, K41, method);% Modified Hausdorff distance
[ mhdBird1 ] = ModHausdorffDist( A, B ); % Modified Hausdorff distance (MHD) by Dubuisson and Jain
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Bird with outliers %%%%%%%%%%%%%%%%%%%%%%%%%%%
load('A_Bird_outlier.mat');
load('B_Bird_outlier.mat');
K42 = 53.00;
[ hdBird2 ] = computeHD( A, B, method); % Original Hausdorff distance
[ rhdBird2 ] = robustHD( A, B, K42, method);% Modified Hausdorff distance
[ mhdBird2 ] = ModHausdorffDist( A, B ); % Modified Hausdorff distance (MHD) by Dubuisson and Jain
rc72 = (abs((mhdBird2 - mhdBird1)/mhdBird1))*100;
rc73 = (abs((rhdBird2 - rhdBird1)/rhdBird1))*100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
waitbar(2/ 3);
%%%%%%%%%%%%%%%%%%%% Butterfly with outliers and noise %%%%%%%%%%%%%%%%%%%%
load('A_Butterfly_outlier_noise.mat');
load('B_Butterfly_outlier_noise.mat');
K6 = 2.90; % K5 = 3 gives rhdButterfly = 31.2055.
[ hdButterfly3 ] = computeHD( A, B, method); % Original Hausdorff distance
[ rhdButterfly3 ] = robustHD( A, B, K6, method);% Modified Hausdorff distance
[ mhdButterfly3 ] = ModHausdorffDist( A, B ); % Modified Hausdorff distance (MHD) by Dubuisson and Jain     
rc62 = (abs((mhdButterfly3 - mhdButterfly1)/mhdButterfly1))*100;
rc63 = (abs((rhdButterfly3 - rhdButterfly1)/rhdButterfly1))*100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
waitbar(3/ 3);
close(h)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Summary %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% Scenes without outliers %%%%%%%%%%%%%%%%%%%%%%%%%%%
rows = 7; cols = 3;
resultsTable4 = cell(rows,cols);
resultsTable4{1,1} = 'Scene';
resultsTable4{1,2} = 'MHD (% error)';
resultsTable4{1,3} = 'RHD (% error)';
resultsTable4{2,1} = 'Fish';
resultsTable4{2,2} = rc22;
resultsTable4{2,3} = rc23;
resultsTable4{3,1} = 'Chinese character';
resultsTable4{3,2} = rc32;
resultsTable4{3,3} = rc33;
resultsTable4{4,1} = 'Elephant';
resultsTable4{4,2} = rc42;
resultsTable4{4,3} = rc43;
resultsTable4{5,1} = 'Butterfly-1';
resultsTable4{5,2} = rc52;
resultsTable4{5,3} = rc53;
resultsTable4{6,1} = 'Butterfly-2';
resultsTable4{6,2} = rc62;
resultsTable4{6,3} = rc63;
resultsTable4{7,1} = 'Bird';
resultsTable4{7,2} = rc72;
resultsTable4{7,3} = rc73;
save('resultsTable4.mat','resultsTable4');
disp('Results of errors generated by MHD and RHD are stored in a variable resultsTable4.mat');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
