function dist = VectorCosDist(v1,v2)

    dist = dot(v1,v2) / (norm(v1) * norm(v2));

end
