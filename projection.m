function p = projection(bwImage)
    [m, n] = size(bwImage);
    %--------------------------------------------------------------------------
    %Calculate image centroid:(I,J)
    %--------------------------------------------------------------------------
    m00 = sum(sum(bwImage));% zeroth moment
    m01 = 0;% First moment 
    m10 = 0;% First moment
    for i = 1:m
        for j = 1:n
            m01 = bwImage(i,j)*j+m01;
            m10 = bwImage(i,j)*i+m10;
        end
    end
    I = (m10)/(m00);
    J = m01/m00;

    m00 = sum(sum(bwImage));% zeroth moment
    u11 = 0;
    u20 = 0; u02 = 0;
    for i = 1:m
        for j = 1:n
            u20 = bwImage(i,j)*(i-I)^2+u20;
            u02 = bwImage(i,j)*(j-J)^2+u02;
            u11 = bwImage(i,j)*(i-I)*(j-J)+u11;
        end
    end
    u20 = u20/m00^2;
    u02 = u02/m00^2;
    u11 = u11/m00^2;
    
    %calcolo angolo tra asse x e asse maggiore
    tetha = 1/2 * atan(2 * u11 / (u20 - u02));
    %ruoto l'immagine verso l'asse maggiore per fare in modo che sia
    %coincidente con l'asse x

    bwImage = imrotate(bwImage, tetha);
    x = sum(bwImage);
    y = sum(bwImage, 2);
    %per passare da array colonna ad array riga
    y = y.';
    p.x = x;
    p.y = y;
end