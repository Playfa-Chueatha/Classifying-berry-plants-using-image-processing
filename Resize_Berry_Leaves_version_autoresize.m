% ----------------------------------------------------
function y = Resize_Mango_Leaves_version_autoresize()
% ----------------------------------------------------
clc;
fname = dir('D:\work\img\Berry\input_berry\Strawberry\*.jpg');
s =size(fname,1);
for i =1 : s
    imgfilename = fname(i).name;
    auto_Resize(imgfilename);
end

% ----------------------------------------------------
function  y = auto_Resize(imgFilename)
% ----------------------------------------------------
imgfilePart = 'D:\work\img\Berry\input_berry\Strawberry\';
img1 = strcat(imgfilePart,imgFilename);
img = imread(img1);


%B = imresize(A,[numrows numcols])
img_red = double(img(:,:,1));
img_green = double(img(:,:,2));
img_blue = double(img(:,:,3));

red_resize   = imresize(img_red,[150 150]);
green_resize = imresize(img_green,[150 150]);
blue_resize  = imresize(img_blue,[150 150]);

out(:,:,1) = red_resize;
out(:,:,2) = green_resize;
out(:,:,3) = blue_resize;

%figure, imshow(uint8(out)), title('ok');

foldername = 'D:\work\img\Berry\output_berry_resize150\Strawberry\';
New_name = strcat(foldername,'resize150_',imgFilename);
imwrite(uint8(out),New_name);
