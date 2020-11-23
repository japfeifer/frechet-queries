% plot the seq euclidean distances to start seq
figure(1);
set(gcf, 'Position',  [100, 100, 1200, 300]); % set figure window position and size
N = length(x);
x1 = 1:length(x);
yunit = max(x) * 1.1;
if plotType == 1
    plot(x1,x,'k','LineWidth',2)
    hold on
    fcTick = 0:freqSize:N;
elseif plotType == 2
    plot(x1,x,'k','LineWidth',2)
    hold on
    fcTick = fc(:,2);
    fcTick = [fc(1,1); fcTick];
    [fcTmp,bestTotDist] = GetBestSeqCluster(fc,seq);
    for i = 1:size(fcTmp,1)
        xunit = fcTmp(i,2) + 3;
        txt = [num2str(round(fcTmp(i,4),3))];
        if fcTmp(i,4) < meanDist
            txtColor = 'k';
        elseif fcTmp(i,4) < threshDist
            txtColor = 'b';
        else
            txtColor = 'r';
        end
        text(xunit,yunit,txt,'color',txtColor)
    end
    hold off
else
    plot(x1,x,'r','LineWidth',2)
    hold on
    for i = 1:size(fcNew,1)
        plot(x1(fcNew(i,1) : fcNew(i,2)), x(fcNew(i,1) : fcNew(i,2)),'k','LineWidth',2)
        hold on
    end
    for i = 1:size(fcNew,1)
        xunit = fcNew(i,1) + 3;
        txt = [num2str(round(fcNew(i,3),3))];
        text(xunit,yunit,txt,'color','k')
    end
    for i = 1:size(fcDiscard,1)
        xunit = fcDiscard(i,1) + 3;
        txt = [num2str(round(fcDiscard(i,3),3))];
        text(xunit,yunit,txt,'color','r')
    end
    hold off
    if isempty(fcDiscard) == true
        fcTick = fcNew(:,2);
    else
        fcTick = [fcNew(:,2); fcDiscard(:,2)];
        fcTick = sort(fcTick,1);
    end
end
ax = gca;
ax.YLim = [0 max(x) * 1.2;];
ax.XTick = fcTick;
ax.GridColor = [0 0 0];
ax.LineWidth = 3.5;
% ax.GridAlpha = 1;
ax.XGrid = 'on';
% grid on
titleName = ['Sequence ID: ',num2str(seqID), ...
    '    Word: ',cell2mat(CompMoveData(seqID,1)), ...
    '    ',cell2mat(CompMoveData(seqID,2)), ...
    '    Phase: ',num2str(phase), ...
    '    Num Sub Seq: ',num2str(numSubSeq), ...
    '    Freq: ',num2str(freqSize), ...
    '    Thresh Dist: ',num2str(round(threshDist,3)),...
    '    Mean Dist: ',num2str(round(meanDist,3))];
title(titleName)
xlabel('Frame ID')
ylabel('Euclidean Distance')

% % plot the Periodogram
% Xaxis = 0:Fs/length(x):Fs/2;
% plot(Xaxis,10*log10(psdx))
% grid on
% title('Periodogram Using FFT')
% xlabel('Frequency (Hz)')
% ylabel('Power/Frequency (dB/Hz)')

% periodogram(x,rectwin(length(x)),length(x),N); % plot the Periodogram using built-in function

