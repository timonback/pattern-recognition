function [error_q, reference, deriv] = my_kmeans_quant(data, kvalues, plusplus)
    % Calculates the quanifization error using kmeans
    % with the data for k's in kvalues.
    % If plusplus == 1, then the fast kmeans prototype initialization is
    % used

    error_q=[];reference=[];deriv=[];
    d=2;
    for k = unique([1 kvalues])
        % calculate kmeans
        prototypes = my_kmeans_prototypes(data, k, plusplus);
        [means, closest, ~] = my_kmeans(data, k, prototypes);

        error = 0;
        for means_i = 1:length(means)
            data_means_i = data(closest == means_i,:);
            %data_means_diff = bsxfun(@minus, data_means_i, means(means_i, :));
            data_means_diff = arrayfun(@(i) euclideanDistance(data_means_i(i, 1), data_means_i(i, 2), means(means_i, 1), means(means_i, 2)), 1:length(data_means_i));
            error = error + 0.5 * sum(data_means_diff.^2);
        end

        error_q(end+1) = error;
        reference(end+1) = error_q(1) * k^(-2/d);
        deriv(end+1) = reference(end) / error_q(end);
    end
end