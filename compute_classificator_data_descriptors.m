clear all;
close all;

DATASET = "knownBG";

SAVE_SEGMENTATION = true;

load('Saved Data\data_'+DATASET+'.mat');
load('Saved Data\partition_'+DATASET+'.mat');

n = numel(images);

for j = 1:n
    disp(string(j) + ' - ' + string(n));
    im = imread([images{j}]);
    [mask, bg] = compositeBGEdgeSegmentation(im);

    mask_labels = bwlabel(mask);

    max_area = 0;
    max_label = 0;

    for i = 1:max(mask_labels(:))
        current_label = mask_labels == i;
        current_area = sum(current_label(:));
        if current_area>max_area
            max_area = current_area;
            max_label = current_label;
        end
    end
    
    if SAVE_SEGMENTATION
        fig = figure();
        fig.WindowState = 'maximized';
        subplot(2,2,1); imshow(im), title('immagine ' + string(j));
        subplot(2,2,2); imagesc(mask_labels), axis image, colorbar;
        subplot(2,2,3); imshow(max_label);
        subplot(2,2,4); imshow(uint8(max_label).*im);
        saveas(gcf,'export/segmentation_dataset'+string(j)+'.png')
        close all;
    end

    s = regionprops(max_label, "BoundingBox");
    bboxe = floor(cat(1, s.BoundingBox));
    if numel(bboxe) ~= 0
        bboxe = bboxe+[1,1,-1,-1];
        im_crop = imcrop(im, bboxe);
        mask_crop = imcrop(max_label, bboxe);
    
        d = compute_descriptors(im_crop, mask_crop);
    else
        d = compute_descriptors(im, mask);
    end
    descriptors(j) = d;
end

descriptors = struct2table(descriptors);

train.images = images(train_list);
train.labels = labels(train_list);
train.descriptors = descriptors(train_list, :);


test.images = images(test_list);
test.labels = labels(test_list);
test.descriptors = descriptors(test_list, :);

save('Saved Data\trts_'+DATASET+'.mat', "train", "test");