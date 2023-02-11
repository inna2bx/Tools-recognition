function out = uniformBGEdgeSegmentation(gray)
gray = medfilt2(gray,[15,15]);
edges = edge(gray,"zerocross",0.0005);
trs = strel("diamond",15);
edges = imclose(edges,trs);
edges = imfill(edges,"holes");
labels = bwlabel(edges);

[r c] = size(edges);
for i = 1:r
    if labels(i,1) ~= 0
        lab = labels(i,1);
        edges(labels == lab) = 0;
        labels(labels == lab) = 0;
    end
    if labels(i,c) ~= 0
        lab = labels(i,c);
        edges(labels == lab) = 0;
        labels(labels == lab) = 0;
    end
end

for i = 1:c
    if labels(1,i) ~= 0
        lab = labels(1,i);
        edges(labels == lab) = 0;
        labels(labels == lab) = 0;
    end
    if labels(r,i) ~= 0
        lab = labels(r,i);
        edges(labels == lab) = 0;
        labels(labels == lab) = 0;
    end
end

edges = bwareaopen(edges,3000);

out = edges;