library(ggplot2)

# Define parameters
beta_S <- 0.27      # Transmission rate between susceptible and infected
beta_F <- 0.79      # Transmission rate between susceptible and funerals
gamma <- 0.1782     # Recovery rate
sigma <- 0.5        # Funeral clearance rate
mu <- 0.0111 / 365  # Birth and natural death rate (per day)
c                   # Exponential decay factor for funeral transmission (extended model)
# Initial conditions
N <- 1                 # Total population
initial_state <- list(
  S = 1 - 1 / 11472914, # Initial susceptible population
  I = 1 / 11472914,     # Initial infected individuals
  F = 0,                # Initial funeral population
  R = 0                 # Initial recovered individuals
)

# Time frame for simulation
time_steps <- 150      # Simulate for 150 days

# Function to run the base model
run_base_model <- function() {
  # Initialize vectors to store results
  S <- numeric(time_steps + 1)
  I <- numeric(time_steps + 1)
  F <- numeric(time_steps + 1)
  R <- numeric(time_steps + 1)
  
  # Set initial values
  S[1] <- initial_state$S
  I[1] <- initial_state$I
  F[1] <- initial_state$F
  R[1] <- initial_state$R
  
  # Simulation loop for base model
  for (t in 1:time_steps) {
    S[t + 1] <- S[t] + mu - mu * S[t] - beta_S * S[t] * I[t] - beta_F * S[t] * F[t]
    I[t + 1] <- I[t] - mu * I[t] + beta_S * S[t] * I[t] + beta_F * S[t] * F[t] - gamma * I[t]
    F[t + 1] <- F[t] + gamma * I[t] - sigma * F[t]
    R[t + 1] <- R[t] + sigma * F[t]
  }
  
  data.frame(time = 0:time_steps, Susceptible = S, Infected = I, Funeral = F, Recovered = R)
}

# Function to run the extended model
run_extended_model <- function(c) {
  # Initialize vectors to store results
  S <- numeric(time_steps + 1)
  I <- numeric(time_steps + 1)
  F <- numeric(time_steps + 1)
  R <- numeric(time_steps + 1)
  
  # Set initial values
  S[1] <- initial_state$S
  I[1] <- initial_state$I
  F[1] <- initial_state$F
  R[1] <- initial_state$R
  
  # Simulation loop for extended model
  for (t in 1:time_steps) {
    S[t + 1] <- S[t] + mu - mu * S[t] - beta_S * S[t] * I[t] - beta_F * S[t] * F[t] * exp(-c * F[t])
    I[t + 1] <- I[t] - mu * I[t] + beta_S * S[t] * I[t] + beta_F * S[t] * F[t] * exp(-c * F[t]) - gamma * I[t]
    F[t + 1] <- F[t] + gamma * I[t] - sigma * F[t]
    R[t + 1] <- R[t] + sigma * F[t]
  }
  
  data.frame(time = 0:time_steps, Susceptible = S, Infected = I, Funeral = F, Recovered = R)
}

# Run the base model
base_model_results <- run_base_model()

# Run the extended model for c = 10, 100, 500
extended_model_results_c10 <- run_extended_model(c = 10)
extended_model_results_c100 <- run_extended_model(c = 100)
extended_model_results_c500 <- run_extended_model(c = 500)

# Define custom colors
colours <- c(
  "Susceptible" = "blue",
  "Infected" = "red",
  "Funeral" = "green",
  "Recovered" = "purple"
)

# Function to plot comparison
plot_comparison <- function(base_results, extended_results, c_value) {
  base_results$model <- "Base Model"
  extended_results$model <- paste("Extended Model (c =", c_value, ")")
  combined_results <- rbind(base_results, extended_results)
  
  ggplot(combined_results, aes(x = time)) +
    geom_line(aes(y = Susceptible, colour = "Susceptible", linetype = model), lwd = 1) +
    geom_line(aes(y = Infected, colour = "Infected", linetype = model), lwd = 1) +
    geom_line(aes(y = Funeral, colour = "Funeral", linetype = model), lwd = 1) +
    geom_line(aes(y = Recovered, colour = "Recovered", linetype = model), lwd = 1) +
    labs(
      x = "Time (days)",
      y = "Proportion of population",
      title = paste("SIFR Model Comparison: Base vs Extended for c =", c_value),
      colour = "Compartment",
      linetype = "Model"
    ) +
    scale_colour_manual(values = colours) 
}

# Generate plots for c = 10, 100, 500
plot_c10 <- plot_comparison(base_model_results, extended_model_results_c10, 10)
plot_c100 <- plot_comparison(base_model_results, extended_model_results_c100, 100)
plot_c500 <- plot_comparison(base_model_results, extended_model_results_c500, 500)


print(plot_c10)
print(plot_c100)
print(plot_c500)