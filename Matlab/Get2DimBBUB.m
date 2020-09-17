function dist = Get2DimBBUB(PCornerPoints,QCornerPoints)

        dist = 0;
        for i = 1:size(PCornerPoints,1)
            for j = 1:size(QCornerPoints,1)
                currBound = CalcPointDist(PCornerPoints(i,:), QCornerPoints(j,:));
                if currBound > dist
                    dist = currBound;
                end
            end
        end

end