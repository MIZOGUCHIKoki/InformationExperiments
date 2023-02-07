close all;

close all;

result = zeros(256,256);
[H, W] = size(result);
for y = 1:H
    for x = 1:W
        result(y,x) = sin(2 * pi / (256 / 16) * x) + 1;
    end
end
imshow(result,[0 2]);