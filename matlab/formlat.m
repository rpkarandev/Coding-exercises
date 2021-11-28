function lat = formlat(lat,ch)
lat=zeros(size(lat,1),size(lat,2));
for i = 1 : max(size(ch,1))
    j = lat(ch(i,1),ch(i,2));
    if j == 0
        lat(ch(i,1),ch(i,2)) = i;
   else
      warning('Error in Lattice Setup Data: two monomer in same position: %d overriding %d!!',i,j);
      break;
    end
end