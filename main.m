clear;
clc;

%% Initialize
%% History Container 
%% datastored: count+1,M(4){no of Interactions}, E, delE ,eta ,Acceptance(boolean),rmsd, rmsdx, rmsdy
histd = zeros(1,12);
choice = 0;
iter = 0;

%% get a choice
while not(choice > 0 && iter > 0) 
    %Choose the Mode/Type of Protein Folding
    choice = input('Enter a number (1-4)  \n    1-> Chain Unfolding (Method 1)\n    2-> Chain Unfolding (Method 2)\n    3-> Chain Folding \n    4-> Multi Chain Folding:  ');
    %% Number of iterations: to gather large data
    iter = input('Enter no of runs/stimulations \n(if not sure enter 1):'); 
end

%Calling for Folding Function
for i = 1:iter
    %%Chain Data is fed via "Data.mat" and chain length is hardcoded in Lattice_Chain_Folding Function.
    tic;
    disp('Left Click on the Plot (off plot area) to Pause/Resume and Right Click to stop the Run');
    disp('Charts and Plots will be displayed after Right-Click');
    histi = Lattice_Chain_Folding(choice);
    toc;
    %%Concatenating all the Data into a variable
    histd = vertcat(histd,histi);
end
disp('Iteration Stopped !! Plotting gathered data .. . ');
histd = histd(2:size(histd,1),:);

%% Plotting Historical Data Gathered
%%## History Container %count+1,M,E,delE,eta,Acceptance,rmsd, rmsdx, rmsdy
 %Filtering only accepted states data from History 
warning('off','MATLAB:scatteredInterpolant:DupPtsAvValuesWarnId');
    x = histd(:,10);  %%% Root Mean Square Distance from Native Fold
    y = (histd(:,3) + histd(:,5))/27; %%% fraction of native interactions (In 8 directions, both native and non native)
    yy = (histd(:,2) + histd(:,4)+ histd(:,3) + histd(:,5))/27; %%% fraction of interactions (In 8 directions, both native and non native)
    z = histd(:,6); %%% Energy value E of the state. if E0 = 0, it becomes del E
    y1 = histd(:,11); %%% Root mean square distance X (X - Component)
    y2 = histd(:,12); %%% Root mean square distance Y (Y - Component)
    dx = 0.05;
    dy = 0.05;
    y1_edge=[floor(min(y1)):dx:ceil(max(y1))];
    y2_edge=[floor(min(y2)):dy:ceil(max(y2))];
    x_edge=[floor(min(x)):dx:ceil(max(x))];   
    y_edge=[floor(min(y)):dx:ceil(max(y))];
    yy_edge=[floor(min(yy)):dy:ceil(max(yy))];
f1 = figure('name','Scatter Plot: RMSD vs delE');
    c = linspace(1,200,length(z));
    scatter(x,z,54,c,'v')
    title('Root Mean Square Distance (Ref: Native) vs delE');
    xlabel('RMSD');
    ylabel('delE');
f2 = figure('name','Scatter Plot: Fraction of Native Interactions vs delE');
    c = linspace(1,200,length(z));
    scatter(y,z,54,c,'v');
    title('Fraction of Native Interactions vs delE');
    xlabel('Fraction of Native Interactions');
    ylabel('delE');    
f3 = figure('name','Surface 3D Plot: RMSD, NC & delE');
    [X,Y]=meshgrid(x_edge,y_edge);
    Z=griddata(x,y,z,X,Y);
    surf(X,Y,Z);
    shading interp
    title('Root Mean Square Distance (Ref: Native), Fraction of Native Interactions (8 dir) vs delE');
    xlabel('RMSD');
    ylabel('Fraction of Native Interactions');
    zlabel('delE');
    set(gcf,'units','normalized','outerposition',[0 0 1 1]) 
 f4 = figure('name','Surface 3D Plot: RMSDx, RMSDy & delE'); 
    [Y1,Y2]=meshgrid(y1_edge,y2_edge);
    Z=griddata(y1,y2,z,Y1,Y2);
    surf(Y1,Y2,Z);
    shading interp
    title('Root Mean Square Distance X, Y (Ref: Native) vs delE');
    xlabel('RMSDx');
    ylabel('RMSDy');
    zlabel('delE');
    set(gcf,'units','normalized','outerposition',[0 0 1 1]) 
  f5 = figure('name','Surface 3D Plot: Fraction of Native Interactions, Fraction of Interactions & delE'); 
    [Y,YY]=meshgrid(y_edge,yy_edge);
    Z=griddata(y,yy,z,Y,YY);
    surf(Y,YY,Z);
    shading interp
    title('Fraction of Native Interactions, Fraction of Interactions vs delE');
    xlabel('Fraction of Native Interactions');
    ylabel('Fraction of Interactions ');
    zlabel('delE');
   set(gcf,'units','normalized','outerposition',[0 0 1 1]) 
warning('on','MATLAB:scatteredInterpolant:DupPtsAvValuesWarnId');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END END END %%%%%%%%%%%%%%%%%