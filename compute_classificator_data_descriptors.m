clear all;
close all;

load('Saved Data\data.mat');
load("Saved Data\partition.mat");

n = numel(images);

for j = 1:n
    disp(string(j) + ' - ' + string(n));
    im = imread([images{j}]);
    d = compute_descriptors(im);
    descriptors(j) = d;
end

descriptors = struct2table(descriptors);

train.images = images(train_list);
train.labels = labels(train_list);
train.descriptors = descriptors(train_list, :);


test.images = images(test_list);
test.labels = labels(test_list);
test.descriptors = descriptors(test_list, :);

save('Saved Data\trts.mat', "train", "test");