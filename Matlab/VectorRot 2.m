function vRot = VectorRot(v,numRot,Dir)

    vSz = size(v,2);
    if Dir == 1 % rotate to the right
        vRot = [v(:,numRot+1:vSz) v(:,1:numRot)];
    else % rotate to the left
        vRot = [v(:,vSz-numRot+1:end) v(:,1:vSz-numRot)];
    end 
    
end