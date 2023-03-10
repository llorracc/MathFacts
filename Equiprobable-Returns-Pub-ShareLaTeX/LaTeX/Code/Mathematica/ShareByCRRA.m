(* ::Package:: *)

Clear[\[Stigma]];
{\[Rho]MinPlot,\[Rho]MaxPlot}={1,3};\[Rho]Gap=(\[Rho]MaxPlot-\[Rho]MinPlot);
\[Stigma]PlotTiming={};


Print[AppendTo[\[Stigma]PlotTiming,{"Direct",First[Timing[\[Stigma]PlotDirect = 
Plot[\[Stigma]OptDirect[\[ScriptR]1, \[ScriptR]2, \[ScriptX],\[CapitalSigma],\[Omega], \[Rho]],{\[Rho],\[Rho]MinPlot,\[Rho]MaxPlot}
,PlotStyle->Black
,AxesLabel->{"\[Rho]","\[Stigma]"}
]]]}]];
\[Stigma]Vals=Transpose[First@Cases[\[Stigma]PlotDirect,Line[x_]:>x,Infinity]][[2]];
{\[Stigma]Min,\[Stigma]Max}={Min[\[Stigma]Vals],Max[\[Stigma]Vals]};


AppendTo[\[Stigma]PlotTiming,{"EquiprobableList",First[Timing[
NumPtsToUseForApprox=10;
ptsList= Table[\[Rho]MinPlot+\[Rho]Gap(i/(NumPtsToUseForApprox)),{i,1,NumPtsToUseForApprox}]//N;
\[Stigma]OptEquiPts = Table[\[Stigma]OptEqui[\[ScriptR]1, \[ScriptR]2, \[ScriptX], \[CapitalSigma], \[Omega], ptsList[[i]]],{i,NumPtsToUseForApprox}];
Print[\[Stigma]PlotEquiList=ListPlot[Transpose[{ptsList,\[Stigma]OptEquiPts}],PlotStyle->Blue]]]]}];


AppendTo[\[Stigma]PlotTiming,{"Equiprobable",First[Timing[Print[\[Stigma]PlotEqui = Plot[\[Stigma]OptEqui[\[ScriptR]1,\[ScriptR]2,\[ScriptX],\[CapitalSigma],\[Omega],\[Rho]],{\[Rho],\[Rho]MinPlot,\[Rho]MaxPlot}
,PlotStyle->Green
,AxesLabel->{"\[Rho]","\[Stigma]"}
]]]]}];
\[Stigma]Vals=Transpose[First@Cases[\[Stigma]PlotEqui,Line[x_]:>x,Infinity]][[2]];
{\[Stigma]Min,\[Stigma]Max}={Min[\[Stigma]Min,Min[\[Stigma]Vals]],Max[\[Stigma]Max,Max[\[Stigma]Vals]]};


AppendTo[\[Stigma]PlotTiming,{"CVApprox",First[Timing[Print[
\[Stigma]PlotCVApprox = Plot[\[Stigma]OptCVApprox[\[ScriptR]1, \[ScriptR]2, \[ScriptX], \[CapitalSigma], \[Omega], \[Rho]],{\[Rho],\[Rho]MinPlot,\[Rho]MaxPlot}
,PlotStyle->Red
,AxesLabel->{"\[Rho]","\[Stigma]"}
]]]]}];
\[Stigma]Vals=Transpose[First@Cases[\[Stigma]PlotCVApprox,Line[x_]:>x,Infinity]][[2]];
{\[Stigma]Min,\[Stigma]Max}={Min[\[Stigma]Min,Min[\[Stigma]Vals]],Max[\[Stigma]Max,Max[\[Stigma]Vals]]};


Print[Show[\[Stigma]PlotDirect,\[Stigma]PlotCVApprox,\[Stigma]PlotEqui,\[Stigma]PlotEquiList
,PlotLabel->Style["{Black, Red, Green}={Direct, CV, Equiprobable("<>ToString[NumOfPoints]<>")}",14,Black]
,PlotRange->{Automatic,{\[Stigma]Min-0.02,\[Stigma]Max+0.02}}]];


Print[MatrixForm[\[Stigma]PlotTiming,TableHeadings->{None,"Method","Seconds"}]];


Export["./Figures/ShareVsCRRA.pdf",ShareVsCRRA];
Export["./Figures/ShareVsCRRA.png",ShareVsCRRA,ImageSize->72 9];
Export["./Figures/ShareVsCRRA.svg",ShareVsCRRA];
