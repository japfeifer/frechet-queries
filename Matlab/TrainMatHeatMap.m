% mapMat = trainMat(1:300,1:300);

mapMat = trainMat;

T = array2table(trainLabels);
G = grpstats(T,'trainLabels');
ids = G{:,1};
x = G{:,2};
y = floor(x/2);
z = [];
for i=1:size(x,1)
    if i == 1
        z(i,1) = y(i,1);
    else
        z(i,1) = y(i,1) + sum(x(1:i-1,1));
    end
end

zval = 1;
axXVal = strings(1,size(mapMat,2));
for i=1:size(mapMat,2)
    if i == z(zval)
        axXVal(1,i) = num2str(ids(zval,1));
        zval = zval + 1;
    else
        axXVal(1,i) = "";
    end
    if zval > size(z,1)
       break 
    end
end

zval = 1;
axYVal = strings(1,size(mapMat,1));
for i=1:size(mapMat,1)
    if i == z(zval)
        axYVal(1,i) = num2str(ids(zval,1));
        zval = zval + 1;
    else
        axYVal(1,i) = "";
    end
    if zval > size(z,1)
       break 
    end
end

% skew distances
mapMat = mapMat.^(0.3);

% normalize distances between [0,1]
maxDist = max(max(mapMat));
mapMat = mapMat / maxDist;


figure
axes('Units', 'normalized', 'Position', [0.1300 0.1000 0.7750 0.8150]);
hm = heatmap(mapMat);
% cmap = bone(256);
% cmap = jet(256);
cmap = gray(256);
cmap = flipud(cmap);
hm.Colormap = cmap;
hm.GridVisible = 'off';
% hm.ColorScaling = 'log';
% hm.GridVisible = 'off';
hm.XLabel = 'Class Label Id''s';
hm.YLabel = 'Class Label Id''s';
hm.XDisplayLabels = axXVal;
hm.YDisplayLabels = axYVal;
hm.FontSize = 18;