function myhoughline(image, rho, theta)
  x = 0:size(image, 2);
  y = (rho - x * cos(theta * pi / 180) )/ sin (theta * pi / 180);
  
  hold off;
  imshow(image);
  title('Strongest line in the given image')
  hold on;
  plot(x,y,'Color','r','LineWidth',2);
end