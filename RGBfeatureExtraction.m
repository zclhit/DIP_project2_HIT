%Name: RGB feature、 extraction
%Function: Extract ROI in a RGB image
%Author:    Changle Zhang, zhangchanglehit@163.com
clc;
clear all;
close all;
%Initilization
%rgbimg=imread('Fruit Samples For Project2/澳洲蜜桔/澳洲蜜桔_image069.jpg');

pathname='E:\Pro2_15S158746_张常乐\Fruit Samples For Project2\纽荷剂橙';           %^^change this to make analysis among NC or PSD/or AD
cd(pathname);

dirs=dir;
dircell=struct2cell(dirs)';
filenames=dircell(:,1);
rgbmean=zeros(10,3);        %预分配平均参数
for number=3:12
%figure;
%imshow(rgbimg);
rgbimg=imread(char(filenames(number)));
r=rgbimg(:,:,1);
g=rgbimg(:,:,2);
b=rgbimg(:,:,3);
% imshow(r);
% figure;
% imshow(g);
% figure;
% imshow(b);
grayimg=rgb2gray(rgbimg);
% imshow(grayimg);
hsvimg=rgb2hsv(rgbimg);
H=hsvimg(:,:,1);
S=hsvimg(:,:,2);
V=hsvimg(:,:,3);
% figure;
% imshow(H);
% title('H');
% figure;
% imshow(S);
% title('S');
% figure;
% imshow(V);
% title('V');

%rgb = imread('pears.png');%读取原图像
I = S;%转化为灰度图像
hy = fspecial('sobel');%sobel算子
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');%滤波求y方向边缘
Ix = imfilter(double(I), hx, 'replicate');%滤波求x方向边缘
gradmag = sqrt(Ix.^2 + Iy.^2);%求摸
%3.分别对前景和背景进行标记：本例中使用形态学重建技术对前景对象进行标记，首先使用开操作，开操作之后可以去掉一些很小的目标。
se = strel('disk', 20);%圆形结构元素
Io = imopen(I, se);%形态学开操作
Ie = imerode(I, se);%对图像进行腐蚀
Iobr = imreconstruct(Ie, I);%形态学重建
Ioc = imclose(Io, se);%形态学关操作
Iobrd = imdilate(Iobr, se);%对图像进行膨胀
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));%形态学重建
Iobrcbr = imcomplement(Iobrcbr);%图像求反
bw = im2bw(Iobrcbr, graythresh(Iobrcbr));%转化为二值图像
%figure;
%imshow(bw), %显示二值图像
%title('Thresholded opening-closing by reconstruction')
bww=im2uint8(bw)/255;
rgbimg(:,:,1)=bww.*rgbimg(:,:,1);
rgbimg(:,:,2)=bww.*rgbimg(:,:,2);
rgbimg(:,:,3)=bww.*rgbimg(:,:,3);
%figure;
%imshow(rgbimg);

imgsize=size(grayimg);
counter=0;
rgb=[0 0 0];
rgb=double(rgb);
for i=1:imgsize(1)
    for j=1:imgsize(2)
        if bww(i,j)>0
            rgb(1)=rgb(1)+double(rgbimg(i,j,1));
            rgb(2)=rgb(2)+double(rgbimg(i,j,2));
            rgb(3)=rgb(3)+double(rgbimg(i,j,3));
            counter=counter+1;
        end
    end
end
rgbmean(number-2,:)=rgb/counter;
end
allrgbmean=mean(rgbmean);
save('rgbmean.txt','rgbmean','-ascii');
save('allrgbmean.txt','allrgbmean','-ascii');
% %行边界
% for i = 1:imgsize(1)
%     sumrow(i)=sum(bww(i,:));
% end
% %列边界
% for j = 1:imgsize(2)
%     sumcol(j)=sum(bww(:,j));
% end
% for x=1:imgsize(1)
%     if sumrow(x)>0
%         Seg(x,:,1)=rgbimg(x,:,1);
%         Seg(x,:,2)=rgbimg(x,:,2);
%         Seg(x,:,3)=rgbimg(x,:,3);
%     end
% end
% counter=1;
% for y=1:imgsize(2)
%     if sumcol(y)>0
%         Seg1(:,counter,1)=Seg(:,y,1);
%         Seg1(:,counter,2)=Seg(:,y,2);
%         Seg1(:,counter,3)=Seg(:,y,3);
%         counter=counter+1;
%     end
% end
% imshow(Seg1);

