function out = checkersBGEdgeSegmentation(gray)
fil = fspecial("average",[3 3]);
gray = imfilter(gray,fil);

edges = edge(gray,"zerocross",0.00001);         %Ricerca di quanti più edge
                                                %spuri possibile

str = strel("disk",3);                          
edges = imclose(edges,str);                     %Connessione edge spuri

%ris = bwareaopen(edges,8000);
ris = edges;
ris = not(ris);                                 %Rimozione sfondo
ris = bwareaopen(ris,200);                      %Rimozione sfondo non rimosso precedentemente

str = strel("disk",15);
ris = imclose(ris,str);                         %Chiusura di oggetti non connessi

str = strel("disk",8);
ris = imopen(ris,str);                          %Rottura fughe

ris = bwareaopen(ris,15000);                    %Rimozione fughe

labels = bwlabel(ris,4);


[r c] = size(labels);
p = 0.01;
by = floor(r * p);
bx = floor(c * p);
for i = 1:r                                     %Rimozione componenti connesse vicine ai bordi

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

