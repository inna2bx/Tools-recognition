function [out, sfondo] = newCompositeBGEdgeSegmentation(im)
addpath("Segmentation_subroutines\");

gray = rgb2gray(im);
[r_original,c_original] = size(gray);
resize_factor = 2500 / sqrt(r_original^2+c_original^2);
disp(resize_factor);
gray = imresize(gray,resize_factor);

[r,c] = size(gray);
sz = r.*c;
tmp = uniformBGEdgeSegmentation(gray);
sfondo = "uniforme";
test = sum(sum(tmp));
fac = 60/100;
if(test>fac.*sz)
    tmp = tovagliaBGEdgeSegmentation(gray);
    test = sum(sum(tmp));
    sfondo = "tovaglia";
    if(test>fac.*sz)
        tmp = newCheckersBGEdgeSegmentation(gray);
        sfondo = "piastrelle";
    end
end
rmpath("Segmentation_subroutines\");

tmp = imresize(tmp,[r_original,c_original],"nearest");
out = tmp;