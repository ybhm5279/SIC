%% The project out inverse compositional algorithm 
% proposed in active appearance model revisited10.6581
% ========================================================================
% 1/24/2014
display('*********** START *********')
clc;
clear;

%% initialize the setting
display('******** preprocess ********')
addpath(pwd);
addpath(fullfile(pwd,'data'));
addpath(fullfile(pwd,'function'));
opt.impath = 'E:\computer vision\Face Tracking\material\ÈËÁ³Êý¾Ý¿â\300W\lfpw\testset\';
opt.imformat =  '*.png';
opt.np = 68;
[imNames,gt_shape] = ini(opt); 
load AAM
%% compute SD
if exist('J.mat','file')
    display('******** load J  ********')
    load J
else
    display('******** compute constant J  ********')
    tic
    J = compute_J(AAM);
    toc
    save([pwd,'/data/J.mat']);
    display('******** J over!  ********')
end

%% face detect
load initializations_LFPW;
s0 = AAM.shapemodel.s0;
s0 = reshape(s0,[], 2);
fit_opt.max_iter = 20;
fit_opt.J = J;
fit_opt.AAM = AAM;
display('******** begin fitting ********')
for i = 1 : numel(imNames)
    display(['******** fitting ',num2str(i),'th image ********'])
    ini_shape = scl(i)*s0 + repmat(trans(i, :), size(s0,1), 1);
    imagedata = imread(imNames{i});
    if size(imagedata, 3) == 3
        input_image = double(rgb2gray(imagedata));
    else
        input_image = double(imagedata);
    end
    [ shape, lambda ] = fit2d(ini_shape, input_image, fit_opt);
    display(['******** ',num2str(i),'th image over! ********'])
    preShapes(:,:,i) = shape;
    imshow(imagedata);hold on;plot(shape(:,1),shape(:,2),'b+');pause(1);close all;
end
display('******** END!  ********')



