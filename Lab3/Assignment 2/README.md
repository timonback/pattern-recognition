# Assignment 2

This assignment is about K-nearest neighbor classification. The wrapper function in the file knn_wrapper.m implements this kind of classification on the given data, and visualizes the results. However, in order for it to work, you must write the function "KNN" (line 18 in knn_wrapper.m), which performs the K-nearest neighbor algorithm.

Given is the data file lab3_2.mat containing 200 2D data points in the space [0, 1] × [0, 1]. The first 100 points belong to class ω1 and the second 100 points belong to class ω2.

The program in file knn_wrapper.m visualizes the results by producing a gray scale image that shows to which class each point in the space belongs (in the case of two classes, black is ω1, and white is ω2).


Question 1: Implement the KNN function with the Euclidean distance. The function should work as follow: For a given K it should return the class to which point (X, Y) belongs based on the data and class_labels variables. The value that your KNN function returns should be one of the class_labels. Write your function in such a way that it works with more than two classes, and with more than two features as well (i.e. given [X Y Z] instead of [X Y] as first parameter) the dimensions of data will then of course be different as well.

Question 2: In this question, you must implement the file knn_wrapper.m for K = 1, 3, 5, 7, and compare the visualization of the results of each case. Note: In the visualization, black is ω1, and white is ω2.

Questions 3-7: The goal of these questions is to find the optimal choice of K using Leave One Out Cross Validation (LOOCV), in which each point is classified based on KNN classification implemented on a copy of the dataset that does not contain the point. The optimal choice should be based on the minimum error-rate.

Questions 8-10: In these questions, you should solve the previous problems assuming there are 4 classes instead of 2. The 4 classes contain the points with indices (1:50, 51:100, 101:150, 151:200). Note: Now in the case where K = 3, for instance, it may happen that all three nearest neighbors are of a different class (similar scenarios exist for higher K). In case of such a tie, make an arbitrary choice. You can for example simply choose the class with the lowest class number.

Note: In this assignment, you are asked to submit part of your code in Question 1. You should use the first question to upload all the code you used to complete this assignment, which should include the segment you submitted in Question 1, as well as any code you used to solve the other questions.

Important: The function KNN that you write and implement in this assignment will be used in Assignment 3.