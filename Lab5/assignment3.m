% Question 1
A = importdata('data_lvq_A.mat');
B = importdata('data_lvq_B.mat');

% Add class label to matrix
A = [A (ones(size(A, 1), 1).*1)];
B = [B (ones(size(B, 1), 1).*2)];

points = [A;B];
% shuffle the data
rng(0) % deterministic random
%points = points(randperm(size(points, 1)), :);

% prototype = w
w = [A(end-1:end, :); B(end, :)];

% Question 2
% Run the lvq algorithm
[w_lvq, trainingErrors, relevances] = lvq_relevance(points, w);
plot(w_lvq(:,1), w_lvq(:,2), 'go')
print('data_lvq_relevance_progress.png', '-dpng')

% Plot the data
ax1 = subplot(1,1,1);
hold off;
scatter(A(:, 1), A(:, 2), 'b')
hold on;
scatter(B(:, 1), B(:, 2), 'r')
plot(w_lvq(:,1), w_lvq(:,2), 'go')
title('Final positions of prototypes using LVQ global relevance')
legend('Class A','Class B')
print('data_lvq_relevance.png', '-dpng')

% Question 3
hold off;
ax1 = subplot(2,1,1);
plot(ax1, 1:size(trainingErrors,1), trainingErrors(:, 1))
title('Change of the training errors over the LVQ epochs')
xlabel('Epoch')
ylabel('Training error')

ax2 = subplot(2,1,2);
plot(ax2, 1:length(relevances), relevances(:,1), ...
    1:length(relevances), relevances(:,2))
title('Change of the relevances over the LVQ epochs')
xlabel('Epoch')
ylabel('Relevance')
legend('{\lambda}1', '{\lambda}2')

print('data_lvq_relevance_curve.png', '-dpng')


%%%
% Question 4
% code copied from assignment 2

split_amount = 10;
errors = [];
for split_index=1:split_amount    
    % Split the data
    % X_split contains only the subset, X_splitI contains the original X
    % excluding the subset
    [A_split, A_splitI] = splitData(A, split_amount, split_index);
    [B_split, B_splitI] = splitData(B, split_amount, split_index);
    split = [A_split; B_split];
    splitI = [A_splitI; B_splitI];
    
    % Take the initial points out of the training set
    w = [A_splitI(1:2, :); B_splitI(1, :)];

    % Apply the algorithm with the inverse of the split (everything without
    % the split)
    [w_lvq, ~, trainingErrors]  = lvq_relevance(splitI, w);

    % Valiate the result with the original split
    [error, c1, c2] = trainingError(split, w_lvq);
    errors = [errors;error];
end

% Plot the errors
hold off;
subplot(1,1,1)
errors_mean = mean(errors);
%bar(errors, 'BaseValue',errors_mean)
bar(errors)
hold on;
plot(0:length(errors)+1, repelem(errors_mean, 12, 1))
for i = 1:numel(errors)
    text(i-0.2, errors(i)+0.03, num2str(errors(i)), 'VerticalAlignment', 'top', 'FontSize', 8)
end
title('Training error based on the 10-folded split')
xlabel('Split number')
ylabel('Training error')
print('data_lvq_relevance_error_bar.png', '-dpng')
