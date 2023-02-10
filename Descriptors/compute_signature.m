function s = compute_signature(bwImage)
    stats = regionprops(bwImage, 'Centroid');
    c = stats.Centroid;
    boundary = bwboundaries(bwImage);
    boundary = boundary{1};
    x = boundary(:,1);
    y = boundary(:,2);
    %distanza pitagora
    dist = sqrt((x - c(1)).^2 + (y - c(2)).^2);
    %spazio lineare da 0 a 360 con numero di punti equivalente al numero di
    %punti nella boundry
    l = linspace(0, 360, length(dist));
    s = zeros([360, 1]);
    x = 0;
    s(1) = dist(1);
    for i = 2:length(dist)
        if floor(l(i)) == x + 1
            x = x + 1;
            s(x + 1) = dist(i);
        end
    end
    s = rescale(s).';
end