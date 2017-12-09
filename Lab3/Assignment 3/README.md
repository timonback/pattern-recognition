# Assignment 3

Consider Parzen-window estimates and a classifier for 3-dimensional data sampled from three categories. The data points are given in the files lab3_3_cat1.mat, lab3_3_cat2.mat and lab3_3_cat3.mat.

Let your Parzen window function be the following spherical Gaussian:

ϕ open parentheses fraction numerator x minus x to the power of left parenthesis j right parenthesis end exponent over denominator h end fraction close parentheses space equals exp open square brackets minus fraction numerator left parenthesis x subscript 1 minus x subscript 1 superscript left parenthesis j right parenthesis end superscript right parenthesis squared plus left parenthesis x subscript 2 minus x subscript 2 superscript left parenthesis j right parenthesis end superscript right parenthesis squared plus left parenthesis x subscript 3 minus x subscript 3 superscript left parenthesis j right parenthesis end superscript right parenthesis squared over denominator 2 h squared end fraction close square brackets

where x subscript i superscript left parenthesis j right parenthesis end superscript is the i-th element of a j-th feature vector x to the power of left parenthesis j right parenthesis end exponent in a given set.

Set h equals 1 and consider the following three points: 

u with rightwards harpoon with barb upwards on top equals open square brackets table row cell 0.5 end cell row cell 1.0 end cell row cell 0.0 end cell end table close square brackets space comma space space space space space space v with rightwards harpoon with barb upwards on top equals open square brackets table row cell 0.31 end cell row cell 1.51 end cell row cell minus 0.50 end cell end table close square brackets space comma space space space space space w with rightwards harpoon with barb upwards on top equals open square brackets table row cell minus 1.7 end cell row cell minus 1.7 end cell row cell minus 1.7 end cell end table close square brackets space space space space space

 


Instructions

Questions 1 to 9: Compute the densities for each of the three classes for the following three points  x element of left curly bracket u with rightwards arrow on top comma v with rightwards arrow on top comma w with rightwards arrow on top right curly bracket. Do this for all three classes in order to obtain the three probability densities in the concerned point x.

Hint: The density for a given point x element of left curly bracket u with rightwards arrow on top comma v with rightwards arrow on top comma w with rightwards arrow on top right curly bracket and class k space left parenthesis k equals 1 comma 2 comma 3 right parenthesis is computed following these steps: 

        Evaluate the function ϕ for the given point x and a data point x to the power of left parenthesis j right parenthesis end exponent comma space j equals 1...10, for the concerned class. Note that ϕ is a product of three Gaussian functions, one for each of the three elements of x and x to the power of left parenthesis j right parenthesis end exponent.
        Sum the results obtained for the different data points x to the power of left parenthesis j right parenthesis end exponent comma space j equals 1...10, of the concerned class.
        Divide the result by a normalization factor left parenthesis h square root of 2 pi end root right parenthesis cubed which is the volume of the Parzen window.
        Divide the result by the number of data points in the concerned class (10).



Questions 10 to 12: Give an estimate of the priors P subscript 1, P subscript 2, and P subscript 3.  (Hint: keep it simple!) 


Questions 13 to 21: Using the obtained values of the priors (Questions 10 to 12), and the densities of the three classes in the concerned points x (Questions 1 to 9), compute the posterior probabilities of the classes for that point. Do this for the three points xgiven. Let the posterior probability of class k space left parenthesis k equals 1 comma 2 comma 3 right parenthesis for point x element of left curly bracket u with rightwards arrow on top comma v with rightwards arrow on top comma w with rightwards arrow on top right curly bracket be denoted as p left parenthesis k vertical line x right parenthesis. 