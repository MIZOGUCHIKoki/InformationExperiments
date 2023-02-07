img = imread('kut.jpg');
red = 256 - img(:,:,1);
green = 256 - img(:,:,2);
blue = 256 - img(:,:,3);

result = img;
result(:,:,1) = red;
result(:,:,2) = green;
result(:,:,3) = blue;
imshow(result);
