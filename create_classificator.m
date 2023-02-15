clear all;
close all;

rng(42);

DATASET = "knownBG";

addpath('Utils');
load('Saved Data\trts_'+DATASET+'.mat');


descriptors = {'qhist','HuMoments'};

train_array_descriptors = table2array(train.descriptors(:, descriptors));
classificator = TreeBagger(120, train_array_descriptors, train.labels,...
    OOBPrediction="on");
% classificator = fitctree(train_array_descriptors, train.labels, MaxNumSplits=100);


train_predicted = predict(classificator, train_array_descriptors);

cm_train = confmat(train.labels, train_predicted);

test_array_descriptors = table2array(test.descriptors(:, descriptors));
test_predicted = predict(classificator, test_array_descriptors);

cm_test = confmat(test.labels, test_predicted);

show_confmat(cm_test.cm_raw, cm_test.labels), title(cm_test.accuracy);

save('Saved Data\classificator.mat', 'classificator');

rmpath('Utils');