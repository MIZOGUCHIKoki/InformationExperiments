img = imread('kut.jpg');
gimg = 0.3*img(:,:,1) + 0.59*img(:,:,2) + 0.11*img(:,:,3);
result = 256 - gimg;

