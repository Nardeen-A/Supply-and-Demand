%=================================================
% Economics Coursework Template
%=================================================
\documentclass[12pt]{article}

%------------ Packages ------------
\usepackage[margin=1in]{geometry}   % Page layout
\usepackage{lmodern}                % Latin Modern (LaTeX default font)
\usepackage{amsmath, amssymb}       % Math symbols
\usepackage{booktabs}               % Professional tables
\usepackage{graphicx}               % Figures
\usepackage{natbib}                 % References
\usepackage[hidelinks]{hyperref}    % Hyperlinks
\usepackage{fancyhdr}               % Headers/footers
\usepackage{setspace}               % Line spacing
\usepackage{titlesec}               % Section formatting
\usepackage{geometry}
\usepackage{comment} 
\usepackage{xcolor} 
\usepackage{amsthm} 
\usepackage{float} 
\usepackage{dcolumn}
\usepackage{titlesec}
\usepackage{enumitem}
\usepackage{hyperref}
\usepackage{tikz}
\usepackage{multicol}
\usetikzlibrary{arrows.meta,positioning,fit,calc}
\usepackage{subcaption}
\tikzset{
  var/.style={rectangle, draw, rounded corners, minimum width=18mm, minimum height=7mm, align=center},
  latent/.style={ellipse, draw, dashed, minimum width=18mm, minimum height=7mm, align=center},
  controlarrow/.style={->, dashed, draw=red!60},
  lightbluearrow/.style={->, dashed, draw=blue!40} % NEW style
}

%------------ Page Style ------------
\rhead{\thepage}
\lhead{ECO1465 Weekly Report 1}

%------------ Section Formatting ------------
\titleformat{\section}{\large\bfseries}{\thesection.}{0.5em}{}
\titleformat{\subsection}{\normalsize\bfseries\itshape}{\thesubsection}{0.5em}{}
\titlespacing*{\subsection}{0pt}{1.5ex plus 1ex minus .2ex}{1em} % spacing before/after subsections


%------------ Begin Document ------------
\begin{document}
% Title Page only
\begin{titlepage}
    \thispagestyle{empty} % no headers/footers
    \centering
    \vspace*{\fill}

    {\Large \textbf{Entry Game} \par}

    \vspace{3em}
    {\large Nardeen Abdulkareem \par}
    {\normalsize The University of Toronto \par}
    {\normalsize \today \par}
    {\texttt{nardeen.abdulkareem@mail.utoronto.ca} \par}

    \vspace*{\fill}
\end{titlepage}
\clearpage

\section{Monopoly Variable Profit Under Cournot}
Price:
\[
P_m = A_m + \alpha_1 q_{jm}
\]
where $A_m = \alpha_0 + \alpha_2 Y_m + \xi_m$.

Cost function for firm $j$:
\[
C_{jm}(q_{jm}) = c_{jm} q_{jm} + \gamma_2 q_{jm}^2
\]
where $c_{jm} = \gamma_0 + \gamma_1 W_m + \omega_{jm}$.

Firm’s variable profit is:
\[
\pi_{jm} = (P_m - c_{jm}) q_{jm} - \gamma_2 q_{jm}^2
\]

\[
\pi_{jm} = (A_m + \alpha_1 q_{jm} - c_{jm}) q_{jm} - \gamma_2 q_{jm}^2
\]

First-order condition:
\[
\frac{\partial \pi_{jm}}{\partial q_{jm}} = (A_m + \alpha_1 q_{jm} - c_{jm}) + \alpha_1 q_{jm} - 2\gamma_2q_{jm} = 0
\]

Monopoly quantity:
\[
q_{jm}^{M} = \frac{A_m - c_{jm}}{2(\gamma_2 - \alpha_1)}
\]

Substituting back into the profit function yields:
\[
\boxed{
\pi_{jm}^{M} = \frac{(A_m - c_{jm})^2}{4(\gamma_2 - \alpha_1)}
}
\]

\section{Duopoly Variable Profit}
Inverse demand is:
\[
P_m = A_m + \alpha_1 Q_m, \qquad Q_m = q_{1m} + q_{2m}
\]

Firm 1's profit is
\[
\pi_{1m}^V = \left(A_m + \alpha_1(q_{1m}+q_{2m}) - c_{1m}\right)q_{1m} - \gamma_2 q_{1m}^2
\]

Firm 2's profit is
\[
\pi_{2m}^V = \left(A_m + \alpha_1(q_{1m}+q_{2m}) - c_{2m}\right)q_{2m} - \gamma_2 q_{2m}^2
\]

First-order conditions:
\[
\frac{\partial \pi_{1m}^V}{\partial q_{1m}}
= \left(A_m + \alpha_1(q_{1m}+q_{2m}) - c_{1m}\right) + \alpha_1 q_{1m} - 2\gamma_2q_{1m} = 0
\]

\[
\frac{\partial \pi_{2m}^V}{\partial q_{2m}}
= \left(A_m + \alpha_1(q_{1m}+q_{2m}) - c_{1m}\right) + \alpha_1 q_{2m} - 2\gamma_2q_{2m} = 0
\]

Rearranging,
\[
2(\gamma_2-\alpha_1)q_{1m} - \alpha_1 q_{2m} = A_m - c_{1m}
\]
\[
-\alpha_1 q_{1m} + 2(\gamma_2-\alpha_1)q_{2m} = A_m - c_{2m}
\]

In matrix form,
\[
\begin{bmatrix}
2(\gamma_2-\alpha_1) & -\alpha_1 \\
-\alpha_1 & 2(\gamma_2-\alpha_1)
\end{bmatrix}
\begin{bmatrix}
q_{1m} \\ q_{2m}
\end{bmatrix}
=
\begin{bmatrix}
A_m - c_{1m} \\ A_m - c_{2m}
\end{bmatrix}
\]

Let
\[
\Delta = 4(\gamma_2-\alpha_1)^2 - \alpha_1^2
\]

Solving the system gives
\[
q_{1m}^D = \frac{2(\gamma_2-\alpha_1)(A_m - c_{1m}) + \alpha_1 (A_m - c_{1m})}{\Delta}
\]
\[
q_{2m}^D = \frac{2(\gamma_2-\alpha_1)(A_m - c_{2m}) + \alpha_1 (A_m - c_{2m})}{\Delta}
\]


Substituting in duopoly quantities into variable profits:
\[
\pi_{1m}^V = \left(A_m + \alpha_1(q_{1m}+q_{2m}) - c_{1m}\right)q_{1m} - \gamma_2 q_{1m}^2
\]
\[
= (A_m-c_{1m})q_{1m} + \alpha_1 q_{1m}^2 + \alpha_1 q_{1m}q_{2m} - \gamma_2 q_{1m}^2
\]
\[
= (A_m-c_{1m})q_{1m} + (\alpha_1-\gamma_2)q_{1m}^2 + \alpha_1 q_{1m}q_{2m}
\]
\[
= (A_m-c_{1m} + \alpha_1 q_{2m})q_{1m} + (\alpha_1-\gamma_2)q_{1m}^2
\]


For the first-order condition:
\[
A_m-c_{1m} + 2(\alpha_1-\gamma_2)q_{1m} + \alpha_1 q_{2m} = 0
\]
\[
(A_m-c_{1m}) + \alpha_1 q_{2m} = 2(\gamma_2-\alpha_1)q_{1m}
\]

Therefore,
\[
\pi_{1m}^V
= (2(\gamma_2-\alpha_1)q_{1m})q_{1m} + (\alpha_1-\gamma_2)q_{1m}^2
\]
\[
= 2(\gamma_2-\alpha_1)q_{1m}^2 - (\gamma_2-\alpha_1)q_{1m}^2
\]
\[
= (\gamma_2-\alpha_1)q_{1m}^2
\]

\[
\pi_{1m}^D
= (\gamma_2-\alpha_1)\left(q_{1m}^D\right)^2
\]
\[
= (\gamma_2-\alpha_1)\left(
\frac{2(\gamma_2-\alpha_1)(A_m - c_{1m}) + \alpha_1 (A_m - c_{2m})}{\Delta}
\right)^2
\]
\[
\pi_{2m}^V = \left(A_m + \alpha_1(q_{1m}+q_{2m}) - c_{2m}\right)q_{2m} - \gamma_2 q_{2m}^2
\]
\[
\pi_{2m}^D
= (\gamma_2-\alpha_1)\left(q_{2m}^D\right)^2
\]
\[
= (\gamma_2-\alpha_1)\left(
\frac{2(\gamma_2-\alpha_1)(A_m - c_{2m}) + \alpha_1 (A_m - c_{1m})}{\Delta}
\right)^2
\]

Therefore, the duopoly variable profits are
\[
\boxed{
\pi_{1m}^D
=
(\gamma_2-\alpha_1)\left(
\frac{2(\gamma_2-\alpha_1)(A_m - c_{1m}) + \alpha_1 (A_m - c_{2m})}{\Delta}
\right)^2
}
\]
\[
\boxed{
\pi_{2m}^D
=
(\gamma_2-\alpha_1)\left(
\frac{2(\gamma_2-\alpha_1)(A_m - c_{2m}) + \alpha_1 (A_m - c_{1m})}{\Delta}
\right)^2
}
\]

\section{Computation of the sub--game perfect equilibrium (SPE)}
\begin{enumerate}
\item \textbf{Input:} $Y_m, W_m, F_{1m}, F_{2m}$

\item Compute expected profits:
\[
\bar{\pi}_{1m}^M,\; \bar{\pi}_{2m}^M,\; \bar{\pi}_{1m}^D,\; \bar{\pi}_{2m}^D
\]

\item Compute payoffs:
\begin{align*}
(0,0) &: (0,0) \\
(1,0) &: (\bar{\pi}_{1m}^M - F_{1m},\,0) \\
(0,1) &: (0,\,\bar{\pi}_{2m}^M - F_{2m}) \\
(1,1) &: (\bar{\pi}_{1m}^D - F_{1m},\,\bar{\pi}_{2m}^D - F_{2m})
\end{align*}

\item Check Nash equilibrium conditions:

\begin{itemize}
\item $(0,0)$ is an equilibrium if:
\[
\bar{\pi}_{1m}^M - F_{1m} \leq 0, \quad
\bar{\pi}_{2m}^M - F_{2m} \leq 0
\]

\item $(1,0)$ is an equilibrium if:
\[
\bar{\pi}_{1m}^M - F_{1m} \geq 0, \quad
\bar{\pi}_{2m}^D - F_{2m} \leq 0
\]

\item $(0,1)$ is an equilibrium if:
\[
\bar{\pi}_{2m}^M - F_{2m} \geq 0, \quad
\bar{\pi}_{1m}^D - F_{1m} \leq 0
\]

\item $(1,1)$ is an equilibrium if:
\[
\bar{\pi}_{1m}^D - F_{1m} \geq 0, \quad
\bar{\pi}_{2m}^D - F_{2m} \geq 0
\]
\end{itemize}

\item Store strategy profiles satisfying these conditions.

\item Select unique equilibrium.

\item For multiple equilibria, use a selection rule.
\end{enumerate}

\section{Simulation Descriptives}
\begin{table}[!htbp] \centering 
  \caption{Descriptive Results} 
  \label{tab:q5_descriptives} 
\begin{tabular}{@{\extracolsep{5pt}} cc} 
\\[-1.8ex]\hline 
\hline \\[-1.8ex] 
Statistic & Value \\ 
\hline \\[-1.8ex] 
Fraction (0 entrants) & $0$ \\ 
Fraction (1 entrant) & $0.506$ \\ 
Fraction (2 entrants) & $0.494$ \\ 
Fraction with multiple equilibria & $0.096$ \\ 
\hline \\[-1.8ex] 
Average price (1 active firm) & $118.948$ \\ 
Average price (2 active firms) & $91.011$ \\ 
\hline \\[-1.8ex] 
Average total quantity (1 active firm) & $27.973$ \\ 
Average total quantity (2 active firms) & $42.051$ \\ 
\hline \\[-1.8ex] 
\end{tabular} 
\end{table} 

\section{Reduced Form Logit Entry Regressions}

Consider two reduced form logit specifications:

\[
\Pr(a_{jm}=1 \mid Y_m,W_m)
=
\frac{\exp(\beta_0+\beta_1Y_m+\beta_2W_m)}
{1+\exp(\beta_0+\beta_1Y_m+\beta_2W_m)}
\]

and

\[
\Pr(a_{jm}=1 \mid Y_m,W_m,a_{-jm})
=
\frac{\exp(\delta_0+\delta_1Y_m+\delta_2W_m+\delta_3a_{-jm})}
{1+\exp(\delta_0+\delta_1Y_m+\delta_2W_m+\delta_3a_{-jm})}
\]

These regressions can be estimated in the simulated data, however, they do not recover the structural fixed-cost parameter \(F^C\), nor do they recover the monopoly and duopoly profit functions of the entry game.

\subsection*{(a) Why ignoring rival actions is problematic}

In the previous section monopoly profits and duopoly profits generally differ, and the profitability of entry depends on the rival's action. A logit regression that includes only \(Y_m\) and \(W_m\) ignores this strategic dependence and therefore omits a key determinant of entry. Hence, Logit regression 1's coefficients only capture correlations between observed market characteristics and observed entry outcomes. They do not isolate the underlying fixed costs or separately identify the strategic effect of rival entry on profits.

\subsection*{(b) Why including the rival's action is also problematic}

The rival's entry decision is simultaneously determined with the firms own entry decision as an equilibrium outcome of the same game. \(a_{-jm}\) is jointly determined with \(a_{jm}\), and both depend on the same underlying profit environment. This means that regression 2 only add an additional endogenous variable since the rival's action is another equilibrium outcome. Hence, the coefficient \(\delta_3\) does not measure a causal strategic effect of rival entry. Instead, it conflates strategic interaction, market characteristics, and the equilibrium mapping from primitives into observed actions.


\subsection*{(c) How multiple equilibria complicate the interpretation}

A logit model treats outcomes as a binary entry decision generated with a unique conditional probability given \((Y_m,W_m)\). With multiplicity in play in a logit model, the conditional probability of entry is not pinned down solely by \((Y_m,W_m)\). This means that identical market characteristics can lead to different observed entry outcomes, depending on which equilibrium is selected. Therefore, a logit model cannot accommodate for multiplicity and as a result we do not have ways to easily interpret the reduced form logit coefficients when multiplicity is present.

\subsection*{(d) Interpretation of the two regressions}

The two regressions can be interpreted as a descriptive relationship for entry decisions when conditioning on \((Y_m,W_m)\). The first regression describes how observed market demand and cost shifters are associated with the probability of entry. The second regression describes how a firm's entry decision is correlated with a rival's entry decision. However, because the rival's action is endogenous, we cannot conclude that this regression, or the \(\delta_3\) coefficient, has any causal interpretation. 

\section{Estimation of Logit Models}
\begin{table}[!htbp] \centering 
  \caption{Reduced-Form Logit Regressions of Entry} 
  \label{} 
\begin{tabular}{@{\extracolsep{5pt}}lcc} 
\\[-1.8ex]\hline 
\hline \\[-1.8ex] 
 & \multicolumn{2}{c}{\textit{Dependent variable:}} \\ 
\cline{2-3} 
 & $Pr(a_{jm}=1 \mid Y_m,W_m)$ & $Pr(a_{jm}=1 \mid Y_m,W_m,a_{-jm}$ \\ 
\\[-1.8ex] & (1) & (2)\\ 
\hline \\[-1.8ex] 
 Demand Shifter (Y) & 0.143$^{***}$ & 0.216$^{***}$ \\ 
  & (0.050) & (0.054) \\ 
  Cost Shifter (W) & $-$0.167 & $-$0.256$^{**}$ \\ 
  & (0.102) & (0.111) \\ 
  Rival Entry &  & $-$17.947 \\ 
  &  & (287.858) \\ 
  Constant & $-$5.887$^{**}$ & 8.059 \\ 
  & (2.511) & (287.870) \\ 
 \hline \\[-1.8ex] 
Observations & 2,000 & 2,000 \\ 
\hline 
\hline \\[-1.8ex] 
\textit{Note:}  & \multicolumn{2}{r}{$^{*}$p$<$0.1; $^{**}$p$<$0.05; $^{***}$p$<$0.01} \\ 
\end{tabular} 
\end{table} 

In row 1, both coefficients have the expected signs. The demand shifter \(Y_m\) enters positively and is statistically significant, indicating that higher demand increases the probability of entry by raising expected profits. In row 2, the cost shifter \(W_m\) enters with a negative sign, suggesting that higher costs reduce the likelihood of entry, although it is not statistically significant in model 1.

For model 2, the coefficient on \(Y_m\) remains positive and significant, and the coefficient on \(W_m\) becomes more negative and statistically significant, reinforcing the interpretation that higher costs deter entry. The coefficient on rival entry \(a_{-jm}\) is extremely large in magnitude and imprecisely estimated, with a very large standard error. This may be due to multicollinearity in the data. Economically, we would expect a negative effect of rival entry since competition reduces profits.

\section{Market Level Inequalities and Bounds on Fixed Costs}
Suppose,
\[
F_{jm} = F^C + \epsilon_{jm},
\qquad \epsilon_{jm} \in [{-300},{300}]
\]
\[
F^C + \overline{\epsilon} \geq F_{jm} , \quad F^C + \underline{\epsilon} \leq F_{jm}.
\]

We use the no unilateral profitable deviation conditions from above to derive bounds on the realized fixed costs \(F_{1m}\) and \(F_{2m}\).

\subsection*{Case 1: \((0,0)\)}

Neither firm enters, and neither firm has an incentive to deviate and enter alone:
\[
F_{1m} \geq \bar{\pi}_{1m}^M,
\qquad
F_{2m} \geq \bar{\pi}_{2m}^M
\]

\[
F^C \geq \bar{\pi}_{jm}^M - \overline{\epsilon}
\]

\[
F^C \geq \bar{\pi}_{1m}^M - 300,
\qquad
F^C \geq \bar{\pi}_{2m}^M - 300
\]

This market structure only yields lower bounds.

\subsection*{Case 2: \((1,0)\)}

Firm 1 enters and firm 2 stays out. Firm 1 does not want to deviate and stay out, and firm 2 does not want to deviate and enter:

\[
F_{1m} \leq \bar{\pi}_{1m}^M,
\qquad
F_{2m} \geq \bar{\pi}_{2m}^D
\]

Firm 1:
\[
F^C + \underline{\epsilon} \leq F_{1m}.
\]

\[
F^C \leq \bar{\pi}_{1m}^M - \underline{\epsilon}
= \bar{\pi}_{1m}^M + 300
\]

Firm 2:
\[
F^C \geq \bar{\pi}_{2m}^D - \overline{\epsilon}
= \bar{\pi}_{2m}^D - 300
\]

\[
F^C \leq \bar{\pi}_{1m}^M + 300,
\qquad
F^C \geq \bar{\pi}_{2m}^D - 300
\]

We end up with both an upper and lower bounds in case 2.


\subsection*{Case 3: \((0,1)\)}

Firm 2 enters and firm 1 stays out. Firm 2 does not want to deviate and stay out, and firm 1 does not want to deviate and enter:

\[
F^C \leq \bar{\pi}_{2m}^M + 300,
\qquad
F^C \geq \bar{\pi}_{1m}^D - 300
\]

This market structure also yields an upper and a lower bound.

\subsection*{Case 4: \((1,1)\)}

Both firms enter. N, and neither firm has an incentive to deviate and stay out:

\[
F^C \leq \bar{\pi}_{1m}^D + 300,
\qquad
F^C \leq \bar{\pi}_{2m}^D + 300
\]

This market structure only yields upper bounds.

\subsection*{Summary of Bounds}

The bounds on \(F^C\) are:

\[
(0,0):
\qquad
F^C \geq \bar{\pi}_{1m}^M - 300,
\qquad
F^C \geq \bar{\pi}_{2m}^M - 300
\]
\[
(1,0):
\qquad
F^C \leq \bar{\pi}_{1m}^M + 300,
\qquad
F^C \geq \bar{\pi}_{2m}^D - 300
\]
\[
(0,1):
\qquad
F^C \leq \bar{\pi}_{2m}^M + 300,
\qquad
F^C \geq \bar{\pi}_{1m}^D - 300
\]
\[
(1,1):
\qquad
F^C \leq \bar{\pi}_{1m}^D + 300,
\qquad
F^C \leq \bar{\pi}_{2m}^D + 300
\]

\section{Identified Set for Fixed Cost in the Sample}

The identified set for \(F^C\) in the sample is obtained by intersecting all market-level inequalities across markets. This is done to maintain consistency with all observed entry outcomes in the sample. Any value of \(F^C\) below the maximum market level bound would violate at least one of the market level lower bound inequalities. While, any value above the minimum market level upper bound would violate at least one market level upper bound inequality. If \(\underline{F}^C > \overline{F}^C\), then the sample identified set is empty, meaning that no value of \(F^C\) satisfies all of the inequalities exactly. \(F^C\) must satisfy every lower bound and every upper bound simultaneously. Hence, the sample lower bound must be:
\[
\underline{F}^C = \max_m LB_m
\]

Sample upper bound must be:
\[
\overline{F}^C = \min_m UB_m
\]

The sample identified set is:
\[
\boxed{
F^C \in [\underline{F}^C,\overline{F}^C]
}
\]

\section*{Estimated Identified Set for \(F^C\)}

Using the simulated data, I first compute the expected monopoly and duopoly profits for each market. Next, for each market, I use the observed entry profile and the inequalities derived in Q8 to construct market level lower and upper bounds on the common fixed-cost component \(F^C\). I then aggregate these market level inequalities across all markets. The sample lower bound is the maximum of all lower bounds, and the sample upper bound is the minimum of all upper bounds:

After running the code, I obtain:
\[
\boxed{
F^C \in [\,1105.938,\ 1530.197\,].
}
\]

The true value used in the data-generating process is
\[
F^C = 1200.
\]

Thus, the comparison of the estimated identified set with the truth is:
\begin{itemize}
\item if \(1200 \in [\underline{F}^C,\overline{F}^C]\), then the true value is contained in the identified set;
\item if \(1200 \notin [\underline{F}^C,\overline{F}^C]\), then the estimated set misses the true value, which may reflect finite-sample or Monte Carlo approximation error.
\end{itemize}

Knowledge of the bounded support of \(\epsilon_{jm}\) is what allows us to translate bounds on the realized fixed costs \(F_{jm}\) into bounds on the common component \(F^C\). Without the restriction
\[
\epsilon_{jm} \in [-300,300],
\]
we could infer only inequalities involving \(F_{jm}\), but not isolate \(F^C\). The support therefore converts the entry inequalities into informative bounds on the fixed cost parameter itself.








\end{document}
