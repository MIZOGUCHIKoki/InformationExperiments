close all
img_name = 'kut.jpg';
output_name = 'input1_tonemapped.jpg';

img = imread(img_name);
[height,width] = size(img);

red = img(:,:,1);
green = img(:,:,2);
blue = img(:,:,3);

mapR = zeros(256,1);
for k=1:256
    if(k >= 192)
        mapR (k)=255;
    elseif (k>=128)
        mapR (k)=170;
    elseif (k>=64)
        mapR(k)=85;
    else
        mapR(k)=0;
    end
end
resultR = zeros(height,width);

for h = 1:height
    for w = 1:width
        resultR(h,w) = mapR(red(h,w) + 1);
    end
end

mapG = zeros(256,1);
for k=1:256
    mapG(k) = 180 * sin(2 * pi / 255 * k) + k;
    mapG(k) = uint8(mapG(k));
end

resultG = zeros(height,width);

for h = 1:height
    for w = 1:width
        resultG(h,w) = mapG(green(h,w) + 1);
    end
end
mapB = zeros(256,1);
for k=1:256
    mapB(k) = 255/(150-25) * k - 15;
end
resultB = zeros(height,width);

for h = 1:height
    for w = 1:width
        resultB(h,w) = mapB(blue(h,w) + 1);
    end
end

% resultR = forfunc(red,mapR);
% resultG = forfunc(green,mapR,img);
% resultB = forfunc(blue,mapR,img);
% 
img(:,:,1) = resultR;
img(:,:,2) = resultG;
img(:,:,3) = resultB;
result = img;
imshow(result);
% 
% function out = forfunc(x,map,img)
% [height,width] = size(img);
% out = zeros(height,width);
%     for h = 1:height
%         for w = 1:width
%             out(h,w) = map(x(h,w) + 1);
%         end
%     end
% end