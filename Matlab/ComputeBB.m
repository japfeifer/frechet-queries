% compute the bounding box

function BB = ComputeBB(P,deg)

    if deg > 0 % rotate P
        sPDim = size(P,2);
        if (sPDim == 2 || sPDim == 3)
            if sPDim == 2
                RotMatrix = [cosd(deg)  sind(deg); ...
                             -sind(deg) cosd(deg)];
            else % sPDim == 3
                RotMatrix = [cosd(deg)  sind(deg)  0; ...
                             -sind(deg) cosd(deg)  0; ...
                             0           0           1];
            end
            P = P*RotMatrix; % matrix multiplication
        else
            error('Dimension not supported');
        end
    end
    
    BB = [min(P);max(P)];

end