%Name: RGB feature MED
%Function: Sort the RGB feature
%Author:    Changle Zhang, zhangchanglehit@163.com
clc;
clear all;
close all;
%Initilization
load RGBfeature.mat;

pathname='E:\cl\DIP\Pro2_15S158746_张常乐\Fruit Samples For Project2\青苹果';           %^^change this to make analysis among NC or PSD/or AD
cd(pathname);
rgbs=load('rgbmean.txt');

results=cell(10,1);
for i=1:10
    test=rgbs(i,:);
    distance=zeros(10,1);
    for j=1:10
        distance(j)=(test(1)-features(j,1))^2+(test(2)-features(j,2))^2+(test(3)-features(j,3))^2;
    end
    position=find(distance==min(distance));
    results(i)=filenames(position);
end