data = load('provinces.mat');
data = data.provinces;

means = mean(data);
stds = std(data);

transformed=zeros(size(data));
for i=1:size(transformed,1)
    % calc z-score
    transformed(i,:) = (data(i,:) - means) ./ stds;
end

dist = pdist(transformed);
dist = squareform(dist);

% 9 == index of Groningen
% groSimilar == similarity value, groSimilarProvince == province index in
% the original data
groSimilar = min(dist(9,dist(9,:)>0));
groSimilarProvince = find(dist(9,:)==groSimilar);
groDisSimilar = max(dist(9,:));
groDisSimilarProvince = find(dist(9,:)==groDisSimilar);
