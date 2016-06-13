%Name: mainG1
%Function: Get the accury for SIFT in group 1
%Author:    Changle Zhang, zhangchanglehit@163.com
clc;
clear all;
close all;
%初始化
pathname='E:\cl\DIP\Pro2_15S158746_张常乐\Pro2_15S158746_张常乐\testsample\G1';           %^^change this to choose group
cd(pathname);
dirs=dir([,'*.jpg']);
dircell=struct2cell(dirs)';
filenames=dircell(:,1);
accury=0;

for i=1:10
    testsample=round(30*rand);
    
    
    test=char(filenames(testsample));
    
    
    alla=0;
    allb=0;
    allc=0;
    
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
    
        
    for num=21:30
        if num~=testsample
            [numc(num),m1,m2]=match(test,char(filenames(num)));
            allc=allc+m2;
        end
    end
    c=sum(numc)/alla;
    if a>=b&&a>c
        test='白梨';
        testnum=1;
    end
    
    if b>=a&&b>c
        test='猕猴桃';
        testnum=2;
    end
    if c>=a&&c>b
        test='雪山白苹果';
        testnum=3;
    end
    if ((testnum==1)&&(testsample<=10))||((testnum==1)&&(testsample>10)&&(testsample<=20))||((testnum==3)&&(testsample>20)&&(testsample<=30))
        accury=accury+1;
    end
end
accury