function frechet_init(P,Q)
%--function to initialize data structures for frechet_decide and
%--frechet_compute
global I J lP lQ lPQ bP bQ
[M,N]=size(P);
if M~=2, error('P must be a 2 by I array'); end
if (I ~= N), error('P must be a 2 by I array'); end
[M,N]=size(Q);
if M~=2, error('Q must be a 2 by J array'); end
if (J ~= N), error('Q must be a 2 by J array'); end
for i=1:I-1
    xp = P(1,i); yp = P(2,i);
    xp1 = P(1,i+1); yp1 = P(2,i+1);
    lP(i) = (xp1-xp)^2 + (yp1-yp)^2;  %--length^2 of the ith segment of P
end
for j=1:J-1
    xq = Q(1,j); yq = Q(2,j);
    xq1 = Q(1,j+1); yq1 = Q(2,j+1);
    lQ(j) = (xq1-xq)^2 + (yq1-yq)^2;  %--length^2 of the jth segment of Q
end
for i=1:I
    xp = P(1,i); yp = P(2,i);
    for j=1:J
        xq = Q(1,j); yq = Q(2,j);
        lPQ(i,j) = (xq-xp)^2 + (yq-yp)^2;  %--length^2 of P->Q link
    end
end
%--Interior
for i=1:I-1
    xp = P(1,i); yp = P(2,i);
    xp1 = P(1,i+1); yp1 = P(2,i+1);    
    for j=1:J-1
        xq = Q(1,j); yq = Q(2,j);
        xq1 = Q(1,j+1); yq1 = Q(2,j+1);
        bP(i,j) = 2*((xp-xq)*(xp1-xp)+(yp-yq)*(yp1-yp));
        bQ(i,j) = 2*((xq-xp)*(xq1-xq)+(yq-yp)*(yq1-yq));
    end
end
%--Top row
xp = P(1,I); yp = P(2,I);
for j=1:J-1
    xq = Q(1,j); yq = Q(2,j);
    xq1 = Q(1,j+1); yq1 = Q(2,j+1);
    bQ(I,j) = 2*((xq-xp)*(xq1-xq)+(yq-yp)*(yq1-yq));
end
%--Right column
xq = Q(1,J); yq = Q(2,J);
for i=1:I-1
    xp = P(1,i); yp = P(2,i);
    xp1 = P(1,i+1); yp1 = P(2,i+1);
    bP(i,J) = 2*((xp-xq)*(xp1-xp)+(yp-yq)*(yp1-yp));
end
%--Top Right cell
xp = P(1,I-1); yp = P(2,I-1);
xp1 = P(1,I); yp1 = P(2,I);
xq = Q(1,J-1); yq = Q(2,J-1);
xq1 = Q(1,J); yq1 = Q(2,J);
bP(I,J) = 2*((xp-xq1)*(xp1-xp)+(yp-yq1)*(yp1-yp));
bQ(I,J) = 2*((xq-xp1)*(xq1-xq)+(yq-yp1)*(yq1-yq));
return


