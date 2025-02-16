# Double Pendulum Dynamical System

## Three integration methods:
1. Euler Method
2. Trapezoid Method
3. Runge-Kutta Method

## Running the Simulation

In MATLAB, run `double_pendulum.m`. This file will generate several figures comparing the simulated trajectories of a double pendulum with fixed initial conditions across 6 different instances. There will be 2 simulations run for each of the 3 integration methods, each with a different initial `L2` length and `t_step` precision:

1. *Figure 1* **Simulation** - The left column shows animations of the simulated trajectories. The right column plots $$\theta_1$$ and $$\theta_2$$ over time. The top row corresponds to initial conditions 1, and the bottom corresponds to initial conditions 2.
2. *Figure 2* **Performance** - Each cell plots the absolute difference of $$\theta_1$$ and $$\theta_2$$ between the above three integration methods and MATLAB's ode45 differential equation solver.

_Notes_: 
- _For less chaotic results, use a smaller `t_step` value (Adjusted at the top of `double_pendulum.m`)._
- _Some initial conditions cause the pendulum to spin sporadically, resulting in values of_ $$\theta_1$$ _and_ $$\theta_2$$ _that become hard to visualize. To counterract this, the right column of `Figure 1` — the_ $$\theta$$_/Time plots — has been normalized to [-π, π]._

## Project Files:

1. *Function* `M1AA.m` - Calculates angular momentum $$\ddot{\theta_{1}}$$ of $$\theta_{1}$$ given the current values of $$\theta_{1}$$, $$\dot{\theta_{1}}$$, $$\theta_{2}$$, $\dot{\theta_{2}}$ at the $n$-th state.

2. *Function* `M2AA.m` - Calculates angular momentum $$\ddot{\theta_{2}}$$ of $$\theta_{2}$$ given the current values of $$\theta_{1}$$, $$\dot{\theta_{1}}$$, $$\theta_{2}$$, $$\dot{\theta_{2}}$$ at the $$n$$-th state.

3. *Function* `runge_kutta_method.m` - Calculates the $$(n+1)$$-th state values of $$\theta_{1}$$, $$\dot{\theta_{1}}$$, $$\theta_{2}$$, $$\dot{\theta_{2}}$$ given them at the $$n$$-th state. Takes the weighted average of intermediate slopes $$k_{1}$$ - $$k_{4}$$. Calls `M1AA.m` and `M2AA.m`.

4. *Function* `trapezoid_method.m` - Calculates the $$(n+1)$$-th state values of $$\theta_{1}$$, $$\dot{\theta_{1}}$$, $$\theta_{2}$$, $$\dot{\theta_{2}}$$ given them at the $$n$$-th state. Takes the average of slopes at the start and end of each time interval. Calls `M1AA.m` and `M2AA.m`.

5. *Function* `euler_method.m` - Calculates the $$(n+1)$$-th state values of $$\theta_{1}$$, $$\dot{\theta_{1}}$$, $$\theta_{2}$$, $$\dot{\theta_{2}}$$ given them at the $$n$$-th state. Calls `M1AA.m` and `M2AA.m`

6. *Function* `ode45_method.m` - Calculates the $$(n+1)$$-th state values of $$\theta_{1}$$, $$\dot{\theta_{1}}$$, $$\theta_{2}$$, $$\dot{\theta_{2}}$$ given them at the $$n$$-th state using MATLAB's ode45 differential equation solver. Calls `M1AA.m` and `M2AA.m`

7. *Class* `simulation.m` - Instantiates a simulation object from an initial pendulum state with the provided initial condition and other system values. Calculates iterative state values for a set duration. Calls either `euler_method.m`, `trapezoid_method.m`, or `runge_kutta_method.m`, depending on what integration function is passed in as an object parameter during initialization. Plots $$\theta_1$$ and $$\theta_2$$ over time, the performance of each integration method, and an animation of the simulation.

8. *Class* `state.m` - Represents the values of $$\theta_{1}$$, $$\dot{\theta_{1}}$$, $$\theta_{2}$$, $$\dot{\theta_{2}}$$ at any given state.

9. *Main Script* `double_pendulum.m` - Calls `simulation.m` to construct various double pendulum simulations with set initial states and plots the corresponding generated animations.