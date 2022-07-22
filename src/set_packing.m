function set_packing(file_name)
    fileID = fopen(file_name,'r');
    buffer2 = fscanf(fileID,'%d');
    fclose(fileID);
    m = buffer2(1,1);
    size = buffer2(2,1);
    coefficient = zeros(size,1);
    for i = 1 : size
        coefficient(i,1) = buffer2(i+2,1);
    end
    max_coefficient = max(abs(coefficient));
    intersection = zeros(size);
    buffer = zeros(size,1);
    count = size + 3;
    for i = 1 : m
        num = buffer2(count,1);
        count = count + 1;
        for j = 1 : num
            buffer(j,1) = buffer2(count,1);
            count = count + 1;
        end
        for j = 1 : num
            for k = 1 : num
                if(j ~= k)
                    intersection(buffer(j,1),buffer(k,1)) = intersection(buffer(j,1),buffer(k,1)) + 1;
                end
            end
        end
    end
    initial_graph(intersection);
    max_intersection = max(intersection,[],'all');
    error_rate = 0.01;
    infinite_factor = 100;
    init_t = max_coefficient * max_intersection;
    min_t = (error_rate/(size * log2(size) * 3 / 2));
    beta = 1.0 / (max_coefficient * max_intersection * infinite_factor);
    fprintf("init_t %f max factor %d beta %f mint %f",init_t,(max_coefficient * max_intersection),beta,min_t);
    same_energy_count = 0;
    last_total_energy = Inf;
    break_count = 100;
    current_t=init_t;
    A = max_coefficient;
    spin = false(size,1);
    first_sum = 0; 
    second_sum = 0;
    total_energy = 0;
    while(current_t>min_t)
        for u = 1 : size
            first_difference = 0;
            if(spin(u,1))% // 1 to 0
                for v = 1 : size
                    if (spin(v,1))
                        first_difference = first_difference - intersection(u,v);
                    end                            
                end  
                second_difference = coefficient(u,1) ;                                           
            else % 0 to 1
                for v = 1 : size
                    if (spin(v,1))
                        first_difference = first_difference + intersection(u,v);
                    end                            
                end  
                second_difference = -coefficient(u,1); 
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
        fprintf("first sum %d second sum %d total energy %d current t %f\n",first_sum,second_sum,total_energy,current_t);
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
    set_packing_final_graph(intersection,size,spin)
end
function set_packing_final_graph(intersection,size,spin)
    f3 = figure;
    R = 1;
    alf=linspace(pi/2,5/2*pi,size+1);
    x = R*cos(alf);
    y = R*sin(alf);
    for i = 1 : size
        if(spin(i,1) == 1) % plot the selected set
            p1 = plot(x(i),y(i),'ro');
            hold on;
        else
            p2 = plot(x(i),y(i),'bo');
            hold on;
        end
    end
    for i = 1 : size
        for j = 1 : (i-1)
            if(intersection(i,j)~=0 && spin(i,1) &&spin(j,1)) % if set i and set j are both selected, and they are not disjoint, the edge between them will be plotted.
                plot([x(i),x(j)],[y(i),y(j)]);
                hold on
            end
        end
    end
    legend([p1,p2],{'selected set','unselected set'},'Location','northeastoutside');
    axis 'equal';
    title('Final Graph');
end