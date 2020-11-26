function dist = VectorCosDist(v1,v2)

    dist = dot(single(v1),single(v2)) / (norm(single(v1)) * norm(single(v2)));

end
