function out = checkersBGEdgeSegmentation(gray)
gray = medfilt2(gray,[15,15]);
edges = edge(gray,"zerocross",0.0005);
nhood = [1 1 1 1 1 1];
mask = imopen(edges,nhood);
edges = edges-mask;
nhood = [1;1;1;1;1;1];
mask = imopen(edges,nhood);
edges = edges-mask;
labels = bwlabel(edges);
labels = labels + 1;
nlabels = max(unique(labels));
massimo = 0;
indexm = 0;
for k = 1:nlabels
    tmp = labels == k;
    nk = sum(sum(tmp));
    if nk > massimo
        massimo = nk;
        indexm = k;
    end
    if nk < 40
        labels(tmp)=0;
    end
end
labels(labels == indexm)=0;
edges = labels >0;
labels = bwlabel(edges);
[r c] = size(edges);
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


str = strel("disk",25,6);
tmp = imdilate(edges,str);
str = strel("square", 30);
%tmp = imerode(tmp,str);
out = tmp;
