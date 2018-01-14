function [mu_pos] = my_kmeans_prototypes(data, k, plusplus)
    % Chooses k prototypes from the data
    if plusplus == 1
        index = randi(length(data));
        mu_pos = data(index, :);
        
        % take more prototypes
        for notneeded = 2:k
            probs = [];
            for data_i=1:length(data)
                data_point = data(data_i, :);
                data_dist = arrayfun(@(i) euclideanDistance(...
                    data_point(1), data_point(2),...
                    mu_pos(i,1), mu_pos(i,2)),...
                    1:size(mu_pos,1));

                probs(end+1)=min(data_dist);
            end
            probs = probs.^2;
            
            index = randsample(1:size(data,1),1,true,probs);
            mu_pos(end+1,:) = data(index, :);
        end
    else
        mu_pos = data(randperm(length(data), k), :);
    end
end