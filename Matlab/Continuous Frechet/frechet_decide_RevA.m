function [decide] = frechet_decide_RevA(P,Q,len,plotFSD,printFSD)
%--solves the decision problem for Frechet distance
%--modified: 27 Apr 2012:  To compute data required in frechet_init
global I J lP lQ lPQ bP bQ 
[M,N]=size(P);
if M~=2, error('P must be a 2 by I array'); end
if (I ~= N), error('P must be a 2 by I array'); end
[M,N]=size(Q);
if M~=2, error('Q must be a 2 by J array'); end
if (J ~= N), error('Q must be a 2 by J array'); end
%--compute the free space in each cell
for i=1:I-1
    xp = P(1,i); yp = P(2,i);
    xp1 = P(1,i+1); yp1 = P(2,i+1);    
    for j=1:J-1
        xq = Q(1,j); yq = Q(2,j);
        xq1 = Q(1,j+1); yq1 = Q(2,j+1);
        %--solve for the line segment circle intersections
        ap = lP(i);  aq = lQ(j);
        bp = bP(i,j);
        bq = bQ(i,j);
        c = lPQ(i,j) - len^2;
        dp = bp*bp - 4*ap*c;
        dq = bq*bq - 4*aq*c;
        if dp<0.0,  %--  a_ij, b_ij, LF_ij
            %--line and circle do not intersect
            A(i,j) = NaN; B(i,j) = NaN; 
            LF(i,j,1) = NaN; LF(i,j,2) = NaN;
        else
            up = (-bp+sqrt(dp))/(2*ap); um = (-bp-sqrt(dp))/(2*ap);
            if (((up<0)&&(um<0))||((up>1)&&(um>1)))
                %--line segment outside circle
                A(i,j) = NaN; B(i,j) = NaN;
                LF(i,j,1) = NaN; LF(i,j,2) = NaN;
            elseif ((min([um up])<0)&&(max([um up])>1))
                %--line segment is interior to circle
                A(i,j) = 0; B(i,j) = 1;
                LF(i,j,1) = 0; LF(i,j,2) = 1;
            elseif ((min([um up])<=0)&&(max([um up])<=1))
                %--one intersection (b_i,j)
                A(i,j) = 0; B(i,j) = max([um up]);
                LF(i,j,1) = 0; LF(i,j,2) = B(i,j);
            elseif ((min([um up])>=0)&&(max([um up])>1))
                %--one intersection (a_i,j)
                A(i,j) = min([um up]); B(i,j) = 1;
                LF(i,j,1) = A(i,j); LF(i,j,2) = 1;
            elseif ((min([um up])>=0)&&(max([um up])<=1))
                %--two intersections
                A(i,j) = min([um up]); B(i,j) = max([um up]);
                LF(i,j,1) = A(i,j); LF(i,j,2) = B(i,j);
            else
                error('Unexpected case in frechet_decide at LF');
            end
        end
        if dq<0.0,  %--  c_ij, d_ij, BF_ij
            %--line and circle do not intersect
            C(i,j) = NaN; D(i,j) = NaN; 
            BF(i,j,1) = NaN; BF(i,j,2) = NaN;
        else
            up = (-bq+sqrt(dq))/(2*aq); um = (-bq-sqrt(dq))/(2*aq);
            if (((up<0)&&(um<0))||((up>1)&&(um>1)))
                %--line segment outside circle
                C(i,j) = NaN; D(i,j) = NaN;
                BF(i,j,1) = NaN; BF(i,j,2) = NaN;
            elseif ((min([um up])<0)&&(max([um up])>1))
                %--line segment is interior to circle
                C(i,j) = 0; D(i,j) = 1;
                BF(i,j,1) = 0; BF(i,j,2) = 1;
            elseif ((min([um up])<=0)&&(max([um up])<=1))
                %--one intersection (d_i,j)
                C(i,j) = 0; D(i,j) = max([um up]);
                BF(i,j,1) = 0; BF(i,j,2) = D(i,j);
            elseif ((min([um up])>=0)&&(max([um up])>1))
                %--one intersection (a_i,j)
                C(i,j) = min([um up]); D(i,j) = 1;
                BF(i,j,1) = C(i,j); BF(i,j,2) = 1;
            elseif ((min([um up])>=0)&&(max([um up])<=1))
                %--two intersections
                C(i,j) = min([um up]); D(i,j) = max([um up]);
                BF(i,j,1) = C(i,j); BF(i,j,2) = D(i,j);
            else
                error('Unexpected case in frechet_decide at BF');
            end
        end
    end
end
%--Top row
xp = P(1,I); yp = P(2,I);
for j=1:J-1
    xq = Q(1,j); yq = Q(2,j);
    xq1 = Q(1,j+1); yq1 = Q(2,j+1);
    %--solve for the line segment circle intersections
    aq = lQ(j);
    bq = bQ(I,j);
    c = lPQ(I,j) - len^2;
    dq = bq*bq - 4*aq*c;
    if dq<0.0,  %--  c_ij, d_ij, BF_ij
        %--line and circle do not intersect
        C(I,j) = NaN; D(I,j) = NaN;
        BF(I,j,1) = NaN; BF(I,j,2) = NaN;
    else
        up = (-bq+sqrt(dq))/(2*aq); um = (-bq-sqrt(dq))/(2*aq);
        if (((up<0)&&(um<0))||((up>1)&&(um>1)))
            %--line segment outside circle
            C(I,j) = NaN; D(I,j) = NaN;
            BF(I,j,1) = NaN; BF(I,j,2) = NaN;
        elseif ((min([um up])<0)&&(max([um up])>1))
            %--line segment is interior to circle
            C(I,j) = 0; D(I,j) = 1;
            BF(I,j,1) = 0; BF(I,j,2) = 1;
        elseif ((min([um up])<=0)&&(max([um up])<=1))
            %--one intersection (d_i,j)
            C(I,j) = 0; D(I,j) = max([um up]);
            BF(I,j,1) = 0; BF(I,j,2) = D(I,j);
        elseif ((min([um up])>=0)&&(max([um up])>1))
            %--one intersection (a_i,j)
            C(I,j) = min([um up]); D(I,j) = 1;
            BF(I,j,1) = C(I,j); BF(I,j,2) = 1;
        elseif ((min([um up])>=0)&&(max([um up])<=1))
            %--two intersections
            C(I,j) = min([um up]); D(I,j) = max([um up]);
            BF(I,j,1) = C(I,j); BF(I,j,2) = D(I,j);
        else
            error('Unexpected case in frechet_decide at BF (top row)');
        end
    end
end
%--Right column
xq = Q(1,J); yq = Q(2,J);
for i=1:I-1
    xp = P(1,i); yp = P(2,i);
    xp1 = P(1,i+1); yp1 = P(2,i+1);
    %--solve for the line segment circle intersections
    ap = lP(i); 
    bp = bP(i,J);
    c = lPQ(i,J) - len^2;
    dp = bp*bp - 4*ap*c;
    if dp<0.0,  %--  a_ij, b_ij, LF_ij
        %--line and circle do not intersect
        A(i,J) = NaN; B(i,J) = NaN;
        LF(i,J,1) = NaN; LF(i,J,2) = NaN;
    else
        up = (-bp+sqrt(dp))/(2*ap); um = (-bp-sqrt(dp))/(2*ap);
        if (((up<0)&&(um<0))||((up>1)&&(um>1)))
            %--line segment outside circle
            A(i,J) = NaN; B(i,J) = NaN;
            LF(i,J,1) = NaN; LF(i,J,2) = NaN;
        elseif ((min([um up])<0)&&(max([um up])>1))
            %--line segment is interior to circle
            A(i,J) = 0; B(i,J) = 1;
            LF(i,J,1) = 0; LF(i,J,2) = 1;
        elseif ((min([um up])<=0)&&(max([um up])<=1))
            %--one intersection (b_i,j)
            A(i,J) = 0; B(i,J) = max([um up]);
            LF(i,J,1) = 0; LF(i,J,2) = B(i,J);
        elseif ((min([um up])>=0)&&(max([um up])>1))
            %--one intersection (a_i,j)
            A(i,J) = min([um up]); B(i,J) = 1;
            LF(i,J,1) = A(i,J); LF(i,J,2) = 1;
        elseif ((min([um up])>=0)&&(max([um up])<=1))
            %--two intersections
            A(i,J) = min([um up]); B(i,J) = max([um up]);
            LF(i,J,1) = A(i,J); LF(i,J,2) = B(i,J);
        else
            error('Unexpected case in frechet_decide at LF (right col)');
        end
    end
end
%--Top Right cell
xp = P(1,I-1); yp = P(2,I-1);
xp1 = P(1,I); yp1 = P(2,I);
xq = Q(1,J-1); yq = Q(2,J-1);
xq1 = Q(1,J); yq1 = Q(2,J);
ap = lP(I-1);  aq = lQ(J-1);
bp = bP(I,J);
bq = bQ(I,J);
cp = lPQ(I-1,J) - len^2;
cq = lPQ(I,J-1) - len^2;
dp = bp*bp - 4*ap*cp;
dq = bq*bq - 4*aq*cq;
if dp<0.0,  %--  a_ij, b_ij, LF_ij
    %--line and circle do not intersect
    A(I,J) = NaN; B(I,J) = NaN;
    LF(I,J,1) = NaN; LF(I,J,2) = NaN;
else
    up = (-bp+sqrt(dp))/(2*ap); um = (-bp-sqrt(dp))/(2*ap);
    if (((up<0)&&(um<0))||((up>1)&&(um>1)))
        %--line segment outside circle
        A(I,J) = NaN; B(I,J) = NaN;
        LF(I,J,1) = NaN; LF(I,J,2) = NaN;
    elseif ((min([um up])<0)&&(max([um up])>1))
        %--line segment is interior to circle
        A(I,J) = 0; B(I,J) = 1;
        LF(I,J,1) = 0; LF(I,J,2) = 1;
    elseif ((min([um up])<=0)&&(max([um up])<=1))
        %--one intersection (b_i,j)
        A(I,J) = 0; B(I,J) = max([um up]);
        LF(I,J,1) = 0; LF(I,J,2) = B(i,j);
    elseif ((min([um up])>=0)&&(max([um up])>1))
        %--one intersection (a_i,j)
        A(I,J) = min([um up]); B(I,J) = 1;
        LF(I,J,1) = A(i,j); LF(I,J,2) = 1;
    elseif ((min([um up])>=0)&&(max([um up])<=1))
        %--two intersections
        A(I,J) = min([um up]); B(I,J) = max([um up]);
        LF(I,J,1) = A(I,J); LF(I,J,2) = B(I,J);
    else
        error('Unexpected case in frechet_decide at LF (top right cell)');
    end
end
if dq<0.0,  %--  c_ij, d_ij, BF_ij
    %--line and circle do not intersect
    C(I,J) = NaN; D(I,J) = NaN;
    BF(I,J,1) = NaN; BF(I,J,2) = NaN;
else
    up = (-bq+sqrt(dq))/(2*aq); um = (-bq-sqrt(dq))/(2*aq);
    if (((up<0)&&(um<0))||((up>1)&&(um>1)))
        %--line segment outside circle
        C(I,J) = NaN; D(I,J) = NaN;
        BF(I,J,1) = NaN; BF(I,J,2) = NaN;
    elseif ((min([um up])<0)&&(max([um up])>1))
        %--line segment is interior to circle
        C(I,J) = 0; D(I,J) = 1;
        BF(I,J,1) = 0; BF(I,J,2) = 1;
    elseif ((min([um up])<=0)&&(max([um up])<=1))
        %--one intersection (d_i,j)
        C(I,J) = 0; D(I,J) = max([um up]);
        BF(I,J,1) = 0; BF(I,J,2) = D(I,J);
    elseif ((min([um up])>=0)&&(max([um up])>1))
        %--one intersection (a_i,j)
        C(I,J) = min([um up]); D(I,J) = 1;
        BF(I,J,1) = C(I,J); BF(I,J,2) = 1;
    elseif ((min([um up])>=0)&&(max([um up])<=1))
        %--two intersections
        C(I,J) = min([um up]); D(I,J) = max([um up]);
        BF(I,J,1) = C(I,J); BF(I,J,2) = D(I,J);
    else
        error('Unexpected case in frechet_decide at BF (top right cell)');
    end
end
if plotFSD==1  %--plot the free space diagram
    figure(2)
    if exist('h')==1
        close(2)
        figure(2)
        h = [];
    end
    ih = 1;
    for i=1:I-1
        for j=1:J-1
            x = [j-1 j j j-1];  y = [i-1 i-1 i i];
            h(ih)=patch(x',y','k'); ih = ih + 1;
            x = []; y = [];
            if ~isnan(C(i,j))
                x = [x j-1+C(i,j)];  y = [y i-1];
            end
            if ~isnan(D(i,j))
                x = [x j-1+D(i,j)];  y = [y i-1];
            end
            if ~isnan(A(i,j+1))
                x = [x j];  y = [y i-1+A(i,j+1)];
            end
            if ~isnan(B(i,j+1))
                x = [x j];  y = [y i-1+B(i,j+1)];
            end
            if ~isnan(D(i+1,j))
                x = [x j-1+D(i+1,j)];  y = [y i];
            end
            if ~isnan(C(i+1,j))
                x = [x j-1+C(i+1,j)];  y = [y i];
            end
            if ~isnan(B(i,j))
                x = [x j-1];  y = [y i-1+B(i,j)];
            end
            if ~isnan(A(i,j))
                x = [x j-1];  y = [y i-1+A(i,j)];
            end
            if length(x)>2
                h(ih) = patch(x',y','w'); ih = ih + 1;
            elseif length(x)>0
                fprintf('patch error\n');
            end
        end
    end
end
%--Compute the reachable sets for each cell
for i=2:I    %--fill in column 1
    LR(i,1,1) = NaN; LR(i,1,2) = NaN;
end
for j=2:J    %--fill in row 1
    BR(1,j,1) = NaN; BR(1,j,2) = NaN;
end
for i=1:I-1
    for j=1:J-1
        if (i==1)&&(j==1)
            if (LF(i,j,1)==0)&&(BF(i,j,1)==0)   %--start at the origin
                LR(i,j+1,1) = LF(i,j+1,1); LR(i,j+1,2) = LF(i,j+1,2);
                BR(j+1,i,1) = BF(j+1,i,1); BR(j+1,i,2) = BF(j+1,i,2);
            else
                LR(i,j+1,1) = NaN; LR(i,j+1,2) = NaN;
                BR(j+1,i,1) = NaN; BR(j+1,i,2) = NaN;
            end
        else
            if isnan(LR(i,j,1))&&isnan(BR(i,j,1))
                LR(i,j+1,1) = NaN; LR(i,j+1,2) = NaN;
                BR(i+1,j,1) = NaN; BR(i+1,j,2) = NaN;
            elseif (~isnan(LR(i,j,1)))&&isnan(BR(i,j,1))
                BR(i+1,j,1) = BF(i+1,j,1); BR(i+1,j,2) = BF(i+1,j,2);
                if (LF(i,j+1,2)<LR(i,j,1))||isnan(LF(i,j+1,2))
                    LR(i,j+1,1) = NaN; LR(i,j+1,2) = NaN;
                elseif LF(i,j+1,1)>LR(i,j,1)
                    LR(i,j+1,1) = LF(i,j+1,1);
                    LR(i,j+1,2) = LF(i,j+1,2);
                else
                    LR(i,j+1,1) = LR(i,j,1);
                    LR(i,j+1,2) = LF(i,j+1,2);
                end
            elseif isnan(LR(i,j,1))&&(~isnan(BR(i,j,1)))
                LR(i,j+1,1) = LF(i,j+1,1); LR(i,j+1,2) = LF(i,j+1,2);
                if (BF(i+1,j,2)<BR(i,j,1))||isnan(BF(i+1,j,2))
                    BR(i+1,j,1) = NaN; BR(i+1,j,2) = NaN;
                elseif BF(i+1,j,1)>BR(i,j,1)
                    BR(i+1,j,1) = BF(i+1,j,1);
                    BR(i+1,j,2) = BF(i+1,j,2);
                else
                    BR(i+1,j,1) = BR(i,j,1);
                    BR(i+1,j,2) = BF(i+1,j,2);
                end
            else
                LR(i,j+1,1) = LF(i,j+1,1); LR(i,j+1,2) = LF(i,j+1,2);
                BR(i+1,j,1) = BF(i+1,j,1); BR(i+1,j,2) = BF(i+1,j,2);
            end
        end
        if printFSD==1
            fprintf('cell(%d,%d):\n',i,j);
            fprintf('\tLF(i,j)=[%f,%f] ',LF(i,j,1),LF(i,j,2));
            fprintf('\tBF(i,j)=[%f,%f] \n',BF(i,j,1),BF(i,j,2));
            fprintf('\tLR(i,j)=[%f,%f] ',LR(i,j,1),LR(i,j,2));
            fprintf('\tBR(i,j)=[%f,%f] \n',BR(i,j,1),BR(i,j,2));
            fprintf('\tLR(i,j+1)=[%f,%f] ',LR(i,j+1,1),LR(i,j+1,2));
            fprintf('\tBR(i+1,j)=[%f,%f] \n',BR(i+1,j,1),BR(i+1,j,2));
        end
    end
end
%--decide
if (BR(I,J-1,2)==1)||(LR(I-1,J,2)==1)
    decide = 1;
else
    decide = 0;
end
if plotFSD==1, title(['Free Space for Leash Length = ' num2str(len)]); end
return
end

                
            



