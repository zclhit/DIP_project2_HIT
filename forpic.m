%画图用
load('hsvfeature.mat');
a=features;
plot3(a(:,1),a(:,2),a(:,3),'b.');
hold on

pathname='E:\cl\DIP\Pro2_15S158746_张常乐\Pro2_15S158746_张常乐\Fruit Samples For Project2';           %^^change this to make analysis among NC or PSD/or AD
cd(pathname);
dirs=dir;
dircell=struct2cell(dirs)';
filenames=dircell(3:12,1);
results=cell(11,10);
for num=1:10
    cd(char(filenames(num)));
    hsvs=load('hsvmean.txt');
    plot3(hsvs(:,1),hsvs(:,2),hsvs(:,3),'r.');
    hold on
    cd(pathname);
end