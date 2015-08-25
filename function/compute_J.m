function J = compute_J(AAM)
shapemodel = AAM.shapemodel;
warpmodel = AAM.warpmodel;

si = shapemodel.si;
s_star = shapemodel.s_star;
warp_map = warpmodel.warp_map;
[modelh,modelw] = size(warp_map);
alpha = warpmodel.alpha;
beta = warpmodel.beta;
triangles = warpmodel.triangles;

np = size(si,1)/2;
ns = size(si,2);

%% compute dW/dp 
Jx = zeros(modelh,modelw,4+ns);
Jy = zeros(modelh,modelw,4+ns);
for i = 1 : modelh
    for j = 1 : modelw
        if warp_map(i,j)~=0;
            ind = triangles(warp_map(i,j),:);
            Jx(i,j,:) = [alpha(i,j),beta(i,j),(1-alpha(i,j)-beta(i,j))]*[s_star(ind,:),si(ind,:)];
            Jy(i,j,:) = [alpha(i,j),beta(i,j),(1-alpha(i,j)-beta(i,j))]*[s_star(ind+np,:),si(ind+np,:)];
        end
    end
end

%% obtain J
J(:,:,1) = reshape(Jx,[],4+ns);
J(:,:,2) = reshape(Jy,[],4+ns);
