function out_image=ritaglioscatolav2(image)
%im=im2double(imread(image));
im = image;
im=imresize(im,0.2);
im2=rgb2gray(im);


%figure(1), imshow(im2);
im2=edge(im2,'sobel',0.05);

%figure(2), imshow(im2);

out=imclose(im2,strel('disk',9));
%figure(3), imshow(out);
out=imclose(out,strel('rectangle', [5,5]));
%figure(4), imshow(out);


%trovo riquadro scatola (considero riquadro più grande , escluso sfondo)
labels = bwlabel(out);
%figure(5), imshow(labels);
max_label = max(max(labels));
min_area = -1;
array = zeros(max_label);
k=1;
for n = 1 : max_label
  region_n = (labels==n);
  area_n = sum(sum(region_n));
  if (area_n>min_area)
    min_area = area_n;
    array(k) = n;
    k=k+1;
  end
end
mask = (labels == array(k-1));
mask2=imfill(mask,'holes');
%figure(1), imshow(mask2);
mask2= imdilate(mask2, strel('rectangle', [9,9]));
mask2=imclose(mask2,strel('rectangle',[33 33]));
mask2=imfill(mask2,'holes');
%figure(2), imshow(mask2);
mask2=imopen(mask2,strel('rectangle',[19 19]));
%figure(7), imshow(mask2);


out_image =mask2.*im;
