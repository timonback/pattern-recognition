function [w, trainingErrors] = lvq(points, w)
    n = 0.01;

    continueLoop = 1;
    loopCounter = 0;
    trainingErrors = [];
    lastErrors = 0;
    lastErrorDiff = 0.01;
    lastErrorRepeat = 5;
    while continueLoop
        for point_index=1:length(points)
            point = points(point_index, :);
            % calc the distance between the prototypes and the point
            w_dist = arrayfun(@(i) euclideanDistance(point(1), point(2), w(1,1), w(i,2)), 1:size(w,1));
%             w_dist = [
%                 euclideanDistance(point(1), point(2), w(1,1), w(1,2)) ...
%                 euclideanDistance(point(1), point(2), w(2,1), w(2,2)) ...
%                 euclideanDistance(point(1), point(2), w(3,1), w(3,2))
%             ];
            
            % determine whether the clostest prototype has the same class
            w_index_closest = find(w_dist==min(w_dist));
            w_match = (point(3) == w(w_index_closest, 3)) * 1;
            if (w_match==0)
                w_match = -1;
            end

            % update x and y coordinates
            w_x_update = n * w_match * (point(1) - w(w_index_closest, 1));
            w_y_update = n * w_match * (point(2) - w(w_index_closest, 2));
            w(w_index_closest, 1) = w(w_index_closest, 1) + w_x_update;
            w(w_index_closest, 2) = w(w_index_closest, 2) + w_y_update;
        end

        % For debug purposes
        plot(w(:,1), w(:,2), 'gx')

        % Calc the current errors
        [currentError, c1, c2] = trainingError(points, w);
        trainingErrors = [trainingErrors; currentError c1 c2];

        % Check if more loop iterations are needed
        loopCounter = loopCounter +1;
        if(abs(mean(lastErrors) - currentError) > lastErrorDiff)
            lastErrors = [currentError];
        else
            if(length(lastErrors) >= lastErrorRepeat)
                continueLoop = 0;
            end
            lastErrors = [lastErrors; currentError];
        end
    end
    fprintf('Stopped LVQ after %d iterations\n', loopCounter);
    print('data_progress.png', '-dpng')
end