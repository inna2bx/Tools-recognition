function s = compute_signature(bwImage)
    %calcolo il centroide dell'immagine
    stats = regionprops(bwImage, 'Centroid');
    c = stats.Centroid;
    %algoritmo di inseguimento del bordo in un immagine binaria
    boundary = bwboundaries(bwImage);
    %si prende il primo oggetto
    boundary = boundary{1};
    x = boundary(:,1);
    y = boundary(:,2);
    %distanza pitagora
    dist = sqrt((x - c(1)).^2 + (y - c(2)).^2);
    %spazio lineare da 0 a 360 con numero di punti equivalente al numero di
    %punti nella boundry
    l = linspace(0, 360, length(dist));
    s = zeros([361, 1]);
    %si crea l'array s, di lunghezza 361 per inserire i valori della
    %signature
    %viene aggiunto un nuovo elemento all'array ogni volta che il numero
    %nella stessa posizione dell'array l cambia parte intera
    x = 0;
    s(1) = dist(1);
    for i = 2:length(dist)
        if floor(l(i)) == x + 1
            x = x + 1;
            s(x + 1) = dist(i);
        end
    end
    %si utilizza la funzione rescale per avere valori tra 0 ed 1
    s = rescale(s).';
end