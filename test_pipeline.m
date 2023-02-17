clear all;
close all;

%%debug flags

%stampa alla fine dei tests lo scarto quadratico medio delle IoU delle 
% bboxes trovate dalla segmentazione e le bboxes della GT di ogni immagine
IOU = false; 

%stampa a video la segmentazione e le labels ottenute per ogni immagine
PRINT_SEGMENTATION = false;
%salva nella cartella export la precedente stampa
SAVE_SEGMENTATION = false;

%stampa a video un immagine contenente gli oggetti trovati con la classe
%stimata dalla segmentazione
PRINT_CLASSIFICATION = false;
%salva nella cartella export la precedente stampa
SAVE_CLASSIFICATION = false;

%chiude tutte le finestre aperte alla fine di ogni iterazione della pipline
CLOSE_WINDOWS = false;

%%load data
load('Saved Data\GT-multiobject.mat');
load("Saved Data\data_multiobject.mat");

addpath('Utils\');

%%process data
n = numel(images_multiobject);

IoUs = zeros(1, n, 'double');
ratios_bboxes = zeros(1, n, 'double');

dataset_labels = {};
dataset_predicted_labels = {};

for j = 1:n

    disp(string(j)+' - '+string(n));
    
    im = imread([images_multiobject{j}]);

    result = pipeline(im);
    
    if PRINT_SEGMENTATION
        fig = figure();
        fig.WindowState = 'maximized';
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

    [labels,predicted_labels] = link_predictions(result.predictions, result.bboxes, gt(j,:));
    dataset_labels = [dataset_labels, labels];
    dataset_predicted_labels = [dataset_predicted_labels, predicted_labels];




    if PRINT_CLASSIFICATION
        fig = figure();
        fig.WindowState = 'maximized';
        subplot(1,2,1); imshow(im), title('immagine ' + string(j));
        hold on
        for i=1:numel(result.predictions)
            bbox = result.bboxes(i,:);
            rectangle('Position', bbox,'EdgeColor','g', 'LineWidth', 3)
            text(bbox(1), bbox(2), result.predictions(i), 'FontSize', 15);
        end
        
        cm = confmat(labels, predicted_labels);
        subplot(1,2,2); show_confmat(cm.cm_raw, cm.labels), 
            title('accuracy: ' + string(cm.accuracy));
        if SAVE_CLASSIFICATION
            saveas(gcf,'export/classification'+string(j)+'.png')
        end

    end

    if CLOSE_WINDOWS
        close all;
    end
    
end
disp('---------------------------------');

if IOU
    disp(sqrt(mean((IoUs-1).^2)));
    disp(sqrt(mean((ratios_bboxes-1).^2)));
end

    cm = confmat(dataset_labels, dataset_predicted_labels);
    disp('accuracy: ' + string(cm.accuracy));

    fig = figure();
    fig.WindowState = 'maximized';
    show_confmat(cm.cm_raw, cm.labels),
    title('accuracy: ' + string(cm.accuracy));
    saveas(gcf,'export/cm.png')


rmpath('Utils\');