function out = uniformBGEdgeSegmentation(gray)
gray = medfilt2(gray,[15,15]);
edges = edge(gray,"zerocross",0.0005);
trs = strel("diamond",15);
edges = imclose(edges,trs);
edges = imfill(edges,"holes");
out = edges;
end