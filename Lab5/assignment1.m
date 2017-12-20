
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
points = points(randperm(size(points, 1)), :);

% prototype = w
% three prototypes. One belongs to class 1, 2 to class 2
w = [A(1,1) A(1,2) 1; ...
    A(2,1) A(2,2) 1; ...
    B(1,1) B(1,2) 2];

figure;
hold off;
scatter(A(:, 1), A(:, 2), 'b')
hold on;
scatter(B(:, 1), B(:, 2), 'r')

plot(w(:,1), w(:,2), 'go')

% Run the lvq algorithm
[w, trainingErrors] = lvq(points, w);

% Question 4
hold off;
plot(1:size(trainingErrors,1), trainingErrors(:, 1))
title('Change of the training errors over the LVQ epochs')
xlabel('Epoch')
ylabel('Training error')
print('data_curve_global.png', '-dpng')


% Question 5
% REDO
hold off;    
title('Classification of the classes A and B')

ax1 = subplot(2,2,1);
plot(1:size(trainingErrors,1), 1- trainingErrors(:, 2) / 100)
xlabel('Epoch')
ylabel('Correctly classified A')

ax2 = subplot(2,2,2);
plot(1:size(trainingErrors,1), trainingErrors(:, 2) / 100)
xlabel('Epoch')
ylabel('Incorrectly classified A')

ax3 = subplot(2,2,3);
plot(1:size(trainingErrors,1), 1 - trainingErrors(:, 3) / 100)
xlabel('Epoch')
ylabel('Correctly classified B')

ax4 = subplot(2,2,4);
plot(1:size(trainingErrors,1), trainingErrors(:, 3) / 100)
xlabel('Epoch')
ylabel('Incorrectly classified B')

axis([ax1 ax2 ax3 ax4],[1 size(trainingErrors,1) 0 1])
print('data_curves.png', '-dpng')


% Question 6
hold off;
title('Classification of the classes A and B')

[x,y] = classifiedPoints(points, w, 1, 1);
ax1 = subplot(2,2,1);
scatter(x, y)
xlabel('')
ylabel('')
title('Points of Class A classified as A')

[x,y] = classifiedPoints(points, w, 1, 2);
ax2 = subplot(2,2,2);
scatter(x, y)
xlabel('')
ylabel('')
title('Points of Class A classified as B')

[x,y] = classifiedPoints(points, w, 2, 1);
ax3 = subplot(2,2,3);
scatter(x, y)
xlabel('')
ylabel('')
title('Points of Class B classified as A')

[x,y] = classifiedPoints(points, w, 2, 2);
ax4 = subplot(2,2,4);
scatter(x, y)
xlabel('')
ylabel('')
title('Points of Class B classified as B')

axis([ax1 ax2 ax3 ax4], [0 10 0 10]);
print('data_classified.png', '-dpng')


function [x,y] = classifiedPoints(points, w, point_c, classified_c)
    % Return all x,y coordinated of points that have the class point_c
    % and are classified as classified_c
    
    x = [];
    y = [];
    
    for point_index=1:length(points)
        point = points(point_index, :);
        if(point(3) == point_c)
            w_dist = [
                euclideanDistance(point(1), point(2), w(1,1), w(1,2)) ...
                euclideanDistance(point(1), point(2), w(2,1), w(2,2)) ...
                euclideanDistance(point(1), point(2), w(3,1), w(3,2))
            ];

            w_closest_index = find(w_dist==min(w_dist));
            w_closest_c =  w(w_closest_index, 3);
            if(classified_c == w_closest_c)
                x = [x;point(1)];
                y = [y;point(2)];
            end
        end
    end
end
