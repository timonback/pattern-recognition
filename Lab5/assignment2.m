
% Question 1
A = importdata('data_lvq_A.mat');
B = importdata('data_lvq_B.mat');

% Add class label to matrix
A = [A (ones(size(A, 1), 1).*1)];
B = [B (ones(size(B, 1), 1).*2)];

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
    [w_lvq, trainingErrors]  = lvq(splitI, w);

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
print('data_error_bar.png', '-dpng')

