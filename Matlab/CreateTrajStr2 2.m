% create trajectory structure datatype (faster than cell datatype)

trajStrData = [];
for i=1:size(trajData,1)
    trajStrData(i).traj = cell2mat(trajData(i,1));
end

trajData = [];
clear trajData;
