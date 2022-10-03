function [x,y,m,n] = get_rect(xC,yC)


Ax = xC(:,4);
Ay = yC(:,4);
Bx = xC(:,3);
By = yC(:,3);
Cx = xC(:,2);
Cy = yC(:,2);
Dx = xC(:,1);
Dy = yC(:,1);

diffx1 = (Ax - Dx); 
diffx2 = (Ax - Bx); 
diffx3 = (Dx - Cx); 
diffx4 = (Cx - Bx); 

diffy1 = (Ay - Dy); 
diffy2 = (Ay - By);
diffy3 = (Dy - Cy);
diffy4 = (Cy - By);


%d = pdist(X,"euclidean")
distAD = sum(sqrt(diffx1.^2+diffy1.^2)); %lato AD
distAB = sum(sqrt(diffx2.^2+diffy2.^2)); %lato AB
distDC = sum(sqrt(diffx3.^2+diffy3.^2)); %lato DC
distBC = sum(sqrt(diffx4.^2+diffy4.^2)); %lato BC




%prende la figura piu' piccola
if(distAB < distDC)
    dist1 = distAB;
else
    dist1 = distDC;
end

if(distAD < distBC)
    dist2 = distAD;
else
    dist2 = distBC;
end

x = xC(:,1);
y = yC(:,1);
m = dist1;
n = dist2;
%rect = [xC(:,1),yC(:,1),distAB,distAD];

end