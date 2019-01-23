% This function takes two curves and a sorted length list as inputs and
% attempts to find the first length that is >= the continuous frechet
% distance.  Since the length list is sorted it uses a binary divide and
% conquer approach to find the first length >= frechet.

function [decide,minlen,maxlen,dCount] = FrechetDecideBinSearch(P,Q,lenList)

    decide = 0;
    dCount = 0;
    len = 0;
    lastlen = 0;
    innerCount=0;
    minlen=0;
    maxlen=0;
    if ~isempty(lenList) % length list is not empty
        sizeLenList = size(lenList,2);
        if sizeLenList <=2 % there are only 1 or 2 lengths to check, just do linear search
            for i=1:sizeLenList
                len = lenList(i);
                decide = frechet_decide2(P,Q,len,0,0);
                dCount = dCount + 1;
                if decide == 1 % we found the first length >= frechet
                    if i==1
                        minlen=0;
                    else
                        minlen=lenList(i-1);
                    end
                    maxlen=len;
                    return
                end
            end
            % we found no lengths >= frechet
            minlen=len;
            maxlen=Inf;
            return 
        else
            % there are 3 or more lengths to check, do binary divide/conquer search
            
            % first find a Position in lenList where decide == 1
            pos1=1;
            pos2=ceil(sizeLenList/2); % find middle position
            len = lenList(pos2);
            while decide == 0 && pos1 <= sizeLenList
                decide = frechet_decide2(P,Q,len,0,0);
%                 disp(['pos1: ',num2str(pos1),', pos2: ',num2str(pos2),', length: ',num2str(lenList(pos2))]);
                dCount = dCount + 1;
                if decide == 0
                    pos1 = pos2 + 1;
                    pos2 = min(ceil((sizeLenList-pos1+1)/2) - 1 + pos1, sizeLenList);
                    len = lenList(pos2);
                end
            end
            
            % now find where decide changes from 0 to 1.  It's between pos1
            % and pos2. If all items in lenList are 0 decide, then don't 
            % process this.
            if decide == 1 
                while 1==1
%                     disp(['pos1: ',num2str(pos1),', pos2: ',num2str(pos2)]);
                    if pos2-pos1<=1  % we've narrowed it down to two items
                        % we just have to check pos1 as we know pos2 has
                        % decide == 1
                        len = lenList(pos1);
                        decide = frechet_decide2(P,Q,len,0,0);
                        dCount = dCount + 1;
                        if decide == 0 % it's pos2
                            decide = 1;
                            len = lenList(pos2);
                            pos1 = pos2;
                        end
                        break
                    else % test a middle pos and reduce size of lenList
                        midpos = ceil((pos2-pos1+1)/2) -1 + pos1;
                        len = lenList(midpos);
                        decide = frechet_decide2(P,Q,len,0,0);
                        dCount = dCount + 1;
                        if decide == 0
                            pos1 = midpos;
                        else
                            pos2 = midpos;
                        end
                    end
                end
                if pos1==1
                    minlen=0;
                else
                    minlen=lenList(pos1-1);
                end
                maxlen=len;
            else % decide == 0
                minlen=lenList(sizeLenList);
                maxlen=Inf;
            end
        end  
    end
end