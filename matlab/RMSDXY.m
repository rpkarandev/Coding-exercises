function [rmsdx,rmsdy] = RMSDXY(ch0,ch)
rmsdx = 0;
rmsdy = 0;
l = size(ch,1);
for i = 1:l
   rmsdx = rmsdx + (ch(i,1)-ch0(i,1))^2; 
   rmsdy = rmsdy + (ch(i,2)-ch0(i,2))^2; 
end
rmsdx = sqrt(rmsdx/l);
rmsdy = sqrt(rmsdy/l);