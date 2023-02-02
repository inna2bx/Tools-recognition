function out = compute_descriptors(image)
  
    addpath('Descriptors');
    
    out.lbp = compute_lbp(rgb2gray(image));
    out.qhist = compute_qhist(image);
    out.cedd = compute_CEDD(image);
    out.descriptors = [out.lbp, out.qhist, out.cedd];
    
    rmpath('Descriptors\');
end