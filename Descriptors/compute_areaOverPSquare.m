function x = compute_areaOverPSquare(bwImage)
    [r, c] = size(bwImage);
    filter = [1 1 1;
              1 1 1;
              1 1 1];
    perimeter = 0;
    %aggiungo zero padding per poter applicare il filtro a tutta l'immagine
    zeropadding = padarray(bwImage, [1 1], 0, 'both');
    s = 0;
    for i = 2:r
        for j = 2:c
            if zeropadding(i, j) == 1
                %calcolo l'applicazione del filtro
                s = sum(filter .* zeropadding((i - 1) : (i + 1), (j - 1) : (j + 1)), 'all');
                %se il risultato è diverso da 9 allora vuol dire che
                %abbiamo un pixel di perimetro considerando la
                %8-connessione
                if s ~= 9
                    perimeter = perimeter + 1;
                end
            end
        end
    end
    area = sum(sum(bwImage));
    
    x = area / (perimeter) ^ 2;

end