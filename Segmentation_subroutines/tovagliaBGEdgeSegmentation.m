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
    for j = 1:bx
        if labels(i,j) ~= 0
            lab = labels(i,j);
            edges(labels == lab) = 0;
            labels(labels == lab) = 0;
        end
    end
end
for i = 1:r
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
end
for i = 1:c
    for j = r-by:r
        if labels(j,i) ~= 0
            lab = labels(j,i);
            edges(labels == lab) = 0;
            labels(labels == lab) = 0;
        end
    end
end

edges = bwareaopen(edges,2000);
out = edges;


