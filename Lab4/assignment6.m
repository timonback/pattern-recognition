
image = imread('dogGrayRipples.png');
image = im2double(image);

Y = fft2(image);
Y_shifted = fftshift(Y);
% show Fourier space
showFFT(Y_shifted)

% apply a 9x9 gaussian filter on two center spots found in the Fourier
% space
gauss_size = 9;
gauss_filter = 1 - 50*fspecial('gaussian',gauss_size,4);
centers = [121 167; 181 167];
for center=centers'
    top_l = center(1)-floor(gauss_size/2);
    top_r = center(1)+floor(gauss_size/2);
    bottom_l = center(2)-floor(gauss_size/2);
    bottom_r = center(2)+floor(gauss_size/2);
    original = Y_shifted(top_l:top_r, bottom_l:bottom_r);
    updated = original .* gauss_filter;
    Y_shifted(top_l:top_r, bottom_l:bottom_r) = updated;
end

% Do additional adjustments
Y_shifted(121,167)=Y_shifted(121,167)*0.4;
Y_shifted(181,167)=Y_shifted(121,167)*0.4;

% show updated Fourier space
figure; showFFT(Y_shifted)

% retranslate the image and save
image_improved = ifft2(fftshift(Y_shifted));
imwrite(image_improved, 'dog.tif');

function showFFT(image_shifted)
    F = abs(image_shifted); % Get the magnitude (of the complex number)
    F = log(F+1); % Use log, for perceptual scaling, and +1 since log(0) is undefined
    F = mat2gray(F); % Use mat2gray to scale the image between 0 and 1

    imshow(F,[]);
    axis on;
    grid on;
end
