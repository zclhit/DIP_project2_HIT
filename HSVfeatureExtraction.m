%Name: HSV feature、 extraction
%Function: Extract ROI feature from HSV images
%Author:    Changle Zhang, zhangchanglehit@163.com
clc;
clear all;
close all;
%Initilization

pathname='E:\Pro2_15S158746_张常乐\Fruit Samples For Project2\雪山白苹果';           %修改文件夹名称
cd(pathname);

dirs=dir([,'*.jpg']);
dircell=struct2cell(dirs)';
filenames=dircell(:,1);
hsvmean=zeros(10,3);             %预分配平均参数
for number=1:10

rgbimg=imread(char(filenames(number)));
r=rgbimg(:,:,1);
g=rgbimg(:,:,2);
b=rgbimg(:,:,3);

grayimg=rgb2gray(rgbimg);

hsvimg=rgb2hsv(rgbimg);
H=hsvimg(:,:,1);
S=hsvimg(:,:,2);
V=hsvimg(:,:,3);


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
bww=double(bw);
hsvimg(:,:,1)=bww.*hsvimg(:,:,1);
hsvimg(:,:,2)=bww.*hsvimg(:,:,2);
hsvimg(:,:,3)=bww.*hsvimg(:,:,3);
%figure;
%imshow(rgbimg);

imgsize=size(grayimg);
counter=0;
hsv=[0 0 0];
hsv=double(hsv);
for i=1:imgsize(1)
    for j=1:imgsize(2)
        if bww(i,j)>0
            hsv(1)=hsv(1)+double(hsvimg(i,j,1));
            hsv(2)=hsv(2)+double(hsvimg(i,j,2));
            hsv(3)=hsv(3)+double(hsvimg(i,j,3));
            counter=counter+1;
        end
    end
end
hsvmean(number,:)=hsv/counter;
end
allhsvmean=mean(hsvmean);
save('hsvmean.txt','hsvmean','-ascii');             %保存每幅图像的ROI内hsv均值参数信息
save('allhsvmean.txt','allhsvmean','-ascii');       %保存整个类内ROI hsv均值参数信息
