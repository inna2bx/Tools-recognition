clear all;
close all;

addpath('Utils\');

%extract and save multiobject data from list files
images_multiobject = read_list_file('List Files\images_multiobject.list');
back_grounds_multiobject = read_list_file('List Files\back_grounds_multiobject.list');

save('Saved Data\data_multiobject.mat','images_multiobject', ...
    "back_grounds_multiobject");

%extract and save one-object data from list files

images = read_list_file('List Files\images.list');
labels = read_list_file('List Files\labels.list');
back_grounds = read_list_file('List Files\back_grounds.list');

save('Saved Data/data.mat', 'images', 'labels', 'back_grounds');

rmpath('Utils\');