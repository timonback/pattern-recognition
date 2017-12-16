
% Question 2
hold off;
image  = imread('chess.jpg');
image = rgb2gray(image); % Convert rgb to grayscale
BW = edge(image, 'Canny');
%imshow(BW)

[H,theta,rho] = hough(BW);

imshow(imadjust(mat2gray(H)),[], ... 
    'XData',theta,... 
    'YData',rho,... 
    'InitialMagnification','fit'); 
xlabel('\theta (degrees)') 
ylabel('\rho') 
axis on 
axis normal 
hold on 

% Question 3
P = houghpeaks(H,15);

x = theta(P(:,2)); 
y = rho(P(:,1)); 
plot(x,y,'s','color','red');
print('chess_houghpeaks_15.png', '-dpng')

% Question 4
hold off;
lines = houghlines(image,theta,rho,P,'FillGap',5,'MinLength',7);
imshow(image), hold on
title('Detected lines on chess.jpg')
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
end
print('chess_lines.png', '-dpng')
