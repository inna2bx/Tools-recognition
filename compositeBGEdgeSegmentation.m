function [out, sfondo] = compositeBGEdgeSegmentation(im)
addpath("Segmentation_subroutines\");

[r_original,c_original,~] = size(im);
resize_factor = 2500 / sqrt(r_original^2+c_original^2);
im = imresize(im,resize_factor);

gray = rgb2gray(im);


[r,c] = size(gray);
sz = r.*c;
tmp = uniformBGEdgeSegmentation(gray);
sfondo = "uniforme";
test = sum(sum(tmp));
fac = 50/100;
if(test>fac.*sz)
    tmp = tovagliaBGEdgeSegmentation(gray);
    test = sum(sum(tmp));
    sfondo = "tovaglia";
    if(or(test>fac.*sz,test==0) )
        tmp = checkersBGEdgeSegmentation(gray);
        sfondo = "piastrelle";
    end
end
%rmpath("Segmentation_subroutines\");

tmp = imresize(tmp,[r_original,c_original],"nearest");
out = tmp;