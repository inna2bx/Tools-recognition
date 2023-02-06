function out = tovagliaBGEdgeSegmentation(gray)


gray = medfilt2(gray,[15,15]);
edges = edge(gray,"zerocross",0.0005);

str = strel("disk",5);
edges = imdilate(edges,str);
edges = not(edges);
edges = imfill(edges, "holes");
[r,c] = size(edges);
labels = bwlabel(edges);
for i = 1:r
    if labels(i,1) ~= 0
        lab = labels(i,1);
        edges(labels == lab) = 0;
        labels(labels == lab) = 0;
    end
end
for i = 1:r
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
end
for i = 1:c
    if labels(r,i) ~= 0
        lab = labels(r,i);
        edges(labels == lab) = 0;
        labels(labels == lab) = 0;
    end
end

str = strel("disk",13);
edges = imdilate(edges,str);
edges = imclose(edges,str);

labels = bwlabel(edges);
nlabels = max(unique(labels));
for i = 1:nlabels
    ni = sum(sum(labels==i));
    if ni<1000
        edges(labels==i) = 0;
    end
end
out = edges;
