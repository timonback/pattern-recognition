
image  = imread('cameraman.tif');
BW = edge(image, 'Canny');

[H,theta,rho] = hough(BW);
subplot(1,2,1), imshow(imadjust(mat2gray(H)),[], ... 
    'XData',theta,... 
    'YData',rho,... 
    'InitialMagnification','fit'); 
title('Original')
xlabel('\theta (degrees)') 
ylabel('\rho') 
axis on 
axis normal 


[myH,myTheta,myRho] = myhough(BW);
subplot(1,2,2), imshow(imadjust(mat2gray(myH)),[], ... 
    'XData',myTheta,... 
    'YData',myRho,... 
    'InitialMagnification','fit');
title('myhough');
xlabel('\theta (degrees)') 
ylabel('\rho') 
axis on 
axis normal

print('cameraman_myhough.png', '-dpng')
