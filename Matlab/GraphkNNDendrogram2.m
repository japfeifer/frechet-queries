
function GraphkNNDendrogram2(nodeID,xStart,xEnd,depth,lineColor,lineStyle)

    global tmpCCT tmpCCTDepth lowClustRad

    if depth <= tmpCCTDepth % only process up to a certain tree depth
        cRad = tmpCCT(nodeID,4); % cluster radius

        if tmpCCT(nodeID,8) == 1 % node was visited
            % plot top horizontal line
            semilogy([xStart xEnd],[cRad cRad],'linewidth',1,'color',lineColor,'LineStyle',lineStyle);
            hold on;

            % plot bottom horizontal line
            semilogy([xStart xEnd],[lowClustRad lowClustRad],'linewidth',1,'color',lineColor,'LineStyle',lineStyle);
            hold on;

            % plot two vertical lines
            semilogy([xStart xStart],[cRad lowClustRad],'linewidth',1,'color',lineColor,'LineStyle',lineStyle);
            hold on;
            semilogy([xEnd xEnd],[cRad lowClustRad],'linewidth',1,'color',lineColor,'LineStyle',lineStyle);
            hold on;
        end

        % go to child with same center trajID first, otherwise go to the other 
        % child, but do not go to any leafs

        totalLength = xEnd - xStart;

        numTrajLeft = tmpCCT(tmpCCT(nodeID,2),5);
        numTrajRight = tmpCCT(tmpCCT(nodeID,3),5);

        leftSizeFactor = numTrajLeft / (numTrajLeft + numTrajRight);
        rightSizeFactor = numTrajRight / (numTrajLeft + numTrajRight);

        % try and go to child with same center trajID first
        if tmpCCT(tmpCCT(nodeID,2),6) == tmpCCT(nodeID,6) && tmpCCT(tmpCCT(nodeID,2),4) > 0
            GraphkNNDendrogram2(tmpCCT(nodeID,2),xStart,xEnd - (totalLength * (1-leftSizeFactor)),depth+1,lineColor,lineStyle);
        end
        if tmpCCT(tmpCCT(nodeID,3),6) == tmpCCT(nodeID,6) && tmpCCT(tmpCCT(nodeID,3),4) > 0
            GraphkNNDendrogram2(tmpCCT(nodeID,3),xStart,xEnd - (totalLength * (1-rightSizeFactor)),depth+1,lineColor,lineStyle);
        end

        % next, try and go to child with different center trajID
        if tmpCCT(tmpCCT(nodeID,2),6) ~= tmpCCT(nodeID,6) && tmpCCT(tmpCCT(nodeID,2),4) > 0
            GraphkNNDendrogram2(tmpCCT(nodeID,2),xStart + (totalLength * leftSizeFactor),xEnd,depth+1,lineColor,lineStyle);
        end
        if tmpCCT(tmpCCT(nodeID,3),6) ~= tmpCCT(nodeID,6) && tmpCCT(tmpCCT(nodeID,3),4) > 0
            GraphkNNDendrogram2(tmpCCT(nodeID,3),xStart + (totalLength * leftSizeFactor),xEnd,depth+1,lineColor,lineStyle);
        end
    end
end