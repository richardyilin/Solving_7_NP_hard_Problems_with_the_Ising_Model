clc;
close all;
clear;
selection = get_selected_problem;
close all;
if(selection >= 1 && selection <=7)
    file_name = get_input_file;
end
close all;
switch selection
    case 1
        asymetric_traveling_salesman(file_name);
    case 2
        graph_coloring(file_name);
    case 3
        graph_partitioning(file_name);
    case 4
        hamiltonian_cycle(file_name);
    case 5
        max_cut(file_name);
    case 6
        set_packing(file_name);
    case 7
        vertex_cover(file_name);
end
