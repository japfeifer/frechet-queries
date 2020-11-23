function hDist = HausdorffDist(P,Q)

    % Computes the discrete Hausdorff distance between two curves P and Q.
    % i.e. does not compute any distances from a point to thhe interior of an edge
    
    % code taken from: https://www.mathworks.com/matlabcentral/fileexchange/56336-hausdorffdist-a-b
    
    pairwiseDist = pdist2(P,Q);
    hpq = max(min(pairwiseDist,[],2));  % dist from p to q
    hqp = max(min(pairwiseDist));  % dist from q to p
    hDist = max([hpq,hqp]); % choose the max of the two directed distances

end
