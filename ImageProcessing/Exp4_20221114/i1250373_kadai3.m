close all;

result = zeros(256,256);
[H, W] = size(result);
for y = 1:H
    for x = 1:W
        result(x,y) = sin(2 * pi / (256 / 4) * x) + 1;
    end
end
imshow(result,[0 2]);