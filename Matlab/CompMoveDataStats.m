% calculate stats on CompMoveData

disp(['---------------------']);
CompMoveClassID; % create class ID's

disp(['Num Sequences: ',num2str(size(CompMoveData,1))]);
disp(['Num Classes: ',num2str(size(classes,1))]);
seq = cell2mat(CompMoveData(1,4));
disp(['Total joint coordinates: ',num2str(size(seq,2))]);

% Frame per seq stats.
szList = [];
for i = 1:size(CompMoveData,1)
    seq = cell2mat(CompMoveData(i,4));
    szList(end+1,:) = size(seq,1);
end
fmin = min(szList);
fmax = max(szList);
fmean = mean(szList);
fmedian = median(szList);
fstd = std(szList);
disp(['Frame per seq stats.  Min: ',num2str(fmin),' Max: ',num2str(fmax),' Mean: ',num2str(fmean),' Median: ',num2str(fmedian),' Stddev: ',num2str(fstd)]);

% Seq per class

a = cell2mat(CompMoveData(:,5)); % list of class ID's
[C,ia,ic] = unique(a);
a_counts = accumarray(ic,1);
value_counts = [C, a_counts];
smin = min(a_counts);
smax = max(a_counts);
smean = mean(a_counts);
smedian = median(a_counts);
sstd = std(a_counts);
disp(['Seq per class stats.  Min: ',num2str(smin),' Max: ',num2str(smax),' Mean: ',num2str(smean),' Median: ',num2str(smedian),' Stddev: ',num2str(sstd)]);


disp(['---------------------']);

T = cell2table(allClasses);
G = grpstats(T,'allClasses');
