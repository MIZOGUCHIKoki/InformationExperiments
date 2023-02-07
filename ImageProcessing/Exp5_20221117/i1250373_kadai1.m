close all;

infile = 'hough.png';

divT=180;
divR=100;
vote=zeros(divR,divT);
img=imread(infile);
[sizex,sizey,ch]=size(img);

gimg = 0.3*img(:,:,1) + 0.59*img(:,:,2) + 0.11*img(:,:,3);

theta_tics=2*pi/divT;
rhomax=hypot(sizex,sizey);
rho_tics=hypot(sizex,sizey)/(divR-1);

for y=1:sizey
    for x=1:sizex
        if gimg(y,x)>128
            for t=0:divT-1
                theta=t*theta_tics;
                rho=x*cos(theta)+y*sin(theta);
                if rho>=0
                    rho_int=int32(rho/rho_tics)+1;
                    vote(rho_int,t+1)=vote(rho_int,t+1)+1;
                end
            end
        end
    end
end
max(max(vote));
figure;
imshow(vote,[0,max(max(vote))]);
result=vote;