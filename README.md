# Double Pendulum Dynamical System

## Three integration methods:
1. Euler Method
2. Trapezoid Method
3. Runge-Kutta Method

## Running the Simulation

In matlab, run `double_pendulum.m`. This file will generate a plot comparing the simulated trajectories of a double pendulum with fixed initial conditions across 6 different instances.
There will be 2 simulations run for each of the 3 integration methods, each with a slightly different L2 length and step value.

## Project Files:

`M1AA.m` - Calculates angular momentum (`theta1_doot`) of theta 1 given the current values of `theta1`, `theta2`, `theta1_dot`, and `theta2_dot` at the n-th state.