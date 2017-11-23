# Lab 1 - Assignment 1

Consider the 24x3 array in the file lab1_1.mat. Each row is a three-dimensional (3D) feature vector. The first element of each vector is the height of a person in centimeters; the second element is the age in years; the third element is the body weight in kilograms.

1. Compute the pair-wise correlation coefficients ci,j between the features (elements of the vectors), where i and j are the indices of the columns in the considered 24x3 array. The correlation coefficient of two features is equal to their (unbiased) covariance divided by the square root of the product of their variances, see the file `Statistics reminder', week0 in section 'Lecture slides'.

2. Create 2D scatter plots of the data points with x- and y-axis being:
 - plot A: the two features for which the correlation coefficient is largest,
 - plot B: the two features for which the correlation coefficient is second largest.
 


Some of the following matlab functions may be useful for this or the following assignment:
  axis square, corrcoef, load, plot, hold on, hist, bar, length, find, rand, scatter, sprintf, sum, xor, normpdf, normcdf
