function x = compute_areaOverPSquare(bwImage)
    [m, n] = size(bwImage);
    filter = [1 1 1;
              1 1 1;
              1 1 1];
    perimeter = 0;
    zeropadding = padarray(bwImage, [1 1], 0, 'both');
    s = 0;
    for i = 2:m
        for j = 2:n
            if zeropadding(i, j) == 1
                s = sum(filter .* zeropadding((i - 1) : (i + 1), (j - 1) : (j + 1)), 'all');
                if s ~= 9
                    perimeter = perimeter + 1;
                end
            end
        end
    end
    area = sum(sum(bwImage));
    
    x = area / (perimeter) ^ 2;

end