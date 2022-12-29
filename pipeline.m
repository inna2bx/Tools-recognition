clear all;
close all;

[images, o, p] = readlists();

load('Saved Data\classificator.mat');
addpath('Descriptors\');

n = numel(images);

for j = 233:10 + 233
    
    im = imread([images{j}]);

    %preprocessing


    im_gray = rgb2gray(im);
    otsu_t = graythresh(im_gray);
    
    mask = im2bw(im_gray, otsu_t);
    
    if sum(mask(:)) > numel(mask)/2
        mask = not(mask);
    end

    labels = bwlabel(mask);
    
    for i=1:max(unique(labels))
        region_n = labels==i;
        area = sum(sum(region_n));
        current_label = 1;
        if area> numel(im_gray) * 0.05
            labels(region_n) = current_label;
            current_label = current_label + 1;
        else
            labels(region_n) = 0;
        end
    end
    
    
    figure();
    imagesc(labels), axis image, colorbar;

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
        img_crop = imcrop(im,[cmin rmin w h]);
        crop.img = img_crop;
        crop.box = [cmin, rmin, w, h];
        crops = [crops, crop];
    end

    for i = 1:numel(crops)
        crop = crops(i);
        crop_img_gray = rgb2gray(crop.img);
        lbp = compute_lbp(crop_img_gray);
        
        label_predict = predict(knn, lbp);

        figure();
        imshow(crop.img), title(label_predict);
    end

end


rmpath('Descriptors\');