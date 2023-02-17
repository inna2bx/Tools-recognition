clear all;
close all;

rng(42);

DATASET = "knownBG";

addpath('Utils');
load('Saved Data\trts_'+DATASET+'.mat');

%creo classificatore
classificator = TreeBagger(300, train.descriptors, train.labels,...
     InBagFraction=0.66, MaxNumSplits=25);

%predict su train set
train_predicted = predict(classificator, train.descriptors);

cm_train = confmat(train.labels, train_predicted);

figure();
show_confmat(cm_train.cm_raw, cm_train.labels), title("train " + cm_train.accuracy);

%predict su test set
test_predicted = predict(classificator, test.descriptors);

figure();
cm_test = confmat(test.labels, test_predicted);

show_confmat(cm_test.cm_raw, cm_test.labels), title("test " + cm_test.accuracy);


save('Saved Data\classificator.mat', 'classificator');

rmpath('Utils');