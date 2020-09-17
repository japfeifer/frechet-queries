

function GraphDendrogram(nodeID,xStart,xEnd,depth,lowerPct,upperPct)

    global tmpCCT tmpCCTDepth lowClustRad

    if depth <= tmpCCTDepth % only process up to a certain tree depth
        cRad = tmpCCT(nodeID,4); % cluster radius

        % choose top horizontal line colors
        if tmpCCT(nodeID,8) < lowerPct
            lineColor = [204/255 229/255 255/255]; % light blue
        elseif tmpCCT(nodeID,8) < upperPct
            lineColor = [51/255 153/255 255/255]; % medium blue
        else
            lineColor = [0/255 76/255 153/255]; % dark blue
        end
        % plot top horizontal line
        semilogy([xStart xEnd],[cRad cRad],'linewidth',2,'color',lineColor);
        hold on;

        % plot bottom horizontal line
        semilogy([xStart xEnd],[lowClustRad lowClustRad],'linewidth',1,'color','k');
        hold on;

        % plot two vertical lines
        semilogy([xStart xStart],[cRad lowClustRad],'linewidth',1,'color','k','LineStyle',':');
        hold on;
        semilogy([xEnd xEnd],[cRad lowClustRad],'linewidth',1,'color','k','LineStyle',':');
        hold on;

        % go to child with same center trajID first, otherwise go to the other 
        % child, but do not go to any leafs

        totalLength = xEnd - xStart;

        numTrajLeft = tmpCCT(tmpCCT(nodeID,2),5);
        numTrajRight = tmpCCT(tmpCCT(nodeID,3),5);

        leftSizeFactor = numTrajLeft / (numTrajLeft + numTrajRight);
        rightSizeFactor = numTrajRight / (numTrajLeft + numTrajRight);

        % try and go to child with same center trajID first
        if tmpCCT(tmpCCT(nodeID,2),6) == tmpCCT(nodeID,6) && tmpCCT(tmpCCT(nodeID,2),4) > 0
            GraphDendrogram(tmpCCT(nodeID,2),xStart,xEnd - (totalLength * (1-leftSizeFactor)),depth+1,lowerPct,upperPct);
        end
        if tmpCCT(tmpCCT(nodeID,3),6) == tmpCCT(nodeID,6) && tmpCCT(tmpCCT(nodeID,3),4) > 0
            GraphDendrogram(tmpCCT(nodeID,3),xStart,xEnd - (totalLength * (1-rightSizeFactor)),depth+1,lowerPct,upperPct);
        end

        % next, try and go to child with different center trajID
        if tmpCCT(tmpCCT(nodeID,2),6) ~= tmpCCT(nodeID,6) && tmpCCT(tmpCCT(nodeID,2),4) > 0
            GraphDendrogram(tmpCCT(nodeID,2),xStart + (totalLength * leftSizeFactor),xEnd,depth+1,lowerPct,upperPct);
        end
        if tmpCCT(tmpCCT(nodeID,3),6) ~= tmpCCT(nodeID,6) && tmpCCT(tmpCCT(nodeID,3),4) > 0
            GraphDendrogram(tmpCCT(nodeID,3),xStart + (totalLength * leftSizeFactor),xEnd,depth+1,lowerPct,upperPct);
        end
    end
end