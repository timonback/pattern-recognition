
% Given feature vector
features = ...
[
    [4 5 6]
    [6 3 9]
    [8 7 3]
    [7 4 8]
    [4 6 5]
];

feature_1 = features(1:end, 1);
feature_2 = features(1:end, 2);
feature_3 = features(1:end, 3);

features_mean = [ ...
    mean(feature_1), ...
    mean(feature_2), ...
    mean(feature_3)
];

covariance = zeros(3,3);
for i = 1:length(covariance)
    for j = 1:length(covariance)
        diff_x = features(1:end, i) - features_mean(i);
        diff_y = features(1:end, j) - features_mean(j);
        diff = diff_x' * diff_y;
        covariance(i, j) = diff / (length(features));
    end
end

covariance

