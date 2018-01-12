function [w, trainingErrors, relevances] = lvq(points, w)
    % Function to run the lvq on points with the prototypes w
    % Both, points and w consist out of three values per row, the x and y
    % and in the third row a value for the associated class
    
    n = 0.01;
    relevance = [0.5 0.5];
    relevances = [relevance];
    
    % START For debugging purposes
    % Draw all data points and initial prototypes
    hold off;
    A = points(points(:, end) == 1, :);
    B = points(points(:, end) == 2, :);
    scatter(A(:, 1), A(:, 2), 'b')
    hold on;
    scatter(B(:, 1), B(:, 2), 'r')
    title('Distribution of data points')
    legend('Class A','Class B')
    plot(w(:,1), w(:,2), 'go')
    % END For debugging purposes

    % Begin of the epoch loop
    continueLoop = 1;
    loopCounter = 0;
    trainingErrors = [];
    lastErrors = 0;
    lastErrorDiff = 0.005;
    lastErrorRepeat = 5;
    while continueLoop
        for point_index=1:length(points)
            point = points(point_index, :);
            
            % calc the distance between the prototypes and the point
            w_dist = arrayfun(@(i) euclideanDistance(point(1), point(2), w(i,1), w(i,2)), 1:size(w,1));
            
            % include relevance
            w_dist = arrayfun(@(i) w_dist(i) * relevance(w(i,3)), 1:length(w_dist));
            
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
            
            % update relevance
            class = w(w_index_closest, 3);
            relevance(class) = relevance(class) - n * w_match;
            relevance = relevance ./ sum(relevance);
        end

        % START For debugging purposes
        % Iterative prototype update
        plot(w(:,1), w(:,2), 'gx')
        % END For debugging purposes

        % Calc the current errors
        [currentError, c1, c2] = trainingError(points, w);
        trainingErrors = [trainingErrors; currentError c1 c2];

        relevances = [relevances; relevance];
        
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
end