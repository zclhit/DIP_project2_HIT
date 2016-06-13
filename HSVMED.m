%Name: HSV feature MED
%Function: Use MED to determind a picture's group
%Author:    Changle Zhang, zhangchanglehit@163.com
clc;
clear all;
close all;
%Initilization
load hsvfeature5groups.mat;

pathname='E:\cl\DIP\Pro2_15S158746_张常乐\Pro2_15S158746_张常乐\Fruit Samples For Project2';           %^^change this to make analysis among NC or PSD/or AD
cd(pathname);
dirs=dir;
dircell=struct2cell(dirs)';
filename=dircell(3:12,1);
results=cell(11,10);
for num=1:10
    cd(char(filename(num)));
    results(11,num)=filename(num);
    hsvs=load('hsvmean.txt');
    for i=1:10
        test=hsvs(i,:);
        distance=zeros(10,1);
        for j=1:10
            distance(j)=(test(1)-features(j,1))^2+(test(2)-features(j,2))^2+(test(3)-features(j,3))^2;
        end
        position=find(distance==min(distance));
        results(i,num)=filenames(position);
    end
    cd(pathname);
end
%save ('hsvresults.txt','results');