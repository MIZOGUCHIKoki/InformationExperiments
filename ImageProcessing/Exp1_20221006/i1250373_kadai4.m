result = imread('kut.jpg');
gray = (result(:,:,1) + result(:,:,2) + result(:,:,3)) / 3;
for k = 1:3 
    result(:,:,k) = gray;
end