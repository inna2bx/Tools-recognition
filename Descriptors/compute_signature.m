function s = signature(bwImage)
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
    s(:, 1) = dist;
    %s(:, 2) = l * pi / 180;
    s(:, 2) = l;
end