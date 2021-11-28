## 2D lattice chain model to understand protein folding -
+ Learning exercise to understand protein folding
+ Old code
+ todo: translate to python (someday)

### list of files
#### matlab scripts
+ main.m - main script; call the function to start; Four choices are provided; Executes Lattice_Chain_Folding.m
+ CalInteract.m - calculate interactions and score the conformations
+ DefNatInteract.m - define native interactions
+ Lattice_Chain_Folding.m - 
+ Moves.m - Crank-Shaft and corner moves

+ PlotChain.m - script to plot the lattice models in realtime
+ RMSD.m, RMSDXY.m - functions to simplify the code
+ formlat.m - create a lattice with given chains

#### Data files
+ Unfolded_Chain.dat
+ Folded_Chain.dat
+ Interactions.dat

####
+ Data is stored as history (12 values): count+1,M(4){no of Interactions}, E, delE ,eta ,Acceptance(boolean),rmsd, rmsdx, rmsdy
