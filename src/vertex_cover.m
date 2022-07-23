function vertex_cover(file_name)
    fileID = fopen(file_name,'r');
    buffer = fscanf(fileID,'%d');
    fclose(fileID);
    size = buffer(1,1);
    edge = buffer(2,1);
    degree = zeros(size,1);
    data = false(size);
    for i = 1 : edge
        start = buffer(2 * i + 1,1);
        over = buffer(2 * i + 2,1);
        data(start,over) = true;
        data(over,start) = true;
        degree(start,1) = degree(start,1) + 1;
        degree(over,1) = degree(over,1) + 1;
    end
    initial_graph(data);
    max_degree = max(degree);
    error_rate = 0.01;
    A = 3;
    infinite_factor = 100;
    init_t = max_degree * A;
    min_t = (error_rate/(size * (log2(size) * 3 / 2)));
    beta = 1.0 / (max_degree * infinite_factor);
    fprintf('init %f max degree %d beta %f mint %f\n',init_t,max_degree,beta,min_t);
    same_energy_count = 0;
    last_total_energy = Inf;
    break_count = 100;
    current_t=init_t;
    spin = false(size,1);
    first_sum = edge; 
    second_sum = 0;
    total_energy = 0;
    while(current_t>min_t)     
        for u = 1 : size
            first_difference = 0;
            if(spin(u,1))% // 1 to 0
                for v = 1 : size
                    if (data(u,v) && (~spin(v,1)))
                        first_difference = first_difference + 1;
                    end                            
                end  
                second_difference = -1 ;  
            else% 0 to 1
                for v = 1 : size
                    if (data(u,v) && (~spin(v,1)))
                        first_difference = first_difference - 1;
                    end                             
                end   
                second_difference = 1 ; 
            end 
            energy_difference = A * first_difference + second_difference;
            if (energy_difference < 0)
                spin(u,1) = (~spin(u,1));
                first_sum = first_sum + first_difference; 
                second_sum = second_sum + second_difference;
                total_energy = first_sum + second_sum;
            else
                prob = exp(-energy_difference/current_t);
                if (prob>rand)
                    spin(u,1) = (~spin(u,1));
                    first_sum = first_sum + first_difference; 
                    second_sum = second_sum + second_difference;
                    total_energy = first_sum + second_sum;
                end                         
            end       
        end   
        fprintf('first sum %d second sum %d current t %f total energy %d\n',first_sum,second_sum,current_t,total_energy);
        current_t = current_t / (1 + beta * current_t);       
        if (last_total_energy == total_energy)
            if (same_energy_count == break_count)
                break;
            end             
            same_energy_count = same_energy_count + 1;
        else
            same_energy_count = 0;
            last_total_energy = total_energy;
        end  
    end
    ising_configuration_1D(spin);
    vertex_cover_final_graph(size,spin)
end
function vertex_cover_final_graph(size,spin)
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
    legend([p1,p2],{'Vertices in S','Vertices not in S'},'Location','northeastoutside');
    axis 'equal';
    title('Final Graph');
end