%%%%MAIN 

clear all;
close all;
clc;

%aggiungere percorso immagine
image = "immagini\IMG_8637.jpg";


REALIMAGE = im2double(imread(image));



hsv = rgb2hsv(im2double(imread(image)));
v = hsv(:,:,3);


%%% CLASSIFY IMAGE ON COLOR
%input: image
%output: "dark"; "light"

bright = count_light_or_dark(v);





% Ritaglio immagine con algoritmo
%image = ritaglioscatolav2(image);

image = ritaglioscatolav2(im2double(imread(image)));


ycbcr = rgb2ycbcr(image);
hsv = rgb2hsv(image);


h = hsv(:,:,1);
s = hsv(:,:,2);
v = hsv(:,:,3);

y = ycbcr(:,:,1);
cb = ycbcr(:,:,2);
cr = ycbcr(:,:,3);

r = image(:,:,1);
g = image(:,:,2);
b = image(:,:,3);




t = graythresh(r);
rbw = imbinarize(r, t-0.03); %scelto guardando istogramma del grigio








% Morfologia
% Prendo contorno scatola
BW = rbw;
BW = imclose(BW, strel("rectangle", [15 11]));
%figure(223), imshow(BW), title("close");
BW = imfill(BW,"holes");
%figure(224), imshow(BW), title("fill");
BW = bwmorph(BW, "thin"); %% PROVARE SE FANNO SCHIFO TOGLIERE
%figure(227), imshow(BW), title("thin");
BW = edge(BW, 'canny', [0.1 0.2], 1);
%figure(222), imshow(BW), title("final");





%%HOUGH
% Calcolo linea piu' lunga con Hough
[p1,p2] = longest_line_hough(BW);


%equazione prima retta
c = [[1; 1]  p1(:)]\p2(:);
% calcolo coefficiente angolare
coefficiente_ang_m = c(2);
intercetta_q = c(1);

%coefficiente_ang_m
%atand(coefficiente_ang_m)
%equazione retta ortogonale
%y - y1 = -1/m1(x - x1)

%ruoto immagine con angolo dato dal coefficiente angolare del lato maggiore
%trovato con Hough

image_old = image;


image = imrotate(image, atand(coefficiente_ang_m));
% figure(1), imshow(image), title("ruotata");





rgbgray = rgb2gray(image);
t =graythresh(rgbgray);
gbw = imbinarize(rgbgray, t-0.03);

%BW = edge(cbcr,'canny', [0.1 0.2], 1);
BW = imdilate(gbw, strel("rectangle", [1,1]));
%figure(441), imshow(BW);
%BW = imclose(BW, strel("rectangle", [53 53]));
BW = imclose(BW, strel("rectangle", [73 73]));
%figure(442), imshow(BW);
BW = imfill(BW,6,"holes");


labels = bwlabel(BW);



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
%se l'immagine si fosse frammentata dopo la morfologia,
%prendo la regione connessa maggiore (-1, che e' lo sfondo)
%nel caso ci siano regioni connesse piu' piccole (sporco)
BW = (labels == array(k-1));
%figure(17), imshow(BW);


% Bounding Box della scatola [NON USATO]
% st = regionprops(BW, 'BoundingBox');
% pointsbb = ([st.BoundingBox(1),st.BoundingBox(2),st.BoundingBox(3),st.BoundingBox(4)]);
% 
% xCoordsbb = [st.BoundingBox(1), st.BoundingBox(1)+st.BoundingBox(3),st.BoundingBox(1)+st.BoundingBox(3), st.BoundingBox(1), st.BoundingBox(1)];
% yCoordsbb = [st.BoundingBox(2), st.BoundingBox(2), st.BoundingBox(2)+st.BoundingBox(4), st.BoundingBox(2)+st.BoundingBox(4), st.BoundingBox(2)];
% %bb = rectangle('Position',[st.BoundingBox(1),st.BoundingBox(2),st.BoundingBox(3),st.BoundingBox(4)],...
%   %  'EdgeColor','r','LineWidth',2 );

BWedge = edge(BW,"canny", [0.01 0.9], 0.5);
%figure(443), imshow(BW);

BWedge = bwmorph(BWedge,'thicken');
%figure(27), imshow(BWedge);
%figure(22), imshow(BW.* image), title("final");





%%%%%%//FIND VERTEX
[rows, columns] = size(BW);


%calcolo massima bounding box
%metodo dei rettangoli
[xCorners, yCorners] = max_bounding_box(BW);


xCorners;
yCorners;


%%% CUT AND ROTATED IMAGE
FI = BW .* image;

%figure(35), imshow(FI);




%%%plot edges
%hold on;
% plot([xCorners(:,4),xCorners(:,1)],[yCorners(:,4),yCorners(:,1)],'LineWidth',2,'Color','cyan');
% plot([xCorners(:,4),xCorners(:,3)],[yCorners(:,4),yCorners(:,3)],'LineWidth',2,'Color','white');
% plot([xCorners(:,1),xCorners(:,2)],[yCorners(:,1),yCorners(:,2)],'LineWidth',2,'Color','green');
% plot([xCorners(:,2),xCorners(:,3)],[yCorners(:,2),yCorners(:,3)],'LineWidth',2,'Color','red');




%D 1        %C 2



%A 4        %B 3

Ax = xCorners(:,4);
Ay = yCorners(:,4);
Bx = xCorners(:,3);
By = yCorners(:,3);
Cx = xCorners(:,2);
Cy = yCorners(:,2);
Dx = xCorners(:,1);
Dy = yCorners(:,1);

%%%plot vertex
% x= 1;
% y= 1;
% plot(x,y, 'bs', Ax, Ay, 'b*');%blu
% plot(x,y, 'bs', Bx, By, 'r*');%rosso
% plot(x,y, 'bs', Cx, Cy, 'g*');%verde
% plot(x,y, 'bs', Dx, Dy, 'y*');%giallo


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% STRETCH IMAGE TO FIT A SQUARE

origImgVertex = [Dx Dy;  Cx Cy; Ax Ay; Bx By ];
height = 550;
width = 550;

%%%OLD
%TFORM=cp2tform(origImgVertex,[1 1; height 1; 1 width; height width],'projective');
%A =imtransform(FI,TFORM,'XData',[1 width],'YData',[1 height],'XYScale',[1 1]);


%%%NEW
TFORM=fitgeotrans(origImgVertex,[1 1; height 1; 1 width; height width],'projective');
%-->fitgeotrans
%takes the pairs of control points, movingPoints and fixedPoints, 
%and uses them to infer the geometric transformation specified by transformationType
%-->'projective'	
%Use this transformation when the scene appears tilted. 
%Straight lines remain straight, but parallel lines converge toward a vanishing point.

RA = imref2d([height width],[1 width], [1 height]);
%Create a reference coordinate system where the extent is the size of the image
[A,~] = imwarp(FI, TFORM, 'OutputView', RA);




% figure(665), imshow(A), title('stretched');


%hold on;
% Ax = 1;
% Ay = height;
% Bx = width;
% By = height;
% Cx = width;
% Cy = 1;
% Dx = 1;
% Dy = 1;

% x= 1;
% y= 1;
% plot(x,y, 'bs', Ax, Ay, 'b*');%blu
% plot(x,y, 'bs', Bx, By, 'r*');%rosso
% plot(x,y, 'bs', Cx, Cy, 'g*');%verde
% plot(x,y, 'bs', Dx, Dy, 'y*');%giallo



% pause(5);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


diffx1 = (Ax - Dx);
diffx2 = (Ax - Bx);
diffx3 = (Dx - Cx);
diffx4 = (Cx - Bx);

diffy1 = (Ay - Dy);
diffy2 = (Ay - By);
diffy3 = (Dy - Cy);
diffy4 = (Cy - By);

%X = [xCorners(:,4),xCorners(:,1);yCorners(:,4),yCorners(:,1)];
%d = pdist(X,"euclidean")
distAD = sum(sqrt(diffx1.^2+diffy1.^2)); %lato AD
distAB = sum(sqrt(diffx2.^2+diffy2.^2)); %lato AB
distDC = sum(sqrt(diffx3.^2+diffy3.^2)); %lato DC
distBC = sum(sqrt(diffx4.^2+diffy4.^2)); %lato BC






lati = [distAD, distAB, distDC, distBC];

%latoMaggiore = min(lati)
latoMaggiore = max(lati); 
%%%TODO raddrizzare con lato maggiore
%%% TODO calcolo rapporto tra lato maggiore e due lati adiacenti

position = find(lati == latoMaggiore, 1);

switch position
    case 1
        %AD e' lato maggiore
        rapp1 = distAD/distDC;
        rapp2 = distAD/distAB;
        
       % plot([Ax,Dx],[Ay,Dy],'LineWidth',7,'Color','yellow');
    case 2
        %AB e' lato maggiore
        rapp1 = distAB/distBC;
        rapp2 = distAB/distAD;
        
     %   plot([Ax,Bx],[Ay,By],'LineWidth',7,'Color','yellow');
    case 3
        %DC e' lato maggiore
        rapp1 = distDC/distAD;
        rapp2 = distDC/distBC;
        
     %   plot([Dx,Cx],[Dy,Cy],'LineWidth',7,'Color','yellow');
    case 4
        %BC e' lato maggiore
        rapp1 = distBC/distAB;
        rapp2 = distBC/distDC;
        
       % plot([Bx,Cx],[By,Cy],'LineWidth',7,'Color','yellow');
end


rapporti = [rapp1, rapp2];
rapportoMax = max(rapporti);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
latiOrdinati = min(lati);
%latiOrdinati = latiOrdinati([1]);

position = find(lati == latiOrdinati, 1);
%vertical = false;
switch position
    case 1
        %AD e' lato minore
        %A #4
        X11 = Ax;
        Y11 = Ay;
        %D #1
        X21 = Dx;
        Y21 = Dy;
        
        %BC e' lato minore
        %B #3
        X12 = Bx;
        Y12 = By;
        %C #2
        X22 = Cx;
        Y22 = Cy;
        
        vertical = false;
        
    case 2
        %(inverto B con C)
        %AB e' lato minore
        %A
        X11 = Ax;
        Y11 = Ay;
        %B
        X21 = Bx;
        Y21 = By;
        
        
        %DC e'altro lato minore
        %D
        X12 = Dx;
        Y12 = Dy;
        %C
        X22 = Cx;
        Y22 = Cy;
        
        vertical = true;
        
    case 3
        %(inverto B con C)
        %DC e' lato minore
        %D
        X12 = Dx;
        Y12 = Dy;
        %C
        X22 = Cx;
        Y22 = Cy;
        
        
        %AB e'altro lato minore
        %A
        X11 = Ax;
        Y11 = Ay;
        %B
        X21 = Bx;
        Y21 = By;
        
        vertical = true;
    case 4
        %BC e' lato minore
        %A
        X11 = Ax;
        Y11 = Ay;
        %B
        X12 = Bx;
        Y12 = By;
        
        
        %AD e' altro lato minore
        %D
        X21 = Dx;
        Y21 = Dy;
        %C
        X22 = Cx;
        Y22 = Cy;
        
        vertical = false;
end


%A B C D
%4 3 2 1

p1 = [Ax,Dx]; %cyano
p2 = [Ay,Dy];
%equazione prima retta
c = [[1; 1]  p1(:)]\p2(:);                        % Calculate Parameter Vector
m1 = c(2);

p1 = [Ax,Bx]; %bianca
p2 = [Ay,By];
%equazione prima retta
c = [[1; 1]  p1(:)]\p2(:);                        % Calculate Parameter Vector
m2 = c(2);

p1 = [Dx,Cx]; %verde
p2 = [Dy,Cy];
%equazione prima retta
c = [[1; 1]  p1(:)]\p2(:);                        % Calculate Parameter Vector
m3 = c(2);

p1 = [Cx,Bx]; %rossa
p2 = [Cy,By];
%equazione prima retta
c = [[1; 1]  p1(:)]\p2(:);                        % Calculate Parameter Vector
m4 = c(2);

ORTOGONALICB = m1 * m2;  %cyano bianca


ORTOGONALICV = m1 * m3;  %cyano verde


ORTOGONALIBR = m2 * m4;  %bianca rossa

ORTOGONALIVR = m3 * m1;  %cyano verde



Ms = [ORTOGONALICB, ORTOGONALICV, ORTOGONALIBR, ORTOGONALIVR];
Mminor = min(Ms);

position = find(Ms == Mminor, 1);

switch position
    case 1
        %m1
        mc = m1;
        %ciano bianco
        %coord B e D
        topxy = [Dx; Dy];
        botxy = [Bx; By];
        tb = [Dx Dy Bx-Dx By-Dy];
        %m2
    case 2
        %m1
        mc = m1;
        %ciano verde
        topxy = [Cx; Cy];
        botxy = [Ax; Ay];
        tb = [Cx Cy Ax-Cx Ay-Cy];
        
        %m3
    case 3
        %m2
        mc = m4;
        %bianco rosso
        topxy = [Cx; Cy];
        botxy = [Ax; Ay];
        tb = [Cx Cy Ax-Cx Ay-Cy];
        %m4
    case 4
        %m3
        mc = m4;
        %verde rosso
        topxy = [Dx; Dy];
        botxy = [Bx; By];
        tb = [Dx Dy Bx-Dx By-Dy];
        %m4
end


%%%%%
% fprintf('is vertical? \n')
% vertical
Ax = 1;
Ay = height;
Bx = width;
By = height;
Cx = width;
Cy = 1;
Dx = 1;
Dy = 1;
if (vertical)
    X12 = Dx;
    Y12 = Dy;
    %C
    X22 = Cx;
    Y22 = Cy;
    
    
    %AB e'altro lato minore
    %A
    X11 = Ax;
    Y11 = Ay;
    %B
    X21 = Bx;
    Y21 = By;
    
else
    X11 = Ax;
    Y11 = Ay;
    %B
    X12 = Bx;
    Y12 = By;
    
    
    %AD e' altro lato minore
    %D
    X21 = Dx;
    Y21 = Dy;
    %C
    X22 = Cx;
    Y22 = Cy;
    
end

[m,n,~] = size(image);
BWmask = poly2mask(xCorners,yCorners,m,n); %rettangoli &quad



shape = classify_shape(BWmask, rapportoMax);





if shape == "Rectangle"
    
    %DO RETTANGOLO
   % BWmask = poly2mask(xCorners,yCorners,m,n);
%     rp = regionprops(BWmask, "Centroid");
    
   tag = do_rectangle_box(A, vertical, bright, X11, Y11, X12, Y12, X22, Y22, X21, Y21);
   
else
    %DO QUADRATO
    
    %%% COUNT STICKERS ON FI IMAGE
    if (bright == "light")
        %FI al posto di image
        stickers = count_square_light(image_old, true);
    else
        stickers = count_square_dark(image_old, true);
    end
%     stickers
    if (stickers ~= 24)
        
        tag = do_square_box(A, Ax, Ay, Bx, By, Cx, Cy, Dx, Dy);
    else
        tag = "conforme";
        figure(1001), imshow(A), title(tag);
    end
   % imBollini = countTEST(BWmask .* original_image);
end


 



