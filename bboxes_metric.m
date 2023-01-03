function  [IoU, ratio_bboxes] = bboxes_metric(crops, gt, im)
    [r, c] = size(im, [1,2]); 

    bboxes_area = zeros(r,c, 'logical');
    n_crops = numel(crops);
    
    gt_area = zeros(r,c, 'logical');
    n_gt_bboxes = 0;

    for i=1:numel(crops)

        crop = crops(i);
        c = crop.bbox(1);
        r = crop.bbox(2);
        w = crop.bbox(3);
        h = crop.bbox(4);

        bboxes_area(r:r+h,c:c+w) = 1;

    end
    
    cell_array = table2cell(gt);
    for i=1:numel(cell_array)
        gt_class_bboxes_mat = cell2mat(cell_array(i));
        n_bboxes = size(gt_class_bboxes_mat, 1);
        n_gt_bboxes = n_gt_bboxes + n_bboxes;
        for j=1:n_bboxes
            bbox = gt_class_bboxes_mat(j,:);
            c = bbox(1);
            r = bbox(2);
            w = bbox(3);
            h = bbox(4);
            gt_area(r:r+h,c:c+w) = 1;
        end
    end

    union = or(bboxes_area, gt_area);
    intersection = and(bboxes_area, gt_area);
    
    IoU = sum(intersection(:)) / sum(union(:));
    ratio_bboxes = n_crops / n_gt_bboxes;

end