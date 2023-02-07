img = imread('kut.jpg');
gimg = 0.3*img(:,:,1) + 0.59*img(:,:,2) + 0.11*img(:,:,3);
shifted = bitshift(gimg, -6);
result = imshow(shifted,[0,3]);
