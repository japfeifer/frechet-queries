% find the curve P with the largest size

nMax=0;
iBest = 0;
for i = 1:size(trajOrigData,1)
    P = cell2mat(trajOrigData(i,1));
    n = size(P,1);
    if n > nMax
        nMax = n;
        iBest = i;
    end
end

disp(['iBest: ',num2str(iBest),'  nMax: ',num2str(nMax)]);