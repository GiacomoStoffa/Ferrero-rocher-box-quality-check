function out = do_rectangle_box(image, vertical, bright, X11, Y11, X12, Y12, X22, Y22, X21, Y21)

error_yellow1 = [];
error_yellow2 = [];
error_black = [];
error_white = [];

%%%IF RETTANGOLO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%GRIGLIA
n = 9;  %righe
%deltax = (X1 - X2)/n;
%deltay = (Y1 - Y2)/n;

deltax = (X21-X11)/n;
deltay = (Y21-Y11)/n;
halfdx = deltax/2;
halfdy = deltay/2;
xcents1 = X11 + halfdx + (0:n-1)*deltax;
ycents1 = Y11 + halfdy + (0:n-1)*deltay;

deltax = (X22-X12)/n;
deltay = (Y22-Y12)/n;
halfdx = deltax/2;
halfdy = deltay/2;
xcents2 = X12 + halfdx + (0:n-1)*deltax;
ycents2 = Y12 + halfdy + (0:n-1)*deltay;

n = 7;
deltax = (X22-X21)/n;
deltay = (Y22-Y21)/n;
halfdx = deltax/2;
halfdy = deltay/2;
xcents3 = X21 + halfdx + (0:n-1)*deltax;
ycents3 = Y21 + halfdy + (0:n-1)*deltay;

deltax = (X12-X11)/n;
deltay = (Y12-Y11)/n;
halfdx = deltax/2;
halfdy = deltay/2;  
xcents4 = X11 + halfdx + (0:n-1)*deltax;
ycents4 = Y11 + halfdy + (0:n-1)*deltay;


[m,n,c] = size(image);


xCornsYellow = [ xcents1(:,3) ,xcents1(:,7),xcents2(:,7) ,xcents2(:,3)]; %21 22 12 11
yCornsYellow = [ ycents1(:,3) ,ycents1(:,7),ycents2(:,7) ,ycents2(:,3)];
BWmaskYellows = poly2mask(xCornsYellow,yCornsYellow,m,n); %cioccolatini gialli centrali
yellowChocos = BWmaskYellows .* image;

[xC,yC] = max_bounding_box(BWmaskYellows);
[x,y,m1,n1]  = get_rect(xC,yC);
rect = [x,y,m1,n1];
fi_yellows = imcrop(image,rect);
gray_yellows = rgb2gray(fi_yellows);
% figure(668), subplot(121),imshow(fi_yellows),subplot(122), plot(imhist(gray_yellows));
%bp_yellows = count_black_pixel(gray_yellows);

xAyellow = xcents1(:,3);
yAyellow = ycents1(:,3);

xByellow = xcents1(:,7);
yByellow = ycents1(:,7);

xCyellow = xcents2(:,7);
yCyellow = ycents2(:,7);

xDyellow = xcents2(:,3);
yDyellow = ycents2(:,3);

%%%%%%%%%%%%%%%%%%%%%%
ncolumn = 1;% colonne
deltax = (xcents1(:,7)-xcents1(:,3))/ncolumn; %21-11
deltay = (ycents1(:,7)-ycents1(:,3))/ncolumn;
halfdx = deltax/2;
halfdy = deltay/2;
%radius = sqrt(halfdx.^2 + halfdy.^2);
xcentsYellow1 = xcents1(:,3) + halfdx + (0:ncolumn-1)*deltax;%11
ycentsYellow1 = ycents1(:,3) + halfdy + (0:ncolumn-1)*deltay;

deltax = (xcents2(:,7)-xcents2(:,3))/ncolumn; %22-12
deltay = (ycents2(:,7)-ycents2(:,3))/ncolumn;
halfdx = deltax/2;
halfdy = deltay/2;
%radius = sqrt(halfdx.^2 + halfdy.^2);
xcentsYellow2 = xcents2(:,3) + halfdx + (0:ncolumn-1)*deltax;%12
ycentsYellow2 = ycents2(:,3) + halfdy + (0:ncolumn-1)*deltay;



%%%%%CORNICE GIALLi1
xCornsYellow1 = [ xcents1(:,3) ,xcentsYellow1,xcentsYellow2 ,xcents2(:,3)]; %21 22 12 11
yCornsYellow1 = [ ycents1(:,3) ,ycentsYellow1,ycentsYellow2 ,ycents2(:,3)];
%%%%%CORNICE GIALLI2
xCornsYellow2 = [ xcentsYellow1 ,xcents1(:,7),xcents2(:,7) ,xcentsYellow2]; %21 22 12 11
yCornsYellow2 = [ ycentsYellow1 ,ycents1(:,7),ycents2(:,7) ,ycentsYellow2];

BWmaskYellow1 = poly2mask(xCornsYellow1,yCornsYellow1,m,n); %cioccolatini neri
BWmaskYellow2 = poly2mask(xCornsYellow2,yCornsYellow2,m,n); %cioccolatini bianchi
chocosYellow1 = BWmaskYellow1 .* image;
chocosYellow2 = BWmaskYellow2 .* image;

% figure(680),imshow(chocosYellow1);
% figure(681),imshow(chocosYellow2);

%%%%%%%%controllo cornici giallo (centrali)

if (bright == "light") 
    count_y_row1 = count_square_light(chocosYellow1, false);
    count_y_row2 = count_square_light(chocosYellow2, false);  
else
    count_y_row1 = count_square_dark(chocosYellow1, false);
    count_y_row2 = count_square_dark(chocosYellow2, false); 
end


if (count_y_row1 ~= 6)
    error_yellow1 = grid_choco_row(chocosYellow1, xCornsYellow1, yCornsYellow1, m,n, vertical, "giallo");
end

if (count_y_row2 ~= 6)
    error_yellow2 = grid_choco_row(chocosYellow2, xCornsYellow2, yCornsYellow2, m,n, vertical, "giallo");
end


Ax = xcents1(:,1);
Ay = ycents1(:,1);
Bx = xcents2(:,1);
By = ycents2(:,1);
Cx = xcents2(:,9);
Cy = ycents2(:,9);
Dx = xcents1(:,9);
Dy = ycents1(:,9);

if (vertical)
    

    xCornsRow1 = [ xcents1(:,7) ,Dx,Cx ,xcents2(:,7)];
    yCornsRow1 = [ ycents1(:,7) ,Dy,Cy ,ycents2(:,7)];

    xCornsRow2 = [ Ax ,xcents1(:,3),xcents2(:,3) ,Bx];
    yCornsRow2 = [ Ay ,ycents1(:,3),ycents2(:,3) ,By];
    
    
else %Orizzontali
    xCornsRow1 = [ xcents1(:,7) ,Dx,Cx ,xcents2(:,7)];
    yCornsRow1 = [ ycents1(:,7) ,Dy,Cy ,ycents2(:,7)];

    xCornsRow2 = [ Ax ,xcents1(:,3),xcents2(:,3) ,Bx];
    yCornsRow2 = [ Ay ,ycents1(:,3),ycents2(:,3) ,By];
    
end

BWmaskRow1 = poly2mask(xCornsRow1,yCornsRow1,m,n); %cioccolatini neri
BWmaskRow2 = poly2mask(xCornsRow2,yCornsRow2,m,n); %cioccolatini bianchi
chocosRow1 = BWmaskRow1 .* image;
chocosRow2 = BWmaskRow2 .* image;





[xC,yC] = max_bounding_box(BWmaskRow1);
[x,y,m1,n1]  = get_rect(xC,yC);
rect = [x,y,m1,n1];
fi_row1 = imcrop(image,rect);
gray_row1 = rgb2gray(fi_row1);
% figure(668), subplot(121),imshow(fi_row1),subplot(122), plot(imhist(gray_row1));
bp_row1 = count_black_pixel(gray_row1);


[xC,yC] = max_bounding_box(BWmaskRow2);
[x,y,m1,n1]  = get_rect(xC,yC);
rect = [x,y,m1,n1];
fi_row2 = imcrop(image,rect);

% figure(1001),imshow(chocosRow2);
% hold on;
%  plot(x, y, 'bs', xC, yC, 'r*');
%  plot(x, y, 'bs', x, y, 'r*');
gray_row2 = rgb2gray(fi_row2);
% figure(669), subplot(121),imshow(fi_row2),subplot(122), plot(imhist(gray_row2));
bp_row2 = count_black_pixel(gray_row2);

if(bp_row1 > bp_row2)
    %%bp e' riga cioccolatini neri
    
    %%CLASSIFICATORE
    error_black = grid_choco_row(chocosRow1, xCornsRow1, yCornsRow1, m,n, vertical, "nero");
    error_white = grid_choco_row(chocosRow2, xCornsRow2, yCornsRow2, m,n, vertical, "bianco");
    %%--------------
else
    %%bp1 e' riga cioccolatini neri
    error_black = grid_choco_row(chocosRow2, xCornsRow2, yCornsRow2, m,n, vertical, "nero");
    error_white = grid_choco_row(chocosRow1, xCornsRow1, yCornsRow1, m,n, vertical, "bianco");
end

if (isempty(error_black) && isempty(error_white) && isempty(error_yellow1) && isempty(error_yellow2))
    tag = "conforme";
else
    tag ="non conforme";
end
figure(1000), imshow(image),title(tag); % IMMAGINE RISULTATO
hold on;
for er = 1: length(error_black)
    z = error_black(er).Centroid;
    viscircles(z, 10,'Color','b');
end

for er = 1: length(error_white)
    z = error_white(er).Centroid;
    viscircles(z, 10,'Color','b');
end

for er = 1: length(error_yellow1)
    z = error_yellow1(er).Centroid;
    viscircles(z, 10,'Color','b');
end

for er = 1: length(error_yellow2)
    z = error_yellow2(er).Centroid;
    viscircles(z, 10,'Color','b');
end

out = tag;
end