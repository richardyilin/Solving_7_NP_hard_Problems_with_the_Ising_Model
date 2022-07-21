function ising_configuration_1D(spin)
    len = size(spin, 1);
    x = linspace(0, len-1, len);
    f2 = figure;
    other_value = 0;
    for i = 1 : len
        if spin(i, 1) == 1
            p1 = plot(x(1, i), 0, 'ro');
        else
            p2 = plot(x(1, i), 0, 'bo');
            other_value = spin(i, 1);
        hold on
        end
    end
    axis 'equal';
    title('Ising Spins');
    legend([p1,p2],{'1',num2str(other_value)},'Location','northeastoutside');
end