function  [IoU, ratio_bboxes] = bboxes_metric(bboxes, gt, im)
    [r,c] = size(im, [1,2]);

    bboxes_area = zeros(r,c, 'logical');
    n_bboxes = numel(bboxes(:,1));
    
    gt_area = zeros(r,c, 'logical');
    n_gt_bboxes = 0;

    for i=1:n_bboxes

        [c] = bboxes(i,1);
        [r] = bboxes(i,2);
        [w] = bboxes(i,3);
        [h] = bboxes(i,4);

        bboxes_area(r:r+h,c:c+w) = 1;

    end
    
    cell_array = table2cell(gt);
    for i=1:numel(cell_array)
        gt_class_bboxes_mat = cell2mat(cell_array(i));
        n_gt_current_class_bboxes = size(gt_class_bboxes_mat, 1);
        n_gt_bboxes = n_gt_bboxes + n_gt_current_class_bboxes;
        for j=1:n_gt_current_class_bboxes
            bbox = gt_class_bboxes_mat(j,:);
            c = floor(bbox(1));
            r = floor(bbox(2));
            w = floor(bbox(3));
            h = floor(bbox(4));
            gt_area(r:r+h,c:c+w) = 1;
        end
    end
    

    union = or(bboxes_area, gt_area);
    intersection = and(bboxes_area, gt_area);
    
    IoU = sum(intersection(:)) / sum(union(:));
    ratio_bboxes = n_bboxes / n_gt_bboxes;

end