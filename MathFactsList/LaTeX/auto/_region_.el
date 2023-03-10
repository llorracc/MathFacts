(TeX-add-style-hook "_region_"
 (lambda ()
    (LaTeX-add-bibliographies
     "economics")
    (LaTeX-add-labels
     "CRRALim"
     "fact:CRRALim"
     "fact:FinSum"
     "fact:InfSum"
     "fact:LogEps"
     "eq:ELogNorm"
     "fact:SmallSmallZero"
     "fact:EulersTheorem")
    (TeX-run-style-hooks
     "latex2e"
     "art12"
     "article"
     "12pt"
     "EconDocStart"
     "OptDocStart"
     "HandoutHeader")))

