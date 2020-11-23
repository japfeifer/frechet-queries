parfor i=1:1000 % do this to startup the parallel pool
	a=0;
end

tic;
n=10000000;
a=0.5;
b=1;
q=0.0;
w=(b-a)/n;
parfor i=1:n
    q = q + w*bessely(4.5,((n-1)*a+(i-1)*b)/(n-1));
end
q
toc;