# packages ####
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

# code ####
rm(list = ls())
set.seed(2404)

R <- 500 #draws
M <- 1000 

alpha0 <- 100
alpha1 <- -2
alpha2 <- 1.5

gamma0 <- 5
gamma1 <- 2
gamma2 <- 1

FC <- 1200

xi_common     <- rnorm(R, mean = 0, sd = 1)
omega1_common <- rnorm(R, mean = 0, sd = 1)
omega2_common <- rnorm(R, mean = 0, sd = 1)

Delta <- 4 * (gamma2 - alpha1)^2 - alpha1^2

Y    <- rnorm(M, mean = 50, sd = 1)
W    <- rnorm(M, mean = 1,  sd = 0.5) 
eps1 <- runif(M, min = -300, max = 300)
eps2 <- runif(M, min = -300, max = 300)

F1 <- FC + eps1
F2 <- FC + eps2


# Profits functions
piM <- function(A, c) {
  (A - c)^2 / (4 * (gamma2 - alpha1))
}

piD1_fun <- function(A, c1, c2) {
  (gamma2 - alpha1) *
    ((2 * (gamma2 - alpha1) * (A - c1) + alpha1 * (A - c2)) / Delta)^2
}

piD2_fun <- function(A, c1, c2) {
  (gamma2 - alpha1) *
    ((2 * (gamma2 - alpha1) * (A - c2) + alpha1 * (A - c1)) / Delta)^2
}

qM <- function(A, c) {
  (A - c) / (2 * (gamma2 - alpha1))
}

qD1_fun <- function(A, c1, c2) {
  (2 * (gamma2 - alpha1) * (A - c1) + alpha1 * (A - c2)) / Delta
}

qD2_fun <- function(A, c1, c2) {
  (2 * (gamma2 - alpha1) * (A - c2) + alpha1 * (A - c1)) / Delta
}


# Equilibrium functions
get_eq <- function(piM1, piM2, piD1, piD2, F1, F2) {
  eq <- list()
  
  if (piM1 - F1 <= 0 && piM2 - F2 <= 0) {
    eq[[length(eq) + 1]] <- c(0, 0)
  }
  if (piM1 - F1 >= 0 && piD2 - F2 <= 0) {
    eq[[length(eq) + 1]] <- c(1, 0)
  }
  if (piD1 - F1 <= 0 && piM2 - F2 >= 0) {
    eq[[length(eq) + 1]] <- c(0, 1)
  }
  if (piD1 - F1 >= 0 && piD2 - F2 >= 0) {
    eq[[length(eq) + 1]] <- c(1, 1)
  }
  
  eq
}

# array
piM1_bar <- numeric(M)
piM2_bar <- numeric(M)
piD1_bar <- numeric(M)
piD2_bar <- numeric(M)

# solve 
for (m in 1:M) {
  A_mc  <- alpha0 + alpha2 * Y[m] + xi_common
  c1_mc <- gamma0 + gamma1 * W[m] + omega1_common
  c2_mc <- gamma0 + gamma1 * W[m] + omega2_common
  
  piM1_bar[m] <- mean(piM(A_mc, c1_mc))
  piM2_bar[m] <- mean(piM(A_mc, c2_mc))
  piD1_bar[m] <- mean(piD1_fun(A_mc, c1_mc, c2_mc))
  piD2_bar[m] <- mean(piD2_fun(A_mc, c1_mc, c2_mc))
}

a1 <- integer(M)
a2 <- integer(M)
n_eq <- integer(M)

xi_real <- rnorm(M, 0, 1)
om1_real <- rnorm(M, 0, 1)
om2_real <- rnorm(M, 0, 1)

q1 <- numeric(M)
q2 <- numeric(M)
Q  <- numeric(M)
P  <- numeric(M)

for (m in 1:M) {
  
  eq_set <- get_eq(piM1_bar[m], piM2_bar[m], piD1_bar[m], piD2_bar[m], F1[m], F2[m])
  n_eq[m] <- length(eq_set)
  
  chosen <- eq_set[[sample.int(length(eq_set), 1)]]
  a1[m] <- chosen[1]
  a2[m] <- chosen[2]
  
  A_real  <- alpha0 + alpha2 * Y[m] + xi_real[m]
  c1_real <- gamma0 + gamma1 * W[m] + om1_real[m]
  c2_real <- gamma0 + gamma1 * W[m] + om2_real[m]
  
  if (a1[m] == 0 && a2[m] == 0) {
    q1[m] <- 0
    q2[m] <- 0
  } else if (a1[m] == 1 && a2[m] == 0) {
    q1[m] <- qM(A_real, c1_real)
    q2[m] <- 0
  } else if (a1[m] == 0 && a2[m] == 1) {
    q1[m] <- 0
    q2[m] <- qM(A_real, c2_real)
  } else {
    q1[m] <- qD1_fun(A_real, c1_real, c2_real)
    q2[m] <- qD2_fun(A_real, c1_real, c2_real)
  }
  
  Q[m] <- q1[m] + q2[m]
  P[m] <- A_real + alpha1 * Q[m]
}

# data
data <- data.frame(
  market = 1:M,
  Y, W, eps1, eps2, F1, F2,
  piM1_bar, piM2_bar, piD1_bar, piD2_bar,
  n_eq, a1, a2,
  xi_real, om1_real, om2_real,
  q1, q2, Q, P
)

data$n_enter <- data$a1 + data$a2
data$multiple_eq <- data$n_eq > 1






data_1 <- data %>%
  mutate(
    n_enter = a1 + a2,
    multiple_eq = as.integer(n_eq > 1)
  )

frac_0 <- mean(data_1$n_enter == 0)
frac_1 <- mean(data_1$n_enter == 1)
frac_2 <- mean(data_1$n_enter == 2)
frac_mult <- mean(data_1$multiple_eq == 1)


market_summary <- data_1 %>%
  filter(n_enter %in% c(1, 2)) %>%
  group_by(n_enter) %>%
  summarise(
    avg_price = mean(P, na.rm = TRUE),
    avg_total_quantity = mean(Q, na.rm = TRUE),
    n_markets = n(),
    .groups = "drop"
  )


q5_table <- data.frame(
  Statistic = c(
    "Fraction with 0 entrants",
    "Fraction with 1 entrant",
    "Fraction with 2 entrants",
    "Fraction with multiple equilibria",
    "Average price | 1 active firm",
    "Average total quantity | 1 active firm",
    "Average price | 2 active firms",
    "Average total quantity | 2 active firms"
  ),
  Value = c(
    frac_0,
    frac_1,
    frac_2,
    frac_mult,
    market_summary$avg_price[market_summary$n_enter == 1],
    market_summary$avg_total_quantity[market_summary$n_enter == 1],
    market_summary$avg_price[market_summary$n_enter == 2],
    market_summary$avg_total_quantity[market_summary$n_enter == 2]
  )
)

stargazer(
  q5_table,
  summary = FALSE,
  rownames = FALSE,
  digits = 3,
  title = "Q5 Descriptive Results",
  label = "tab:q5_descriptives",
  type = "latex",
  out = "q5_descriptives.tex"
)





# Logit
firm_data <- bind_rows(
  data %>%
    transmute(
      market = market,
      firm = 1,
      entry = a1,
      rival_entry = a2,
      Y = Y,
      W = W
    ),
  data %>%
    transmute(
      market = market,
      firm = 2,
      entry = a2,
      rival_entry = a1,
      Y = Y,
      W = W
    )
)

logit_1 <- glm(entry ~ Y + W,
               data = firm_data,
               family = binomial(link = "logit"))

logit_2 <- glm(entry ~ Y + W + rival_entry,
               data = firm_data,
               family = binomial(link = "logit"))


# Optional: save LaTeX table to file
stargazer(
  logit_1, logit_2,
  type = "latex",
  out = "q7_logit_table.tex",
  title = "Reduced-Form Logit Regressions of Entry",
  column.labels = c("Entry on Y, W", "Entry on Y, W, Rival Entry"),
  dep.var.labels = "Firm Entry",
  covariate.labels = c("Demand Shifter (Y)",
                       "Cost Shifter (W)",
                       "Rival Entry"),
  omit.stat = c("ll", "aic"),
  digits = 3,
  no.space = TRUE
)

