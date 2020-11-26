 s = [1 4]; % line segment start point, [x y] coordinates
 e = [3 2]; % line segment end point, [x y] coordinates
 
 % define the square. 
 % instead of defining the four corners, describe the square as a bounding box.
 % first row is set of min coordinates, second row is set of max coordinates.
 % first column is x coordinate, second column is y coordinate.
 sq = [2 1;6 5];   
 
 % now, the code below tests if the line segment start and end points are covered by the square.
 % note that this code works for d-dimensional space for cases 1-4 below.
 
 % for each line segment start point coordinate, test if it is >= both the min and max square coordinates
 tmpS = s >= sq; 
 
 % if the line segment start point coordinates are all >= the square min coordinates, 
 % and the line segment start point coordinates are all < the square max coordinates, 
 % then the line segment start point is covered by the square.
 
 coveredS = all(tmpS(1,:) == 1) && all(tmpS(2,:) == 0);
 
 % now simply do the same for the end point line segment
 tmpE = e >= sq; 
 coveredE = all(tmpE(1,:) == 1) && all(tmpE(2,:) == 0);
 
 % now there is enough information to test if we are in cases 1,2, and 3.
 if coveredS == false && coveredE == true
     disp('Case 1: line segment enters a square');
 elseif coveredS == true && coveredE == false
     disp('Case 2: line segment exits a square');
 elseif coveredS == true && coveredE == true
     disp('Case 3: line segment within a square');
 else
     disp('Case still unknown! Both start and end points are outside of square');
 end
 
 % for case 4 create a bounding box around the line segement and
 % compare it to the square
 bb = [min([s; e]); max([s; e])]; % line segment bounding box
 
 % if any of the line seg bounding box min coordinates are > the square max
 % coordinates, or any of the line seg bounding box max coordinates are <
 % the square min coordinates, then the line seg bb does not cover any part
 % of the square.
 if any(bb(1,:) > sq(2,:) == 1) || any(bb(2,:) < sq(1,:) == 1)
     disp('Case 4: line segment is far and does not intersect square');
 end
 
 % now, if all the above checks fail, then the line seg bounding box
 % partially (or fully) covers the square, and the line seg start and end 
 % points are not covered by the square.  But, we do not know if the line 
 % segment in this state intersects the square or not.  An additional check 
 % must be made here.
 
 % so this is the question of my post - what is the the most efficient code
 % that can check this state, and also works for d-dimensional space?
 
 
 
 