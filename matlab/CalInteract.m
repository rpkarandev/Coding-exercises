%CalInteract
%Calculate the Interactions in the Lattice
function [ch, M1, E, eta] = CalInteract(lat,ch,NI,N1,E1,cho)
minX = min(ch(:,1));
maxX = max(ch(:,1));
minY = min(ch(:,2));
maxY = max(ch(:,2));
M1 = zeros(1,4);
for x = minX:maxX    
    for y = minY:maxY        
        M = lat(x,y);
        %Compute the Interaction horizontally and vertically !!
        if M > 0  && not (any(N1(:) == M)) %if lattice occupied
            ch(M,3) = 0;
            ch(M,4) = 0;
            ch(M,5) = 0;
            ch(M,6) = 0;            
            %% Horizontal/Veritical Interactions
            %ch(M,3) for All Interactions, ch(M,4) for Native Interactions
                I1 = [lat(x-1,y),lat(x,y-1),lat(x+1,y),lat(x,y+1)];            
                I1 = I1(I1>0);
                I1 = I1(abs(I1-M)>1);
                ch(M,3) = ch(M,3) + nnz(I1);
                if ch(M,3) >= 1                    
                    I1 = I1(ismember(I1,NI(M,1:3)));
                    ch(M,4) = ch(M,4) + nnz(I1);                 
                end               
                
            %% Diagonal Interactions
            %ch(M,5) for All Interactions, ch(M,6) for Native Interactions
                I2= [lat(x-1,y-1),lat(x+1,y-1),lat(x+1,y+1),lat(x-1,y+1)];  
                I2 = I2(I2 > 0);  %&& abs(I2-M) > 1
                ch(M,5) = ch(M,5) + nnz(I2);
                I2 = I2(ismember(I2,NI(M,4:7)));
                ch(M,6) = ch(M,6) + nnz(I2); 
                M1 = M1 + [ch(M,3), ch(M,4), ch(M,5), ch(M,6)];
        elseif M > 0  && (any(N1(:) == M))
            ch(M,3) = 0;
            ch(M,4) = 0;
            ch(M,5) = 0;
            ch(M,6) = 0;            
            %% Horizontal/Veritical Interactions
            %ch(M,3) for All Interactions, ch(M,4) for Native Interactions
                I1 = [lat(x-1,y),lat(x,y-1),lat(x+1,y),lat(x,y+1)];            
                I1 = I1(I1>0);
                I1 = I1((I1-M) ~= -1);
                ch(M,3) = ch(M,3) + nnz(I1);
                I1 = I1(ismember(I1,NI(M,1:3)));
                ch(M,4) = ch(M,4) + nnz(I1);
            %% Diagonal Interactions
          %%  ch(M,5) for All Interactions, ch(M,6) for Native Interactions
                I2= [lat(x-1,y-1),lat(x+1,y-1),lat(x+1,y+1),lat(x-1,y+1)];  
                I2 = I2(I2 > 0 );  %&& (I2-M) ~= -1
                ch(M,5) = ch(M,5) + nnz(I2);
                I2 = I2(ismember(I2,NI(M,4:7)));
                ch(M,6) = ch(M,6) + nnz(I2);
                M1 = M1 + [ch(M,3), ch(M,4), ch(M,5), ch(M,6)];
        end           
    end        
end
M1 = [(M1(1)-M1(2))/2, (M1(2))/2, (M1(3)-M1(4))/2, (M1(4))/2];
if cho == 1               
          %E = M * [-2; -2; -0.5; -0.5]; %Unfolding
          E = M1 * [1; -2.5; 0.5; 0]; %Unfolding
          eta = exp((E1-E)/10);
%           if E == [0 0 0 0] * [-2; -2; -0.5; -0.5]                              
%              uiwait                 
%           end
elseif cho == 2               
          %E = M * [-2; -2; -0.5; -0.5]; %Unfolding
          E = M1 * [1; 2.5; 0.5; 0.75]; %Unfolding
          eta = exp((E1-E));
%           if E == [0 0 0 0] * [-2; -2; -0.5; -0.5]                              
%              uiwait                 
%           end 
elseif cho == 3
          E = M1 * [1; -2.5; 0; 0];  
          eta = exp((E1-E));
%           if E <= [0 9 0 18] * [1; -2.5; 0; 0]                                
%              uiwait                 
%           end
elseif cho == 4
          E = M1 * [1; -2.5; 0; 0];  
          eta = exp((E1-E));
%           if E <= [0 9 0 18] * [1; -2.5; 0; 0]                                
%              uiwait                 
%           end         
end 
eta = min(1,eta); 
%%#########################################################################################################       
%%% Lengthy form of the program  
%         if M > 0  %if lattice occupied
%             ch(M,3) = 0;
%             ch(M,4) = 0;
%             %Compute the Interaction horizontally and vertically !!
%             %% Horizontal/Veritical Interactions
%             %ch(M,3) for All Interactions, ch(M,4) for Native Interactions
%             M1 = lat(x-1,y);                      
%             if M1 > 0 && abs(M-M1) > 1
%                 ch(M,3) = ch(M,3) + 1;
%                 v = find(NI(M,:)== M1);
%                 if v > 0
%                     ch(M,4) = ch(M,4) + 1;
%                 end
%             end
%             M1 = lat(x+1,y);                      
%             if M1 > 0 && abs(M-M1) > 1
%                 ch(M,3) = ch(M,3) + 1;
%                 v = find(NI(M,:)== M1);
%                 if v > 0
%                     ch(M,4) = ch(M,4) + 1;
%                 end
%             end
%             M1 = lat(x,y-1);                      
%             if M1 > 0 && abs(M-M1) > 1
%                 ch(M,3) = ch(M,3) + 1;
%                 v = find(NI(M,:)== M1);
%                 if v > 0
%                     ch(M,4) = ch(M,4) + 1;
%                 end
%             end
%             M1 = lat(x,y+1);                      
%             if M1 > 0 && abs(M-M1) > 1
%                 ch(M,3) = ch(M,3) + 1;
%                 v = find(NI(M,:)== M1);
%                 if v > 0
%                     ch(M,4) = ch(M,4) + 1;
%                 end
%             end
%             
%             ch(M,5) = 0;
%             ch(M,6) = 0;
%             %%% Diagonal Interactions
%             %ch(M,5) for All Interactions, ch(M,6) for Native Interactions
%               M1 = lat(x-1,y-1);                      
%             if M1 > 0 %&& abs(M-M1) > 1
%                 ch(M,5) = ch(M,5) + 1;
%                 v = find(NID(M,:)== M1);
%                 if v > 0
%                     ch(M,6) = ch(M,6) + 1;
%                 end
%             end
%             M1 = lat(x+1,y+1);                      
%             if M1 > 0 %&& abs(M-M1) > 1
%                 ch(M,5) = ch(M,5) + 1;
%                 v = find(NID(M,:)== M1);
%                 if v > 0
%                     ch(M,6) = ch(M,6) + 1;
%                 end
%             end
%             M1 = lat(x-1,y+1);                      
%             if M1 > 0 %&& abs(M-M1) > 1
%                 ch(M,5) = ch(M,5) + 1;
%                 v = find(NID(M,:)== M1);
%                 if v > 0
%                     ch(M,6) = ch(M,6) + 1;
%                 end
%             end
%             M1 = lat(x+1,y-1);                      
%             if M1 > 0 %&& abs(M-M1) > 1
%                 ch(M,5) = ch(M,5) + 1;
%                 v = find(NID(M,:)== M1);
%                 if v > 0
%                     ch(M,6) = ch(M,6) + 1;
%                 end
%             end
%             M3 = M3 + ch(M,3);
%             M4 = M4 + ch(M,4);
%             M5 = M5 + ch(M,5);
%             M6 = M6 + ch(M,6);
%         end        
%     end
% end
% 
% %E = - M3 - M4 * 1.5 - 0.25 * M5 - M6 * .15;
% E =  M3 * 1 - M4 * 2.5 - 0.0 * M5 - M6 * .25;
