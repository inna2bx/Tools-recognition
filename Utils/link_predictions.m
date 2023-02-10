function [labels,predicted_labels] = link_predictions(predictions,bboxes,gt)
 
    labels={};
    predicted_labels={};
    
    cell_array = table2cell(gt);
    gt_classes = gt.Properties.VariableNames;
    gt_bboxes = [];
    n_gt_bboxes=0;
    for i=1:numel(cell_array)
        gt_class_bboxes_mat = cell2mat(cell_array(i));
        gt_bboxes = [gt_bboxes; gt_class_bboxes_mat];
        n_gt_current_class_bboxes = size(gt_class_bboxes_mat, 1);
        for j = 1:n_gt_current_class_bboxes
            n_gt_bboxes = n_gt_bboxes + 1;
            gt_structure(n_gt_bboxes).label = gt_classes(i);
            gt_structure(n_gt_bboxes).linked = false;
        end
        
    end

    for i=1:numel(predictions)
        ratios = bboxOverlapRatio(gt_bboxes, bboxes(i,:));
        [m,indexMax] = max(ratios);
        predicted_labels(i) = predictions(i);
        if m > 0.25
            labels(i) = gt_structure(indexMax).label;
            gt_structure(indexMax).linked = true;
        else
            labels(i) = {'back_ground'};
        end
            
    end
    
    for i=1:n_gt_bboxes
        if not(gt_structure(i).linked)
            predicted_labels = [predicted_labels, {'back_ground'}];
            labels = [labels, gt_structure(i).label];
        end
    end
    
end

