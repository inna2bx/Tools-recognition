clear all;
close all;

%debug flags
IOU = true;
PRINT_SEGMENTATION = true;
PRINT_CLASSIFICATION = false;

%load data
load('Saved Data\GT-multiobject.mat');
load("Saved Data\data_multiobject.mat");

load('Saved Data\classificator.mat');

addpath('Descriptors\');
addpath('Utils\');

%process data
n = numel(images_multiobject);

IoUs = zeros(1, n, 'double');
ratios_bboxes = zeros(1, n, 'double');

for j = 1:n
    
    im = imread([images_multiobject{j}]);

    %preprocessing
   
    
    %segmentation
    [mask, bg] = compositeBGEdgeSegmentation(im);
    labels = bwlabel(mask);
    
    if PRINT_SEGMENTATION
        figure();
        subplot(2,2,1); imshow(im), title('immagine ' + string(j));
        subplot(2,2,3); imshow(mask);
        subplot(2,2,4); imagesc(labels), axis image, colorbar;
        saveas(gcf,'export/segmentation'+string(j)+'.png')
    end
    
    %extrating bounding boxes
    s = regionprops(labels, "BoundingBox");
    bboxes = floor(cat(1, s.BoundingBox));
    bboxes = bboxes+[1,1,-1,-1];
    
    if IOU
        [IoU, ratio_bboxes] = bboxes_metric(bboxes, gt(j,:), im);
        IoUs(j) = IoU;
        ratios_bboxes(j) = ratio_bboxes;
    end
    
    

    classification
    for i = 1:numel(bboxes(:,1))
        crop = imcrop(im, bboxes(i,:));
        d = struct2table(compute_descriptors(crop));
        
        descriptors = {'lbp','cedd'};
        descriptors = table2array(d(:, descriptors));

        label_predict = predict(knn, descriptors);
        
        if PRINT_CLASSIFICATION
            figure();
            imshow(crop), title(label_predict);
        end
    end

end
disp('---------------------------------');

if IOU
    disp(sqrt(mean((IoUs-1).^2)));
    disp(sqrt(mean((ratios_bboxes-1).^2)));
end

rmpath('Descriptors\');
rmpath('Utils\');