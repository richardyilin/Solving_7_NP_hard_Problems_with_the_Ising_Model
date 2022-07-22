function graph_partitioning_max_cut_final_graph(data,size,spin)
    f3 = figure;
    R = 1;
    alf=linspace(pi/2,5/2*pi,size+1);
    x = R*cos(alf);
    y = R*sin(alf);
    for i = 1 : size
        if(spin(i,1) == 1)
            p1 = plot(x(i),y(i),'ro');
            hold on;
        else
            p2 = plot(x(i),y(i),'bo');
            hold on;
        end
    end
    for i = 1 : size
        for j = 1 : (i-1)
            if(spin(i,1) ~= spin(j,1) && data(i,j)~=0)
                plot([x(i),x(j)],[y(i),y(j)]);
                hold on;
            end
        end
    end
    legend([p1,p2],{'set 1','set 2'},'Location','northeastoutside');
    axis 'equal';
    title('Final Graph');
end