function hamiltonian_cycle_asymetric_traveling_salesman_graph(spin)
    spin_size = size(spin,1);
    f3 = figure;
    alf = linspace(pi/2,5/2*pi,spin_size+1);
    R = 1;
    x = R*cos(alf);
    y = R*sin(alf);
    plot(x,y,'ro');
    hold on
    for j1 = 1 : spin_size
        if j1 ~= spin_size
            j2 = j1 + 1;
        else
            j2 = 1;
        end
        for u = 1 : spin_size
            for v = 1 : spin_size
                if(spin(u,j1) && spin(v,j2))
                    plot([x(u),x(v)],[y(u),y(v)]);
                    hold on
                end
            end
        end
    end
    axis 'equal';
    title('Final Graph');
end