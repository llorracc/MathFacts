(TeX-add-style-hook
 "MathFactsIndex604"
 (lambda ()
   (TeX-run-style-hooks
    "latex2e"
    "makePostHandoutsStart"
    "../"
    "./body"
    "handout"
    "handout10"
    "handoutSetup"
    "handoutShortcuts")
   (TeX-add-symbols
    '("hBoth" 1)
    '("entrylabel" 1)
    "file"
    "publec"
    "toDir"
    "dir")
   (LaTeX-add-environments
    "entry"))
 :latex)

