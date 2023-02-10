function out = newCheckersBGEdgeSegmentation(gray)
fil = fspecial("average",[3 3]);
gray = imfilter(gray,fil);

edges = edge(gray,"zerocross",0.00001);


str = strel("disk",2);
edges = imclose(edges,str);
labels = bwlabel(edges,4);
nlabels = max(unique(labels));
for i = 1:nlabels
    tmp = labels==i;
    ni = sum(sum(tmp));
    if ni<2000
        labels(tmp)=0;
    end
end
ris = labels>0;
ris = not(ris);

str = strel("disk",6);
ris = imopen(ris,str);
ris = imdilate(ris,str);
labels = bwlabel(ris,4);
nlabels = max(unique(labels));
for i = 1:nlabels
    tmp = labels==i;
    ni = sum(sum(tmp));
    if ni<5500
        labels(tmp)=0;
    end
end

[r c] = size(labels);
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
out = labels>0;
