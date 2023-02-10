clear all;
close all;

DATASET = "segmentable";

load('Saved Data\data_'+DATASET+'.mat');


cv = cvpartition(labels, 'holdout', 0.2);

train_list = cv.training(1);
test_list = cv.test(1);

save('Saved Data/partition_'+DATASET+'.mat', "train_list", "test_list");
