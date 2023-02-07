close all;

img_name = 'kut.jpg';

img = imread(img_name);
gimg = 0.3*img(:,:,1) + 0.59*img(:,:,2) + 0.11*img(:,:,3);

imshow(gimg);

[height, width] = size(gimg);
filter = [0 1 0 ; 1 -4 1 ; 0 1 0]
oimg = zeros(height, width);

double(gimg);

for h = 2 : height - 1
    for w = 2 : width - 1
        for y = 1 : 3
            for x = 1 : 3
                % double * uint8 = uint8になるから，事前にuint8をキャストする
                oimg(h, w) = oimg(h, w) + double(gimg(h + y - 2, w + x - 2)) * filter(y, x);
            end
        end
    end
end

% 画像に表示するためのプロセス
oimg = oimg + (255 * 4);
oimg = oimg / 8;
result = uint8(oimg);
figure;
imshow(result);