function graph_partitioning_max_cut_final_graph(data,size,spin)
    f2 = figure;
    R = 1;
    alf=linspace(pi/2,5/2*pi,size+1);
    x = R*cos(alf);
    y = R*sin(alf);
    for i = 1 : size
        if(spin(i,1) == 1)
            plot(x(i),y(i),'ro');
            hold on;
        else
            plot(x(i),y(i),'bd');
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
    axis 'equal';
    title('Final Graph');
end