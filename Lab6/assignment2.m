data=load('data/checkerboard.mat');
data=data.checkerboard;

clf;
epoch_given = [20 100 200 500];
for epoch=epoch_given
    hold off;
    subplot(2,2, find(epoch_given==epoch))
    
    prototypes = batchNG(data, 100, epoch, 1, 2);
    title(['After ' num2str(epoch) ' epochs']);
%     scatter(data(:, 1), data(:, 2));
%     hold on;
%     voronoi(prototypes(:, 1), prototypes(:, 2));
end
print('naturalgas.png', '-dpng')


% Kmeans
initProtos=load('data/clusterCentroids.mat');
initProtos=initProtos.clusterCentroids;

clf;

[prototypes, ~, ~] = my_kmeans(data, 100, initProtos);
hold off;
scatter(data(:, 1), data(:, 2));
title('Kmeans clustering using 100 clusters')
hold on;
scatter(prototypes(:, 1), prototypes(:, 2), 'rx');

[vx,vy] = voronoi(prototypes(:, 1), prototypes(:, 2));
plot(vx,vy,'b-');
xlim([-1 1])
ylim([-1 1])
print('naturalgas_comp_kmeans.png', '-dpng')
