function out = tovagliaBGEdgeSegmentation(gray)


gray = medfilt2(gray,[15,15]);
edges = edge(gray,"zerocross",0.0005);         %Rilevazione edge sfondo

str = strel("disk",8);
edges = imdilate(edges,str);                   %Riempimento sfondo
edges = not(edges);                            %Rimozione sfondo
edges = imfill(edges, "holes");                %Riempimento di eventuali buchi
[r,c] = size(edges);

p = 0.01;
by = floor(r * p);
bx = floor(c * p);

str = strel("disk",15);
edges = imdilate(edges,str);
edges = imclose(edges,str);                     %Connessione di eventuali parte sconnesse di oggetti

labels = bwlabel(edges);

for i = 1:r                                     %Rimozione componenti connesse vicine ai bordi
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

edges = bwareaopen(edges,10000);                    %Rimozione aree piccole

out = edges;

%imshow(out);
