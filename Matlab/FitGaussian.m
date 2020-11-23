function gauss_data = FitGaussian(data)

    % code taken from: https://www.mathworks.com/matlabcentral/fileexchange/50412-transform-data-to-gaussian-distribution
    
    % make linear array over range of data
    N = size(data,1);
    peak=max(data); 
    trough=min(data); 
    inc=(peak-trough)/(N-1);
    lin_array=trough:inc:peak;

    % make pseudo CPDF 
    sdata=sort(data);  % sort data
    uniform_data=interp1(sdata,lin_array,data);  % transform to uniform distributed data

    % warning, data now equal to values in lin_array
    % normalize data between 0-1
    u1_data=uniform_data/(max(uniform_data)-min(uniform_data));  
    u1_data=u1_data -min(u1_data);

    % generate Gaussian pdf and cpdf
    inc2=0.1;
    lin2_array=-5:inc2:5;
    gauss_array=(1/(2*pi))^0.5*exp(-((lin2_array-mean(lin2_array)).^2)/2);  
    area_1=sum(gauss_array)*inc2;  % check
    cpdf_gauss=cumsum(gauss_array*inc2);  % cpdf
    gauss_data=interp1(cpdf_gauss,lin2_array,u1_data);
    
    minData = min(gauss_data);
    for i = 1:size(gauss_data,1) % set any NaN to the smallest number
        if isnan(gauss_data(i)) == 1
            gauss_data(i) = minData * 2;
        end
    end

end