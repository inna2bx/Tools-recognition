function [out, sfondo] = compositeBGEdgeSegmentation(im)
addpath("Segmentation_subroutines\");

[r_original,c_original,~] = size(im);
resize_factor = 2500 / sqrt(r_original^2+c_original^2);
im = imresize(im,resize_factor);            %Resize basato sulla diagonale

gray = rgb2gray(im);


[r,c] = size(gray);
sz = r.*c;
tmp = uniformBGEdgeSegmentation(gray);      %Segmentazione tramite routine "Uniforme"
sfondo = "uniforme";
test = sum(sum(tmp));                       %Numero di pixel rilevati
fac = 50/100;
if(or(test>fac.*sz,test==0))                %Controllo per sovra/sotto segmentazione
    tmp = tovagliaBGEdgeSegmentation(gray); %Segmentazione tramite routine "tovaglia"
    test = sum(sum(tmp));
    sfondo = "tovaglia";
    if(or(test>fac.*sz,test==0) )           %Controllo per sovra/sotto segmentazione
        tmp = checkersBGEdgeSegmentation(gray); %Segmentaziobe tramite routine "checkers"
        sfondo = "piastrelle";
    end
end
rmpath("Segmentation_subroutines\");

tmp = imresize(tmp,[r_original,c_original],"nearest");
out = tmp;