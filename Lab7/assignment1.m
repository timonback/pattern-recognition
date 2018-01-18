data = load('cluster_data.mat');
data = data.cluster_data;

% Question 2-4
dist = pdist(data);
dist = squareform(dist);

thresholds = [0.05 0.1 0.15 0.2 0.25];
for t = thresholds
    subplot(2,3, find(thresholds==t));
    hold off;
    scatter(data(:,1), data(:,2));
    title(['Graph using t<=' num2str(t)]);
    hold on;
    
    [row,col] = find(dist<=t);
    for i=1:size(row,1)
        X = [data(row(i), 1) data(col(i), 1)];
        Y = [data(row(i), 2) data(col(i), 2)];
        line(X, Y);
    end
end
print('distance_graph.png', '-dpng')

% Question 5
t=0.18;
subplot(1,1,1);
hold off;
scatter(data(:,1), data(:,2));
title(['Graph using t<=' num2str(t)]);
hold on;

[row,col] = find(dist<=t);
for i=1:size(row,1)
    X = [data(row(i), 1) data(col(i), 1)];
    Y = [data(row(i), 2) data(col(i), 2)];
    line(X, Y);
end
print('distance_optimal.png', '-dpng')
