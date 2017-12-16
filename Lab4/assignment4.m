
% Question 1
image = imread('HeadTool0002.bmp');
image = im2double(image);

% Question 2
image_histeq = adapthisteq(image);
imshow(image_histeq);

% Question 3
% centers is sorted by strength
[centers, radii, metric] = imfindcircles(image_histeq, [20 40], 'Sensitivity', 0.95);
for i=1:size(centers, 1)
    for j=i+1:size(centers, 1)
        if p_in_circle(centers(i, :), centers(j, :), radii(i))
            % remove the duplicate circles (set metric to zero)
            % the one with the lower confidence (j) is removed
            metric(j)= 0;
        end
    end
end

% Actually remove the duplicates
for i=size(centers, 1):-1:1
    if metric(i) == 0
        metric(i) = [];
        radii(i) = [];
        centers(i, :) = [];
    end
end


% Question 4 + 5
centersStrong = centers(1:8,:); 
radiiStrong = radii(1:8);
imshow(image_histeq)
viscircles(centersStrong, radiiStrong,'EdgeColor','b');
print('HeadTool0002_hough_circles.png', '-dpng')

% Question 6 + 7
centersStrong = centers(1:2,:); 
radiiStrong = radii(1:2);
imshow(image_histeq)
viscircles(centersStrong, radiiStrong,'EdgeColor','b');
print('HeadTool0002_hough_circles2.png', '-dpng')


function inside = p_in_circle(point, circle, radius)
  inside = (point(1) - circle(1))^2 + (point(2) - circle(2))^2 < radius^2;
end
