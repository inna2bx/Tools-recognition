function out = uniformBGEdgeSegmentation(gray)
gray = medfilt2(gray,[15,15]);
edges = edge(gray,"zerocross",0.0005);
trs = strel("diamond",15);
edges = imclose(edges,trs);
edges = imfill(edges,"holes");
labels = bwlabel(edges);

[r c] = size(edges);

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

edges = bwareaopen(edges,3000);

out = edges;