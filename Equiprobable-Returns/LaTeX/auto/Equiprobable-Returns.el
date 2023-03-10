(TeX-add-style-hook
 "Equiprobable-Returns"
 (lambda ()
   (TeX-run-style-hooks
    "latex2e"
    "{"
    "handoutBibMake"
    "handout"
    "handout10"
    "handoutSetup"
    "handoutShortcuts")
   (TeX-add-symbols
    "sigAll"
    "scale"
    "ifriskyAlt")
   (LaTeX-add-labels
    "eq:r2tp1CheckDef"
    "eq:Cov"
    "eq:CovMat"
    "eq:wtdAvg"
    "eq:wtdAvgMod"
    "fig:ShareVsCovByMethod"))
 :latex)

