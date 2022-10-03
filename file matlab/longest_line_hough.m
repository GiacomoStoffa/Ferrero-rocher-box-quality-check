function [A,B] = longest_line_hough(BW)

[H,theta,rho] = hough(BW);

P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
% x = theta(P(:,2));
% y = rho(P(:,1));

lines = houghlines(BW,theta,rho,P,'FillGap',5,'MinLength',7);

max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];

   len = norm(lines(k).point1 - lines(k).point2);
   
   if ( len > max_len)
       max_len = len;
      xy_long = xy;
   end
end


A = xy_long(:,1);
B = xy_long(:,2);