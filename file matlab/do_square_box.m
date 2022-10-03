function out = do_square_box(image, Ax, Ay, Bx, By, Cx, Cy, Dx, Dy)


%D 1    %C 2


%A 4    %B 3

ncoloumn = 4;
%ncoloumn = 6;
%giallo GIUSTO
deltax = (Dx-Ax)/ncoloumn;
deltay = (Dy-Ay)/ncoloumn;
halfdx = deltax/2;
halfdy = deltay/2;
xcents1 = Ax + halfdx + (0:ncoloumn-1)*deltax;
ycents1 = Ay + halfdy + (0:ncoloumn-1)*deltay;
%ROSSO
deltax = (Cx-Bx)/ncoloumn;
deltay = (Cy-By)/ncoloumn;
halfdx = deltax/2;
halfdy = deltay/2;
xcents2 = Bx + halfdx + (0:ncoloumn-1)*deltax;
ycents2 = By + halfdy + (0:ncoloumn-1)*deltay;

%VERDE
deltax = (Dx-Cx)/ncoloumn;
deltay = (Dy-Cy)/ncoloumn;
halfdx = deltax/2;
halfdy = deltay/2;
xcents3 = Cx + halfdx + (0:ncoloumn-1)*deltax;
ycents3 = Cy + halfdy + (0:ncoloumn-1)*deltay;
%BLU giusto
deltax = (Bx-Ax)/ncoloumn;
deltay = (By-Ay)/ncoloumn;
halfdx = deltax/2;
halfdy = deltay/2;
xcents4 = Ax + halfdx + (0:ncoloumn-1)*deltax;
ycents4 = Ay + halfdy + (0:ncoloumn-1)*deltay;
% 
% 

%%%PLOT vertex
% x= 1;
% y= 1;
% plot(x,y, 'bs', xcents1, ycents1, 'b*');%blu
% plot(x,y, 'bs', xcents2, ycents2, 'r*');%rosso
% plot(x,y, 'bs', xcents3, ycents3, 'g*');%verde
% plot(x,y, 'bs', xcents4, ycents4, 'y*');%giallo


% figure(665), imshow(image), title('grill');
% hold on;



% %%diagonale da 4
% plot([xcents1(:,1),xcents4(:,1)],[ycents1(:,1),ycents4(:,1)],'LineWidth',1,'Color','red');
% plot([xcents1(:,2),xcents4(:,2)],[ycents1(:,2),ycents4(:,2)],'LineWidth',4,'Color','red');
% plot([xcents1(:,3),xcents4(:,3)],[ycents1(:,3),ycents4(:,3)],'LineWidth',1,'Color','red');
% plot([xcents1(:,4),xcents4(:,4)],[ycents1(:,4),ycents4(:,4)],'LineWidth',4,'Color','red');
% 
% 
% plot([xcents3(:,1),xcents2(:,4)],[ycents3(:,1),ycents2(:,4)],'LineWidth',1,'Color','red');
% plot([xcents3(:,2),xcents2(:,3)],[ycents3(:,2),ycents2(:,3)],'LineWidth',4,'Color','red');
% plot([xcents3(:,3),xcents2(:,2)],[ycents3(:,3),ycents2(:,2)],'LineWidth',1,'Color','red');
% plot([xcents3(:,4),xcents2(:,1)],[ycents3(:,4),ycents2(:,1)],'LineWidth',4,'Color','red');
% 
% 
% plot([xcents3(:,1),xcents1(:,1)],[ycents3(:,1),ycents1(:,1)],'LineWidth',1,'Color','yellow');
% plot([xcents3(:,2),xcents1(:,2)],[ycents3(:,2),ycents1(:,2)],'LineWidth',4,'Color','yellow');
% plot([xcents3(:,3),xcents1(:,3)],[ycents3(:,3),ycents1(:,3)],'LineWidth',1,'Color','yellow');
% plot([xcents3(:,4),xcents1(:,4)],[ycents3(:,4),ycents1(:,4)],'LineWidth',4,'Color','yellow');
% 
% 
% plot([xcents2(:,1),xcents4(:,4)],[ycents2(:,1),ycents4(:,4)],'LineWidth',1,'Color','yellow');
% plot([xcents2(:,2),xcents4(:,3)],[ycents2(:,2),ycents4(:,3)],'LineWidth',4,'Color','yellow');
% plot([xcents2(:,3),xcents4(:,2)],[ycents2(:,3),ycents4(:,2)],'LineWidth',1,'Color','yellow');
% plot([xcents2(:,4),xcents4(:,1)],[ycents2(:,4),ycents4(:,1)],'LineWidth',4,'Color','yellow');
% %%%diagonale

b_points = [xcents1;ycents1];
r_points = [xcents2;ycents2];
y_points = [xcents4;ycents4];
g_points = [xcents3;ycents3];

A = [Ax;Ay];
B = [Bx;By];
C = [Cx;Cy];
D = [Dx;Dy];

% RITAGLIO E CLASSIFICAZIONE
% @returns: Array[] of coords of each error

errors = square_box_cut(image,b_points,r_points,y_points,g_points,A,B,C,D);

if (isempty(errors))
    tag = "conforme";
else
    tag = "non conforme";
end
figure(1000), imshow(image),title(tag); % IMMAGINE RISULTATO
hold on;
for er = 1: length(errors)
    z = errors(er).Centroid;
    viscircles(z, 10,'Color','b');
end

out = tag;