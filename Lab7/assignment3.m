x1 = [0 0];
x2 = [2 3];
x3 = [1 4];
x4 = [4 2];
x5 = [3 0];

% Question 1
error1 = sum([...
    sumOfSquaredError([x1; x2; x3])...
    sumOfSquaredError([x4; x5])
])

% Question 2
error2 = sum([...
    sumOfSquaredError([x2; x3; x5])...
    sumOfSquaredError([x1; x4])
])

% Question 3
error3 = sum([...
    sumOfSquaredError([x4])...
    sumOfSquaredError([x1; x2; x3; x5])
])

% Question 4
error4 = sum([...
    sumOfSquaredError([x3; x5])...
    sumOfSquaredError([x1; x2; x4])
])


