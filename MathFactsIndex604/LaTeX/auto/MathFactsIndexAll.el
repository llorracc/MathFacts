(TeX-add-style-hook "MathFactsIndexAll"
 (lambda ()
    (LaTeX-add-bibliographies
     "economics")
    (LaTeX-add-environments
     "entry")
    (TeX-add-symbols
     '("hBoth" 1)
     '("entrylabel" 1)
     "file"
     "publec"
     "toDir"
     "dir")
    (TeX-run-style-hooks
     "latex2e"
     "art12"
     "article"
     "12pt"
     "EconDocStart"
     "OptDocStart"
     "HandoutHeader")))

