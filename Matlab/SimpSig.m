function [SS] = SimpSig(P)

    % initialize some variables
    SS = []; processMore = true;
    sPos = 1; ePos = 3;
    
    % get current trajectory size
    sP = size(P);
    
    % set distance matrix to -1's
    dM = ones(sP(1),sP(1)).*-1;
    
%     % determine the max distance for trajectory
%     maxDist = ContFrechet(P',cat(1,P(1,:),P(sP(1),:))');
%          
%     dM(1,sP(1)) = maxDist;  % update distance matrix
    
    % update simplification signature 
    SS(1,:) = [0 sP(1)]; % full curve with max edges
%     if sP(1) > 2
%         SS(2,:) = [maxDist 2]; % simplified curve with two vertices
%     end
    
    if sP(1) > 3 % only process more if size of curve is 4 or greater
        
        while processMore
            % calculate next epsilon to process (curve distance)
            if dM(sPos,ePos) == -1
                currDist = ContFrechet(P(sPos:ePos,:)',cat(1,P(sPos,:),P(ePos,:))');
                dM(sPos,ePos) = currDist;  % update distance matrix
            else
                currDist = dM(sPos,ePos);
            end
            
            % discover simplificaton vertex size for epsilon = currDist
%             if currDist < maxDist % only process if distance is less than max Dist
                numVertex = 1; Pos1 = 1; Pos2 = 2;
                doneTraj = false;
                
                % for now just do linear search - I'll change it to exp/bin search later
                while doneTraj == false
                    
                    % get distance from Pos 1 to Pos 2
                    if Pos2 == Pos1 + 1
                        Pos1to2Dist = 0;
                    else
                        if dM(Pos1,Pos2) == -1
                            Pos1to2Dist = ContFrechet(P(Pos1:Pos2,:)',cat(1,P(Pos1,:),P(Pos2,:))');
                            dM(Pos1,Pos2) = Pos1to2Dist;  % update distance matrix
                        else
                            Pos1to2Dist = dM(Pos1,Pos2);
                        end                     
                    end
                    
                    if Pos1to2Dist > currDist
                        numVertex = numVertex + 1;
                        Pos1 = Pos2 - 1;
                    elseif Pos2 == sP(1)
                        doneTraj = true;
                        numVertex = numVertex + 1;
                    else 
                        Pos2 = Pos2 + 1;
                    end           
                end  % while doneTraj == false             
%             end  % if currDist < maxDist
            
            % insert/update the simplification signature 
%             if currDist < maxDist % only update if distance is less than max Dist 
                currIndex = find(SS(:,2)==numVertex);
                if currIndex > 0 % the simpl size exists - update it
                    if SS(currIndex,1) > currDist
                        SS(currIndex,1) = currDist;
                    end                    
                else % insert the new simpl size
                    SS = [SS; currDist numVertex];
                end    
%             end
            
            % determine what epsilon distance to process next, or if we are done
            if (ePos == sP(1)) && ((sPos+2) == sP(1))
                processMore = false;  % this was the last one, we're done
            elseif (ePos == sP(1)) % restart at next start pos
                sPos = sPos + 1;
                ePos = sPos + 2;
            else
                ePos = ePos + 1; % just move the end pos one
            end            
        end  % while processMore 
    end  % if sP(1) > 3
    
    % finally, sort the simplification signature 
    SS = sortrows(SS,2,'descend');

end % function [SS] = SimpSig(P)