clear
clc
image = imread("2.png");
gray = rgb2gray(image);
% imshow(gray);
[ counts , num ]  = imhist(gray);
position = find( counts == max(counts));

[ row, col ] = size(gray);

delta = 15;

for i = 1:row
    for j = 1:col
        if gray(i,j) < position + delta
            if gray(i,j) > position - delta
                gray(i,j) = 255;
            else
                gray(i,j) = 0;
            end
        else
            gray(i,j) = 0;
        end
    end
end

RGB = imread('2.png');%Read the image
Highlight=RGB;
I=rgb2gray(RGB); %transform the image to gray
[x,y]=size(I);   %get the size of the picture
BW=edge(I);      %get the edge of the picture


rho_max=floor(sqrt(x^2+y^2))+1; %由原图数组坐标算出ρ最大值，并取整数部分加1
%此值作为ρ，θ坐标系ρ最大值
accarray=zeros(rho_max,180); %定义ρ，θ坐标系的数组，初值为0。
%θ的最大值，180度

Theta=[0:pi/180:pi]; %定义θ数组，确定θ取值范围

for n=1:x,
    for m=1:y
        if BW(n,m)==1
            for k=1:180
            %将θ值代入hough变换方程，求ρ值
                rho=(m*cos(Theta(k)))+(n*sin(Theta(k)));
                %将ρ值与ρ最大值的和的一半作为ρ的坐标值（数组坐标），这样做是为了防止ρ值出现负数
                rho_int=round(rho/2+rho_max/2);
                %在ρθ坐标（数组）中标识点，即计数累加
                accarray(rho_int,k)=accarray(rho_int,k)+1;
            end
        end
    end
end



%=======利用hough变换提取直线======%
%寻找100个像素以上的直线在hough变换后形成的点
K=1; %存储数组计数器
for rho_n=1:rho_max %在hough变换后的数组中搜索
    for theta_m=1:180
        if accarray(rho_n,theta_m)>=100 %设定直线的最小值。
        case_accarray_n(K)=rho_n; %存储搜索出的数组下标
        case_accarray_m(K)=theta_m;
        K=K+1;
        end
    end
end

%=====把这些点构成的直线提取出来,输出图像数组为I_out===%
I_out=zeros(x,y);
I_jiao_class=zeros(x,y);
for n=1:x,
    for m=1:y
         if BW(n,m)==1
             for k=1:180
              rho=(m*cos(Theta(k)))+(n*sin(Theta(k)));
              rho_int=round(rho/2+rho_max/2);
             %如果正在计算的点属于100像素以上点，则把它提取出来
                for a=1:K-1
                    if rho_int==case_accarray_n(a)&k==case_accarray_m(a)%%%==gai==%%% k==case_accarray_m(a)&rho_int==case_accarray_n(a)
                    I_out(n,m)=BW(n,m); 
                        for p=0:5 %在原RGB图像上高亮
                         Highlight(n,m+p,1)=255;
                         Highlight(n,m+p,2)=0;
                         Highlight(n,m+p,3)=0;
                        end
                    I_jiao_class(n,m)=k;
                    end
                end
             end
         end
    end
end


figure,imshow(RGB);
title('原图');
imwrite(RGB,'原图.jpg','jpg');

figure,imshow(BW);
title('edge处理后的边界图');
imwrite(BW,'edge处理后的边界图.jpg','jpg');

figure,imshow(I_out);
title('Hough变换检测出的直线');
imwrite(I_out,'Hough变换检测出的直线.jpg','jpg');

figure,imshow(Highlight);
title('高亮后的图');
imwrite(Highlight,'高亮后的图.jpg','jpg');