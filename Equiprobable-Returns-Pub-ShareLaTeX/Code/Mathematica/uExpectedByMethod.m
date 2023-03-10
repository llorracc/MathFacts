(* ::Package:: *)

uPlotTimes={};(* Used to keep track of the time it takes to produce the plots of utility *)

Print[AppendTo[uPlotTimes,{"Equiprobable",First[Timing[Print[Plot[\[DoubleStruckCapitalE]uEqui[\[Stigma], \[ScriptR]1, \[ScriptR]2, \[ScriptX],\[CapitalSigma],\[Omega], \[Rho]],{\[Omega],-0.9,0.9}
,AxesLabel->{"\[Omega]","\!\(\*SubscriptBox[\(\[DoubleStruckCapitalE]\), \(t\)]\)[\!\(\*SubscriptBox[\(u\), \(t + 1\)]\)]"}]]]]}]];

Print[AppendTo[uPlotTimes,{"Direct",First[Timing[Print[
Plot[\[DoubleStruckCapitalE]uNInt[\[Stigma], \[ScriptR]1, \[ScriptR]2,\[ScriptX],\[CapitalSigma],\[Omega], \[Rho]],{\[Omega],-0.9,0.9}
,AxesLabel->{"\[Omega]","\!\(\*SubscriptBox[\(\[DoubleStruckCapitalE]\), \(t\)]\)[\!\(\*SubscriptBox[\(u\), \(t + 1\)]\)|NInt]"}]]]
]}]];

Print[AppendTo[uPlotTimes,{"Difference",First[Timing[Print[
Plot[\[DoubleStruckCapitalE]uEqui[\[Stigma], \[ScriptR]1, \[ScriptR]2, \[ScriptX], \[CapitalSigma], \[Omega], \[Rho]]-\[DoubleStruckCapitalE]uNInt[\[Stigma], \[ScriptR]1, \[ScriptR]2, \[ScriptX], \[CapitalSigma], \[Omega], \[Rho]],{\[Omega],-0.9,0.9}
,AxesLabel->{"\[Omega]","\!\(\*SubscriptBox[\(\[DoubleStruckCapitalE]\), \(t\)]\)[\!\(\*SubscriptBox[\(u\), \(t + 1\)]\)|Equi]-\!\(\*SubscriptBox[\(\[DoubleStruckCapitalE]\), \(t\)]\)[\!\(\*SubscriptBox[\(u\), \(t + 1\)]\)|NInt]"}]]]
]}]];

Print[MatrixForm[uPlotTimes,TableHeadings->{None,"Method","Seconds"}]];
