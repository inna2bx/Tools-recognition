function [labels,predicted_labels] = link_predictions(predictions,bboxes,gt)
 
    labels={};
    predicted_labels={};
    
    %estraggo dalla GT le bounding boxes annotate con relative classi di
    %oggetto
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

    %per ogni bbox trovata cerco a quale bbox della GT ha maggiore IoU e se
    %supera un valore ti treshold segno come true class della bbox la
    %classe associata alla bbox della GT associata
    for i=1:numel(predictions)
        ratios = bboxOverlapRatio(gt_bboxes, bboxes(i,:));
        [m,indexMax] = max(ratios);
        predicted_labels(i) = predictions(i);
        if m > 0.15
            labels(i) = gt_structure(indexMax).label;
            gt_structure(indexMax).linked = true;
        else
            labels(i) = {'back_ground'};
        end
            
    end
    
    %segno tutte le bbox della gt non associate a nessuna bbox trovata come
    %ettichettate con background
    for i=1:n_gt_bboxes
        if not(gt_structure(i).linked)
            predicted_labels = [predicted_labels, {'back_ground'}];
            labels = [labels, gt_structure(i).label];
        end
    end
    
end

