function x = compute_areaMinRectangle(bwImage)
    stats = regionprops(bwImage, "MajorAxisLength");
    majorax = stats.MajorAxisLength;
    stats = regionprops(bwImage, "MinorAxisLength");
    minax = stats.MinorAxisLength;
    area = sum(sum(bwImage));
    %l'area del rettangolo minimo è il prodotto tra l'asse minore e l'asse
    %maggiore 
    area_Rect = majorax * minax;
    x = area/area_Rect;
end