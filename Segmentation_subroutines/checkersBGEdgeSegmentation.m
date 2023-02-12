function out = checkersBGEdgeSegmentation(gray)
fil = fspecial("average",[3 3]);
gray = imfilter(gray,fil);

edges = edge(gray,"zerocross",0.00001);


str = strel("disk",3);
edges = imclose(edges,str);

%ris = bwareaopen(edges,8000);
ris = edges;
ris = not(ris);
ris = bwareaopen(ris,200);

str = strel("disk",15);
ris = imclose(ris,str);

str = strel("disk",8);
ris = imopen(ris,str);

ris = bwareaopen(ris,15000);

labels = bwlabel(ris,4);


[r c] = size(labels);
p = 0.005;
by = floor(r * p);
bx = floor(c * p);
for i = 1:r

    for j = 1:bx
        if labels(i,j) ~= 0
            lab = labels(i,j);
            edges(labels == lab) = 0;
            labels(labels == lab) = 0;
        end
    end

    for j = c-bx:c
        if labels(i,j) ~= 0
            lab = labels(i,j);
            edges(labels == lab) = 0;
            labels(labels == lab) = 0;
        end
    end

end

for i = 1:c
    for j = 1:by
        if labels(j,i) ~= 0
            lab = labels(j,i);
            edges(labels == lab) = 0;
            labels(labels == lab) = 0;
        end
    end
    for j = r-by:r
        if labels(j,i) ~= 0
            lab = labels(j,i);
            edges(labels == lab) = 0;
            labels(labels == lab) = 0;
        end
    end
end
out = labels>0;
%imshow(out);

