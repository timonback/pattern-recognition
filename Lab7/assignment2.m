data = load('cluster_data.mat');
data = data.cluster_data;

cluster_max = 4;

% Question 1 + 2 + 4
for type={'single', 'complete', 'average'}
    hold off;
    links = linkage(data,type{1},'euclidean');
    clusters = cluster(links,'maxclust',cluster_max);
    scatter(data(:,1),data(:,2),[],clusters)
    hold on;
    for i=1:cluster_max
        cluster_data = data(clusters==i,:);
        centroid = mean(cluster_data);
        plot(centroid(1), centroid(2), 'rx');
    end
    title(['Clustering using ' type{1} ' linkage']);
    print(['linkage_' type{1} '.png'], '-dpng')
    
    dendrogram(links);
    title(['Dendrogram using ' type{1} ' linkage']);
    print(['dendrogram_' type{1} '.png'], '-dpng')
end