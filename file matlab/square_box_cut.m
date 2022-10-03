function out=square_box_cut(image,b_points,r_points,y_points,g_points,A,B,C,D)

[m,n,c] =size(image);

errors = [];
%interi
%x
xb_1 = b_points(1,1);
xb_2 = b_points(1,2);
xb_3 = b_points(1,3);
xb_4 = b_points(1,4);

xr_1 = r_points(1,1);
xr_2 = r_points(1,2);
xr_3 = r_points(1,3);
xr_4 = r_points(1,4);

xy_1 = y_points(1,1);
xy_2 = y_points(1,2);
xy_3 = y_points(1,3);
xy_4 = y_points(1,4);

xg_1 = g_points(1,1);
xg_2 = g_points(1,2);
xg_3 = g_points(1,3);
xg_4 = g_points(1,4);
%y
yb_1 = b_points(2,1);
yb_2 = b_points(2,2);
yb_3 = b_points(2,3);
yb_4 = b_points(2,4);

yr_1 = r_points(2,1);
yr_2 = r_points(2,2);
yr_3 = r_points(2,3);
yr_4 = r_points(2,4);

yy_1 = y_points(2,1);
yy_2 = y_points(2,2);
yy_3 = y_points(2,3);
yy_4 = y_points(2,4);

yg_1 = g_points(2,1);
yg_2 = g_points(2,2);
yg_3 = g_points(2,3);
yg_4 = g_points(2,4);

Ax = A(1,1);
Ay = A(2,1);
Bx = B(1,1);
By = B(2,1);
Cx = C(1,1);
Cy = C(2,1);
Dx = D(1,1);
Dy = D(2,1);
%mezzi

xg_D4 = (Dx + xg_4)/2 ;
xg_43 = (xg_4 + xg_3)/2;
xg_32 = (xg_3 + xg_2)/2;
xg_21 = (xg_2 + xg_1)/2;
xg_1C = (xg_1 + Cx)/2;

yb_D4 = (Dy + yb_4)/2;
yb_43 = (yb_4 + yb_3)/2;
yb_32 = (yb_3 + yb_2)/2;
yb_21 = (yb_2 + yb_1)/2;
yb_1A = (yb_1 + Ay)/2;

xy_A1 = (Ax + xy_1)/2;
xy_12 = (xy_1 + xy_2)/2;
xy_23 = (xy_2 + xy_3)/2;
xy_34 = (xy_3 + xy_4)/2;
xy_4B = (xy_4 + Bx)/2;

yr_B1 = (By + yr_1)/2;
yr_12 = (yr_1 + yr_2)/2;
yr_23 = (yr_2 + yr_3)/2;
yr_34 = (yr_3 + yr_4)/2;
yr_4C = (yr_4 + Cy)/2;

%METODO 1
%ritagli file diagonali gialle
% %BOX 1
% xbox1 = [ xb_4 ,xg_4,xg_43 ,xg_D4];
% ybox1 = [ yb_4 ,yg_4,yb_D4 ,yb_43];
%
%
% %BOX 2 (3)
% xbox2 = [xb_3, xg_3, xg_32, xg_D4];
% ybox2 = [yb_3, yg_3, yb_D4, yb_32];
%
% %BOX3 (5)
% xbox3 = [xb_2,xg_2, xg_21, xg_D4];
% ybox3 = [yb_2,yg_2, yb_D4, yb_21];
%
% %BOX 4 (6)
% xbox4 = [xb_1,xg_1, xr_4, xy_1];
% ybox4 = [yb_1,yg_1, yr_4, yy_1];
%
% %BOX 5 (5)
% xbox5 = [xy_12,xg_1,Cx,xy_2];
% ybox5 = [yr_1,yr_34,yr_3,By];
%
% %BOX 6 (3)
% xbox6 = [xy_23,xg_1,Bx,xy_3];
% ybox6 = [yr_1,yr_23,yr_2,By];
%
% %BOX 7
% xbox7 = [xy_34,xy_4,Bx,xy_4];
% ybox7 = [yr_1,yr_12,yr_1,By];

%METODO 2
%ritagli diagonali + triplette
%extra = 15;
extra =0;
%da 1
xbox1 = [Ax,xg_4,xg_43+extra,xg_4];
ybox1 = [yb_3,yb_43,yb_3,yb_32];

xbox2 = [xg_43,xg_3,xg_32+extra,xg_3];
ybox2 = [yb_4,Dy,yb_4,yb_43];

xbox3 = [xy_23,xy_3,xy_34+extra,xy_3];
ybox3 = [yr_1,yr_12,yr_1,By];

xbox4 = [xy_34,xy_4,Bx+extra,xy_4];
ybox4 = [yr_2,yr_23,yr_2,yr_12];

%da 2
xbox5 = [Ax,xg_43+extra,xg_3+extra,xy_1];
ybox5 = [yb_2,yb_3,yb_32,yb_21];

xbox6 = [xg_3,xg_2,xg_21+extra,xg_32+extra];
ybox6 = [yb_43,Dy,yr_4,yr_3];

xbox7 = [xy_12,xy_23+extra,xg_2+extra,xy_2];
ybox7 = [yb_1,yb_2,yb_21,yy_2];

xbox8 = [xg_2,xg_1,Cx+extra,xy_34+extra];
ybox8 = [yr_23,yr_34,yr_3,yr_2];

%da 6

xbox9 = [Ax,xg_4,Bx,xy_4];
ybox9 = [yb_4,Dy,yr_1,yy_4];

xbox10 = [xb_1,xg_1, xr_4, xy_1];
ybox10 = [yb_1,yg_1, yr_4, yy_1];




BWmask1 = poly2mask(xbox1,ybox1,m,n);
BWmask2 = poly2mask(xbox2,ybox2,m,n);
BWmask3 = poly2mask(xbox3,ybox3,m,n);
BWmask4 = poly2mask(xbox4,ybox4,m,n);
BWmask5 = poly2mask(xbox5,ybox5,m,n);
BWmask6 = poly2mask(xbox6,ybox6,m,n);
BWmask7 = poly2mask(xbox7,ybox7,m,n);
BWmask8 = poly2mask(xbox8,ybox8,m,n);
BWmask9 = poly2mask(xbox9,ybox9,m,n);
BWmask10 = poly2mask(xbox10,ybox10,m,n);

box1 = BWmask1 .* image;
box2 = BWmask2 .* image;
box3 = BWmask3 .* image;
box4 = BWmask4 .* image;
box5 = BWmask5 .* image;
box6 = BWmask6 .* image;
box7 = BWmask7 .* image;
box8 = BWmask8 .* image;
box9 = BWmask9 .* image;
box10 = BWmask10 .* image;




% 
% figure(300), subplot(221), imshow(box1),
% subplot(222), imshow(box2), subplot(223),
% imshow(box3), subplot(224), imshow(box4);
% 
% figure(301), subplot(221), imshow(box5),
% subplot(222), imshow(box6), subplot(223),
% imshow(box7), subplot(224), imshow(box8);
% 
% figure(302), subplot(211), imshow(box9),
% subplot(212), imshow(box10);















%  figure(11),subplot(132), imshow(box1);
%  subplot(232),
%  figure(12), imshow(box2);
%  figure(13), imshow(box3);
%  figure(14), imshow(box4);
%  figure(15), imshow(box5);
%  figure(16), imshow(box6);
%  figure(17), imshow(box7);
% figure(11),subplot(331), imshow(box1);
% subplot(332), imshow(box2);
% subplot(333), imshow(box3);
% subplot(334), imshow(box4),title("4");
% subplot(335), imshow(box5);
% subplot(336), imshow(box6);
% subplot(337), imshow(box7);
% subplot(338), imshow(box8);
% subplot(339), imshow(box9);
%
% figure(12), imshow(box10);


b1 = square_rows_cut(box1, xbox1,ybox1, 1,false);
b2 = square_rows_cut(box2, xbox2,ybox2, 1,false);
b3 = square_rows_cut(box3, xbox3,ybox3, 1,false);
b4 = square_rows_cut(box4, xbox4,ybox4, 1,false);

b5 = [];
b6 = [];
b7 = [];
b8 = [];
b9 = [];
b10 = [];

stickers = count_square_light(box5, false);
if (stickers ~= 2)
    b5 = square_rows_cut(box5, xbox5,ybox5, 2,false);
end

stickers = count_square_light(box6, false);
if (stickers ~= 2)
    b6 = square_rows_cut(box6, xbox6,ybox6, 2,false);
end

stickers = count_square_light(box7, false);
if (stickers ~= 2)
    b7 = square_rows_cut(box7, xbox7,ybox7, 2,false);
end

stickers = count_square_light(box8, false);
if (stickers ~= 2)
    b8 = square_rows_cut(box8, xbox8,ybox8, 2,false);
end

stickers = count_square_light(box9, false);
if (stickers ~= 6)
    b9 = square_rows_cut(box9, xbox9,ybox9, 6,true);
end

stickers = count_square_light(box10, false);
if (stickers ~= 6)
    b10 = square_rows_cut(box10, xbox10,ybox10, 6,false);
end

errors = [b1,b2,b3,b4,b5,b6,b7,b8,b9,b10];


out= errors;
end