function histd = Lattice_Chain_Folding(choice)
%## Protein Folding _ Version 0.2    
%## Variable Declaration
    iter = 1000000;           %%## Max Number of Iterations 
    lattice = zeros(100,100); %%## Lattice Container   
    hist = zeros(iter,12);    %%## History Container %count+1,M,E,delE,eta,Acceptance,rmsd
    count = 0;                %%## Counter    
    E1 = 0;
    minmax = zeros(1,6);

%##Data Setup

    switch choice
        case 1
          N1 = [16 0]; %%Different Chains  %Length of Polymer/ No of Subunits or monomer for each chain
          N = sum(N1); %Total no of Monomers
      %Native Structure setup - Monomer Coordinates
        %chains(:,1:2) = xlsread('Data.xls','ChainII',['A2',':','B',num2str(N+1)]);
          Folded_Chain = load('Folded_Chain.dat');
          chains = Folded_Chain(1:N,2:3);
          ch0 = chains;
          case 2
          N1 = [16 0]; %%Different Chains  %Length of Polymer/ No of Subunits or monomer for each chain
          N = sum(N1); %Total no of Monomers
      %Native Structure setup - Monomer Coordinates
          Folded_Chain = load('Folded_Chain.dat');
          chains = Folded_Chain(1:N,2:3);
          ch0 = chains;
        case 3
            N1 = [16 0 0 0]; %%Different Chains
            N = sum(N1); %Total no of Monomers
    %Linear Chain setup
          Unfolded_Chain = load('Unfolded_Chain.dat');
          chains = Unfolded_Chain(1:N,2:3);
          ch0 = chains;
        case 4
            N1 = [16 16 16 16]; %%%%Different Chains
            %N1 = [8 8 8 8 8 8 8 8]; %%%%Different Chains
            N = sum(N1); %Total no of Monomers
         Unfolded_Chain = load('Unfolded_Chain.dat');
         chains = Unfolded_Chain(1:N,2:3);
          ch0 = chains;
        otherwise
            warning('No valid input !! Goodbye :-)');
            return;
    end        
%##Initial Structure setup - Native Interactions
    %%f2 = figure('name','Protein Funnel');  
    f1 = figure('name','Lattice Model');    
    set(f1,'ButtonDownFcn', @OnPlotClick_CB) %%Pause and resume On mouse click.
    disp('Left Click on the Plot (off plot area) to Pause/Resume and Right Click to stop the Run');
   %NInter = zeros(N,7);  %%## Container to hold all Native Interaction Data.xls (Input and Reference)
   %NInter = NInter + xlsread('Data.xls','Interaction',['A2',':','G',num2str(N+1)]);
    Interactions = load('Interactions.dat');
    NInter = Interactions(1:N,2:8);    
    N1 = cumsum(N1(N1 > 0)); %%Transformation of Chain Length data to more usable form !!
    
%##Extract chains and validate input data %Validation : one position, one monomer
    lattice = formlat(lattice,chains(:,1:2));
%##Calculate Interactions; %Funtion to Calculate Interactions    
    [chains, M, E1, ~] = CalInteract(lattice,chains,NInter,N1,E1,choice);
    hist(count+1,:) = [count+1 M E1 0 0 1 0 0 0]; %%## History Container %count+1,M,E,delE,eta,Acceptance,rmsd, rmsdx, rmsdy
%NI = DefNatInteract(lattice,chains,NInter) to compute Native Interactions %.. . ... . . . . Not used anywhere.

%Plotting the Current Structure%%minmax is a dummy variable. Used to retain memory of Plot Axes    
    [minmax, stop] = PlotChain(chains(:,1:2),N1,count,E1,M,minmax,f1);
    
for k = 1:iter
    S = round(rand() * (N-1)) + 1; %% Random Select of a Monomer
    oldX = chains(S,1);
    oldY = chains(S,2);
    %lattice = formlat(lattice,chains(:,1:2)); %% Double Verification
    [newX, newY, move] = Moves(lattice,chains, S, N1); %% Find Possible Moves for the Monomer Selected
    %%%% Moving/ Altering the Chain
    if move == 1 %% If Move Possible 
        chains(S,1) = newX;
        chains(S,2) = newY;
        lattice = formlat(lattice,chains(:,1:2)); %% Rearranging the Lattice based on the Move
        [chains, M, E2, eta] = CalInteract(lattice,chains,NInter,N1,E1,choice); %% Recalculate the Interactions, Energy Change & Beta        
        count = count + 1 ;   
        hist(count+1,:) = [count+1 M E2 E2-E1 eta 0 0 0 0]; %% Record the History for Future !!        
        %tic,pause(0.1),toc 
        [minmax, stop] = PlotChain(chains(:,1:2),N1,count,E2,M,minmax,f1); 
               if eta >= rand()
                    E1 = E2;
                    hist(count+1,9) = 1;
                    hist(count+1,10) = RMSD(ch0,chains(:,1:2));
%                     RMSDXY(ch0,chains(:,1:2))
%                     [a , b] = RMSDXY(ch0,chains(:,1:2))
                    [hist(count+1,11), hist(count+1,12)] = RMSDXY(ch0,chains(:,1:2));
%                     set(0, 'CurrentFigure', f2)
%                     scatter(hist(count+1,10),E2,'Fill');
                    hold on
               else
                     chains(S,1) = oldX;
                     chains(S,2) = oldY;
                     lattice = formlat(lattice,chains(:,1:2));             
                     [minmax, stop] = PlotChain(chains(:,1:2),N1,count,E1,M,minmax,f1);  
                end
    end
    if stop > 0     
        break;
    end
end
histd = hist(hist(:,9) > 0,:);
     %%Function to capture mouse click
        function OnPlotClick_CB(src,~)
            click = get(src,'SelectionType');
            if strcmp(click,'alt')
                setappdata(gcf,'stop',1);
            elseif strcmp(click,'normal')
                state = get( gcf, 'waitstatus' );
                if strcmp(state,'waiting')
                    uiresume;
                    disp('Execution Resumed !! Click to pause.');
                else                    
                    disp('Execution Paused !! Click to resume.');
                    uiwait;
                end
            end
        end    
end
