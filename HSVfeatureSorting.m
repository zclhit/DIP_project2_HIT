%Name: HSV feature sorting
%Function: Sort the HSV feature
%Author:    Changle Zhang, zhangchanglehit@163.com
clc;
clear all;
close all;
%Initilization
pathname='E:\cl\DIP\Pro2_15S158746_张常乐\Pro2_15S158746_张常乐\Fruit Samples For Project2';           %^^change this to make analysis among NC or PSD/or AD
cd(pathname);

dirs=dir;
dircell=struct2cell(dirs)';
filenames=dircell(3:12,1);
features=zeros(10,4);
for i=1:10
    cd (char(filenames(i)));
    x=load('callhsvmean.txt');
    features(i,1:3)=x;
    features(i,4)=i;
    cd(pathname);
end