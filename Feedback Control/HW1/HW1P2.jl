const g = 9.8;
const mass = 1.0; #the system is independant of mass
const len = 1.0;

function f_lean(t, z)
    (θ, dθ) = z
    [dθ;(-g / len) * θ]
end

function f_nonlean(t, z)
    (θ, dθ) = z
    [dθ;(-g / len) * sin(θ)]
end

const initia = [30 * (pi / 180.0);0.0];
tspan = [0.0 ;100.0];

using ODE:ode45;
t_lean, sol_lean = ode45(f_lean, initia, tspan);
θ_lean = map(x->x[1], sol_lean);
ω_lean = map(x->x[2], sol_lean);
t_nonlean, sol_nonlean = ode45(f_nonlean, initia, tspan);
θ_nonlean = map(x->x[1], sol_nonlean);
ω_nonlean = map(x->x[2], sol_nonlean);

using Plots:plot, plot!;

plot(t_lean, θ_lean, linewidth = 1.5, xaxis = ("Time (t)", (0, 10)), title = "Pendulium system", yaxis = "θ in °C", label = "Linear")

plot!(t_nonlean, θ_nonlean, linewidth = 1.5, ls = :dashdot, xaxis = ((0, 10)), label = "Non linear")
