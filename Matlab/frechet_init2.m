function frechet_init2(P,Q)

%--function to initialize data structures for frechet_decide and
%--frechet_compute
global I J lP lQ lPQ bP bQ
% dfcn1 = @(u,v) sum((u-v).^2);
% dfcn2 = @(u,v,w) 2*(sum((u-w).*(v-u)));
[M,N]=size(P);
if M<2, error('P must be a d by I array where d >= 2'); end
if (I ~= N), error('P must be a d by I array'); end
[M,N]=size(Q);
if M<2, error('Q must be a d by I array where d >= 2'); end
if (J ~= N), error('Q must be a d by J array'); end

bP=[];bQ=[];lPQ=[];
bP(1:I-1,1:J-1)=NaN;
bQ(1:I-1,1:J-1)=NaN;
lPQ(1:I,1:J)=NaN;
lP(1:I-1)=NaN;
lQ(1:J-1)=NaN;

for i=1:I-1
    lP(i) = Dfcn1(P(:,i),P(:,i+1)); %--length^2 of the ith segment of P
end
for j=1:J-1
    lQ(j) = Dfcn1(Q(:,j),Q(:,j+1)); %--length^2 of the jth segment of Q
end
for i=1:I
    for j=1:J
        lPQ(i,j) = Dfcn1(P(:,i),Q(:,j)); %--length^2 of P->Q link
    end
end
%--Interior
for i=1:I-1  
    for j=1:J-1
        bP(i,j) = Dfcn2(P(:,i),P(:,i+1),Q(:,j));
        bQ(i,j) = Dfcn2(Q(:,j),Q(:,j+1),P(:,i));
    end
end
%--Top row
for j=1:J-1
    bQ(I,j) = Dfcn2(Q(:,j),Q(:,j+1),P(:,I));
end
%--Right column
for i=1:I-1
    bP(i,J) = Dfcn2(P(:,i),P(:,i+1),Q(:,J));
end
%--Top Right cell
bP(I,J) = Dfcn2(P(:,I-1),P(:,I),Q(:,J));
bQ(I,J) = Dfcn2(Q(:,J-1),Q(:,J),P(:,I));
return

end


