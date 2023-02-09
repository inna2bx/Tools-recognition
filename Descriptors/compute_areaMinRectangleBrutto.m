function x = areaMinRectanleBrutto(bwImage)
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
    %coefficiente angolare asse maggiore
    m = tan(tetha);
    %metto il meno davanti J perché le y sono positive ma i calcoli sono fatti come
    %se fossimo nel quarto quadrante
    q = -J - m * I;
    m2 = - 1 / m;
    q2 = -J - m2 * I;
    
    c = sqrt(1 + m^2);
    a1 = I;
    b1 = J;
    a2 = ((1 - c * a1)/c);
   
    b2 = (m * a2 + q);
    while bwImage(a2, b2) == 1
        a1 = a2;
        b1 = b2;
        a2 = -((1 - c * a1)/c);
        b2 = (m * a2 + q);
    end
    %suppongo di aver calcolato metà della diagonale maggiore
    a1
    b1
    dist = abs(I - a1) * c;
    dist =  2 * dist;
    
    c = sqrt(1 + m2^2);
    a1 = I;
    b1 = J;
    a2 = ((1 - c * a1)/c);
    b2 = (m * a2 + q2);
    while bwImage(a2, b2) == 1
        a1 = a2;
        b1 = b2;
        a2 = ((1 - c * a1)/c);
        b2 = (m * a2 + q2);
    end
    %suppongo di aver calcolato metà della diagonale minore
    a1
    b1
    dist2 = abs(I - a1) * c;
    dist2 =  2 * dist;
    area = sum(sum(bwImage));
    area_Rect = dist * dist2;
    x = area/area_Rect;
end