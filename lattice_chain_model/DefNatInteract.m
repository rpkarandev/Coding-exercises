%CalInteract
%Calculate the Interactions in the Lattice
function NI = DefNatInteract(lat,ch,N1)
minX = min(ch(:,1));
maxX = max(ch(:,1));
minY = min(ch(:,2));
maxY = max(ch(:,2));
N = size(ch,1);
NI = zeros(N,7);
M1 = zeros(1,4);
for x = minX:maxX    
    for y = minY:maxY        
        M = lat(x,y);
        %Compute the Interaction horizontally and vertically !!
        if M > 0  && M ~= N1 %if lattice occupied                     
            %% Horizontal/Veritical Interactions
            %ch(M,3) for All Interactions, ch(M,4) for Native Interactions
                I1 = [lat(x-1,y),lat(x,y-1),lat(x+1,y),lat(x,y+1)]   ;        
                I1 = I1(I1>0);
                I1 = I1(abs(I1-M)>1);
                I1(4) = 0;             
                NI(M,1:3)= I1(1:3)  ;             
            %%% Diagonal Interactions
            %ch(M,5) for All Interactions, ch(M,6) for Native Interactions
                I2= [lat(x-1,y-1),lat(x+1,y-1),lat(x+1,y+1),lat(x-1,y+1)];  
                I2 = I2(I2 > 0);  %&& abs(I2-M) > 1
                I2(5) = 0; 
                NI(M,4:7)= I2(1:4);     
        elseif M > 0  && M == N1                         
            %% Horizontal/Veritical Interactions
            %ch(M,3) for All Interactions, ch(M,4) for Native Interactions
                I1 = [lat(x-1,y),lat(x,y-1),lat(x+1,y),lat(x,y+1)];            
                I1 = I1(I1>0);
                I1 = I1((I1-M) ~= -1);
                I1(4) = 0;             
                NI(M,1:3)= I1(1:3)  ;  
            %%% Diagonal Interactions
            %ch(M,5) for All Interactions, ch(M,6) for Native Interactions
                I2= [lat(x-1,y-1),lat(x+1,y-1),lat(x+1,y+1),lat(x-1,y+1)];  
                I2 = I2(I2 > 0 );  %&& (I2-M) ~= -1               
                I2(5) = 0; 
                NI(M,4:7)= I2(1:4);    
        end           
    end        
end
