function [res] = classifyPoints(points, w)
    % Classify all points in the third column with the closest prototype
    % (w) using the index of w
    
    res = zeros(length(points), 3);
    res(:,1:2) = points(:, 1:2);
    
    for point_index=1:length(points)
        point = points(point_index, :);
        
        % calc the distance between the prototypes and the point
        w_dist = arrayfun(@(i) euclideanDistance(point(1), point(2), w(i,1), w(i,2)), 1:size(w,1));
%             w_dist = [
%                 euclideanDistance(point(1), point(2), w(1,1), w(1,2)) ...
%                 euclideanDistance(point(1), point(2), w(2,1), w(2,2)) ...
%                 euclideanDistance(point(1), point(2), w(3,1), w(3,2))
%             ];

        w_closest_index = find(w_dist==min(w_dist));
        res(point_index, 3) = w_closest_index;
    end
end