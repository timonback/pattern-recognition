% Question 1
image  = imread('cameraman.tif');

% Question 2
BW = edge(image, 'Canny');
hold off;
imshow(BW)

% Question 3
[H,theta,rho] = hough(BW);

% Question 4 + 5
imshow(imadjust(mat2gray(H)),[], ... 
    'XData',theta,... 
    'YData',rho,... 
    'InitialMagnification','fit'); 
xlabel('\theta (degrees)') 
ylabel('\rho') 
axis on 
axis normal 
hold on 
colormap(gca, hot)
print('cameraman_hough.png', '-dpng')

% Question 6
houghpeaks_max = 5; % Choosen based on the value for question 8
P = houghpeaks(H, houghpeaks_max,'threshold',ceil(0.999*max(H(:))));

% Question 7
maxima = P(1, :);
% it is [341 46]

% Question 8
P = houghpeaks(H, houghpeaks_max); % recalc because unthresholded
x = theta(P(:,2)); 
y = rho(P(:,1)); 
plot(x,y,'s','color','black');
print('cameraman_houghpeaks_5.png', '-dpng')

% Question 9 + 10
myhoughline(image, rho(maxima(1)), theta(maxima(2)));
print('cameraman_houghline.png', '-dpng')
