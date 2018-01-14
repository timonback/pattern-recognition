data = load('data/checkerboard.mat');
data = data.checkerboard;

k=100; % 100 clusters
series=10; % take minimum from 10 series
runs=20; % Each serie has 20 runs

results=[];
for serie=1:series
    serie_result=[];
    for run=1:runs
        disp(['Running round ' num2str(run) ' in serie ' num2str(serie)])
        [error_q, reference, deriv] = my_kmeans_quant(data, k, 0);
        [error_q2, reference2, deriv2] = my_kmeans_quant(data, k, 1);

        serie_result(end+1,:)=[  error_q(error_q==min(error_q)) ...
                        error_q2(error_q2==min(error_q2))];
    end
    
    results(end+1, :) = [
        min(serie_result(:, 1))
        min(serie_result(:, 2))
    ];
end

hold off;
plot(1:length(results), results(:,1), 1:length(results), results(:,2));
legend('normal kmeans','kmeans++')
title(['Error over ' num2str(runs) ' using k=' num2str(k)])
xlabel('Run')
ylabel('Quantizied error')
print('kmeans_vs_kmeansPP.png', '-dpng')

mean_kmeans = mean(results(:, 1));
mean_kmeans_plus = mean(results(:, 2));
std_kmeans = std(results(:, 1));
std_kmeans_plus = std(results(:, 2));

[h,p] = ttest2(results(:, 2),results(:, 1),'Vartype','unequal','Tail','left');
disp(['the p value is ' num2str(p)])

