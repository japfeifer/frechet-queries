% this script imports a set of Bringmann queries from a file into the queryStrData   
%
% file data row example:
% trajectory-1.dat 5.7120472240598223479
function ProcBringQueries(fileName,synDataName,dirName)

    global querStrData trajStrData

    fileName = [dirName synDataName '/' fileName];
    queryStrData = [];

    % read query datafile into a cell datatype
    fileID = fopen(fileName,'r');
    % ignore the text 'trajectory-', read the integer (including the period
    % '.'), ignore the text 'dat', read the floating point number
    formatSpec = 'trajectory-%ddat %f';  
    tmpA = textscan(fileID, formatSpec,'Delimiter', ' ');
    fclose(fileID);

    % extract the list of query IDs, and query range values
    qIDList = cell2mat(tmpA(1,1));
    qValueList = cell2mat(tmpA(1,2));

    for i = 1:size(qIDList,1)
        querStrData(i).traj = trajStrData(qIDList(i)).traj;
        querStrData(i).se = trajStrData(qIDList(i)).se;
        querStrData(i,25).qrv = qValueList;
    end
end