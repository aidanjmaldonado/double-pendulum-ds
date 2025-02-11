# Double Pendulum Dynamical System

## Three integration methods:
1. Euler Method
2. Trapezoid Method
3. Runge-Kutta Method

## Running the Simulation

In matlab, run `double_pendulum.m`. This file will generate a plot comparing the simulated trajectories of a double pendulum with fixed initial conditions across 6 different instances.
There will be 2 simulations run for each of the 3 integration methods, each with a slightly different L2 length and step value.

## Project Files:

`M1AA.m`  - Calculates angular momentum $\ddot{\theta_{1}}$ of $\theta_{1}$ given the current values of $\theta_{1}$, $\dot{\theta_{1}}$, $\theta_{2}$, $\dot{\theta_{2}}$ at the $n$-th state.
`M2AA.m`  - Calculates angular momentum $\ddot{\theta_{2}}$ of $\theta_{2}$ given the current values of $\theta_{1}$, $\dot{\theta_{1}}$, $\theta_{2}$, $\dot{\theta_{2}}$ at the $n$-th state.
`runge_kutta_method.m` - To-do
`trapezoid_method.m` - To-do
`euler_method.m` - Calculates the $(n+1)$-th state values of $\theta_{1}$, $\dot{\theta_{1}}$, $\theta_{2}$, $\dot{\theta_{2}}$ given them at the $n-th$ state. Calls `M1AA.m` and `M2AA.m`
`simulation.m` - Instantiates a simulation object forms an initial pendulum state with the provided initial condition and other given values. Calculates iterative state values for a set duration. Calls either `euler_method.m`, `trapezoid_method.m`, or `runge_kutta_method.m`, depending on what integration function is passed in as an object parameter during initialization.
`state.m` - Represents the values of $\theta_{1}$, $\dot{\theta_{1}}$, $\theta_{2}$, $\dot{\theta_{2}}$ at any given state.
`double_pendulum.m` - Main script. Calls `simulation.m` on various constructed pendulum initial states, and plots results.