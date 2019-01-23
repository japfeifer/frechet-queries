function sol_len = frechet_compute(P,Q,prntflg)
%-- function to compute the frechet distance between two polygonal curves
%--modified:    1-May-2012  To include other edge cases in type A missed in
%                           Alt and Godau
global I J lP lQ lPQ bP bQ
[M,N]=size(P);
if M~=2, error('P must be a 2 by I array'); end
if (I ~= N), error('P must be a 2 by I array'); end
[M,N]=size(Q);
if M~=2, error('Q must be a 2 by J array'); end
if (J ~= N), error('Q must be a 2 by J array'); end
%--type A critical values
%E1(1) = sqrt(lPQ(1,1)); %--starting length
%E1(2) = sqrt(lPQ(I,J)); %--ending length
E1 = sqrt(reshape(lPQ,1,I*J));
%ecount = 2;
ecount = I*J;
cnt1=0;
cnt2=0;
LsortedE=0;
LsortedE2=0;
%--type B critical values
for i = 1:I-1
    ap = lP(i);
    for j=1:J-1
        aq = lQ(j);
        bp = bP(i,j);
        tst = -bp/(2*ap);
        if (tst>=0)&(tst<=1)
            ecount = ecount + 1;
            E1(ecount) = sqrt(-((.5*bp)^2/ap)+lPQ(i,j));
        end
        bq = bQ(i,j);
        tst = -bq/(2*aq);
        if (tst>=0)&(tst<=1)
            ecount = ecount + 1;
            E1(ecount) = sqrt(-((.5*bq)^2/aq)+lPQ(i,j));
        end
    end
end
%--First Pass:
%--sort critical values and test using frechet_decide to bound the length,
%--the result is a pseudometric (satisfies the triangle inequality), but
%--not yet a true metric (see Alt and Godau)
[sortedE indx] = sort(E1);
sortedE = round(sortedE,10)+0.00000000009; % getting rounding errors, this fixes it
sortedE = unique(sortedE);
last_len = sortedE(1);
last_decide = frechet_decide_RevA(P,Q,last_len,0,0);
if last_decide==0
    %--the shortest critical distance is not long enough, look for a longer
    %--one
    LsortedE = length(sortedE);
    for i=2:LsortedE
       len = sortedE(i);
       decide = frechet_decide_RevA(P,Q,len,0,0);
       cnt1=cnt1+1;
       if decide==1
           %--the frechet distance has been bracketed
           min_len = last_len;
           max_len = len;
           break;
       else
           last_len = len;
       end
    end
    %--check the longest critical distance (no break encountered)
    if decide==0
        %--the longest critical distance is not long enough
        min_len = len;
        max_len = Inf;
    end
else
    %--the shortest critical distance is long enough
    max_len = last_len;
    min_len = 0;
end
% disp(['min len: ',num2str(min_len),', max len:',num2str(max_len)]);
%fprintf('after the first pass: %f < len <= %f\n',min_len,max_len);
if max_len<Inf
    soln_len = max_len;
else
    sol_len = NaN;
end
%--Second Pass:
%--look for critical values that open up a monotone increasing path from
%--start to end. This is brute force and not efficient (see Alt and Godau).
ecount = 0; E2 = []; sortedE = [];
for i=1:I-1 %--looking for a_i,j = b_i,k for some k>j (see Alt and Godau)
    xp = P(1,i); yp = P(2,i);
    xp1 = P(1,i+1); yp1 = P(2,i+1);    
    for j=1:J-1
        xq = Q(1,j); yq = Q(2,j);
        xq1 = Q(1,j+1); yq1 = Q(2,j+1);
        for k=j+1:J
            den = bP(i,j)-bP(i,k);
            if den~=0
                u1 = (lPQ(i,k)-lPQ(i,j))/den;
                if (u1>=0)&(u1<=1)
                    xu = xp + u1*(xp1-xp); yu = yp + u1*(yp1-yp);
                    tst = sqrt((xu-xq)^2 + (yu-yq)^2);
                    if (tst>min_len)&(tst<max_len)
                        ecount = ecount + 1;
                        E2(ecount) = tst;
                    end
                end
            end
        end
    end
end
for j=1:J-1 %--looking for c_i,j = d_k,j for some k>i (see Alt and Godau)
    xq = Q(1,j); yq = Q(2,j);
    xq1 = Q(1,j+1); yq1 = Q(2,j+1);
    for i=1:I-1
        xp = P(1,i); yp = P(2,i);
        xp1 = P(1,i+1); yp1 = P(2,i+1);
        for k=i+1:I
            den = bQ(i,j)-bQ(k,j);
            if den~=0
                u2 = (lPQ(k,j)-lPQ(i,j))/den;
                if (u2>=0)&(u2<=1)
                    xu = xq + u2*(xq1-xq); yu = yq + u2*(yq1-yq);
                    tst = sqrt((xu-xp)^2 + (yu-yp)^2);
                    if (tst>min_len)&(tst<max_len)
                        ecount = ecount + 1;
                        E2(ecount) = tst;
                    end
                end
            end
        end
    end
end
%-- sort the results: the shortest one that passes frechet_decide is the 
%-- frechet distance
if ~isempty(E2)
    [sortedE indx] = sort(E2);
    sortedE = round(sortedE,10)+0.00000000009; % getting rounding errors, this fixes it
    sortedE = unique(sortedE);
    LsortedE2 = length(sortedE);
    for i=1:LsortedE2
        len = sortedE(i);
        decide = frechet_decide_RevA(P,Q,len,0,0);
        cnt2=cnt2+1;
        if decide==1
            %--the frechet distance has been found
            sol_len = fix(len * 10^10)/10^10;
            if prntflg==1
                fprintf('in the 2nd pass: len = %f \n',sol_len);
                disp(['found frechet in 2nd pass, cnt1: ',num2str(cnt1), ...
                    ' cnt2: ',num2str(cnt2),', LsortedE: ',num2str(LsortedE), ...
                    ', LsortedE2: ',num2str(LsortedE2), ...
                    ', Frechet dist: ',num2str(sol_len)]);
            end
            return
        end
    end
    %--frechet not found in the list if no return
end
sol_len = fix(max_len * 10^10)/10^10;
       
if prntflg==1
    disp(['found frechet in 1st pass, cnt1: ',num2str(cnt1), ...
                ' cnt2: ',num2str(cnt2),', LsortedE: ',num2str(LsortedE), ...
                ', LsortedE2: ',num2str(LsortedE2), ...
                ', Frechet dist: ',num2str(sol_len)]);
end
%--frechet not found in the list: length from the first pass is it
if prntflg==1
fprintf('frechet distance not found in the 2nd pass: len = %f \n',sol_len);
end
return





    