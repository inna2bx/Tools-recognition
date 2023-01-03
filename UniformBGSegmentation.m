clear all;
close all;
path = "C:\Users\marco\OneDrive\Desktop\Uni\IMGs\Progetto\Progetto\DataSet - multioggetto\DataSet - multioggetto";

im = imread(strcat(path,"\IMG_20230102_190605.jpg"));
im = imresize(im,0.25);

imshow(im);
gray = rgb2gray(im);
gray = medfilt2(gray,[15,15]);
edges = edge(gray,"zerocross",0.0005);
imshow(edges)
figure();
trs = strel("diamond",15);
edges = imclose(edges,trs);
edges = imfill(edges,"holes");


%edges = imerode(edges,trs);
%trs = strel("square",5);
for i = 1:10
     %edges = imdilate(edges,trs);
end
edges = uint8(edges);
img = im.*edges;
imshow(img);