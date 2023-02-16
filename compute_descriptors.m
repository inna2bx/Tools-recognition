function out = compute_descriptors(image, mask)
    
    if max(mask(:)) == 0
        [r,c] = size(mask);
        mask = ones([r,c]);
    end
  
    addpath('Descriptors');
    
    out.lbp = compute_lbp(rgb2gray(image));
    out.qhist = compute_qhist(image);
    
    out.areaMinRectangle = compute_areaMinRectangle(mask);
    out.areaOverPSquare = compute_areaOverPSquare(mask);
    out.HuMoments = compute_HuMoments(mask);
    out.signature = compute_signature(mask); 
    
    out.descriptors = struct2array(out);


    
    rmpath('Descriptors\');
end