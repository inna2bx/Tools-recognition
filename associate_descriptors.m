clear all;
close all;

load("Saved Data\data.mat");
load("Saved Data\descriptors.mat");
load("Saved Data\partition.mat");


train.images = images(train_list);
train.labels = labels(train_list);
train.lbp = lbp(train_list, :);
train.qhist = qhist(train_list, :);
train.cedd = cedd(train_list, :);


test.images = images(test_list);
test.labels = labels(test_list);
test.lbp = lbp(test_list, :);
test.qhist = qhist(test_list, :);
test.cedd = cedd(test_list, :);

save('Saved Data\trts.mat', "train", "test");