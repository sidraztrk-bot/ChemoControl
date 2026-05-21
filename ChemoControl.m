clc; clear;

%% --- Parameters ---
r     = 0.2;
K     = 1e6;
kp    = 3e-6;
ki    = 8e-7;
umax  = 1;
ke    = 0.1;

N0    = 1e5;
Nstar = 0.1 * N0;   % = 10,000 خلية

%% --- Model ---
model = @(t,y) [
    % dN/dt: max(N,1) لحماية log من الصفر بس بدون قطع
    r*max(y(1),1)*log(K/max(y(1),1)) - y(3)*max(y(1),1);

    % dx/dt: نكامل الخطأ دايماً
    (y(1) - Nstar);

    % dC/dt: pharmacokinetics
    -ke*y(3) + min(kp*(y(1)-Nstar) + ki*y(2), umax)
];

%% --- Solve ---
[t, y] = ode45(model, [0 200], [N0 0 0]);
N = y(:,1);
x = y(:,2);
C = y(:,3);

e     = N - Nstar;
u_raw = kp*e + ki*x;
u     = max(0, min(umax, u_raw));   % clamp بين 0 و umax

%% --- Plots ---
figure
subplot(4,1,1)
plot(t, N, 'b', 'LineWidth', 2); hold on
yline(Nstar, 'r--', 'Setpoint', 'LineWidth', 1.5)
xlabel('Zaman(Gün)'); ylabel('Tümör Boyutu (Hücre)')
title('PI Kontrolü ile Tümör Dinamiği + Farmakokinetik ')
grid on; legend('N(t)', 'Setpoint')

subplot(4,1,2)
plot(t, C, 'b', 'LineWidth', 2)
xlabel('Zaman(Gün)'); ylabel('İlaç Konsantrasyonu C(t)')
title('Vücüttaki İlaç Konsantrasyonu')
grid on

subplot(4,1,3)
plot(t, x, 'b', 'LineWidth', 2)
xlabel('Zaman(Gün)'); ylabel('Integral term x')
title('Integral of Error (e = N - N*)')
grid on

subplot(4,1,4)
plot(t, u, 'b', 'LineWidth', 2); hold on
yline(umax, 'r--', 'Max dose', 'LineWidth', 1.5)
xlabel('Zaman(Gün)'); ylabel('İlaç Dozu u(t)')
title('Kontrol Girdisi (İlaç Dozu)')
grid on