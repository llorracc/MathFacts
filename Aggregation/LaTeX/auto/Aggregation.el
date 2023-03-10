(TeX-add-style-hook
 "Aggregation"
 (lambda ()
   (TeX-run-style-hooks
    "latex2e"
    "handoutBibMake"
    "handout"
    "handout10"
    "handoutSetup")
   (LaTeX-add-labels
    "eq:4")))

