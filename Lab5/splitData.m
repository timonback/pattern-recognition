function [D, I] = splitData(data, n, index)
    % Splits a data set data into n parts and returns the i-th part
    % D = the split data, I the inverse (everything else)
    
    dataLength=floor(size(data,1) / n);
    startIndex = (index-1)*dataLength +1;
    endIndex = index*dataLength;
    D = data(startIndex:endIndex, :);
    I = [data(1:startIndex-1, :); ...
        data(endIndex+1:end, :)];
end