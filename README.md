# 🧪 SIFR Model Simulation for Ebola Transmission

This project models the spread of the Ebola virus using an extended SIFR (Susceptible–Infected–Funeral–Recovered) compartmental model. It incorporates both a **base model** and an **extended model** with a dynamic funeral transmission factor. The models are implemented in **R**, and results are visualized using `ggplot2`.

## 📁 Project Structure

- `base_model.pdf` – Simulation and explanation of the base SIFR model
- `BASE_VS_EXTEND.pdf` – Comparative analysis of the base and extended models
- `BASE_VS_EXTEND.R` – Main R code containing both models and plots
- `Group_17_Topic_4_Final_Report.pdf` – Full project report with background, methodology, and discussion

## 📚 Background

In the 2014 West African Ebola outbreak, traditional funeral practices played a significant role in viral transmission. To account for this, we build upon the classical SIR model to form a **SIFR model**, adding a "Funeral" compartment. Our extended model introduces a policy-driven decay parameter `c` to simulate the effect of government restrictions on funeral-related transmission.

## 📐 Mathematical Models

### ➤ Base Model Equations

\[
\begin{aligned}
S_{t+1} &= S_t + \mu - \mu S_t - \beta_S S_t I_t - \beta_F S_t F_t \\
I_{t+1} &= I_t - \mu I_t + \beta_S S_t I_t + \beta_F S_t F_t - \gamma I_t \\
F_{t+1} &= F_t + \gamma I_t - \sigma F_t \\
R_{t+1} &= R_t + \sigma F_t
\end{aligned}
\]

### ➤ Extended Model (Funeral Policy Feedback)

\[
\beta_F \to \frac{\beta_F}{1 + c \cdot F_t}
\]

This modification reduces funeral transmission dynamically as funeral population increases.

## 📊 How to Run the Simulation

### Requirements

- R ≥ 4.2.0
- Packages: `ggplot2`

### Instructions

1. Clone this repository or download the `.R` file.
2. Open `BASE_VS_EXTEND.R` in RStudio.
3. Run the script to generate and compare simulation plots for:
   - Base model
   - Extended model with `c = 10`, `c = 100`, and `c = 500`

### Sample Output

Plots will show population changes across compartments (Susceptible, Infected, Funeral, Recovered) over 150 days, highlighting the impact of increasing government intervention.

## 🔍 Key Findings

- **Higher c values** (stricter funeral restrictions) **reduce infection peaks** but may **prolong epidemic duration**.
- The **disease-free equilibrium is unstable**, emphasizing the need for early and effective intervention.
- The model captures critical real-world dynamics and provides a flexible framework for policy evaluation.

## 🔗 Project Report

📄 Full report with equilibrium and stability analysis is available [here](Group_17_Topic_4_Final_Report.pdf)  
📘 R code: [BASE_VS_EXTEND.R](BASE_VS_EXTEND.R)  
📈 Model comparison: [BASE_VS_EXTEND.pdf](BASE_VS_EXTEND.pdf)  
📊 Base model: [base_model.pdf](base_model.pdf)

## 👥 Contributors

- **Yijie Zhu** – Base model implementation & R simulations
- **Ivy Xie** – Stability analysis & discussion
- **Xun Cheng** – Reality interpretation of base/extended models
- **Yuchen Jin** – Stability analysis of extended model
- **Yincheng Zhu** – Equilibrium analysis

## 📄 License

This project is for academic purposes. No license assigned.
