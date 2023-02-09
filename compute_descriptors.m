function out = compute_descriptors(image, mask)
  
    addpath('Descriptors');
    
    out.lbp = compute_lbp(rgb2gray(image));
    out.qhist = compute_qhist(image);
    out.cedd = compute_CEDD(image);
    
    out.areaMinRectangle = compute_areaMinRectangle(mask);
    out.areaOverPSquare = compute_areaOverPSquare(mask);
    out.HuMoments = compute_HuMoments(mask);
    out.projection = compute_projection(mask);
    out.signature = compute_signature(mask);
    
    
    
    out.descriptors = [out.lbp, out.qhist, out.cedd,out.areaMinRectangle, out.areaOverPSquare, out.HuMoments, out.projection.x, out.projection.y, out.signature];


    
    rmpath('Descriptors\');
end