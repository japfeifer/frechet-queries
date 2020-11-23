% Graph seq as a 2D trajectory
seq = cell2mat(queryTraj(1,1));

seq = cell2mat(trajData(cell2mat(queryTraj(2,12)),1));

simplFlg = 1;

if simplFlg == 1
    newSeq = TrajSimp(seq,0.03);
else
    newSeq = seq;
end

% project higher dimensional trajectory onto the plane
[coeff, score] = pca(newSeq); % use Principal Component Analysis
P = score(:,1:2);

f2 = figure;
% figure(102);
set(gcf, 'Position',  [100, 100, 600, 600]); % set figure window position and size

szSeq = size(newSeq,1);
for i = 1:szSeq
    if i == szSeq
        currColor = [0 0 0];
    else
        tmpCol = 0.95 - ((i/szSeq) * 0.7);
        currColor = [tmpCol tmpCol tmpCol];
    end
    
    plot([P(i,1) P(i,1)],[P(i,2) P(i,2)],'o','MarkerSize',3,'MarkerEdgeColor',currColor,'Color',currColor);
    hold on;
    
    if i ~= 1
        plot(P(i-1:i,1),P(i-1:i,2),'o-','linewidth',1,'MarkerSize',3,'markerfacecolor',currColor,'Color',currColor);
        hold on;
    end
    
end

xlim([-1 1]);
ylim([-1 1]);

plot([P(1,1) P(1,1)],[P(1,2) P(1,2)],'ko','MarkerSize',8,'MarkerEdgeColor','k');  
hold on;
plot([P(szSeq,1) P(szSeq,1)],[P(szSeq,2) P(szSeq,2)],'kx','MarkerSize',8,'MarkerEdgeColor','k');
hold on;
axis equal;