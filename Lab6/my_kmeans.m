function [points, mu_closest, mu_tracking] = my_kmeans(data, k, prototypes)
    % Using Lloyds algorithm
    % prototypes are the initialized prototypes!
    % See my_kmeans_prototypes.m for generation
    
    % prototypes = data(randperm(length(data), k), :);
    
    disp(['Running kmeans with ' num2str(k) ' clusters'])
    
    mu_pos = prototypes;
    mu_last = 0;
    mu_tracking(:, :, 1) = mu_pos;
    
    while ~ isequal(mu_pos, mu_last)
        mu_last = mu_pos;
        mu_closest = [];
    
        for data_i=1:length(data)
            data_point = data(data_i, :);
%             data_dist = arrayfun(@(i) euclideanDistance(...
%                 data_point(1), data_point(2),...
%                 mu_pos(i,1), mu_pos(i,2)),...
%                 1:size(mu_pos,1));
            data_dist = sum((repmat(data_point, k, 1) - mu_pos).^2, 2);

            mu_closest_index = find(data_dist==min(data_dist));
            mu_closest(end+1) = mu_closest_index; 
        end

        for mu_i = 1:size(mu_pos,1)
            closest = data(mu_closest == mu_i,:);
            mu_pos(mu_i,:) = mean(closest);
        end
        mu_tracking(:, :, end+1) = mu_pos;
    end
    
    points = mu_pos;
 end