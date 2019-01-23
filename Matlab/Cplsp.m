% This function is written originally by Alec Jacobson
% http://www.alecjacobson.com/weblog/?p=1486

% returns point q on line segment a to b, that is closest to point p
% works for d-dimensional space

function [q] = Cplsp(a,b,p)  % closest point on line segment to point p
  ab = (b-a);  % vector from a to b
  abSquared = dot(ab,ab);  % squared distance from a to b
  if(abSquared == 0)  % a and b are the same point
    q = a;
  else
    ap = (p-a);  % vector from a to p
    t = dot(ap,ab)/abSquared;  % t = [(p-a) . (b-a)] / |b-a|^2
    if (t < 0.0)  % "Before" a on the line segment, just return a
      q = a;
    elseif (t > 1.0)  % "After" b on the line segment, just return b
      q = b;
    else  % "In-between" a and b on the line segment
      q = a + t * ab;  % a + t (b - a)
    end
  end
end