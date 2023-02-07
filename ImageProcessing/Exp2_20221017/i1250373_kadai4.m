close all;
img_name = 'kut.jpg';
output_name = 'input1_tonemapped.jpg';
img = imread(img_name);

%グレイスケール画像に変換
gimg = 0.3*img(:,:,1) + 0.59*img(:,:,2) + 0.11*img(:,:,3);
[height, width] = size(gimg);
map = zeros(256,1);
oimg = zeros(height,width);

for k=1:256
    map(k) = 255/(150-25) * (k - 1) - 51;
end
figure('Name','課題4_トーンマップ');
plot([0:255],map);
xlim([0 255]);
ylim([0 255]);

for h = 1:height
    for w = 1:width
        oimg(h,w) = map(gimg(h,w) + 1);
    end
end

result = uint8(oimg);
figure('Name','課題4_結果画像');
imshow(result);


count = zeros(1,256);
for k = 0:255
    for h = 1:height
        for w = 1:width
            if result(h,w) == k
                count(k+1) = count(k+1) + 1;
            end
        end
    end
end
figure('Name','課題4_ヒストグラム');
plot([0:255], count);
xlim([0 255]);
