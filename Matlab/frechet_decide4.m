function [decide,z,numCell] = frechet_decide4(P,Q,len,plotFSD,printFSD)
%--solves the decision problem for Frechet distance
%--modified: 27 Apr 2012:  To compute data required in frechet_init

% Performs a sub-traj decision procedure.
% Stops early if top cell edges for current row are all non-reachable

global I J lP lQ lPQ bP bQ

[M,N]=size(P);
if M<2, error('P must be a d by I array where d >= 2'); end
if (I ~= N), error('P must be a d by I array'); end
[M,N]=size(Q);
if M<2, error('Q must be a d by I array where d >= 2'); end
if (J ~= N), error('Q must be a d by J array'); end

A=[]; B=[]; C=[]; D=[]; BF=[]; LF=[];LR=[];BR=[];
A(1:I-1,1:J-1)=NaN;
B(1:I-1,1:J-1)=NaN;
C(1:I-1,1:J-1)=NaN;
D(1:I-1,1:J-1)=NaN;
BF(1:I-1,1:J-1)=NaN;
LF(1:I-1,1:J-1)=NaN;
% LR(2:I,1,1:2)=NaN;
% BR(1,2:J,1:2)=NaN;
LR(2:I,2:J,1:2)=NaN;
BR(2:I,2:J,1:2)=NaN;
z = [];
numCell = 0;

% compute the very first column
j=1;
for i=1:I-1 % compute the line segment circle intersections for this column
    %--solve for the line segment circle intersections
    ap = lP(i);  aq = lQ(j);
    bp = bP(i,j);
    bq = bQ(i,j);
    c = lPQ(i,j) - len^2;
    dp = bp*bp - 4*ap*c;
    dq = bq*bq - 4*aq*c;
    if dp<0.0  %--  a_ij, b_ij, LF_ij
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
            error('Unexpected case in frechet_decide2 at LF');
        end
    end
%     if dq<0.0  %--  c_ij, d_ij, BF_ij
%         %--line and circle do not intersect
%         C(i,j) = NaN; D(i,j) = NaN; 
%         BF(i,j,1) = NaN; BF(i,j,2) = NaN;
%     else
%         up = (-bq+sqrt(dq))/(2*aq); um = (-bq-sqrt(dq))/(2*aq);
%         if (((up<0)&&(um<0))||((up>1)&&(um>1)))
%             %--line segment outside circle
%             C(i,j) = NaN; D(i,j) = NaN;
%             BF(i,j,1) = NaN; BF(i,j,2) = NaN;
%         elseif ((min([um up])<0)&&(max([um up])>1))
%             %--line segment is interior to circle
%             C(i,j) = 0; D(i,j) = 1;
%             BF(i,j,1) = 0; BF(i,j,2) = 1;
%         elseif ((min([um up])<=0)&&(max([um up])<=1))
%             %--one intersection (d_i,j)
%             C(i,j) = 0; D(i,j) = max([um up]);
%             BF(i,j,1) = 0; BF(i,j,2) = D(i,j);
%         elseif ((min([um up])>=0)&&(max([um up])>1))
%             %--one intersection (a_i,j)
%             C(i,j) = min([um up]); D(i,j) = 1;
%             BF(i,j,1) = C(i,j); BF(i,j,2) = 1;
%         elseif ((min([um up])>=0)&&(max([um up])<=1))
%             %--two intersections
%             C(i,j) = min([um up]); D(i,j) = max([um up]);
%             BF(i,j,1) = C(i,j); BF(i,j,2) = D(i,j);
%         else
%             error('Unexpected case in frechet_decide2 at BF');
%         end
%     end
end

for j=1:J-1 % process each column, from left to right

    if j == J-1  %--compute far-right Right column
        
        for i=1:I-1
            %--solve for the line segment circle intersections
            ap = lP(i); 
            bp = bP(i,J);
            c = lPQ(i,J) - len^2;
            dp = bp*bp - 4*ap*c;
            if dp<0.0  %--  a_ij, b_ij, LF_ij
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
                    error('Unexpected case in frechet_decide2 at LF (right col)');
                end
            end
        end
        
    else
        
        for i=1:I-1 % compute the line segment circle intersections for the next column - left only (not bottom)
            %--solve for the line segment circle intersections
            ap = lP(i);  aq = lQ(j+1);
            bp = bP(i,j+1);
            bq = bQ(i,j+1);
            c = lPQ(i,j+1) - len^2;
            dp = bp*bp - 4*ap*c;
            dq = bq*bq - 4*aq*c;
            if dp<0.0  %--  a_ij, b_ij, LF_ij
                %--line and circle do not intersect
                A(i,j+1) = NaN; B(i,j+1) = NaN; 
                LF(i,j+1,1) = NaN; LF(i,j+1,2) = NaN;
            else
                up = (-bp+sqrt(dp))/(2*ap); um = (-bp-sqrt(dp))/(2*ap);
                if (((up<0)&&(um<0))||((up>1)&&(um>1)))
                    %--line segment outside circle
                    A(i,j+1) = NaN; B(i,j+1) = NaN;
                    LF(i,j+1,1) = NaN; LF(i,j+1,2) = NaN;
                elseif ((min([um up])<0)&&(max([um up])>1))
                    %--line segment is interior to circle
                    A(i,j+1) = 0; B(i,j+1) = 1;
                    LF(i,j+1,1) = 0; LF(i,j+1,2) = 1;
                elseif ((min([um up])<=0)&&(max([um up])<=1))
                    %--one intersection (b_i,j)
                    A(i,j+1) = 0; B(i,j+1) = max([um up]);
                    LF(i,j+1,1) = 0; LF(i,j+1,2) = B(i,j+1);
                elseif ((min([um up])>=0)&&(max([um up])>1))
                    %--one intersection (a_i,j)
                    A(i,j+1) = min([um up]); B(i,j+1) = 1;
                    LF(i,j+1,1) = A(i,j+1); LF(i,j+1,2) = 1;
                elseif ((min([um up])>=0)&&(max([um up])<=1))
                    %--two intersections
                    A(i,j+1) = min([um up]); B(i,j+1) = max([um up]);
                    LF(i,j+1,1) = A(i,j+1); LF(i,j+1,2) = B(i,j+1);
                else
                    error('Unexpected case in frechet_decide2 at LF');
                end
            end
            
        end
        
    end 
   
    for i=1:I-1 % compute the line segment circle intersections for the this column - bottom edges only
        %--solve for the line segment circle intersections
        ap = lP(i);  aq = lQ(j);
        bp = bP(i,j);
        bq = bQ(i,j);
        c = lPQ(i,j) - len^2;
        dp = bp*bp - 4*ap*c;
        dq = bq*bq - 4*aq*c;
        if dq<0.0  %--  c_ij, d_ij, BF_ij
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
                error('Unexpected case in frechet_decide2 at BF');
            end
        end
    end  
    
    
    %--Top row
    %--solve for the line segment circle intersections
    aq = lQ(j);
    bq = bQ(I,j);
    c = lPQ(I,j) - len^2;
    dq = bq*bq - 4*aq*c;
    if dq<0.0  %--  c_ij, d_ij, BF_ij
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
            error('Unexpected case in frechet_decide2 at BF (top row)');
        end
    end
    
    if j == J-1  %--Top Right cell

        ap = lP(I-1);  aq = lQ(J-1);
        bp = bP(I,J);
        bq = bQ(I,J);
        cp = lPQ(I-1,J) - len^2;
        cq = lPQ(I,J-1) - len^2;
        dp = bp*bp - 4*ap*cp;
        dq = bq*bq - 4*aq*cq;
        if dp<0.0  %--  a_ij, b_ij, LF_ij
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
                error('Unexpected case in frechet_decide2 at LF (top right cell)');
            end
        end
        if dq<0.0  %--  c_ij, d_ij, BF_ij
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
                error('Unexpected case in frechet_decide2 at BF (top right cell)');
            end
        end
    end
    
    if j == 1 % at the first column
        LR(1:I-1,1,:) = LF(1:I-1,1,:); % seed left edge of freespace diagram since we want to determine paths from here
    end
    
    stopEarly = 1; % assume we will stop searching on this column, but if find reachable space on right edge then set to 0
    for i=1:I-1 % compute reachable space for this column
        numCell = numCell + 1;
        if i==1 % at bottom row
            if isnan(LR(i,j,1)) % no free space on left edge
                LR(i,j+1,1) = NaN; LR(i,j+1,2) = NaN;
                BR(i+1,j,1) = NaN; BR(i+1,j,2) = NaN;
            else
                if ~isnan(LF(i,j+1,2))
                    if LR(i,j,1) > LF(i,j+1,2) % we cannot go right on monotone path
                        LR(i,j+1,1) = NaN; LR(i,j+1,2) = NaN;
                        BR(i+1,j,1) = NaN; BR(i+1,j,2) = NaN;
                    else % may reduce the path opening
                        LR(i,j+1,1) = max(LF(i,j+1,1),LR(i,j,1)); LR(i,j+1,2) = LF(i,j+1,2);
                        BR(i+1,j,1) = BF(i+1,j,1); BR(i+1,j,2) = BF(i+1,j,2);
                        stopEarly = 0;
                    end
                else
                    LR(i,j+1,1) = NaN; LR(i,j+1,2) = NaN;
                    BR(i+1,j,1) = BF(i+1,j,1); BR(i+1,j,2) = BF(i+1,j,2);
                end
            end
        else % not on bottom row
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
                    stopEarly = 0;
                else
                    LR(i,j+1,1) = LR(i,j,1);
                    LR(i,j+1,2) = LF(i,j+1,2);
                    stopEarly = 0;
                end
            elseif isnan(LR(i,j,1))&&(~isnan(BR(i,j,1)))
                LR(i,j+1,1) = LF(i,j+1,1); LR(i,j+1,2) = LF(i,j+1,2);
                stopEarly = 0;
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
                stopEarly = 0;
            end
        end
    end
    if stopEarly == 1
        break
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


%--decide
z = [LR(1:I-1,J,1) LR(1:I-1,J,2)];
if stopEarly == 0
    if sum(~isnan(z(:,1))) > 0 || sum(~isnan(z(:,2))) > 0 % if there are any numbers, then reached right side of freespace
        decide = 1;
    else
        decide = 0;
    end
else % stopped early because there is no reachable space on top edges
    decide = 0;
end

if plotFSD==1, title(['Free Space for Leash Length = ' num2str(len)]); end
return
end

                
            



