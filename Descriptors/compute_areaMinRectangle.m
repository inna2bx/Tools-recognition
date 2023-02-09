function x = compute_areaMinRectangle(bwImage)
    [m, n] = size(bwImage);
    stats = regionprops(bwImage, "MajorAxisLength");
    majorax = stats.MajorAxisLength;
    stats = regionprops(bwImage, "MinorAxisLength");
    minax = stats.MinorAxisLength;
    area = sum(sum(bwImage));
    area_Rect = majorax * minax;
    x = area/area_Rect;
end