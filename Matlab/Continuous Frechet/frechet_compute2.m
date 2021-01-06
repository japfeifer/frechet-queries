function sol_len = frechet_compute2(P,Q,prntflg,upBnd,lowBnd,bndCutFlg)
%-- function to compute the frechet distance between two polygonal curves
%--modified:    1-May-2012  To include other edge cases in type A missed in
%                           Alt and Godau
global I J lP lQ lPQ bP bQ

dfcn1 = @(a,b,c,d) sqrt(sum(((a+b.*(c-a))-d).^2));

if ~exist('bndCutFlg','var')
    bndCutFlg = 1;
end
    
upBnd = round(upBnd,10)+0.00000000009; % getting rounding errors, this fixes it
lowBnd = round(lowBnd,10)+0.00000000009; % getting rounding errors, this fixes it

[M,N]=size(P);
if M<2, error('P must be a d by I array where d >= 2'); end
if (I ~= N), error('P must be a d by I array'); end
[M,N]=size(Q);
if M<2, error('Q must be a d by I array where d >= 2'); end
if (J ~= N), error('Q must be a d by J array'); end
E1 = sqrt(reshape(lPQ,1,I*J));
ecount = I*J;
cnt1=0;
cnt2=0;
LsortedE=0;
LsortedE2=0;

timeOldFreDP = 0;

%--type B critical values

for i = 1:I-1
    ap = lP(i);
    for j=1:J-1
        aq = lQ(j);
        bp = bP(i,j);
        tst = -bp/(2*ap);
        if (tst>=0)&&(tst<=1) && (-((.5*bp)^2/ap)+lPQ(i,j)) > 0
            ecount = ecount + 1;
            E1(ecount) = sqrt(-((.5*bp)^2/ap)+lPQ(i,j));
        end
        bq = bQ(i,j);
        tst = -bq/(2*aq);
        if (tst>=0)&&(tst<=1) && (-((.5*bq)^2/aq)+lPQ(i,j)) > 0
            ecount = ecount + 1;
            E1(ecount) = sqrt(-((.5*bq)^2/aq)+lPQ(i,j));
        end
    end
end
%--First Pass:
%--sort critical values and test using frechet_decide to bound the length,
%--the result is a pseudometric (satisfies the triangle inequality), but
%--not yet a true metric (see Alt and Godau)

% E1 = E1(E1 ~= 0); % remove zeros
E1 = round(E1,10)+0.00000000009; % getting rounding errors, this fixes it
E1 = unique(E1);
E1(E1 < lowBnd | E1 > upBnd) = []; % reduce the list by the up/lower bounds
[sortedE indx] = sort(E1);
LsortedE = length(sortedE);

[decide,min_len,max_len,cnt1] = FrechetDecideBinSearch(P,Q,sortedE,bndCutFlg);

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
%
                            
ecount = 0; E2 = []; sortedE = [];

% E2(1:min(100000,I*J*J)) = 0;

for i=1:I-1 %--looking for a_i,j = b_i,k for some k>j (see Alt and Godau)   
    for j=1:J-1
        for k=j+1:J
            den = bP(i,j)-bP(i,k);
            if den~=0
                u1 = (lPQ(i,k)-lPQ(i,j))/den;
                if (u1>=0)&&(u1<=1)
%                     tst = dfcn1(P(:,i),u1,P(:,i+1),Q(:,j));
                    tst = sqrt(sum(((P(:,i)+u1.*(P(:,i+1)-P(:,i)))-Q(:,j)).^2)); % this is faster
                    if (tst>min_len)&&(tst<max_len)
                        ecount = ecount + 1;
                        E2(ecount) = tst;
                    end
                end
            end
        end
    end
end

for j=1:J-1 %--looking for c_i,j = d_k,j for some k>i (see Alt and Godau)
    for i=1:I-1
        for k=i+1:I
            den = bQ(i,j)-bQ(k,j);
            if den~=0
                u2 = (lPQ(k,j)-lPQ(i,j))/den;
                if (u2>=0)&&(u2<=1)
%                     tst = dfcn1(Q(:,j),u2,Q(:,j+1),P(:,i));
                    tst = sqrt(sum(((Q(:,j)+u2.*(Q(:,j+1)-Q(:,j)))-P(:,i)).^2)); % this is faster
                    if (tst>min_len)&&(tst<max_len)
                        ecount = ecount + 1;
                        E2(ecount) = tst;
                    end
                end
            end
        end
    end
end

% if ecount < size(E2)
%     E2 = E2(1:ecount);
% end



%-- sort the results: the shortest one that passes frechet_decide is the 
%-- frechet distance
if ~isempty(E2)
    [sortedE indx] = sort(E2);
%     sortedE = sortedE(sortedE ~= 0); % remove zeros
    sortedE = round(sortedE,10)+0.00000000009; % getting rounding errors, this fixes it
    sortedE = unique(sortedE);
    LsortedE2 = length(sortedE);
    prev_max_len = max_len;
    
    [decide,min_len,max_len,cnt2] = FrechetDecideBinSearch(P,Q,sortedE,bndCutFlg);

    if decide==0
        max_len = prev_max_len; % set max_len to the previous
    else
        %--the frechet distance has been found
        sol_len = fix(max_len * 10^10)/10^10;
        if prntflg==1
            fprintf('in the 2nd pass: len = %f \n',sol_len);
            disp(['found frechet in 2nd pass, cnt1: ',num2str(cnt1), ...
                ' cnt2: ',num2str(cnt2),', LsortedE: ',num2str(LsortedE), ...
                ', LsortedE2: ',num2str(LsortedE2), ...
                ', Frechet dist: ',num2str(sol_len)]);
        end
        
        return
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





    