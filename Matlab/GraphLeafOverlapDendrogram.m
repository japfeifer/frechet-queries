
function GraphLeafOverlapDendrogram(nodeID,xStart,xEnd,depth,lowerPct,upperPct,cmap)

    global tmpCCT tmpCCTDepth lowClustRad trajOverlapList

    if depth <= tmpCCTDepth % only process up to a certain tree depth
        
        if tmpCCT(nodeID,5) > 1 % parent node
            cRad = tmpCCT(nodeID,4); % cluster radius
        else % leaf node
            cRad = tmpCCT(tmpCCT(nodeID,1),4); % get parent cluster radius
        end
   
        idx = trajOverlapList(tmpCCT(nodeID,6)); % number of parent nodes that overlap this traj
        
        % normalize to between 1 and 200 (the colormap has 200 colors)
        idx = floor(idx * (200 - 1) + 1);

        clineColor = cmap(idx,:);

        if tmpCCT(nodeID,5) > 1 % parent node 
            % plot top horizontal line
            semilogy([xStart xEnd],[cRad cRad],'linewidth',1,'color',[190/255 190/255 190/255],'LineStyle','-');
            hold on;

            % plot bottom horizontal line
            semilogy([xStart xEnd],[lowClustRad lowClustRad],'linewidth',1,'color',[190/255 190/255 190/255]);
            hold on;

            % plot left vertical line
            semilogy([xStart xStart],[cRad lowClustRad],'linewidth',3,'color',clineColor);
            hold on;
            % plot right vertical line
            semilogy([xEnd xEnd],[cRad lowClustRad],'linewidth',1,'color',[220/255 220/255 220/255],'LineStyle','-');
            hold on;
        else % leaf node
            % plot left vertical line
            semilogy([xStart xStart],[cRad lowClustRad],'linewidth',3,'color',clineColor);
            hold on;
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
                GraphLeafOverlapDendrogram(tmpCCT(nodeID,2),xStart,xEnd - (totalLength * (1-leftSizeFactor)),depth+1,lowerPct,upperPct,cmap);
            end
            if tmpCCT(tmpCCT(nodeID,3),6) == tmpCCT(nodeID,6) %&& tmpCCT(tmpCCT(nodeID,3),5) > 1
                GraphLeafOverlapDendrogram(tmpCCT(nodeID,3),xStart,xEnd - (totalLength * (1-rightSizeFactor)),depth+1,lowerPct,upperPct,cmap);
            end

            % next, try and go to child with different center trajID
            if tmpCCT(tmpCCT(nodeID,2),6) ~= tmpCCT(nodeID,6) %&& tmpCCT(tmpCCT(nodeID,2),5) > 1
                GraphLeafOverlapDendrogram(tmpCCT(nodeID,2),xStart + (totalLength * leftSizeFactor),xEnd,depth+1,lowerPct,upperPct,cmap);
            end
            if tmpCCT(tmpCCT(nodeID,3),6) ~= tmpCCT(nodeID,6) %&& tmpCCT(tmpCCT(nodeID,3),5) > 1
                GraphLeafOverlapDendrogram(tmpCCT(nodeID,3),xStart + (totalLength * leftSizeFactor),xEnd,depth+1,lowerPct,upperPct,cmap);
            end
        end
    end
end