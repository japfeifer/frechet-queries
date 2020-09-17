
function GraphkNNDendrogram5(nodeID,xStart,xEnd,depth,lineColor,lineStyle)

    global tmpCCT tmpCCTDepth lowClustRad resStat

    if depth <= tmpCCTDepth % only process up to a certain tree depth
        
        if tmpCCT(nodeID,5) > 1 % parent node
            cRad = tmpCCT(nodeID,4); % cluster radius
        else % leaf node
            cRad = tmpCCT(tmpCCT(nodeID,1),4); % get parent cluster radius
        end

        if tmpCCT(nodeID,8) == 1 % node was visited
            if ismember(tmpCCT(nodeID,6),resStat) == 1
                % plot left vertical line
                semilogy([xStart xStart],[cRad lowClustRad],'linewidth',2,'color',lineColor,'LineStyle',lineStyle);
                hold on;
            end
        end

        % go to child with same center trajID first, otherwise go to the other 
        % child, all the way to the leaf level

        totalLength = xEnd - xStart;

        if tmpCCT(nodeID,5) > 1 % parent node
            numTrajLeft = tmpCCT(tmpCCT(nodeID,2),5);
            numTrajRight = tmpCCT(tmpCCT(nodeID,3),5);
        else
            numTrajLeft = 1;
            numTrajRight = 1;
        end

        leftSizeFactor = numTrajLeft / (numTrajLeft + numTrajRight);
        rightSizeFactor = numTrajRight / (numTrajLeft + numTrajRight);
        
        % if not at leaf, recurse
        if tmpCCT(nodeID,5) > 1

            % try and go to child with same center trajID first
            if tmpCCT(tmpCCT(nodeID,2),6) == tmpCCT(nodeID,6) %&& tmpCCT(tmpCCT(nodeID,2),5) > 1
                GraphkNNDendrogram5(tmpCCT(nodeID,2),xStart,xEnd - (totalLength * (1-leftSizeFactor)),depth+1,lineColor,lineStyle);
            end
            if tmpCCT(tmpCCT(nodeID,3),6) == tmpCCT(nodeID,6) %&& tmpCCT(tmpCCT(nodeID,3),5) > 1
                GraphkNNDendrogram5(tmpCCT(nodeID,3),xStart,xEnd - (totalLength * (1-rightSizeFactor)),depth+1,lineColor,lineStyle);
            end

            % next, try and go to child with different center trajID
            if tmpCCT(tmpCCT(nodeID,2),6) ~= tmpCCT(nodeID,6) %&& tmpCCT(tmpCCT(nodeID,2),5) > 1
                GraphkNNDendrogram5(tmpCCT(nodeID,2),xStart + (totalLength * leftSizeFactor),xEnd,depth+1,lineColor,lineStyle);
            end
            if tmpCCT(tmpCCT(nodeID,3),6) ~= tmpCCT(nodeID,6) %&& tmpCCT(tmpCCT(nodeID,3),5) > 1
                GraphkNNDendrogram5(tmpCCT(nodeID,3),xStart + (totalLength * leftSizeFactor),xEnd,depth+1,lineColor,lineStyle);
            end
        end
    end
end