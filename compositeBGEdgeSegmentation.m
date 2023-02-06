function [out, sfondo] = compositeBGEdgeSegmentation(im)
addpath("Segmentation_subroutines\");

gray = rgb2gray(im);
[r_original,c_original] = size(gray);
resize_factor = 2500 / sqrt(r_original^2+c_original^2);
resize_factor = 0.25;
gray = imresize(gray,resize_factor);

[r,c] = size(gray);
sz = r.*c;
tmp = uniformBGEdgeSegmentation(gray);
sfondo = "uniforme";
test = sum(sum(tmp));
fac = 60/100;
if(test>fac.*sz)
    tmp = checkersBGEdgeSegmentation(gray);
    test = sum(sum(tmp));
    sfondo = "piastrelle";
    if(test>fac.*sz)
        tmp = tovagliaBGEdgeSegmentation(gray);
        sfondo = "tovaglia";
    end
end
rmpath("Segmentation_subroutines\");

tmp = imresize(tmp,[r_original,c_original],"nearest");
out = tmp;

