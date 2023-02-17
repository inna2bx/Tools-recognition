function descriptors = compute_descriptors(image, mask)
    
    %se viene passata una maschera vuota si considera come se la maschera
    %fosse stata piena solo di 1
    if max(mask(:)) == 0
        [r,c] = size(mask);
        mask = ones([r,c]);
    end
  
    addpath('Descriptors');
    
%     lbp = compute_lbp(rgb2gray(image));
    qhist = compute_qhist(image);
    
%     areaMinRectangle = compute_areaMinRectangle(mask);
%     areaOverPSquare = compute_areaOverPSquare(mask);
    HuMoments = compute_HuMoments(mask);
%     signature = compute_signature(mask); 
    
    descriptors = [qhist,HuMoments];


    
    rmpath('Descriptors\');
end