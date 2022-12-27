clear all;
close all;

[images, labels, back_grounds] = readlists();


cv = cvpartition(labels, 'holdout', 0.2);

train_list = cv.training(1);
test_list = cv.test(1);

save('Saved Data/partition.mat', "train_list", "test_list");
save('Saved Data/data.mat', 'images', 'labels', 'back_grounds');