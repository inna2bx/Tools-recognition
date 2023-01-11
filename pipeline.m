clear all;
close all;

%load data
load('Saved Data\GT-multiobject.mat');

f=fopen('List Files\images-multiobject.list');
  z = textscan(f,'%s');
  images = z{:}; 
  fclose(f);

load('Saved Data\classificator.mat');
addpath('Descriptors\');

%process data
n = numel(images);

IoUs = zeros(1, n, 'double');
ratios_bboxes = zeros(1, n, 'double');

for j = 1:n
    
    im = imread([images{j}]);
    [r,c] = size(im, [1,2]);

    %preprocessing
   
    
    %segmentation
    RESIZE_FACTOR = 0.1;
    resized_im_size = [floor(RESIZE_FACTOR*r), floor(RESIZE_FACTOR*c)];
    im_resized = imresize(im, resized_im_size);

    im_gray_resized = rgb2gray(im_resized);
    otsu_t = graythresh(im_gray_resized);
    
%     mask = sauvola(im_gray_resized, [50,75]);
%     mask = im2bw(im_gray_resized, otsu_t);
    mask = uniformBGEdgeSegmentation(im_gray_resized);
    mask = not(mask);
    
%     if sum(mask(:)) > numel(mask)/1.5
%         mask = not(mask);
%     end

    es = strel("disk", 10);
    mask = imclose(mask, es);

    labels = bwlabel(mask);
    
    current_label = 1;
    for i=1:max(unique(labels))
        region_n = labels==i;
        area = sum(sum(region_n));
        if area> numel(im_gray_resized) * 0.005
            labels(region_n) = current_label;
            current_label = current_label + 1;
        else
            labels(region_n) = 0;
        end
    end
    
    
%     figure();
%     subplot(1,2,1); imshow(mask), title('immagine ' + string(j));
%     subplot(1,2,2); imagesc(labels), axis image, colorbar;
    
    %extrating bounding boxes
    crops = [];
    for i=1:max(unique(labels))
        current_label = labels == i;
        [r, c] = find(current_label);
        rmax = max(r);
        cmax = max(c);
        rmin = min(r);
        cmin = min(c);
        w = cmax-cmin;
        h = rmax-rmin;
        

        crop.bbox = [cmin, rmin, w, h] ./ RESIZE_FACTOR;
        img_crop = imcrop(im, crop.bbox);
        
        crop.img = img_crop;

        crops = [crops, crop];
    end
    
    [IoU, ratio_bboxes] = bboxes_metric(crops, gt(j,:), im);
    IoUs(j) = IoU;
    ratios_bboxes(j) = ratio_bboxes;
    
    %classification
    for i = 1:numel(crops)
        crop = crops(i);
        crop_img_gray = rgb2gray(crop.img);
        lbp = compute_lbp(crop_img_gray);
        
        label_predict = predict(knn, lbp);

%          figure();
%          imshow(crop.img), title(label_predict);
    end

end
disp('---------------------------------');
% disp(IoUs);
% disp(ratios_bboxes);
disp(sqrt(mean((IoUs-1).^2)));
disp(sqrt(mean((ratios_bboxes-1).^2)));


rmpath('Descriptors\');