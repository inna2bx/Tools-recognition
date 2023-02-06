clear all;
close all;

%debug flags
IOU = true;
PRINT_SEGMENTATION = true;
SAVE_SEGMENTATION = true;
PRINT_CLASSIFICATION = true;

%load data
load('Saved Data\GT-multiobject.mat');
load("Saved Data\data_multiobject.mat");

addpath('Utils\');

%process data
n = numel(images_multiobject);

IoUs = zeros(1, n, 'double');
ratios_bboxes = zeros(1, n, 'double');

for j = 1:n
    
    im = imread([images_multiobject{j}]);

    result = pipeline(im);
    
    if PRINT_SEGMENTATION
        figure();
        subplot(2,2,1); imshow(im), title('immagine ' + string(j));
        subplot(2,2,3); imshow(result.segmentation);
        subplot(2,2,4); imagesc(result.labels), axis image, colorbar;
        if SAVE_SEGMENTATION
            saveas(gcf,'export/segmentation'+string(j)+'.png')
        end
    end
    
    if IOU
        [IoU, ratio_bboxes] = bboxes_metric(result.bboxes, gt(j,:), im);
        IoUs(j) = IoU;
        ratios_bboxes(j) = ratio_bboxes;
    end
    
    
    
        
    if PRINT_CLASSIFICATION

        for i = 1:numel(result.predictions)
            crop = imcrop(im, result.bboxes(i,:));
            label_predicted = result.predictions(i);
            figure();
            imshow(crop), title(label_predicted);
        end
    end
    
end
disp('---------------------------------');

if IOU
    disp(sqrt(mean((IoUs-1).^2)));
    disp(sqrt(mean((ratios_bboxes-1).^2)));
end

rmpath('Utils\');