function out = tovagliaBGEdgeSegmentation(gray)


gray = medfilt2(gray,[15,15]);
edges = edge(gray,"zerocross",0.0005);

str = strel("disk",8);
edges = imdilate(edges,str);
edges = not(edges);
edges = imfill(edges, "holes");
[r,c] = size(edges);

p = 1;
by = floor(r * p / 100);
bx = floor(c * p / 100);

str = strel("disk",15);
edges = imdilate(edges,str);
edges = imclose(edges,str);

labels = bwlabel(edges);

for i = 1:r
    if sum(labels(i,1 : bx)) ~= 0
        lab = labels(i,1);
        edges(labels == lab) = 0;
        labels(labels == lab) = 0;
    end
end
for i = 1:r
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
end
for i = 1:c
    if sum(labels(r - by : r,i)) ~= 0
        lab = labels(r,i);
        edges(labels == lab) = 0;
        labels(labels == lab) = 0;
    end
end

labels = bwlabel(edges);
nlabels = max(unique(labels));
for i = 1:nlabels
    ni = sum(sum(labels==i));
    if ni<2000
        edges(labels==i) = 0;
    end
end
out = edges;


