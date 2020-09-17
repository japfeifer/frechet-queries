% Majority vote classifier

classifierRes = [];
for i=1:size(testMat,1)
    M = []; % result goes into M
    
    % for each kNN predictor, compute the word id that occurs the
    % most times. For ties, choose the one that has the lowest k-value.
    for j=1:size(testMat,2) / kCurr 
        a = [testMat(i,j*kCurr-(kCurr-1):j*kCurr)'];  
        b = (1:size(a,1))';
        c = [];
        for k=1:size(a,1)
            c = [c; sum(a(:) == a(k,1))];
        end
        d = [a b c];
        d = sortrows(d, [3 2], {'descend' 'ascend'});
        M = [M; d(1,1)];
    end
    
    % now we have results for each predictor, so just choose word that
    % occurs the most times
    M = mode(M);  
    classifierRes(end+1,:) = M;  % final kNN majority vote result
    
%     tmp = [];
%     for j=1:size(testMat,2) / kCurr % for each k=kCurr kNN predictor
%         tmp = [tmp testMat(i,j*kCurr-(kCurr-1):j*kCurr)'];  % transpose it for the mode function
%     end
%     [M,F] = mode(tmp); % find the most frequently occuring answer, for each kNN predictor
%     for j=1:size(F,2)
%         if F(1,j) == 1 % all three kNN's are different
%             M(1,j) = tmp(1,j); % so make sure to choose the 1st-NN (mode just choses the lowest value)
%         end
%     end
%     M = mode(M'); % transpose the predictor results for the mode function
%     classifierRes(end+1,:) = M;  % final kNN majority vote result
end
