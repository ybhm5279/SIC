function ShowShapeOnImage(oneimage,shape)
imshow(oneimage);
hold on
shape = reshape(shape, [], 2);
% plot(shape(:,1),shape(:,2),'g+');
%ÂÖÀª
plot(shape(1:15,1), shape(1:15,2),'g','LineWidth',2);
%Ã¼Ã«
plot([shape(16:21,1);shape(16,1)], [shape(16:21,2);shape(16,2)],'g','LineWidth',2);
plot([shape(22:27,1);shape(22,1)], [shape(22:27,2);shape(22,2)],'g','LineWidth',2);
%±Ç×Ó
plot([shape(36:39,1);shape(45,1);shape(40,1);shape(46,1);shape(41:44,1)],...
    [shape(36:39,2);shape(45,2);shape(40,2);shape(46,2);shape(41:44,2)],'g','LineWidth',2);
%×ì°Í
plot([shape(47:53,1);shape(54:58,1);shape(47,1)], [shape(47:53,2);shape(54:58,2);shape(47,2)],'g','LineWidth',2);
% plot([shape(54:58,1);shape(54,1)], [shape(54:58,2);shape(54,2)],'r');
%ÑÛ¾¦
plot([shape(28,1);shape(67,1);shape(29,1);shape(70,1);shape(30,1);shape(69,1);shape(31,1);shape(68,1);shape(28,1)],...
    [shape(28,2);shape(67,2);shape(29,2);shape(70,2);shape(30,2);shape(69,2);shape(31,2);shape(68,2);shape(28,2)],'g','LineWidth',2);
plot([shape(71,1);shape(33,1);shape(74,1);shape(32,1);shape(73,1);shape(35,1);shape(72,1);shape(34,1);shape(71,1)],...
    [shape(71,2);shape(33,2);shape(74,2);shape(32,2);shape(73,2);shape(35,2);shape(72,2);shape(34,2);shape(71,2)],'g','LineWidth',2);

