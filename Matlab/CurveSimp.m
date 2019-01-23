function [numVertex] = CurveSimp(P,epsilonDist)

    % initialize some variables
    numVertex = 1; Pos1 = 1; Pos2 = 2;
    doneTraj = false; 
    
    % get current trajectory size
    sP = size(P);

    % for now just do linear search - I'll change it to exp/bin search later
    while doneTraj == false

        % get distance from Pos 1 to Pos 2
        if Pos2 == Pos1 + 1
            Pos1to2Dist = 0;
        else
            Pos1to2Dist = ContFrechet(P(Pos1:Pos2,:)',cat(1,P(Pos1,:),P(Pos2,:))');                   
        end

        if Pos1to2Dist > epsilonDist
            numVertex = numVertex + 1;
            Pos1 = Pos2 - 1;
        elseif Pos2 == sP(1)
            doneTraj = true;
            numVertex = numVertex + 1;
        else 
            Pos2 = Pos2 + 1;
        end           
    end  % while doneTraj == false             

end % function [numVertex] = CurveSimp(P,epsilonDist)