
% Question 1
A = importdata('data_lvq_A.mat');
B = importdata('data_lvq_B.mat');

% Add class label to matrix
A = [A (ones(size(A, 1), 1).*1)];
B = [B (ones(size(B, 1), 1).*2)];

split_amount = 10;
errors = [];
for split_index=1:split_amount
    w = [A(1,1) A(1,2) 1; ...
        A(2,1) A(2,2) 1; ...
        B(1,1) B(1,2) 2];
    
    % Split the data
    [A_split, A_splitI] = getDataSplit(A, split_amount, split_index);
    [B_split, B_splitI] = getDataSplit(B, split_amount, split_index);
    split = [A_split; B_split];
    splitI = [A_splitI; B_splitI];

    % Apply the algorithm with the inverse of the split (everything without
    % the split)
    [w, trainingErrors]  = lvq(splitI, w);

    % Valiate the result with the original split
    [error, c1, c2] = trainingError(split, w);
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
    text(i-0.2, errors(i)+0.02, num2str(errors(i)), 'VerticalAlignment', 'top', 'FontSize', 8)
end
title('Training error based on the 10-folded split')
xlabel('Split number')
ylabel('Training error')
print('data_error_bar.png', '-dpng')

function [D, I] = getDataSplit(data, n, index)
    % Splits a data set data into n parts and returns the i-th part
    % D = the split data, I the inverse (everything else)
    
    dataLength=floor(size(data,1) / n);
    startIndex = (index-1)*dataLength +1;
    endIndex = index*dataLength;
    D = data(startIndex:endIndex, :);
    I = [data(1:startIndex-1, :); ...
        data(endIndex+1:end, :)];
end