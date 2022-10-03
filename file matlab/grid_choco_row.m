function out=grid_choco_row(image, xCorns, yCorns, m, n, vertical, color)


errors = [];
X11 = xCorns(:,4);
Y11 = yCorns(:,4);
X21 = xCorns(:,1);
Y21 = yCorns(:,1);
X22 = xCorns(:,2);
Y22 = yCorns(:,2);
X12 = xCorns(:,3);
Y12 = yCorns(:,3);

% figure(888),imshow(image),title("grid");
% hold on;

r = 7;
deltax = (X21-X11)/r;
deltay = (Y21-Y11)/r;
halfdx = deltax/2;
halfdy = deltay/2;
xcents3 = X11 + halfdx + (0:r-1)*deltax;
ycents3 = Y11 + halfdy + (0:r-1)*deltay;

deltax = (X22-X12)/r;
deltay = (Y22-Y12)/r;
halfdx = deltax/2;
halfdy = deltay/2;
xcents4 = X12 + halfdx + (0:r-1)*deltax;
ycents4 = Y12 + halfdy + (0:r-1)*deltay;

% plot([xcents3(:,1),xcents4(:,1)],[ycents3(:,1),ycents4(:,1)],'LineWidth',1,'Color','green');%1
% plot([xcents3(:,2),xcents4(:,2)],[ycents3(:,2),ycents4(:,2)],'LineWidth',1,'Color','green');
% plot([xcents3(:,3),xcents4(:,3)],[ycents3(:,3),ycents4(:,3)],'LineWidth',1,'Color','green');%3
% plot([xcents3(:,4),xcents4(:,4)],[ycents3(:,4),ycents4(:,4)],'LineWidth',1,'Color','green');
% plot([xcents3(:,5),xcents4(:,5)],[ycents3(:,5),ycents4(:,5)],'LineWidth',1,'Color','green');%5
% plot([xcents3(:,6),xcents4(:,6)],[ycents3(:,6),ycents4(:,6)],'LineWidth',1,'Color','green');
% plot([xcents3(:,7),xcents4(:,7)],[ycents3(:,7),ycents4(:,7)],'LineWidth',1,'Color','green');%7


xCorns1 = [ xcents3(:,1) ,xcents4(:,1),xcents4(:,2) ,xcents3(:,2)];
yCorns1 = [ ycents3(:,1) ,ycents4(:,1),ycents4(:,2) ,ycents3(:,2)];

xCorns2 = [ xcents3(:,2) ,xcents4(:,2),xcents4(:,3) ,xcents3(:,3)];
yCorns2 = [ ycents3(:,2) ,ycents4(:,2),ycents4(:,3) ,ycents3(:,3)];

xCorns3 = [ xcents3(:,3) ,xcents4(:,3),xcents4(:,4) ,xcents3(:,4)];
yCorns3 = [ ycents3(:,3) ,ycents4(:,3),ycents4(:,4) ,ycents3(:,4)];

xCorns4 = [ xcents3(:,4) ,xcents4(:,4),xcents4(:,5) ,xcents3(:,5)];
yCorns4 = [ ycents3(:,4) ,ycents4(:,4),ycents4(:,5) ,ycents3(:,5)];

xCorns5 = [ xcents3(:,5) ,xcents4(:,5),xcents4(:,6) ,xcents3(:,6)];
yCorns5 = [ ycents3(:,5) ,ycents4(:,5),ycents4(:,6) ,ycents3(:,6)];

xCorns6 = [ xcents3(:,6) ,xcents4(:,6),xcents4(:,7) ,xcents3(:,7)];
yCorns6 = [ ycents3(:,6) ,ycents4(:,6),ycents4(:,7) ,ycents3(:,7)];



mask1 = poly2mask(xCorns1,yCorns1,m,n);
mask2 = poly2mask(xCorns2,yCorns2,m,n);
mask3 = poly2mask(xCorns3,yCorns3,m,n);
mask4 = poly2mask(xCorns4,yCorns4,m,n);
mask5 = poly2mask(xCorns5,yCorns5,m,n);
mask6 = poly2mask(xCorns6,yCorns6,m,n);

% 
% figure(10), imshow(mask1);

[xC,yC] = max_bounding_box(mask1);
center = regionprops(mask1,'centroid');

im = mask1.* image;
% figure(11), imshow(im);
% hold on;
% viscircles(center.Centroid, 5,'Color','y');
fi = stretch_item(im, xC, yC);
% figure(12), imshow(fi);
[m,n,c] = size(fi);

if (color == "giallo")
    predicted = predict_texture_rect_yellow(fi, color);
else
    predicted = predict_texture_rect_bw(fi, color);
end
sticker = classify_bollino(fi);
if (predicted ~= color)
    errors = [errors center];
elseif (sticker ~= 1 && color == "giallo")
    errors = [errors center];
end

[xC,yC] = max_bounding_box(mask2);
center = regionprops(mask2,'centroid');

im = mask2.* image;
fi = stretch_item(im, xC, yC);

if (color == "giallo")
    predicted = predict_texture_rect_yellow(fi, color);
else
    predicted = predict_texture_rect_bw(fi, color);
end
sticker = classify_bollino(fi);
if (predicted ~= color)
    errors = [errors center];
elseif (sticker ~= 1 && color == "giallo")
    errors = [errors center];
end


[xC,yC] = max_bounding_box(mask3);
center = regionprops(mask3,'centroid');

im = mask3.* image;
fi = stretch_item(im, xC, yC);

[m,n,c] = size(fi);

if (color == "giallo")
    predicted = predict_texture_rect_yellow(fi, color);
else
    predicted = predict_texture_rect_bw(fi, color);
end
sticker = classify_bollino(fi);
if (predicted ~= color)
    errors = [errors center];
elseif (sticker ~= 1 && color == "giallo")
    errors = [errors center];
end


[xC,yC] = max_bounding_box(mask4);
center = regionprops(mask4,'centroid');

im = mask4.* image;
fi = stretch_item(im, xC, yC);

[m,n,c] = size(fi);

if (color == "giallo")
    predicted = predict_texture_rect_yellow(fi, color);
else
    predicted = predict_texture_rect_bw(fi, color);
end
sticker = classify_bollino(fi);
if (predicted ~= color)
    errors = [errors center];
elseif (sticker ~= 1 && color == "giallo")
    errors = [errors center];
end


[xC,yC] = max_bounding_box(mask5);
center = regionprops(mask5,'centroid');

im = mask5.* image;
fi = stretch_item(im, xC, yC);

[m,n,c] = size(fi);

if (color == "giallo")
    predicted = predict_texture_rect_yellow(fi, color);
else
    predicted = predict_texture_rect_bw(fi, color);
end
sticker = classify_bollino(fi);
if (predicted ~= color)
    errors = [errors center];
elseif (sticker ~= 1 && color == "giallo")
    errors = [errors center];
end


[xC,yC] = max_bounding_box(mask6);
center = regionprops(mask6,'centroid');

im = mask6.* image;
fi = stretch_item(im, xC, yC);

[m,n,c] = size(fi);

if (color == "giallo")
    predicted = predict_texture_rect_yellow(fi, color);
else
    predicted = predict_texture_rect_bw(fi, color);
end
sticker = classify_bollino(fi);
if (predicted ~= color)
    errors = [errors center];
elseif (sticker ~= 1 && color == "giallo")
    errors = [errors center];
end

out = errors;
end
