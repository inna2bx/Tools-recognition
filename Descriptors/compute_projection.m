function [x, y] = compute_projection(bwImage)
    %calcolo angolo tra asse x e asse maggiore
    stats =  regionprops(bwImage, "Orientation");
    tetha = stats.Orientation;
    %ruoto l'immagine verso l'asse maggiore per fare in modo che sia
    %coincidente con l'asse x
    bwImage = imrotate(bwImage, tetha);
    x = sum(bwImage);
    y = sum(bwImage, 2);
    %per passare da array colonna ad array riga
    y = y.';
    x = rescale(x);
    y = rescale(y);
end