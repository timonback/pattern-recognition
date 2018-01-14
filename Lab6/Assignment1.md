Description 	

k-means clustering, quantization error, gap statistic
Instructions 	

hint:  Write your algorithm as a function that takes the 2D array of feature vectors and the number k of means as arguments so that you need not change your code to use it for a different number of means or a different dataset. Initialize the k means as k distinct points randomly chosen from the dataset. You can make use of the provided plot arrow function to illustrate the movement of the means. Use Matlab's subplot() function to combine multiple plots into one image.

1. The file kmeans1.mat contains 2D feature vectors. Implement and apply the k-means clustering algorithm with Euclidean distance to this data for the values k = 2, 4 and 8. As a stop criterion use the condition that none of the data points are re-assigned to a different cluster.

2. For each value of k used, make a scatter plot of the data points and their respective cluster assignments, taking care that the different clusters can easily be distinguished by rendering points that belong to different clusters in different colors and/or shapes. Add the final cluster means to the same plot, making sure they are distinguishable from the data points. Do this for the values k = 2, 4 and 8.

3. For each value of k used, make another plot that shows all intermediate positions of the cluster means computed at the different iterations of the algorithm, indicating which are the starting and ending position of each cluster mean. (You can make use of the provided plot arrow function to illustrate the movement of the means.) Do this for the values k = 2, 4 and 8.

------------

Upon completion of the algorithm for a given value of k, compute the quantization error J(k) as a function of k for k = 1, 2, 3, ... , kmax where kmax is some reasonable number, not larger than the total number of points in the data set. Now, consider a reference function R(k)=J(1)k^(-2/d), where d=2 is the number of dimensions. (Note, that for k=1 the function J and R have equal values, J(1)=R(1).) Next, consider the function D(k)=R(k)/J(k). 

Remark 1: The term k^(-2/d) in the function R(k) mimics the behavior of the quantization error for a data set that is uniformly distributed in the domain occupied by the real data set. The coefficient J(1) in front of it in the expression for R(k) makes sure that J(1) = R(1). For those who want to learn more on this topic, here is a reference: R. Tibshirani, G. Walther, T. Hastie. Estimating the number of clusters in a data set via the gap statistic, Journal of the Royal Statistical Society, Series B 63 (2000), 411–423.

Remark 2: See the lecture slides for the formula of the quantization error. Pay attention to the summation domain and the fact that each data point contributes to the quantization error with (the square of) its distance to only one cluster mean, the one which is nearest to that point. Since the quantization error can vary between runs, depending on the initialization of the cluster means, run the k-means algorithm multiple times and compute J(k) as the average quantization error over different runs with the same value of k.

4. Plot the function D(k) in a figure and determine the value kopt of k for which D(k) reaches its maximum, kopt = argmax k D(k). This is the optimal number of clusters to be used. Mark the position of kopt in the figure. 

5. Plot the functions J(k) and R(k) simultaneously in one figure using different colors and mark the position of kopt in that figure. 

------------

The k-means algorithm can get stuck in local minima, and so the quality of its results depends heavily on the initialization of the cluster-means. The k-means++ algorithm includes a specific procedure for initializing the prototypes of the k-means algorithm such that its solution is close to the optimal k-means solution. The k-means++ algorithm is as follows: 

    Choose one point at random from the set of all data points and let this point be the first prototype. 
    For each data point x, compute D(x), the distance between x and the nearest prototype. (In the beginning, there is only one prototype but later other prototypes are being added, see below.) 
    Choose one new data point at random as a new prototype, using a probability distribution where a point x is chosen with probability proportional to D(x)ˆ2. Thus, a point x is more likely to be selected as a new prototype if this point is far from the  already selected prototypes. 
    Repeat Steps 2 and 3 until k prototypes have been chosen. 
    After k initial prototypes have been chosen, proceed with the standard k-means clustering algorithm.

6. Modify your k-means function to require a third parameter signifying whether k-means++ initialization should be used. Implement k-means++ initialization in your k-means function. 

7. The file checkerboard.mat contains 3700 2D feature vectors. Apply the k-means and k-means++ algorithms to this data set using k=100 and compute the value of the quantization error achieved by each algorithm at convergence. Repeat this procedure 20 times, each time using a different initialization, and compute the minimum quantization error over the 20 runs for each algorithm. 

8. Does the use of k-means++ initialization for this dataset lead to a statistically significant improvement? The context of this question is as follows: for each run of the k-means and the k-means++ algorithm you may get different values of the quantization error. In general, we expect that the k-means++ algorithm will yield a smaller quantization error but it may happen that for some run the quantization error obtained with the simple k-means algorithm is smaller than the quantization error achieved with the k-means++ algorithm for the same or for some other run. If the minimum value of the quantization error obtained with the k-means++ algorithm over the considered 20 runs is smaller than the corresponding minimum value obtained with the k-means algorithm, does this mean that this will still be the case if we perform another 20 runs with the two algorithms? To explore this, we need to conduct a series of 20 runs, let us say 10 series, each time computing the minimum quantization error achieved by an algorithm over a run. Then we need to compute the average and the standard deviation of the minimum values achieved over the series. The certainty with which we can say that k-means++ algorithm outperforms the k-means algorithm depends on the difference of the two averaged minimum values in relation to the corresponding standard deviations (spreads). It can be computed and expressed as a p-value using an unpaired one-tailed two-sample t-test. In this case we will be using the Welch’s t-test. Perform this test and determine the concerned p-value.

Useful matlab functions: sort, scatter, unique, tcdf, randsample, realmax, randperm, voronoi
