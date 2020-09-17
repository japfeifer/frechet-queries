% Angular Similarity Distance
% This distance is a metric, as opposed to the cosine distance which is not

function dist = AngSimDist(v1,v2)

    dist = 1 - (acos(VectorCosDist(v1,v2))/pi);

end
