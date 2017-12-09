
cat1 = load('../Data/lab3_3_cat1.mat');
cat1 = cat1.x_w1;
cat2 = load('../Data/lab3_3_cat2.mat');
cat2 = cat2.x_w2;
cat3 = load('../Data/lab3_3_cat3.mat');
cat3 = cat3.x_w3;

point1 = [0.5 1.0 0]; % u
point2 = [0.31 1.51 -0.5]; % v
point3 = [-1.7 -1.7 -1.7]; % w

% be sure to set the correct h value (1 or 2) depending on the exercise
point1_cat1 = densityEstimation(point1, cat1);
point1_cat2 = densityEstimation(point1, cat2);
point1_cat3 = densityEstimation(point1, cat3);
point2_cat1 = densityEstimation(point2, cat1);
point2_cat2 = densityEstimation(point2, cat2);
point2_cat3 = densityEstimation(point2, cat3);
point3_cat1 = densityEstimation(point3, cat1);
point3_cat2 = densityEstimation(point3, cat2);
point3_cat3 = densityEstimation(point3, cat3);

% postprior
priors = [0.3333 0.3333 0.3333];
prior_denom_p1 = [point1_cat1 point1_cat2 point1_cat3];
prior_denom_p2 = [point2_cat1 point2_cat2 point2_cat3];
prior_denom_p3 = [point3_cat1 point3_cat2 point3_cat3];
postprior_p1_c1 = priors(1) * point1_cat1 / sum(priors .* prior_denom_p1);
postprior_p1_c2 = priors(1) * point1_cat2 / sum(priors .* prior_denom_p1);
postprior_p1_c3 = priors(1) * point1_cat3 / sum(priors .* prior_denom_p1);
postprior_p2_c1 = priors(2) * point2_cat1 / sum(priors .* prior_denom_p2);
postprior_p2_c2 = priors(2) * point2_cat2 / sum(priors .* prior_denom_p2);
postprior_p2_c3 = priors(2) * point2_cat3 / sum(priors .* prior_denom_p2);
postprior_p3_c1 = priors(3) * point3_cat1 / sum(priors .* prior_denom_p3);
postprior_p3_c2 = priors(3) * point3_cat2 / sum(priors .* prior_denom_p3);
postprior_p3_c3 = priors(3) * point3_cat3 / sum(priors .* prior_denom_p3);


% KNN
addpath('../Assignment 2')
point1_knn1 = KNN(point1, 1, [cat1; cat2; cat3], repelem([1 2 3], 10));
point2_knn1 = KNN(point2, 1, [cat1; cat2; cat3], repelem([1 2 3], 10));
point3_knn1 = KNN(point3, 1, [cat1; cat2; cat3], repelem([1 2 3], 10));
point1_knn5 = KNN(point1, 5, [cat1; cat2; cat3], repelem([1 2 3], 10));
point2_knn5 = KNN(point2, 5, [cat1; cat2; cat3], repelem([1 2 3], 10));
point3_knn5 = KNN(point3, 5, [cat1; cat2; cat3], repelem([1 2 3], 10));


function density = densityEstimation(point, class)
  h = 2; % Switch this value to 1 or 2 depending on the exercise

  diff = point - class;
  diff2 = diff.^2;
  phi_summed = sum(diff2');
  phi_denominator = 2 * h^2;
  phis = exp(-phi_summed/phi_denominator);
  
  nominator = sum(phis);
  volume = (h * sqrt(2 * pi)).^3;
  samples = length(class);
  denominator = volume * samples;
  
  density = nominator / denominator;
end
