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
    
    %extracting bounding boxes
    s = regionprops(labels, "BoundingBox");
    bboxes = floor(cat(1, s.BoundingBox));
    %si fa una piccola riduzione delle bboxes per evitare problemi con 
    %gli arrotondamenti
    if numel(bboxes) ~= 0
        bboxes = bboxes+[1,1,-1,-1];
    end
    
    out.bboxes = bboxes;
    
    n_bboxes = numel(bboxes(:))/4;
    predictions = cell([1,n_bboxes]);
    for i = 1:n_bboxes
        crop = imcrop(im, bboxes(i,:));
        crop_mask = imcrop(labels == i, bboxes(i,:));
        descriptors = compute_descriptors(crop, crop_mask);

        [label_predict, score] = predict(classificator, descriptors);
        
        %si imposta come unknown tutti quei oggetti che hanno uno score
        %sulla classe prevista che non è molto maggiore degli score di
        %tutte le altre classi
        delta = max(score) - mean(score);
        if delta < 0.08
            label_predict = {'unknown'};
        end
        
        predictions(i) = label_predict;
    end
    
    out.predictions = predictions;
    