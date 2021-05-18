% check if result has vertex on right-edge of freespace
function ans = CheckVertexAlt(z)

    ans = 0;
    for i = 1:size(z,1)
        if ~isnan(z(i,1))
            if z(i,1) == 0 || z(i,1) == 1 % a vertex 
                ans = 1;
                break
            end
        end
        if ~isnan(z(i,2))
            if z(i,2) == 0 || z(i,2) == 1 % a vertex 
                ans = 1;
                break
            end
        end
    end

end