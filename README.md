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

## Operating Principles
   1. An Ising Model contains Ising spins x<sub>i</sub> and the Hamiltonian  *H* (a.k.a Ising Energy). The Hamiltonian is a formulation of Ising spins, depending on what problem we are solving. For example, the Hamiltonian for Graph Coloring Problem is . 

## Introduciton to the seven NP-hard problems

### Graph Coloring Problem

#### Problem Statement
   The graph coloring problem can be decision problem or optimization problem. The decision problem asks: Given a graph *G = (V, E)* and *n* color, is there a way to color the vertices of a graph such that no two adjacent vertices are of the same color? The optimization problem is to obtain the smallest valid *n*. While the Ising formulation is for the decision problem, the final output of this program solves the optimization problem. To elaborate, the we use the binary search to find the smallest *n*. We first initialize the lower bound of *n* as 1, and the answer of the problem *ans* as *n*, and the upperbound of *n* as the number of the vertices |*V*|. The input of the Ising Model is the mean *m* of the lowerbound and the upperbound. The Ising Model will tell us if it finds the valid coloring. If it does, the upperbound for the next iteration is *m-1*, and we update *ans* to be *m*. Otherwise, the lowerbound for the next iteration is *m+1*. We iterate the process until the lowerbound is greater than the upperbound. Finally, *ans* is the smallest number of the color for this graph *G*. With binary search, the the time complexity of the optimization problem is only *O(log|V|)* times more than the decision problem.

#### Ising Formulation
   Suppose that the number of color is *n*, and the binary varible *x<sub>v, i</sub> = 1* if vertex v is color with i<sup>th</sup> color. The Ising formulation is
   $$A\sum_{v=1} (1-\sum_{i=1}^n x_{v, i})^2 + A\sum_{uv \in E} \sum_{i=1}^n x_{u, i}x_{v, i}$$

   The first term enforces the constraint that each vertex has exactly one color,and provides an energy penalty each time this is violated and the second term gives an energy penalty each time an edge connects two vertices of the same color. If there is a ground state of this model with *H = 0*, then there is a solution to the coloring problem on this graph with *n* colors.

### Hamiltonian Cycle Problem

#### Problem Statement
   The Hamiltonian cycle problem are problems of determining whether a Hamiltonian cycle (a cycle in an undirected or directed graph that visits each vertex exactly once except the starting point can be returned from the last node).

#### Ising Formulation
   Suppose that the number of node is *n*, and the binary varible *x<sub>u, j</sub> = 1* if vertex u is the j<sup>th</sup> node in the route. The Ising formulation is
   $$A\sum_{v=1}^n (1-\sum_{j=1}^n x_{v, j})^2 + A\sum_{j=1}^n (1-\sum_{v=1}^n x_{v, j})^2 + A\sum_{uv \notin E} \sum_{j=1}^n x_{u, j}x_{v, j+1}$$

   The first term is for the constraint that every vertex must appear exactly once in a cycle. The second term constrains that there must be a j<sup>th</sup> node in the cycle for each j. Finally, there should be an energy penalty if *x<sub>u, j</sub>1* and *x<sub>v, j+1</sub>* are both 1, and *uv* $\notin$ *E*.

### Asymetric Traveling Salesman Problem

#### Problem Statement
   Given a graph *G = (V, E)*, where each edge *uv* in the graph has a weight *W<sub>uv</sub>* associated to it, what is the route with the least sum of the weights that visits each city exactly once and returns to the origin city (i.e. a Hamiltonian cycle)?

#### Ising Formulation
   Suppose that the number of node is *n*, and the binary varible *x<sub>u, j</sub> = 1* if vertex u is the j<sup>th</sup> node in the route. The Ising formulation is
   $$A\sum_{v=1}^n (1-\sum_{j=1}^n x_{v, j})^2 + A\sum_{j=1}^n (1-\sum_{v=1}^n x_{v, j})^2 + A\sum_{uv \notin E} \sum_{j=1}^n x_{u, j}x_{v, j+1} + B\sum_{uv\in E} W_{uv} \sum_{j=1}^n x_{u, j}x_{v, j+1}$$

   The first term is for the constraint that every vertex must appear exactly once in a cycle. The second term constrains that there must be a j<sup>th</sup> node in the cycle for each j. The third term requires that there should be an energy penalty if *x<sub>u, j</sub>1* and *x<sub>v, j+1</sub>* are both 1, and *uv* $\notin$ *E*. Finally, the last term minimizes the sum of the weights of the route.