function ising_configuration_2D(spin)
    size1 = size(spin,1);
    size2 = size(spin,2);
    x = 1 : size1;
    y = 1 : size2;
    f2 = figure;
    other_value = -1;
    for i = 1 : size1
        for j = 1 : size2
            if spin(i,j) == 1
                p1 = plot(x(1,i),y(1,j),'ro'); % 1 is red
            else
                p2 = plot(x(1,i),y(1,j),'bo'); % 1 is blue
                other_value = spin(i,j);
            end
            hold on;
        end
    end
    axis 'equal';
    title('Ising Spins');
    legend([p1,p2],{'1',num2str(other_value)},'Location','northeastoutside');
end