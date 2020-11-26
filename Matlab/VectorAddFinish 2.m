function v = VectorAddFinish(v)

    v(v >= 1) = 1; % change anything >= 1 to 1's
    v(v <= -1) = -1; % change anything <= -1 to -1's
    idx = v == 0; % indexes where v == 0
    vTmp = VectorCreate(size(v,2)); % get a random vector
    v(idx) = vTmp(idx); % change the 0's to -1's or 1's based on the random vector
    
end