function [minmax, stop] = PlotChain(ch, N1, count, E, M1, minmax1,f1)
%%Plotting all chains
cla;
st = 1;   
    for i = N1(N1 > 0)
        set(0, 'CurrentFigure', f1);
        plot(ch(st:i,1),ch(st:i,2),'ko-',ch(st,1),ch(st,2),'bo-',ch(i,1),ch(i,2),'ro-','linewidth',4,'Markersize',6,'markerfacecolor',[.7 .7 .7],'markeredgecolor','auto');
        hold on
        st = i + 1;
    end
hold off
setappdata(gcf,'stop',0);

%% Plot Window set up
a1 = 4; a2 = 6; b = 1; c = 1; d = 3;
if minmax1 == zeros(1,6)
    len1 = max([10,(max(ch(:,1)) - min(ch(:,1)))]);
    len2 = max([10,(max(ch(:,2))- min(ch(:,2)))]);
    minmax(1) = min(ch(:,1)) - a1;    
    minmax(3) = min(ch(:,2)) - a2;
    minmax(2) = minmax(1) + len1 + 2*a1;
    minmax(4) = minmax(3) + len2 + 2*a2;
    minmax(5) = 0;
    minmax(6) = 0;
    if nnz(N1) > 1
        set(gcf,'units','normalized','outerposition',[0 0 1 1]) 
        xlabel('Lattice Model','FontSize', 22, 'FontWeight', 'bold','color', [0 0 0.1], 'FontName','Castellar');
    else
        xlabel('Lattice Model','FontSize', 18, 'FontWeight', 'bold','color', [0 0 0.1], 'FontName','Castellar');
    end   
else
     minmax(1) = minmax1(1);
     minmax(2) = minmax1(2);
     minmax(3) = minmax1(3);
     minmax(4) = minmax1(4);
     minmax(5) = minmax1(5);
     minmax(6) = minmax1(6);
    %%Updating status on Plot  
    str = sprintf('Count = %- 6.0f \t   Energy = % 4.1f \t    I = % 2.0f \t    NI = % 2.0f',count,E,M1(1)+M1(2),M1(2));
    if nnz(N1) > 1
        title(str,'FontSize', 18, 'FontWeight', 'bold', 'FontName','Castellar');
    else
        title(str,'FontSize', 12, 'FontWeight', 'bold', 'FontName','Castellar');
    end
end
    xlim([minmax(1) minmax(2)])
    ylim([minmax(3) minmax(4)])      
     h = handle(gcf); 
    h.name='Lattice Model';
    h.color = [0.7 0.7 0.7];
    %%set(f1,'ButtonDownFcn', @OnPlotClick_CB) %%Pause and resume On mouse click.
    %%set(get(h,'Children'),'ButtonDownFcn', @OnPlotClick_CB) %%Pause and resume On mouse click.
    g=handle(gca);
    g.color = [0.95 0.95 0.95];
    g.XTick = [0:1:100];
    g.YTick = [0:1:100];
    g.XTickLabel = [];
    g.YTickLabel = [];
    g.Xcolor = [.8 .85 .8];
    g.Ycolor = [0.8 0.8 0.85];    
    g.LineWidth = 5;
    g.GridLineStyle = '-';   
    grid on
    %%Redraw the Plot
    drawnow;
    %%pause(0.02)  
    stop = getappdata(gcf,'stop');
    
    
%%Recalibration of Plot Window size for next iteration
    if minmax(1) >= min(ch(:,1))-c && minmax(2) <= max(ch(:,1)) + c
        minmax(1) = minmax(1)-b;
        minmax(2) = minmax(2)+b;
        minmax(5) = minmax(5) + 1;
    elseif minmax(1) >= min(ch(:,1))-c
        minmax(1) = minmax(1)-b; 
        minmax(2) = minmax(2)-b;  
    elseif minmax(2) <= max(ch(:,1)) + c
        minmax(1) = minmax(1)+b; 
        minmax(2) = minmax(2)+b;
    else
       if minmax(5) > 0 && minmax(1) < min(ch(:,1)) - d
        minmax(1) = minmax(1)+b; minmax(5) = minmax(5) -0.5;
       end
       if minmax(5) > 0 && minmax(2) > max(ch(:,1)) + d
        minmax(2) = minmax(2)-b; minmax(5) = minmax(5) -0.5;
       end
    end
    if minmax(3) >= min(ch(:,2)) -c && minmax(4) <= max(ch(:,2)) + c
        minmax(3) = minmax(3)-b;
        minmax(4) = minmax(4)+b;
    elseif minmax(3) >= min(ch(:,2)) -c
        minmax(3) = minmax(3)-b;
        minmax(4) = minmax(4)-b; 
    elseif minmax(4) <= max(ch(:,2)) + c
        minmax(3) = minmax(3)+b;
        minmax(4) = minmax(4)+b;
    else
       if minmax(6) > 0 && minmax(3) < min(ch(:,2))- d
        minmax(3) = minmax(3)+b; minmax(6) = minmax(6) -0.5;
       end
       if minmax(6) > 0 && minmax(4) > max(ch(:,2)) + d
        minmax(4) = minmax(4)-b; minmax(6) = minmax(6) -0.5;
       end
    end  
    
end