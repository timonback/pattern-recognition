# Assignment 1

Consider two normal distributions with different means μ1 = 5 and μ2 = 7 (μ1 < μ2) and equal variances σ2 = 4 (see Fig. 2.19 in book or lecture sheets). Let x* be the value of a decision criterion used to classify an object having a feature with value x in class ω1 for x < x* and in class ω2 for x ≥ x∗.

The integral of the first distribution (with mean μ1) for values of x ≥ x* specifies the probability of wrongly classifying an object from class ω1 into class ω2 to be referred to as a false alarm. The integral of the second distribution for values of x ≥ x* specifies the probability of correctly classifying an object from class ω2 into class ω2, to be referred to as a hit.


Questions 1-2: Let the value of x* be equal to 10 and compute the probabilities of hit (h) and false alarm (fa).

Question 3-5: These questions are about the discriminibility between two distributions.

Questions 7-10: Consider the binary vectors given in file lab3_1.mat. They specifiy the outcomes of a psychometrical experiment in which a test person is presented a visual stimulus that contains or does not contain a given signal and the test person has to specify whether he/she detected the signal. The vectors code for the following outcomes:

- 1 1 	the signal was presented and detected (hit)
- 1 0 	the signal was presented but the person failed to detect it 
- 0 1 	the signal was not presented but the test person indicated to have detected it (false alarm) 
- 0 0 	the signal was not presented and the test person indicated that there was no signal
