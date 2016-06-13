%Name: mainG5
%Function: Get the accury for SIFT in group 5
%Author:    Changle Zhang, zhangchanglehit@163.com
clc;
clear all;
close all;
%初始化
pathname='E:\cl\DIP\Pro2_15S158746_张常乐\Pro2_15S158746_张常乐\testsample\G5';           %^^change this to make analysis
cd(pathname);
dirs=dir([,'*.jpg']);
dircell=struct2cell(dirs)';
filenames=dircell(:,1);
accury=0;

for i=1:100
    testsample=round(20*rand);
    
    
    test=char(filenames(testsample));
    
    
    alla=0;
    allb=0;
    
    for num=1:10
        if num~=testsample
            [numa(num),m1,m2]=match(test,char(filenames(num)));
            alla=alla+m2;
        end
    end
    a=sum(numa)/alla;
    
    for num=11:20
        if num~=testsample
            [numb(num),m1,m2]=match(test,char(filenames(num)));
            allb=allb+m2;
        end
    end
    
    b=sum(numb)/allb;
    if a>=b
        test='番石榴';
        testnum=1;
    end
    
    if a<b
        test='青苹果';
        testnum=2;
    end
    if ((testnum==1)&&(testsample<=10))||((testnum==1)&&(testsample>=10))
        accury=accury+1;
    end
end
accury