function ComputeNTURGBDSeqOverride()

    global CompMoveData overrideNTURGBD
    
    % The following code below can be replaced with generic clustering code
    % to determine seq to omit, seq to choose frames, and how far
    % forward/back to look for each cut.  However, in the interest of time
    % some simple overrides are used instead.
    
    lowVaryPct = 0.30;
    highVaryPct = 0.40;
    lastFramePct = 0.05;
    overrideNTURGBD = [];
    
    for i = 1:size(CompMoveData,1)
        seq = cell2mat(CompMoveData(i,4));
        overrideNTURGBD(i,:) = [1 1 size(seq,1) lowVaryPct highVaryPct lastFramePct];
    end
    
    % now do overrides
    
    
end