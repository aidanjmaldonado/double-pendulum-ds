# Double Pendulum Dynamical System

## Three integration methods:
1. Euler Method
2. Trapezoid Method
3. Runge-Kutta Method

## Running the Simulation

In matlab, run `double_pendulum.m`. This file will generate an animation comparing the simulated trajectories of a double pendulum with fixed initial conditions across 6 different instances.
There will be 2 simulations run for each of the 3 integration methods, each with a slightly different L2 length and step value.

## Project Files:

1. `M1AA.m`  - Calculates angular momentum $\ddot{\theta_{1}}$ of $\theta_{1}$ given the current values of $\theta_{1}$, $\dot{\theta_{1}}$, $\theta_{2}$, $\dot{\theta_{2}}$ at the $n$-th state.
2. `M2AA.m`  - Calculates angular momentum $\ddot{\theta_{2}}$ of $\theta_{2}$ given the current values of $\theta_{1}$, $\dot{\theta_{1}}$, $\theta_{2}$, $\dot{\theta_{2}}$ at the $n$-th state.
3. `runge_kutta_method.m` - Calculates the $(n+1)$-th state values of $\theta_{1}$, $\dot{\theta_{1}}$, $\theta_{2}$, $\dot{\theta_{2}}$ given them at the $n-th$ state. Takes the weighted average of intermediate slopes $k_{1}$ - $k_{4}$. Calls `M1AA.m` and `M2AA.m`
4. `trapezoid_method.m` - Calculates the $(n+1)$-th state values of $\theta_{1}$, $\dot{\theta_{1}}$, $\theta_{2}$, $\dot{\theta_{2}}$ given them at the $n-th$ state. Takes the average of slopes at the start and end of each time interval. Calls `M1AA.m` and `M2AA.m`
5. `euler_method.m` - Calculates the $(n+1)$-th state values of $\theta_{1}$, $\dot{\theta_{1}}$, $\theta_{2}$, $\dot{\theta_{2}}$ given them at the $n-th$ state. Calls `M1AA.m` and `M2AA.m`
6. `simulation.m` - Instantiates a simulation object forms an initial pendulum state with the provided initial condition and other given values. Calculates iterative state values for a set duration. Calls either `euler_method.m`, `trapezoid_method.m`, or `runge_kutta_method.m`, depending on what integration function is passed in as an object parameter during initialization.
7. `state.m` - Represents the values of $\theta_{1}$, $\dot{\theta_{1}}$, $\theta_{2}$, $\dot{\theta_{2}}$ at any given state.
8. `double_pendulum.m` - Main script. Calls `simulation.m` on various constructed pendulum initial states, and plots results.