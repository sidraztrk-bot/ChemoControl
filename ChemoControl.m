clc; clear;

%% --- Parameters ---
r     = 0.2;
K     = 1e6;
kp    = 3e-6;
ki    = 8e-7;
umax  = 1;
ke    = 0.1;

N0    = 1e5;
Nstar = 0.1 * N0;

%% --- Model ---
model = @(t,y) [
    r*max(y(1),1)*log(K/max(y(1),1)) - y(3)*max(y(1),1);

    (y(1) - Nstar);

    -ke*y(3) + min(kp*(y(1)-Nstar) + ki*y(2), umax)
];

%% --- Solve ---
[t, y] = ode45(model, [0 200], [N0 0 0]);
N = y(:,1);
x = y(:,2);
C = y(:,3);

e     = N - Nstar;
u_raw = kp*e + ki*x;
u     = max(0, min(umax, u_raw));

%% --- Plots ---
figure

subplot(4,1,1)
plot(t, N, 'b', 'LineWidth', 2); hold on
yline(Nstar, 'r--', 'Setpoint', 'LineWidth', 1.5)
xlabel('Time (Days)');
ylabel('Tumor Size (Cells)')
title('Tumor Dynamics with PI Control + Pharmacokinetics')
grid on
legend('N(t)', 'Setpoint')

subplot(4,1,2)
plot(t, C, 'b', 'LineWidth', 2)
xlabel('Time (Days)');
ylabel('Drug Concentration C(t)')
title('Drug Concentration in the Body')
grid on

subplot(4,1,3)
plot(t, x, 'b', 'LineWidth', 2)
xlabel('Time (Days)');
ylabel('Integral Term x')
title('Integral of Error (e = N - N*)')
grid on

subplot(4,1,4)
plot(t, u, 'b', 'LineWidth', 2); hold on
yline(umax, 'r--', 'Max Dose', 'LineWidth', 1.5)
xlabel('Time (Days)');
ylabel('Drug Dose u(t)')
title('Control Input (Drug Dose)')
grid on