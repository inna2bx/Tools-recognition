clear all;
close all;

DATASET = "segmentable";

addpath('Utils');
load('Saved Data\trts_'+DATASET+'.mat');


descriptors = {'lbp','cedd','qhist', 'areaMinRectangle'...
    , 'areaOverPSquare', 'HuMoments', 'signature'};

train_array_descriptors = table2array(train.descriptors(:, descriptors));
classificator = fitcknn(train_array_descriptors, train.labels, 'NumNeighbors', 10);


train_predicted = predict(classificator, train_array_descriptors);

cm_train = confmat(train.labels, train_predicted);

test_array_descriptors = table2array(test.descriptors(:, descriptors));
test_predicted = predict(classificator, test_array_descriptors);

cm_test = confmat(test.labels, test_predicted);

show_confmat(cm_test.cm_raw, cm_test.labels);

save('Saved Data\classificator.mat', 'classificator');

rmpath('Utils');