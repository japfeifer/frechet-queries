mapMat = distResults2;

for i=1:size(mapMat,2)
    axXVal(1,i) = "";
end

for i=1:size(mapMat,1)
    axYVal(1,i) = "";
end

% skew distances
mapMat = mapMat.^(0.3);

% normalize distances between [0,1], linear scale
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
hm.XLabel = 'Sequences of the Training Set';
hm.YLabel = 'Sequences of the Testing Set';
hm.XDisplayLabels = axXVal;
hm.YDisplayLabels = axYVal;
hm.FontSize = 18;