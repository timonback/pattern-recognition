% Question 1 + 2
A = importdata('data_lvq_A.mat');
B = importdata('data_lvq_B.mat');

% Add class label to matrix
A = [A (ones(size(A, 1), 1).*1)];
B = [B (ones(size(B, 1), 1).*2)];

ax1 = subplot(1,1,1);
axis(ax1, [0 10 0 10]);
hold off;
scatter(A(:, 1), A(:, 2), 'b')
hold on;
scatter(B(:, 1), B(:, 2), 'r')
title('Distribution of data points')
legend('Class A','Class B')
print('data.png', '-dpng')

% Question 3
points = [A;B];
% shuffle the data
rng(0) % deterministic random
%points = points(randperm(size(points, 1)), :);

% prototype = w
w_1_1 = [A(1, :); B(1, :)];
w_1_2 = [A(1, :); B(1:2, :)];
w = [A(1:2, :); B(1, :)];
% better starting values at the end of the data
w_2_2 = [A(end-1:end, :); B(end-1:end, :)];

hold off;
scatter(A(:, 1), A(:, 2), 'b')
hold on;
scatter(B(:, 1), B(:, 2), 'r')

% Run the lvq algorithm
[~, trainingErrors] = lvq(points, w);

% Question 4
hold off;
plot(1:size(trainingErrors,1), trainingErrors(:, 1))
title('Change of the training errors over the LVQ epochs')
xlabel('Epoch')
ylabel('Training error')
print('data_curve_w.png', '-dpng')


% Question 5
hold off;
[w_1_1_lvq, trainingErrors_w_1_1] = lvq(points, w_1_1);
print('data_progress_w_1_1.png', '-dpng')
[w_1_2_lvq, trainingErrors_w_1_2] = lvq(points, w_1_2);
print('data_progress_w_1_2.png', '-dpng')
[w_lvq, trainingErrors_w] = lvq(points, w);
print('data_progress_w_2_1.png', '-dpng')
[w_2_2_lvq, trainingErrors_w_2_2] = lvq(points, w_2_2);
print('data_progress_w_2_2.png', '-dpng')

hold off;
plot(1:size(trainingErrors_w_1_1,1), trainingErrors_w_1_1(:, 1))
hold on;
plot(1:size(trainingErrors_w_1_2,1), trainingErrors_w_1_2(:, 1))
plot(1:size(trainingErrors_w,1), trainingErrors_w(:, 1))
plot(1:size(trainingErrors_w_2_2,1), trainingErrors_w_2_2(:, 1))
legend('1-1', '1-2', '2-1', '2-2');

print('data_curve.png', '-dpng')


% Question 6
hold off;
title('Classification of the classes A and B')

ax1 = subplot(2,2,1);
[res] = classifyPoints(points, w_1_1_lvq);
scatter(res(:,1), res(:,2), [], res(:,3))
xlabel('')
ylabel('')
title('Classification for 1-1')

ax2 = subplot(2,2,2);
[res] = classifyPoints(points, w_1_2_lvq);
scatter(res(:,1), res(:,2), [], res(:,3))
xlabel('')
ylabel('')
title('Classification for 1-2')

ax3 = subplot(2,2,3);
[res] = classifyPoints(points, w_lvq);
scatter(res(:,1), res(:,2), [], res(:,3))
xlabel('')
ylabel('')
title('Classification for 2-1')

ax4 = subplot(2,2,4);
[res] = classifyPoints(points, w_2_2_lvq);
scatter(res(:,1), res(:,2), [], res(:,3))
xlabel('')
ylabel('')
title('Classification for 2-2')

axis([ax1 ax2 ax3 ax4], [0 10 0 10]);
print('data_classified.png', '-dpng')

