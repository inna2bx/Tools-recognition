clear all;
close all;

addpath('Utils\');

%extract and save multiobject data from list files
images_multiobject = read_list_file('List Files\images_multiobject.list');

save('Saved Data\data_multiobject.mat','images_multiobject');

%extract and save one-object data from list files

DATASET = "knownBG";

images = read_list_file('List Files\images_'+DATASET+'.list');
labels = read_list_file('List Files\labels_'+DATASET+'.list');

save('Saved Data/data_'+DATASET+'.mat', 'images', 'labels');

rmpath('Utils\');