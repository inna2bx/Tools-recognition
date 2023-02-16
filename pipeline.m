function out = pipeline(im)
    
    out.segmentation = NaN;
    out.labels = NaN;
    out.bboxes = NaN;
    out.predictions = NaN;
    
    %load data
    
    load('Saved Data\classificator.mat');
    
    
    %preprocessing
   
    
    %segmentation
    [mask, bg] = compositeBGEdgeSegmentation(im);
    labels = bwlabel(mask);
    
    out.segmentation = mask;
    out.labels = labels;
    
    %extrating bounding boxes
    s = regionprops(labels, "BoundingBox");
    bboxes = floor(cat(1, s.BoundingBox));
    if numel(bboxes) ~= 0
        bboxes = bboxes+[1,1,-1,-1];
    end
    
    out.bboxes = bboxes;
    
    n_bboxes = numel(bboxes(:))/4;
    predictions = cell([1,n_bboxes]);
    for i = 1:n_bboxes
        crop = imcrop(im, bboxes(i,:));
        crop_mask = imcrop(labels == i, bboxes(i,:));
        d = struct2table(compute_descriptors(crop, crop_mask));
        
        descriptors = {'lbp','cedd','qhist', 'areaMinRectangle'...
    , 'areaOverPSquare', 'HuMoments', 'signature'};
        descriptors = table2array(d(:, descriptors));

        [label_predict, score] = predict(classificator, descriptors);
        
%         delta = max(score) - mean(score);
        score = sort(score, "descend");
        delta = score(1) - score(2);
        if delta < 0.00
            label_predict = {'unknown'};
        end
        
        predictions(i) = label_predict;
    end
    
    out.predictions = predictions;
    