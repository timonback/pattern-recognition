
mu1 = 5;
mu2 = 7;
variance = 4;

xStar = 10;

X = [-5:0.2:15];
dist1 = normpdf(X, mu1, variance);
dist2 = normpdf(X, mu2, variance);

hold off;
plot(X, dist1);
hold on;
plot(X, dist2);
print('dists.png', '-dpng')

falseAlarm = 1 - normcdf([xStar], mu1, sqrt(variance));
hit = 1 - normcdf([xStar], mu2, sqrt(variance));

d1 = discriminant(5, 7, sqrt(variance));
d2 = discriminant(5, 9, sqrt(variance));
% mu3 = +- d * variance + mu1
d3_mu = 3 * sqrt(variance) + 5;



% high distance = high discrimination


%%% ROC
mat31 = load('../Data/lab3_1.mat');
mat31 = mat31.outcomes;
mat31_length = length(mat31);
mat31_11 = sum(ismember(mat31, [1 1], 'rows')) / mat31_length; % hit true positive
mat31_10 = sum(ismember(mat31, [1 0], 'rows')) / mat31_length; % true negative
mat31_01 = sum(ismember(mat31, [0 1], 'rows')) / mat31_length; % false alarm/ false positive
mat31_00 = sum(ismember(mat31, [0 0], 'rows')) / mat31_length; % false negative

hold off;
roc_X = [0:0.01:1];
roc_Y = roc_X;
plot(roc_X, 1);
hold on;
plot(mat31_01, mat31_11, 'r*')
print('roc.png', '-dpng')


roc_mu1 = 1;
roc_mu2 = 4.1; % Found by try and error
for x=0:0.1:100
    roc_falseAlarm = 1 - normcdf([x], roc_mu1, sqrt(variance));
    roc_hit = 1 - normcdf([x], roc_mu2, sqrt(variance));
    plot(roc_falseAlarm, roc_hit, 'bo')
end
print('roc_matched.png', '-dpng')

roc_d = abs(roc_mu2 - roc_mu1) / sqrt(variance);
