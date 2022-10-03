function out= count_black_pixel(image)

[n,m] = size(image);
count = 0;
 for r=1:n
   for c=1:m
        if image(r,c) < (30/255) %soglia trial & error
            
            count = count +1;
        end
   end
 end
out = count;
end