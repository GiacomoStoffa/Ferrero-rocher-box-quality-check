function out=square_rows_cut(image, Xs, Ys, length, vertical)
color = "giallo";
[m,n,~] = size(image);

errors = [];
ncoloumn = (length*2)-1;%per migliorare precisione
%ncoloumn = (length *4)-1; %
Ax = Xs(:,1);
Bx = Xs(:,2);
Cx = Xs(:,3);
Dx = Xs(:,4);
Ay = Ys(:,1);
By = Ys(:,2);
Cy = Ys(:,3);
Dy = Ys(:,4);
if(~vertical)
    deltax = (Bx-Ax)/ncoloumn;
    deltay = (By-Ay)/ncoloumn;
    halfdx = deltax/2;
    halfdy = deltay/2;
    xcents1 = Ax + halfdx + (0:ncoloumn-1)*deltax;
    ycents1 = Ay + halfdy + (0:ncoloumn-1)*deltay;
    
    deltax = (Cx-Dx)/ncoloumn;
    deltay = (Cy-Dy)/ncoloumn;
    halfdx = deltax/2;
    halfdy = deltay/2;
    xcents2 = Dx + halfdx + (0:ncoloumn-1)*deltax;
    ycents2 = Dy + halfdy + (0:ncoloumn-1)*deltay;
else
    deltax = (Ax-Dx)/ncoloumn;
    deltay = (Ay-Dy)/ncoloumn;
    halfdx = deltax/2;
    halfdy = deltay/2;
    xcents1 = Dx + halfdx + (0:ncoloumn-1)*deltax;
    ycents1 = Dy + halfdy + (0:ncoloumn-1)*deltay;
    
    deltax = (Bx-Cx)/ncoloumn;
    deltay = (By-Cy)/ncoloumn;
    halfdx = deltax/2;
    halfdy = deltay/2;
    xcents2 = Cx + halfdx + (0:ncoloumn-1)*deltax;
    ycents2 = Cy + halfdy + (0:ncoloumn-1)*deltay;
end

switch(length)
    
    case(1)
        errors = predict_cell(image,Xs,Ys,errors);
    case(2)
        
        if(~vertical)
            xcell1 = [Ax, xcents1(:,2), xcents2(:,2), Dx];
            ycell1 = [Ay, ycents1(:,2), ycents2(:,2), Dy];
            
            xcell2 = [xcents1(:,2), Bx,Cx,xcents2(:,2)];
            ycell2 = [ycents1(:,2), By,Cy,ycents2(:,2)];
        else
            xcell1 = [Dx, xcents1(:,2), xcents2(:,2), Cx];
            ycell1 = [Dy, ycents1(:,2), ycents2(:,2), Cy];
            
            xcell2 = [xcents1(:,2), Ax,Bx,xcents2(:,2)];
            ycell2 = [ycents1(:,2), Ay,By,ycents2(:,2)];
            
        end
        errors = predict_cell(image,xcell1,ycell1,errors);
        errors = predict_cell(image,xcell2,ycell2,errors);
        
    case(3)
        
        if(~vertical)
            xcell1 = [Ax, xcents1(:,2), xcents2(:,2), Dx];
            ycell1 = [Ay, ycents1(:,2), ycents2(:,2), Dy];
            
            xcell3 = [xcents1(:,4), Bx,Cx,xcents2(:,4)];
            ycell3 = [ycents1(:,4), By,Cy,ycents2(:,4)];
        else
            xcell1 = [Dx, xcents1(:,2), xcents2(:,2), Cx];
            ycell1 = [Dy, ycents1(:,2), ycents2(:,2), Cy];
            
            xcell3 = [xcents1(:,4), Ax,Bx,xcents2(:,4)];
            ycell3 = [ycents1(:,4), Ay,By,ycents2(:,4)];
            
        end
        
        
        xcell2 = [xcents1(:,2), xcents1(:,4),xcents2(:,4),xcents2(:,2)];
        ycell2 = [ycents1(:,2), ycents1(:,4),ycents2(:,4),ycents2(:,2)];
        
        
        
        errors = predict_cell(image,xcell1,ycell1,errors);
        errors = predict_cell(image,xcell2,ycell2,errors);
        errors = predict_cell(image,xcell3,ycell3,errors);
        

    case(5)
        
        xcell1 = [Ax, xcents1(:,2), xcents2(:,2), Dx];
        ycell1 = [Ay, ycents1(:,2), ycents2(:,2), Dy];
        xcell2 = [xcents1(:,2), xcents1(:,4),xcents2(:,4),xcents2(:,2)];
        ycell2 = [ycents1(:,2), ycents1(:,4),ycents2(:,4),ycents2(:,2)];
        xcell3 = [xcents1(:,4), xcents1(:,6),xcents2(:,6),xcents2(:,4)];
        ycell3 = [ycents1(:,4), ycents1(:,6),ycents2(:,6),ycents2(:,4)];
        xcell4 = [xcents1(:,6), xcents1(:,8),xcents2(:,8),xcents2(:,6)];
        ycell4 = [ycents1(:,6), ycents1(:,8),ycents2(:,8),ycents2(:,6)];
        xcell5 = [xcents1(:,8), Bx,Cx,xcents2(:,8)];
        ycell5 = [ycents1(:,8), By,Cy,ycents2(:,8)];
        
        errors = predict_cell(image,xcell1,ycell1,errors);
        errors = predict_cell(image,xcell2,ycell2,errors);
        errors = predict_cell(image,xcell3,ycell3,errors);
        errors = predict_cell(image,xcell4,ycell4,errors);
        errors = predict_cell(image,xcell5,ycell5,errors);
        
    case(6)
        if(~vertical)
            xcell1 = [Ax, xcents1(:,2), xcents2(:,2), Dx];
            ycell1 = [Ay, ycents1(:,2), ycents2(:,2), Dy];
            
            xcell6 = [xcents1(:,10), Bx,Cx,xcents2(:,10)];
            ycell6 = [ycents1(:,10), By,Cy,ycents2(:,10)];
        else
            xcell1 = [Dx, xcents1(:,2), xcents2(:,2), Cx];
            ycell1 = [Dy, ycents1(:,2), ycents2(:,2), Cy];
            
            xcell6 = [xcents1(:,10), Ax,Bx,xcents2(:,10)];
            ycell6 = [ycents1(:,10), Ay,By,ycents2(:,10)];
            
        end
        
        
        xcell2 = [xcents1(:,2), xcents1(:,4),xcents2(:,4),xcents2(:,2)];
        ycell2 = [ycents1(:,2), ycents1(:,4),ycents2(:,4),ycents2(:,2)];
        xcell3 = [xcents1(:,4), xcents1(:,6),xcents2(:,6),xcents2(:,4)];
        ycell3 = [ycents1(:,4), ycents1(:,6),ycents2(:,6),ycents2(:,4)];
        xcell4 = [xcents1(:,6), xcents1(:,8),xcents2(:,8),xcents2(:,6)];
        ycell4 = [ycents1(:,6), ycents1(:,8),ycents2(:,8),ycents2(:,6)];
        xcell5 = [xcents1(:,8), xcents1(:,10),xcents2(:,10),xcents2(:,8)];
        ycell5 = [ycents1(:,8), ycents1(:,10),ycents2(:,10),ycents2(:,8)];

        
                errors = predict_cell(image,xcell1,ycell1,errors);
                errors = predict_cell(image,xcell2,ycell2,errors);
                errors = predict_cell(image,xcell3,ycell3,errors);
                errors = predict_cell(image,xcell4,ycell4,errors);
                errors = predict_cell(image,xcell5,ycell5,errors);
                errors = predict_cell(image,xcell6,ycell6,errors);
                
                %errors
        
end

out = errors;

end