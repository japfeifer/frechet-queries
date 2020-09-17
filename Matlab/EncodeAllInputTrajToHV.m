% function EncodeAllInputTrajToHV
%
% Encodes a set of input trajectories into hypervectors

function EncodeAllInputTrajToHV()

    global trajHyperVector coordSz inputSet nodeVisitCnt
    
    tic;
    
    nodeVisitCnt = 0;
    
    h = waitbar(0, 'Encode Traj to HV');
    
    inputSz = size(inputSet,1);
    
    % create set of empty (all zero) hypervectors for input traj
    trajHyperVector = [];
    trajHyperVector(1:inputSz,1:coordSz) = int8(0);

    % for each input traj set, compute it's hypervector
    for i = 1:inputSz
        if mod(i,10) == 0
            X = ['Encode Traj to HV ',num2str(i),'/',num2str(inputSz)];
            waitbar(i/inputSz, h, X);
        end    
        v(1,1:coordSz) = int8(0); % initialize vector to all zeros
        for j = 3:size(inputSet,2)
            P = cell2mat(inputSet(i,j));
            if isempty(P) == false
                v = EncodeTrajToHV(P,v);
            end
        end
        trajHyperVector(i,:) = v;
    end

    close(h);
    timeElapsed = toc;
    disp(['EncodeAllInputTrajToHV time elapsed: ',num2str(timeElapsed)]);
    disp(['nodeVisitCnt: ',num2str(nodeVisitCnt)]);
    
end