function [error, c1, c2] = trainingError(points, w)
   % misclassificiation (between 0 and 1)
   misclassified = 0;
   % amount of data points being c1, but misclassified
   c1 = 0;
   % amount of data points being c2, but misclassified
   c2 = 0;
   for point_index=1:length(points)
        point = points(point_index, :);
        % calc the distance between the prototypes and the point
        w_dist = [
            euclideanDistance(point(1), point(2), w(1,1), w(1,2)) ...
            euclideanDistance(point(1), point(2), w(2,1), w(2,2)) ...
            euclideanDistance(point(1), point(2), w(3,1), w(3,2))
        ];

        % find the closest prototype
        w_index_closest = find(w_dist==min(w_dist));
        if(point(3) ~= w(w_index_closest, 3))
            % this point was misclassified
            misclassified = misclassified + 1;
            % individual counters matching the class
            if(point(3) == 1)
                c1 = c1 + 1;
            elseif(point(3) == 2)
                c2 = c2 +1;
            end
        end
   end
   
   error = misclassified / length(points);
end