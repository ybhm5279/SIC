function [ shape, lambda ] = fit2d(ini_shape, input_image, fit_opt)
%FIT2D 此处显示有关此函数的摘要
%   此处显示详细说明
%% initialize setting
% load data
max_iter = fit_opt.max_iter;
J = fit_opt.J;
shapemodel = fit_opt.AAM.shapemodel;
texturemodel = fit_opt.AAM.texturemodel;
warpmodel = fit_opt.AAM.warpmodel;
si = shapemodel.si;
A0 = texturemodel.A0;
Ai = texturemodel.Ai;
AA0 = texturemodel.AA0;
AAi = texturemodel.AAi;
ind_in = warpmodel.ind_in;
ind_out = warpmodel.ind_out;
ind_out2 = warpmodel.ind_out2;
warp_map = warpmodel.warp_map;
% Initialize current shape
ns = size(si,2);
cur_shape = ini_shape;
iter = 1;

%% begin fitting
while iter<max_iter
    % compute the cost function
    image_warped = reshape(warp_image(cur_shape, input_image,warpmodel), [], 1);
    if iter==1
        iw_out = image_warped;
        iw_out(ind_out) = [];
        c = Ai'*(iw_out - A0);
    end
    % compute gradient
    I = zeros(size(warp_map));
    I(ind_in) = A0 + Ai*c;
    [di,dj] = gradient(I);
    di(ind_out2) = 0;dj(ind_out2) = 0;
    % compute H,J
    J_ = repmat(di(:),1,4+ns).*J(:,:,1)+repmat(dj(:),1,4+ns).*J(:,:,2);
    J_(ind_out2,:) = [];
    Jsic = [J_,AAi];
    Hsic = Jsic' * Jsic;
    inv_Hsic = inv(Hsic);
    % parameter increment
    iw_out2 = image_warped;
    iw_out2(ind_out2) = [];
    error_img = iw_out2 - AA0 - AAi*c;
    d_para = inv_Hsic * Jsic'* error_img;
    % update inrement
    cur_shape =  compute_warp_update(cur_shape, d_para(1:4+ns,1), shapemodel, warpmodel);
    c = c + d_para(4+ns+1:end,1);
    iter = iter + 1;
end

%% output result
% shape
shape = cur_shape;
% app
lambda = c;
end

