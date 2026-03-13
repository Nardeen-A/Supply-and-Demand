# packages
library(data.table)
library(dplyr)
library(ggnewscale)
library(ggplot2)
library(gridExtra)
library(patchwork)
library(pals)
library(RColorBrewer)
library(svglite)
library(readxl)
library(reshape)
library(tidyr)
library(tidyverse)
library(viridis)
library(viridisLite)
library(rvest)
library(rmarkdown)
library(flexdashboard)
library(haven)
library(magrittr)
library(reshape2)
library(stargazer)
library(labelled)
library(Hmisc)
library(stargazer)
library(sandwich)
library(lmtest)
library(arrow)
library(lubridate)
library(sf)
library(tigris)
library(stringr)
library(scales)
library(AER)

theme_set(theme_bw())
theme_update(text = element_text(size=12.5))

# creating data ####
set.seed(123)
n <- 4
m <- 1000

alpha_0 <- 100
alpha_1 <- -2
alpha_2 <- 1.5
gamma_0 <- 5
gamma_1 <- 2
gamma_2 <- 1

Y  <- rnorm(m, mean = 50, sd = 1)
W  <- rnorm(m, mean = 1,  sd = sqrt(0.25))
eta <- rnorm(m, mean = 0,  sd = 1)

omega <- matrix(rnorm(m*n, mean = 0, sd = 1), nrow = m, ncol = n)

# construct a matrix
A <- matrix(alpha_1, nrow = n, ncol = n)
diag(A) <- 2 * (alpha_1 - gamma_2)

# invert the martrix
A_inv <- solve(A) 


# B rows
b <- (-alpha_0 - alpha_2 * Y - eta + gamma_0 + gamma_1 * W) 
B <- omega + b                                     

# Solve quantities for all markets: q (M x N)
q <- t(A_inv %*% t(B))
Q <- rowSums(q)
P <- alpha_0 + alpha_1 * Q + alpha_2 * Y + eta

# data frame
data <- data.frame(
  market = 1:m,
  Y = Y, W = W, eta = eta,
  omega_1 = omega[,1], omega_2 = omega[,2], omega_3 = omega[,3], omega_4 = omega[,4],
  q_1 = q[,1], q_2 = q[,2], q_3 = q[,3], q_4 = q[,4],
  Q = Q,
  P = P
)

# shares
MC_1 <- gamma_0 + gamma_1 * data$W + data$omega_1 + 2 * gamma_2 * data$q_1
MC_2 <- gamma_0 + gamma_1 * data$W + data$omega_2 + 2 * gamma_2 * data$q_2
MC_3 <- gamma_0 + gamma_1 * data$W + data$omega_3 + 2 * gamma_2 * data$q_3
MC_4 <- gamma_0 + gamma_1 * data$W + data$omega_4 + 2 * gamma_2 * data$q_4

L_1 <- (data$P - MC_1) / data$P
L_2 <- (data$P - MC_2) / data$P
L_3 <- (data$P - MC_3) / data$P
L_4 <- (data$P - MC_4) / data$P
  
s_1 <- data$q_1 / data$Q
s_2 <- data$q_2 / data$Q
s_3 <- data$q_3 / data$Q
s_4 <- data$q_4 / data$Q

L_market <- s_1 * L_1 + s_2 * L_2 + s_3 * L_3 + s_4 * L_4

HHI <- s_1^2 + s_2^2 + s_3^2 + s_4^2

data$L_market <- L_market
data$HHI <- HHI

r_1 <- lm(L_market ~ HHI, data = data)

stargazer(
  r_1,
  type = "latex",
  title = "Regression Table",
  single.row = TRUE,
  font.size = "small",
  digits = 2,
  model.numbers = FALSE
)
  
demand_ols <- lm(P ~ Q + Y, data = data)
mc_ols <- lm(P ~ W + q_1, data = data)

demand_iv <- ivreg(P ~ Q + Y | Y + W, data = data)
mc_iv <- ivreg(P ~ W + q_1 | W + Y, data = data)

stargazer(
  demand_ols,
  mc_ols,
  demand_iv,
  mc_iv,
  type = "latex",
  title = "Regression Table",
  single.row = TRUE,
  font.size = "small",
  digits = 2,
  model.numbers = FALSE
)


# counter factual
gamma_0_cf <- gamma_0 / 2

# Recompute RHS of linear system
b_cf <- (-alpha_0 - alpha_2 * data$Y - data$eta + gamma_0_cf + gamma_1 * data$W)

B_cf <- omega + b_cf

# Solve new equilibrium quantities
q_cf <- t(A_inv %*% t(B_cf))

Q_cf <- rowSums(q_cf)
P_cf <- alpha_0 + alpha_1 * Q_cf + alpha_2 * data$Y + data$eta




# plots
df_PQ <- data.frame(
  scenario = rep(c("Baseline", "Counterfactual"), each = nrow(data)),
  P = c(data$P, P_cf),
  Q = c(data$Q, Q_cf)
)

df_q <- data.frame(
  scenario = rep(c("Baseline", "Counterfactual"), each = nrow(data) * 4),
  firm = rep(rep(1:4, each = nrow(data)), times = 2),
  q = c(data$q_1, data$q_2, data$q_3, data$q_4,
        q_cf[,1], q_cf[,2], q_cf[,3], q_cf[,4])
)

ggplot(df_PQ, aes(x = P, fill = scenario)) +
  geom_histogram(
    position = "identity",   # overlay bars
    alpha = 0.55,
    bins = 30,
    color = "white"
  ) +
  scale_fill_viridis_d(
    option = "inferno",   # bright colors
    begin = 0.1,
    end = 0.4
  ) +
  labs(title = "Price (P): Baseline vs Counterfactual",
       x = "P", y = "Density", fill = "")

ggplot(df_PQ, aes(x = Q, fill = scenario)) +
  geom_histogram(
    position = "identity",   # overlay bars
    alpha = 0.55,
    bins = 30,
    color = "white"
  ) +
  scale_fill_viridis_d(
    option = "inferno",   # bright colors
    begin = 0.1,
    end = 0.4
  ) +
  labs(title = "Total Quantity (Q): Baseline vs Counterfactual",
       x = "Q", y = "Density", fill = "") 


ggplot(df_q, aes(x = q, fill = scenario)) +
  geom_histogram(
    position = "identity",   # overlay bars
    alpha = 0.55,
    bins = 30,
    color = "white"
  ) +
  facet_wrap(~ firm, scales = "free_x") +
  scale_fill_viridis_d(
    option = "inferno",   # bright colors
    begin = 0.1,
    end = 0.4
  ) +
  labs(
    title = "Firm Quantities (q): Baseline vs Counterfactual",
    x = "Quantity (q)",
    y = "Count",
    fill = ""
  ) 

ggplot() +
  geom_point(aes(data$Q, data$P), alpha = 0.3, color = "gray50") +
  geom_point(aes(Q_cf, P_cf), alpha = 0.5, color = viridis(1, option = "viridis")) +
  labs(title = "Baseline vs Counterfactual Equilibria",
       x = "Total Quantity (Q)", y = "Price (P)")

