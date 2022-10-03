function out= predict_cell(image,xc,yc,errors)

color ="giallo";
[m,n,~] = size(image);
BWcell = poly2mask(xc,yc,m,n);
center  = regionprops(BWcell,"Centroid");


%ROTATE qua
cell = rotate_n_cut(image,BWcell);
cell = remove_blackp(cell);
 
%PREDICT
predicted = predict_texture_quad(cell, color);
sticker = classify_bollino(cell);
if (predicted ~= color)
    errors = [errors center];
elseif (sticker ~= 1)
    errors = [errors center];
end

% TEST
%  figure(31), subplot(211), imshow(cell),title(predicted);
%  [m,n, ~] = size(cell);
%  m
%  n

 
%  cellResized = imresize(cell, [55 55]);
%  figure(31),subplot(212), imshow(cellResized);
 

out =errors;
end