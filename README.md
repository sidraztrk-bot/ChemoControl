# ChemoControl

MATLAB simulation of tumor growth control using a PI controller combined with pharmacokinetic modeling.

## Project Overview
This project models tumor dynamics under chemotherapy treatment using:

- Gompertz-based tumor growth dynamics
- PI (Proportional–Integral) control
- Pharmacokinetic drug concentration model
- Numerical simulation using MATLAB ODE45

The controller adjusts the chemotherapy drug dose to regulate tumor size toward a desired reference value (setpoint).

---

## Mathematical Model

### Tumor Dynamics
The tumor growth is modeled using a Gompertz-type equation:

dN/dt = r * N * log(K/N) - C * N

where:
- N = tumor cell population
- r = tumor growth rate
- K = carrying capacity
- C = drug concentration

---

### PI Controller
The control input is defined as:

u(t) = kp * e(t) + ki * integral(e(t))

where:
- e(t) = N - N*
- N* = desired tumor size
- kp = proportional gain
- ki = integral gain

The drug dose is limited between 0 and umax.

---

### Pharmacokinetics
Drug concentration dynamics are modeled as:

dC/dt = -ke * C + u(t)

where:
- ke = drug elimination rate
- u(t) = chemotherapy dose

---

## Simulation Outputs

The simulation generates:
1. Tumor size dynamics
2. Drug concentration in the body
3. Integral error term
4. Drug dosage control input

---

## Tools Used
- MATLAB
- ODE45 Solver

---

## Results

The controller successfully reduces tumor size and stabilizes it near the desired setpoint while maintaining bounded drug dosage.

---

## Author
Sedra Ozturk