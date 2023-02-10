clear all;
close all;

load("Saved Data\data.mat");


cv = cvpartition(labels, 'holdout', 0.2);

train_list = cv.training(1);
test_list = cv.test(1);

save('Saved Data/partition.mat', "train_list", "test_list");
