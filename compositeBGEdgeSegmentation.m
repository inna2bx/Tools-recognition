function [out, sfondo] = compositeBGEdgeSegmentation(gray)
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
out = tmp;

