clear all;
close all;

addpath('Descriptors');

load('Saved Data\data.mat');
n = numel(images);

lbp = [];
qhist = [];
cedd = [];

for j = 1:n
    im = imread([images{j}]);
    lbp = [lbp; compute_lbp(rgb2gray(im))];
    qhist = [qhist; compute_qhist(im)];
    cedd = [cedd; compute_CEDD(im)];
end

save('Saved Data\descriptors.mat','lbp',"qhist","cedd");

rmpath('Descriptors');