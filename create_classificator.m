clear all;
close all;

addpath('Utils');
load('Saved Data\trts.mat');


descriptors = {'lbp','cedd','qhist'};

train_array_descriptors = table2array(train.descriptors(:, descriptors));
knn = fitcknn(train_array_descriptors, train.labels, 'NumNeighbors', 1);


train_predicted = predict(knn, train_array_descriptors);

cm_train = confmat(train.labels, train_predicted);

test_array_descriptors = table2array(test.descriptors(:, descriptors));
test_predicted = predict(knn, test_array_descriptors);

cm_test = confmat(test.labels, test_predicted);

show_confmat(cm_test.cm_raw, cm_test.labels);

save('Saved Data\classificator.mat', 'knn');

rmpath('Utils');