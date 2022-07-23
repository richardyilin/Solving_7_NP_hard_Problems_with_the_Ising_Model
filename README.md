# Solving_7_NP_hard_Problems_with_the_Ising_Model
## Overview
   This project solves seven NP-hard Problems with the Ising Model. The seven problems are Asymetric Traveling Salesman Problem, Graph Coloring, Graph Partitioning Problem, Hamiltonian Cycle Problem, Max Cut Problem, Set Packing Problem, and Vertex Cover Problem.

## Usage
   1. Please open the file [src/main.m](./src/main.m), click ``Run``. The GUI Interface will be shown as below.

   ![](./figures/select_problem.PNG)

   2. Please select the problem you want to solve. The GUI Interface will then ask you to enter the input file path.

   ![](./figures/path_blank.PNG)

   3. Enter the input file path. The file path is the relative file path starting from where [src/main.m](./src/main.m) is. For example, your input file path is ``../benchmarks/asymetric_traveling_salesman/ft53.txt`` if your input file is at ``./benchmarks/asymetric_traveling_salesman/ft53.txt`` (The relative file path of this README.md).

   ![](./figures//path_example.PNG)

   4. The GUI Interface will output the graph of your input file. When the program is done, it will output the graph of the Configuration of the Ising spins, and the graph of the final result. This document will show how they look like in each NP-hard problems in the following section.

## Algorithm for Ising Model
   We construct the Ising Model to perform the simulated annealing algorithm to solve the NP-hard problems. An Ising Model contains Ising spins s<sub>i</sub> and the Hamiltonian  *H* (a.k.a Ising Energy). The Hamiltonian is a formulation of Ising spins, depending on what problem we are solving. The following is the algorithm to reach the ground state of *H*.
   1. We are given the initial *H*, *s*, *T*, and *T<sub>min</sub>*.
   2. We try to flip a spin and measure the new Hamiltonian.
   3. We caculate the probability to filp the spin. The probability is $$P=min(1, e^{\frac{\beta (H_{new} - H)}{T}})$$
   4. We generate a random number *rand* = [0, 1]. If the *P > rand*, We flip the spin and update *H*.
   5. We go to step to and repeat the process to try to flip every spin.
   6. After trying on every spin, we lower the temperature *T* with the formula $$T=\frac{T}{1+cT}$$.
   7. We go to the step 2 and repeat the process until *T* < *T<sub>min</sub>*.
   We can observe that in step 3 and step 6, we need to lower the temperature to reduce the probability to flip an Ising spin so that the configuration of the Ising spins converge eventually.
   We use [Metropolis–Hastings algorithm](https://en.wikipedia.org/wiki/Metropolis%E2%80%93Hastings_algorithm) to determine if the spin should be flipped.
   We use [Lundy's cooling schedule](https://link.springer.com/article/10.1007/BF01582166) to lower the temperature.
   The pseudocode is shown below.

```
s = s_init
T = T_init
H = H_init
while T > T_min
   for i = 1 to |S| do
      try to flip the ith spin s[i], where H_new is the Hamiltonian of the trial
      P = min(1, e ^ (b * (H_new - H))) // Probability to flip s[i]
      Generate a random number rand = [0, 1]
      if P > rand then
         flip s[i] // flip the ith spin
         H = H_new
      end if
   end for
   T = T / (1 + c * T)
end while
Output the spin state s as the solution
```


## Introduciton to the seven NP-hard problems

### Asymetric Traveling Salesman Problem

#### Problem Statement
   Given a directed graph *G = (V, E)*, where each edge *uv* in the graph has a weight *W<sub>uv</sub>* associated to it, what is the route with the least sum of the weights that visits each city exactly once and returns to the origin city (i.e. a Hamiltonian cycle)?

#### Ising Formulation
   Suppose that the number of node is *n*, and the binary varible *s<sub>u, j</sub> = 1* if vertex u is the j<sup>th</sup> node in the route. The Ising formulation is
   $$A\sum_{v=1}^n (1-\sum_{j=1}^n s_{v, j})^2 + A\sum_{j=1}^n (1-\sum_{v=1}^n s_{v, j})^2 + A\sum_{uv \notin E} \sum_{j=1}^n s_{u, j}s_{v, j+1} + B\sum_{uv\in E} W_{uv} \sum_{j=1}^n s_{u, j}s_{v, j+1}$$

   The first term is for the constraint that every vertex must appear exactly once in a cycle. The second term constrains that there must be a j<sup>th</sup> node in the cycle for each j. The third term requires that there should be an energy penalty if *s<sub>u, j</sub>1* and *s<sub>v, j+1</sub>* are both 1, and *uv* $\notin$ *E*. Finally, the last term minimizes the sum of the weights of the route.

#### Simulation

##### Input Graph

   ![](./figures/asymetric_traveling_salesman_input_graph.PNG)

##### The configuration of the Ising spins of the output

   ![](./figures/asymetric_traveling_salesman_ising_spins.PNG)

##### The final graph

   ![](./figures/asymetric_traveling_salesman_final_graph.PNG)

### Graph Coloring Problem

#### Problem Statement
   The graph coloring problem can be decision problem or optimization problem. The decision problem asks: Given a graph *G = (V, E)* and *n* color, is there a way to color the vertices of a graph such that no two adjacent vertices are of the same color? The optimization problem is to obtain the smallest valid *n*. While the Ising formulation is for the decision problem, the final output of this program solves the optimization problem. To elaborate, the we use the binary search to find the smallest *n*. We first initialize the lower bound of *n* as 1, and the upperbound of *n* as the number of the vertices |*V*|, and the answer of the problem *ans* as the upperbound. The input of the Ising Model is the mean *m* of the lowerbound and the upperbound. The Ising Model will tell us if it finds the valid coloring. If it does, the upperbound for the next iteration is *m-1*, and we update *ans* to be *m*. Otherwise, the lowerbound for the next iteration is *m+1*. We iterate the process until the lowerbound is greater than the upperbound. Finally, *ans* is the smallest number of the color for this graph *G*. With binary search, the the time complexity of the optimization problem is only *O(log|V|)* times more than the decision problem.

#### Ising Formulation
   Suppose that the number of color is *n*, and the binary varible *s<sub>v, i</sub> = 1* if vertex v is color with i<sup>th</sup> color. The Ising formulation is
   $$A\sum_{v=1} (1-\sum_{i=1}^n s_{v, i})^2 + A\sum_{uv \in E} \sum_{i=1}^n s_{u, i}s_{v, i}$$

   The first term enforces the constraint that each vertex has exactly one color,and provides an energy penalty each time this is violated and the second term gives an energy penalty each time an edge connects two vertices of the same color. If there is a ground state of this model with *H = 0*, then there is a solution to the coloring problem on this graph with *n* colors.

#### Simulation

##### Input Graph

   ![](./figures/graph_coloring_input_graph.PNG)

##### The configuration of the Ising spins of the output

   ![](./figures/graph_coloring_ising_spins.PNG)

##### The final graph

   ![](./figures/graph_coloring_final_graph.PNG)

### Graph Partitioning Problem

#### Problem Statement
   Consider an undirected graph *G = (V, E)*. What is a partition of the set *V* into two subsets *S* of the size $\lfloor N/2 \rfloor$ and |*V-S*| of the size $\lfloor (N+1)/2 \rfloor$ such that the number of edges connecting the two subsets is minimized?

#### Ising Formulation
   Suppose that the number of the vertices in *G* is *n*, and the binary varible *s<sub>i</sub> = 1* if vertex *i* is placed in set 1 while *s<sub>i</sub> = -1* if vertex *i* is placed in set 2. The Ising formulation is $$A(\sum_{i=1}^n s_i)^2 + B\sum_{uv \in E} \frac{1-s_{u}s_{v}}{2}$$

   The first term enforces the constraint that the difference of the sizes of two subsets should equal N%2. The second term minimizes the edges connecting two subsets.

#### Simulation

##### Input Graph

   ![](./figures/graph_partitioning_input_graph.PNG)

##### The configuration of the Ising spins of the output

   ![](./figures/graph_partitioning_ising_spins.PNG)

##### The final graph

   ![](./figures/graph_partitioning_final_graph.PNG)
### Hamiltonian Cycle Problem

#### Problem Statement
   The Hamiltonian cycle problem are problems of determining whether a Hamiltonian cycle (a cycle in an undirected or directed graph that visits each vertex exactly once except the starting point can be returned from the last node).

#### Ising Formulation
   Suppose that the number of node is *n*, and the binary varible *s<sub>u, j</sub> = 1* if vertex u is the j<sup>th</sup> node in the route. The Ising formulation is
   $$A\sum_{v=1}^n (1-\sum_{j=1}^n s_{v, j})^2 + A\sum_{j=1}^n (1-\sum_{v=1}^n s_{v, j})^2 + A\sum_{uv \notin E} \sum_{j=1}^n s_{u, j}s_{v, j+1}$$

   The first term is for the constraint that every vertex must appear exactly once in a cycle. The second term constrains that there must be a j<sup>th</sup> node in the cycle for each j. Finally, there should be an energy penalty if *s<sub>u, j</sub>1* and *s<sub>v, j+1</sub>* are both 1, and *uv* $\notin$ *E*.

#### Simulation

##### Input Graph

   ![](./figures/hamiltonian_cycle_input_graph.PNG)

##### The configuration of the Ising spins of the output

   ![](./figures/hamiltonian_cycle_ising_spins.PNG)

##### The final graph

   ![](./figures/hamiltonian_cycle_final_graph.PNG)

### Max Cut Problem

#### Problem Statement
   Given a graph *G = (V, E)*, where each edge *uv* in the graph has a weight *W<sub>uv</sub>* associated to it, what is the subset *S* of the vertex set *V* such that total weight of the edges between *S* and *V-S* is maximized?

#### Ising Formulation

   Suppose that the binary varible *s<sub>i</sub> = 1* if vertex *i* is placed in the *S* while *s<sub>i</sub> = -1* if vertex *i* is placed in the *V-S*. The Ising formulation is $$\sum_{uv \in E}\frac{W_{uv}(s_{u, j}s_{v, j+1} - 1)}{2}$$

   The Ising formulation maximizes the sum of the weights of the edges connection different subsets.

#### Simulation

##### Input Graph

   ![](./figures/max_cut_input_graph.PNG)

##### The configuration of the Ising spins of the output

   ![](./figures/max_cut_ising_spins.PNG)

##### The final graph

   ![](./figures/max_cut_final_graph.PNG)

### Set Packing Problem

#### Problem Statement
   Given a universe *U* and a family *S* of subsets of *U*, a packing is a subfamily *C* $\subseteq$ *S* of sets such that all sets in *C* are pairwise disjoint. The problem is to find a set packing that uses the most sets (i.e. maximize the size of *C* |*C*|).

#### Ising Formulation

   Suppose that the binary varible *s<sub>i</sub> = 1* if the set *S<sub>i</sub>* is in *C* while *s<sub>i</sub> = 0* if the set *S<sub>i</sub>* is not in *C*. The Ising formulation is $$A\sum_{i:j V_i \bigcap V_j \neq \emptyset}s_is_j - B\sum_{i}^{|S|} s_i$$

   The first term enforces the constraint that all set in *C* are pairwise disjoint. The second term maximizes |*C*|.

#### Simulation

##### Input Graph

   ![](./figures/set_packing_input_graph.PNG)

##### The configuration of the Ising spins of the output

   ![](./figures/set_packing_ising_spins.PNG)

##### The final graph

   ![](./figures/set_packing_final_graph.PNG)

### Vertex Cover Problem

#### Problem Statement
   Given an undirected graph *G = (V, E)*, what is the smallest subset *S* of the vertex set *V* such that every edge is incident to *S*?

#### Ising Formulation

   Suppose that the binary varible *s<sub>i</sub> = 1* if vertex *i* is in the *S* while *s<sub>i</sub> = 0* if vertex *i* is not in the *S*. The Ising formulation is $$A\sum_{uv \in E}(1-x_u)(1-x_v) + B\sum_{i=1}^{|V|}x_i$$

   The first term constrains that every edge is incident to at least one vertex in *S*. The second term minimizes the size of *S*.

#### Simulation

##### Input Graph

   ![](./figures/vertex_cover_input_graph.PNG)

##### The configuration of the Ising spins of the output

   ![](./figures/vertex_cover_ising_spins.PNG)

##### The final graph

   ![](./figures/vertex_cover_final_graph.PNG)






