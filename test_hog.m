clear all;
close all;

load('Saved Data\trts.mat');

%%calcolo hog

n = numel(train.images);
hog = [];
    
image = imresize(imread(train.images{21}), 0.1);
[featureVector,hogVisualization] = extractHOGFeatures(image);
hog_size = numel(featureVector);
hog_label = [];

for i=1:n
    image = imresize(imread(train.images{i}), 0.1);
    [featureVector,hogVisualization] = extractHOGFeatures(image);
    
    if numel(featureVector) == hog_size
        hog=[hog; featureVector];
        hog_label = [hog_label; string(train.labels{i})];
    end
end

% knn = fitcknn([train.lbp, train.cedd], train.labels);
% 
% 
% train_predicted = predict(knn, [train.lbp, train.cedd]);
% 
% cm_train = confmat(train.labels, train_predicted);
% 
% test_predicted = predict(knn, [test.lbp, test.cedd]);
% 
% cm_test = confmat(test.labels, test_predicted);
% 
% show_confmat(cm_test.cm_raw, cm_test.labels);