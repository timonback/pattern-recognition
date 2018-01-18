function [error] = sumOfSquaredError(points)
    mu = mean(points);
    if size(points) == [1 2]
        mu = points;
    end
    
    error = 0;
    for pos=1:size(points,1)
        dist = points(pos,:) - mu;
        dist2 = dist.^2;
        error = error + sum(dist2);
    end
end