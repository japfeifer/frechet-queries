function [ rhd ] = robustHD( A, B, K, method)
%% ROBUSTHD  -- Computes Hausdorff Distance
%            -- The function is robust against outliers in the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% OUTPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      rhd     -- Robust Hausdorff distance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INPUTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       A     -- First point set; can be 1D, 2D, or 3D
%       B     -- Second point set; can be 1D, 2D, or 3D
% Note: Both sets A and B should have the same dimension. That is, 1D vs
% 1D; 2D vs 2D; and 3D vs 3D. The code may easily be extended to dimensions
% higher than 3D.
%       K     -- Tuning constant; Establishes a  tradeoff between fidelity
%                of results and smoothness of data
%  method     -- Selected metric for measuring distance:
%                abs: distance = |x2 - x1|
%              smape: distance = |x2 - x1|/(|x2| + |x1|)
%          Euclidean: distance = sqrt((x2 - x1)^2 + (y2 - y1)^2)
%                                for 2D sets
%                              = sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
%                                for 3D sets
%              quasi: (a) 2D sets
%                         distance = |x2 - x1| + (sqrt(2) - 1)*|y2 -y1|
%                                    if |x2 - x1| > |y2 - y1|
%                                  = (sqrt(2) - 1)*|x2 - x1| + |y2 - y1|
%                                    otherwise
%                     (b) 3D sets
%                         distance = |x2 - x1| + |y2 - y1| + (sqrt(2) -1)*|z2 - z1|
%                                    if |x2 - x1| > |z2 - z1| and |y2 - y1| > |z2 - z1|
%                                  = |x2 - x1| + (sqrt(2) -1)*|y2 - y1| + |z2 - z1|
%                                    if |x2 - x1| > |y2 - y1| and |z2 - z1| > |y2 - y1|
%                                  = (sqrt(2) - 1)*|x2 - x1| + |y2 - y1| + |z2 - z1|
%                                    if |y2 - y1| > |x2 - x1| and |z2 - z1| > |x2 - x1|
%          cityblock:  (a) 2D sets
%                          distance = |x2 - x1| + |y2 - y1|
%                      (b) 3D sets
%                          distance = |x2 - x1| + |y2 - y1| + |z2 - z1|
%         chessboard:  (a) 2D sets
%                          distance = max(|x2 - x1|,|y2 - y1|)
%                      (b) 3D sets
%                          distance = max(|x2 - x1|,|y2 - y1|,|z2 - z1|)
%  A, B, and K are input arguments are of type DOUBLE
%  rhd is returned as DOUBLE
%  'method' argument is of type STRING 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Author  : Baraka Jacob Maiseli
%%% Date    : 10 March, 2017
%%% Version : 1.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
if(isvector(A)&& isvector(B))
    storeA = zeros(length(A),1);
    storeB = zeros(length(B),1);
    for a=1:length(A) 
        P1 = bsxfun(@minus,repmat(A(a),length(B),1),B);
        P2 = bsxfun(@plus,repmat(A(a),length(B),1),B);
        switch method
            case 'abs'
                dab = min(min(abs(P1)));
            case 'smape'
                dab = min(min(abs(P1)./abs(P2)));
            otherwise
                error('Unknown method');
        end
    storeA(a) = dab;
    end
    for b=1:length(B)
        P1 = bsxfun(@minus,repmat(B(b),length(A),1),A);
        P2 = bsxfun(@plus,repmat(B(b),length(A),1),A);
        switch method
            case 'abs'
                dba = min(min(abs(P1)));
            case 'smape'
                dba = min(min(abs(P1)./abs(P2)));
            otherwise
                error('Unknown method');
        end
    storeB(b) = dba;
    end
elseif(size(A,2)==2 && size(B,2)==2)
    storeA = zeros(size(A,1),1);
    storeB = zeros(size(B,1),1);
    m = size(B,1); % Number of rows of set B
    n = size(A,1); % Number of rows of set A
    for a=1:n
            P = bsxfun(@minus,repmat(A(a,:),m,1),B);
            switch method
                case 'euclidean'
                        P = sqrt((P(:,1)).^2 + (P(:,2)).^2);
                case 'quasi'
                        mask = P(:,1)>P(:,2);
                        P =  mask.*(abs(P(:,1)) + (sqrt(2) - 1)*abs(P(:,2))) + ...
                            ~mask.*((sqrt(2) - 1)*abs(P(:,1)) + abs(P(:,2)));
                case 'cityblock'
                        P = abs(P(:,1)) + abs(P(:,2));   
                case 'chessboard'
                        P = max(P,[],2);
                otherwise
                        error('Unknown method');
            end
          dab = min(P);
    storeA(a) = dab;
    end
    for b=1:m
            Q = bsxfun(@minus,repmat(B(b,:),n,1),A);
            switch method
                case 'euclidean'
                        Q = sqrt((Q(:,1)).^2 + (Q(:,2)).^2);
                case 'quasi'
                        mask = Q(:,1)>Q(:,2);
                        Q =  mask.*(abs(Q(:,1)) + (sqrt(2) - 1)*abs(Q(:,2))) + ...
                            ~mask.*((sqrt(2) - 1)*abs(Q(:,1)) + abs(Q(:,2)));
                case 'cityblock'
                        Q = abs(Q(:,1)) + abs(Q(:,2)); 
                case 'chessboard'
                        Q = max(Q,[],2);
                otherwise
                        error('Unknown method');
            end
          dba = min(Q);
    storeB(b) = dba;
    end
elseif(size(A,2)==3 && size(B,2)==3)
    storeA = zeros(size(A,1),1);
    storeB = zeros(size(B,1),1);
    m = size(B,1); % Number of rows of set B
    n = size(A,1); % Number of rows of set A
    for a=1:n
            P = bsxfun(@minus,repmat(A(a,:),m,1),B);
            switch method
                case 'euclidean'
                        P = sqrt((P(:,1)).^2 + (P(:,2)).^2 + (P(:,3)).^2);
                case 'quasi'
                        mask1 = (P(:,1)>P(:,3)) & (P(:,2)>P(:,3));
                        mask2 = (P(:,1)>P(:,2)) & (P(:,3)>P(:,2));
                        mask3 = (P(:,2)>P(:,1)) & (P(:,3)>P(:,1));
                        P =  mask1.*(abs(P(:,1)) + abs(P(:,2)) + (sqrt(2) - 1)*abs(P(:,3))) + ...
                             mask2.*(abs(P(:,1)) + (sqrt(2) - 1)*abs(P(:,2)) + abs(P(:,3))) + ...
                             mask3.*((sqrt(2) - 1)*abs(P(:,1)) + abs(P(:,2)) + abs(P(:,3)));
                case 'cityblock'
                        P = abs(P(:,1)) + abs(P(:,2)) + abs(P(:,3));   
                case 'chessboard'
                        P = max(P,[],2);
                otherwise
                        error('Unknown method');
            end
          dab = min(P);
    storeA(a) = dab;
    end
    for b=1:m
            Q = bsxfun(@minus,repmat(B(b,:),n,1),A);
            switch method
                case 'euclidean'
                        Q = sqrt((Q(:,1)).^2 + (Q(:,2)).^2 + (Q(:,3)).^2);
                case 'quasi'
                        mask1 = (Q(:,1)>Q(:,3)) & (Q(:,2)>Q(:,3));
                        mask2 = (Q(:,1)>Q(:,2)) & (Q(:,3)>Q(:,2));
                        mask3 = (Q(:,2)>Q(:,1)) & (Q(:,3)>Q(:,1));
                        Q =  mask1.*(abs(Q(:,1)) + abs(Q(:,2)) + (sqrt(2) - 1)*abs(Q(:,3))) + ...
                             mask2.*(abs(Q(:,1)) + (sqrt(2) - 1)*abs(Q(:,2)) + abs(Q(:,3))) + ...
                             mask3.*((sqrt(2) - 1)*abs(Q(:,1)) + abs(Q(:,2)) + abs(Q(:,3)));
                case 'cityblock'
                        Q = abs(Q(:,1)) + abs(Q(:,2)) + abs(Q(:,3)); 
                case 'chessboard'
                        Q = max(Q,[],2);
                otherwise
                        error('Unknown method');
            end
          dba = min(Q);
    storeB(b) = dba;
    end    
else
    error('Dimensions of pairs of point sets should be equal. Also, only 1D, 2D, and 3D matrices are allowed.');
end
storeA = storeA.*(1./(1 + ([0;diff(storeA)]/K).^2));
storeB = storeB.*(1./(1 + ([0;diff(storeB)]/K).^2));
rhd = max(max(storeA),max(storeB));
end