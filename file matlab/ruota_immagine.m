function out_image= ruota_immagine(image) %input immagine gia' ritagliata

ycbcr = rgb2ycbcr(image);


im = ycbcr(:,:,3);


bwimage = im;

t =graythresh(bwimage);

BW = imbinarize(bwimage, t-0.03);

BW = imerode(BW, strel("square", 3));

BW = edge(BW,'canny', [0.1 0.2], 1);










[H,theta,rho] = hough(BW);

P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = theta(P(:,2));
y = rho(P(:,1));

lines = houghlines(BW,theta,rho,P,'FillGap',5,'MinLength',7);

max_len = 0;
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];

    % Determine the endpoints of the longest line segment
    len = norm(lines(k).point1 - lines(k).point2);
    
    if ( len > max_len)

        max_len = len;
        xy_long = xy;
    end
end


p1 = xy_long(:,1);
p2 = xy_long(:,2);
%equazione prima retta
c = [[1; 1]  p1(:)]\p2(:);                        % Calculate Parameter Vector
coefficiente_ang_m = c(2);
intercetta_q = c(1);
%coefficiente_ang_m
%atand(coefficiente_ang_m)
%equazione retta ortogonale
%y - y1 = -1/m1(x - x1)
out_image = imrotate(image, atand(coefficiente_ang_m));



end