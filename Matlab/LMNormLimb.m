
function p = LMNormLimb(a,b,a_b,seqFrame)

    % normalize the limb a to b
    vec = seqFrame(1,b) - seqFrame(1,a); % original vector
    uvec = vec ./ CalcPointDist(seqFrame(1,b),seqFrame(1,a)); % unit normal vector
    nvec = uvec .* a_b; % new vector
    p = seqFrame(1,a) + nvec; % new point

end