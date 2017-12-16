function [H, theta, rho] = myhough(BW)
   BW_diameter = round(sqrt(size(BW, 1).^2 + size(BW, 2).^2)) + 1;
   
   H = zeros(2*BW_diameter + 1, 180);
   rho = -BW_diameter:BW_diameter;
   
   [foreground_y, foreground_x] = find(BW);
   
   deg_to_rad = pi / 180;
   theta = -90:89;   
   
   for angle = theta
       angle_cos=cos(angle * deg_to_rad);
       angle_sin=sin(angle * deg_to_rad);
       p=foreground_x * angle_cos + foreground_y * angle_sin;
       p=floor(p);
       for i = p'
           Hx = i + BW_diameter;
           Hy = angle+90 +1;
           H(Hx, Hy) = H(Hx, Hy)+1;
       end
   end
end
