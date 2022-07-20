function initial_graph(data)
    spin_size = size(data,1);
    f = figure;
    alf = linspace(pi/2,5/2*pi,spin_size+1);
    R = 1;
    x = R*cos(alf);
    y = R*sin(alf);
    plot(x,y,'ro');
    hold on
    for i = 1 : spin_size
        for j = 1 : (i-1)
            if(data(i,j)~=0)
                plot([x(i),x(j)],[y(i),y(j)]);
                hold on
            end
        end
    end
    axis 'equal';
    title('Input Graph');
end