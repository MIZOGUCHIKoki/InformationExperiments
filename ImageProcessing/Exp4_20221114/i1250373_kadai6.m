close all;

img = imread('Lenna.bmp');
gimg = 0.3*img(:,:,1) + 0.59*img(:,:,2) + 0.11*img(:,:,3);

 [H, W] = size(gimg);
 filter = zeros(H,W);
 
 c_x = W/2 + 1;
 c_y = H/2 + 1;
 
 for y = 1:H
     for x = 1:W
         di = (c_x - x)^2 + (c_y - y)^2;
         d = sqrt(di);
         if (d <= 30)
             filter (y, x) = 1;
         end
     end
 end
 %imshow(filter)
 
 % FFT
 fft_img = fft2(gimg);
 shift = fftshift(fft_img);
 j = abs(shift);
 power = log(1 + j);

 colormap(gray);
 imagesc(power)
 axis image;
 
 %FFT適用
 fil_img = shift .* filter;

 imshow(real(fil_img));
 
 IFFT_SHIFT = ifftshift(fil_img);
 IFFT = ifft2(IFFT_SHIFT);
 result = real(IFFT);
 figure;
 colormap(gray);
 imagesc(result);
 axis image;