data = load('data/checkerboard.mat');
data = data.checkerboard;

k=100; % 100 clusters
series=10; % take minimum from 10 series
runs=20; % Each serie has 20 runs

% recorded results
% results =[[6.6455 6.3127]; [6.6549 6.291]; [7.2894 5.993]; [6.708 5.6481]; [6.9996 5.6479]; [6.648 5.9798]; [6.9662 6.0473]; [6.9873 6.3078]; [6.6541 5.9764]; [6.9324 5.9718]];

starttime = cputime;
results=[];
for serie=1:series
    serie_result=[];
    for run=1:runs
        disp(['Running round ' num2str(run) ' in serie ' num2str(serie) '. Time used since start: ' num2str(cputime - starttime) 's'])
        [error_q, reference, deriv] = my_kmeans_quant(data, k, 0);
        [error_q2, reference2, deriv2] = my_kmeans_quant(data, k, 1);

        serie_result(end+1,:)=[  error_q(error_q==min(error_q)) ...
                        error_q2(error_q2==min(error_q2))];
    end
    serie_best = [
        min(serie_result(:, 1))
        min(serie_result(:, 2))
    ];
    disp(serie_best);
    
    results(end+1, :) = serie_best;
end

hold off;
plot(1:size(results, 1), results(:,1), 1:1:size(results, 1), results(:,2));
legend('normal kmeans','kmeans++')
title(['Error over ' num2str(series) ' series using k=' num2str(k)])
xlabel('Run')
ylabel('Quantizied error')
print('kmeans_vs_kmeansPP.png', '-dpng')

mean_kmeans = mean(results(:, 1));
mean_kmeans_plus = mean(results(:, 2));
std_kmeans = std(results(:, 1));
std_kmeans_plus = std(results(:, 2));

[h,p] = ttest2(results(:, 2),results(:, 1),'Vartype','unequal','Tail','left');
disp(['the p value is ' num2str(p)])

