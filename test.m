clear all;
close all;

load('Saved Data\trts.mat');

knn = fitcknn(train.lbp, train.labels);


train_predicted = predict(knn, train.lbp);

cm_train = confmat(train.labels, train_predicted);

test_predicted = predict(knn, test.lbp);

cm_test = confmat(test.labels, test_predicted);

show_confmat(cm_test.cm_raw, cm_test.labels);