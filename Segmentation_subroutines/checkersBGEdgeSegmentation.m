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
p = 1;
by = floor(r * p / 100);
bx = floor(c * p / 100);
for i = 1:r
    if sum(labels(i,1 : bx)) ~= 0
        lab = labels(i,1);
        edges(labels == lab) = 0;
        labels(labels == lab) = 0;
    end
    if sum(labels(i, c - bx : c)) ~= 0
        lab = labels(i,c);
        edges(labels == lab) = 0;
        labels(labels == lab) = 0;
    end
end

for i = 1:c
    if sum(labels(1 : by,i)) ~= 0
        lab = labels(1,i);
        edges(labels == lab) = 0;
        labels(labels == lab) = 0;
    end
    if sum(labels(r - by : r,i)) ~= 0
        lab = labels(r,i);
        edges(labels == lab) = 0;
        labels(labels == lab) = 0;
    end
end

out = labels>0;
%imshow(out);

