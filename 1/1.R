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
n <- 1000

t <- seq(0, 15, length.out = 1000)
Y <- rnorm(n, 10, sqrt(0.25))
W <- rnorm(n, 1, sqrt(0.25))
U_d <- rnorm(n, 0, sqrt(1))
U_s <- rnorm(n, 0, sqrt(1))


P = (5 - 30 + 2*W - Y + U_s - U_d)/(-2-3)
Q = 30 - 2*P + Y + U_d

Pc_t = (5 - 30 + 2*W - Y + U_s - U_d - 3*t)/(-2-3)
Pf_t = Pc_t - t
Q_t = 30 - 2*Pc_t + Y + U_d

simu <- data.frame(Y, W, U_d, U_s, P, Q, t, Pc_t, Pf_t, Q_t)

# regression ####
d_1 <- lm(Q ~ P + Y, data = simu)
s_1 <- lm(Q ~ P + W, data = simu)

d_iv <- ivreg(Q ~ P + Y | Y + W, data = simu)
s_iv <- ivreg(Q ~ P + W | Y + W, data = simu)

stargazer(
  d_1,
  s_1,
  d_iv,
  s_iv,
  type = "latex",
  title = "Regression Table",
  single.row = TRUE,
  font.size = "small",
  digits = 2,
  model.numbers = FALSE
)

# taxes ####
simu$P_d_max <- (30 + simu$Y + simu$U_d) / 2
simu$P_s_min <- -(5 + 2*simu$W + simu$U_s) / 3

simu$CS <- 0.5 * simu$Q_t * (simu$P_d_max - simu$Pc_t)
simu$PS <- 0.5 * simu$Q_t * (simu$Pf_t - simu$P_s_min)
simu$TR <- simu$t * simu$Q_t
simu$DWL <- 0.5 * simu$t * (simu$Q - simu$Q_t)


# plotting
welfare_long <- simu %>%
  select(t, CS, PS, TR, DWL) %>%
  pivot_longer(-t, names_to = "Outcome", values_to = "Value") %>%
  mutate(
    Outcome = factor(
      Outcome,
      levels = c("CS","PS","TR","DWL"),
      labels = c("Consumer surplus (CS)",
                 "Producer surplus (PS)",
                 "Tax revenue (TR)",
                 "Deadweight loss (DWL)")
    )
  )

p_welfare_facet <- ggplot(welfare_long,
                          aes(x = t, y = Value)) +
  geom_point(size = 1, color = viridis(6, option = "D")[1]) +
  facet_wrap(~Outcome, scales = "free_y", ncol = 2) +
  scale_x_continuous(expand = expansion(mult = c(0.01, 0.02))) +
  scale_y_continuous(labels = scales::comma) +
  labs(
    title = "Welfare outcomes vs. tax rate",
    x = "Per-unit tax (t)",
    y = element_blank()
  ) +
  theme(
    plot.title = element_text(face = "bold", size = 15, margin = margin(b = 8)),
    strip.text = element_text(face = "bold"),
    panel.grid.minor = element_blank()
  )

p_welfare_facet












