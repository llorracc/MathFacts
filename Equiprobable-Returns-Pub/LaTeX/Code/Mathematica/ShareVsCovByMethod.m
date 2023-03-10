(* ::Package:: *)

\[Stigma]PlotTiming={};

Print[AppendTo[\[Stigma]PlotTiming,{"Direct",First[Timing[\[Stigma]PlotDirect = 
Plot[\[Stigma]OptDirect[\[ScriptR]1, \[ScriptR]2, \[ScriptX], \[CapitalSigma], \[Omega], \[Rho]],{\[Omega],\[Omega]MinPlot,\[Omega]MaxPlot}
,PlotStyle->Black
,AxesLabel->{"\[Omega]","\[Stigma]"}
]]]}]];
\[Stigma]Vals=Transpose[First@Cases[\[Stigma]PlotDirect,Line[x_]:>x,Infinity]][[2]];
{\[Stigma]Min,\[Stigma]Max}={Min[\[Stigma]Vals],Max[\[Stigma]Vals]};


\[Stigma]PlotDirect


AppendTo[\[Stigma]PlotTiming,{"EquiprobableList",First[Timing[
NumPtsToUseForApprox=10;
ptsList= Table[\[Omega]MinPlot+\[Omega]Gap(i/(NumPtsToUseForApprox)),{i,1,NumPtsToUseForApprox}]//N;
\[Stigma]OptEquiPts = Table[\[Stigma]OptEqui[\[ScriptR]1, \[ScriptR]2, \[ScriptX], \[CapitalSigma], ptsList[[i]], \[Rho]],{i,NumPtsToUseForApprox}];
Print[\[Stigma]PlotEquiList=ListPlot[Transpose[{ptsList,\[Stigma]OptEquiPts}],PlotStyle->Blue]]]]}];


AppendTo[\[Stigma]PlotTiming,{"Equiprobable",First[Timing[Print[\[Stigma]PlotEqui = Plot[\[Stigma]OptEqui[\[ScriptR]1,\[ScriptR]2,\[ScriptX],\[CapitalSigma],\[Omega],\[Rho]],{\[Omega],\[Omega]MinPlot,\[Omega]MaxPlot}
,PlotStyle->Green
,AxesLabel->{"\[Omega]","\[Stigma]"}
]]]]}];
\[Stigma]Vals=Transpose[First@Cases[\[Stigma]PlotEqui,Line[x_]:>x,Infinity]][[2]];
{\[Stigma]Min,\[Stigma]Max}={Min[\[Stigma]Min,Min[\[Stigma]Vals]],Max[\[Stigma]Max,Max[\[Stigma]Vals]]};


AppendTo[\[Stigma]PlotTiming,{"CVApprox",First[Timing[Print[
\[Stigma]PlotCVApprox = Plot[\[Stigma]OptCVApprox[\[ScriptR]1, \[ScriptR]2, \[ScriptX], \[CapitalSigma], \[Omega], \[Rho]],{\[Omega],\[Omega]MinPlot,\[Omega]MaxPlot}
,PlotStyle->Red
,AxesLabel->{"\[Omega]","\[Stigma]"}
]]]]}];
\[Stigma]Vals=Transpose[First@Cases[\[Stigma]PlotCVApprox,Line[x_]:>x,Infinity]][[2]];
{\[Stigma]Min,\[Stigma]Max}={Min[\[Stigma]Min,Min[\[Stigma]Vals]],Max[\[Stigma]Max,Max[\[Stigma]Vals]]};


Print[ShareVsCovByMethod=Show[\[Stigma]PlotDirect,\[Stigma]PlotCVApprox,\[Stigma]PlotEqui,\[Stigma]PlotEquiList
,PlotLabel->Style["{Black, Red, Green}={Direct, CV, Equiprobable("<>ToString[NumOfPoints]<>")}",14,Black]
,PlotRange->{Automatic,{\[Stigma]Min-0.01,\[Stigma]Max+0.01}}]];


Print[MatrixForm[\[Stigma]PlotTiming,TableHeadings->{None,"Method","Seconds"}]];


Export["./Figures/ShareVsCovByMethod.pdf",ShareVsCovByMethod];
Export["./Figures/ShareVsCovByMethod.png",ShareVsCovByMethod,ImageSize->72 9];
Export["./Figures/ShareVsCovByMethod.svg",ShareVsCovByMethod];
