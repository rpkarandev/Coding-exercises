function rmsd = RMSD(ch0,ch)
rmsd = 0;
for i = 1:size(ch)
   rmsd = rmsd + (ch0(i,1)-ch(i,1))^2 + (ch0(i,2)-ch(i,2))^2;    
end
rmsd = sqrt(rmsd/16);