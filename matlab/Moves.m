function [newX, newY, move] = Moves(lat,ch,S,N1)
move = 0;
newX = 0;
newY = 0;
oldX = ch(S,1);
oldY = ch(S,2);
    if S == 1  || any(N1(:)+1 == S) || any(N1(:) == S) %%|| S == N  %% Terminals: Corner Move
            if S == 1  || any(N1(:)+1 == S)
                I = 1;
            else
                I = -1;
            end
                if abs(ch(S,1)- ch(S+I,1)) > 0 %%%% Horizontal
                  newX = ch(S+I,1);                     
                 ss = round(rand);
                         if ss == 1 && lat(newX,ch(S,2)+1) == 0
                             newY = ch(S,2)+1;                       
                         elseif lat(newX,ch(S,2)-1) == 0
                             newY = ch(S,2)-1;
                         elseif lat(newX,ch(S,2)+1) == 0
                             newY = ch(S,2)+1;   
                         end
                elseif abs(ch(S,2)- ch(S+I,2)) > 0 %% Vertical
                  newY = ch(S+I,2);
                         ss = round(rand);
                         if ss == 1 && lat(ch(S,1)+1,newY) == 0
                             newX = ch(S,1)+1;                   
                         elseif lat(ch(S,1)-1,newY) == 0
                             newX = ch(S,1)-1;
                         elseif lat(ch(S,1)+1,newY) == 0
                             newX = ch(S,1)+1;   
                         end                  
                end   
    else %% Others: Crank-Shaft Move
      if (abs(ch(S,1)- ch(S+1,1)) > 0) && (abs(ch(S,2)- ch(S-1,2)) > 0)  && lat(ch(S+1,1),ch(S-1,2)) == 0
          newX = ch(S+1,1);
          newY = ch(S-1,2);
%           if lat(newX,newY) == 0 
%             move = 1;
%           end
      elseif (abs(ch(S,2)- ch(S+1,2)) > 0) && (abs(ch(S,1)- ch(S-1,1)) > 0) && lat(ch(S-1,1),ch(S+1,2)) == 0
          newX = ch(S-1,1);
          newY = ch(S+1,2);
%           if lat(newX,newY) == 0 
%             move = 1;
%           end
      end
    end
   %%Verification the New Location is calculated
  if newX > 0 && newY > 0
    %%%%Error Check      . . .Movement cannot be more than 1 magnitude !!
        if abs(newX - oldX) > 1 || abs(newY - oldY) > 1
            warning(' Big Movement Detected !! Move# %d, Residue: %d from (%d %d) to (%d %d) %d',move, S, oldX, oldY, newX,newY);                
            move = 0;
            newX = 0;
            newY = 0;
        else
        move = 1;
        end      
  else
    move = 0;
    newX = 0;
    newY = 0;
      %% No Moves
  end