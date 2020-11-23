function hDist = HausdorffDistSum(P,Q)

    % Computes the discrete Sum Hausdorff distance between two curves P and Q.
    % i.e. does not compute any distances from a point to thhe interior of an edge

    pairwiseDist = pdist2(P,Q);
    hpq = sum(min(pairwiseDist,[],2));  % dist from p to q
    hqp = sum(min(pairwiseDist));  % dist from q to p
    hDist = sum([hpq,hqp]); % choose the max of the two directed distances

end
