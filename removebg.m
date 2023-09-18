ถุึ
% ----------------------------------------------------
function y = removebg()
% ----------------------------------------------------
clc;
fname = dir('D:\work\img\Berry\output_berry_resize150\Strawberry\*.jpg');
s =size(fname,1);
for i =1 : s
    imgfilename = fname(i).name;
    auto_removebg(imgfilename);
end

% ----------------------------------------------------
function  y = auto_removebg(imgFilename)
% ----------------------------------------------------

imgfilePart = 'D:\work\img\Berry\output_berry_resize150\Strawberry\';
img1 = strcat(imgfilePart,imgFilename);
img = imread(img1);

[bw, rgb] = removebby(img);

foldername = 'D:\work\img\Berry\output_segment_berry_resize150\Strawberry\';
New_name = strcat(foldername,'resize150_',imgFilename);
imwrite(uint8(rgb),New_name);

