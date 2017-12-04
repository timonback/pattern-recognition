% Mahalanobis distance 
% https://www.youtube.com/watch?v=spNpfmWZBmg

mu = [3 4];
sigma = [1 0; 0 2];

dim_x1 = -10:0.5:10;
dim_x2 = dim_x1;
[X1, X2] = meshgrid(dim_x1, dim_x2);
Z = mvnpdf([X1(:) X2(:)], mu, sigma);
Z = reshape(Z, length(dim_x1) ,length(dim_x2));

mesh(X1, X2, Z);
xlabel('X1');
ylabel('X2');
zlabel('Propability Density');
print('pdf.png', '-dpng')

% Create first a random distribution using the given parameters
mahal_X = mvnrnd(mu, sigma, 1000000);

% Adjust for the squared values by taking the square root
mahal_10_10 = sqrt(mahal([10 10], mahal_X));
mahal_0_0 = sqrt(mahal([0 0], mahal_X));
mahal_3_4 = sqrt(mahal([3 4], mahal_X));
mahal_6_8 = sqrt(mahal([6 8], mahal_X));
