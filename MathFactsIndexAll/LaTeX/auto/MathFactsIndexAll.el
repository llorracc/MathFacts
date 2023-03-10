(TeX-add-style-hook
 "MathFactsIndexAll"
 (lambda ()
   (TeX-run-style-hooks
    "latex2e"
    "makePostHandoutsStart"
    "../"
    "./body"
    "handout"
    "handout10"
    "handoutSetup")
   (TeX-add-symbols
    '("hBoth" 1)
    '("entrylabel" 1)
    "file"
    "publec"
    "toDir"
    "dir")
   (LaTeX-add-environments
    "entry")))

