function n = compute_HuMoments(bwImage)

    [r,c] = size(bwImage);
    
    % Calcolo il centroide dell'immagine:(I,J)
    m00 = sum(sum(bwImage));
    m01 = 0;
    m10 = 0;
    for i = 1:r
        for j = 1:c
            m01 = bwImage(i,j)*j+m01;
            m10 = bwImage(i,j)*i+m10;
        end
    end
    I = (m10)/(m00);
    J = m01/m00;
    
    % Calcolo i momenti centrali:
    u11 = 0;
    u20 = 0; u02 = 0;
    u30 = 0; u03 = 0;
    u12 = 0; u21 = 0;
    for i = 1:r
        for j = 1:c
            u20 = bwImage(i,j)*(i-I)^2+u20;
            u02 = bwImage(i,j)*(j-J)^2+u02;
            u11 = bwImage(i,j)*(i-I)*(j-J)+u11;
            u30 = bwImage(i,j)*(i-I)^3+u30;
            u03 = bwImage(i,j)*(j-J)^3+u03;
            u12 = bwImage(i,j)*(i-I)*(j-J)^2+u12;
            u21 = bwImage(i,j)*(i-I)^2*(j-J)+u21;
        end
    end
    u20 = u20/m00^2;
    u02 = u02/m00^2;
    u11 = u11/m00^2;
    u30 = u30/m00^(5/2);
    u03 = u03/m00^(5/2);
    u12 = u12/m00^(5/2);
    u21 = u21/m00^(5/2);
    
    % Calcolo i momenti di Hu:
    
    n(1) =  u20+u02;
    n(2) = (u20-u02)^2+4*u11^2;
    n(3) = (u30-3*u12)^2+(u03-3*u21)^2;
    n(4) = (u30+u12)^2+(u03+u21)^2;
    n(5) = (u03-3*u12)*(u30+u12)*((u30+3*u12)^2-3*(u03+u21)^2)+(3*u21-u03)*(u03+u21)*((u03+u21)^2-3*(u30+u12)^2);
    n(6) = (u20-u02)*((u30+u12)^2-(u03+u21)^2)+4*u11*(u30+u12)*(u03+u21);
    n(7) = (3*u21-u03)*(u30+u12)*((u30+u12)^2-3*(u03+u21)^2)+(3*u21-u30)*(u03+u21)*(3*(u30+u12)^2-(u03+u21)^2);

end