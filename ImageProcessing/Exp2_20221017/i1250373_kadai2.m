close all;
img_name = 'kut.jpg';

img = imread(img_name);

%グレイスケール画像に変換
gimg = 0.3*img(:,:,1) + 0.59*img(:,:,2) + 0.11*img(:,:,3);
[height, width] = size(gimg);
% グレイスケール画像のヒストグラムを出力
% count = zeros(1,256);
% for k = 0:255
%     for h = 1:height
%         for w = 1:width
%             if gimg(h,w) == k
%                 count(k+1) = count(k+1) + 1;
%             end
%         end
%     end
% end
% % figure;
% % plot([0:255], count);
% % xlim([0 255]);

map = zeros(256,1);
oimg = zeros(height,width);

for k=1:256
    if(k >= 192)
        map (k)=255;
    elseif (k>=128)
        map (k)=170;
    elseif (k>=64)
        map(k)=85;
    else
        map(k)=0;
    end
end
figure('Name','課題2_トーンマップ');
plot([0:255],map);
xlim([0 255]);
ylim([0 255]);

for h = 1:height
    for w = 1:width
        oimg(h,w) = map(gimg(h,w) + 1);
    end
end

result = uint8(oimg);
figure('Name','課題2_結果画像');
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
figure('Name','課題2_ヒストグラム');
plot([0:255], count);
xlim([0 255]);