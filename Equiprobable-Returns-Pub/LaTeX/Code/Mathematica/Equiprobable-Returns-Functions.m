(* ::Package:: *)

Get["./DiscreteApproxToMeanOneLogNormal.m"];
SystemOptions["EvaluateNumericalFunctionArgument"-> False]; (* Tell Mma to evaluate things numerically wherever possible *)


(* The ?NumericQ part of the definition of an arugment insists that the argument must be numerical *)
(* This prevents Mathematica from fruitlessly attempting to find symbolic solutions *)
\[DoubleStruckCapitalE]uNInt[\[Stigma]_?NumericQ, \[ScriptR]1_?NumericQ, \[ScriptR]2_?NumericQ, \[ScriptX]_?NumericQ, \[CapitalSigma]_?NumericQ, \[Omega]_?NumericQ, \[Rho]_?NumericQ] := Block[{\[Sigma]1, \[Sigma]2,\[Sigma]12, \[DoubleStruckCapitalE]uNIntVal}, 
\[Sigma]1 = \[ScriptX] \[CapitalSigma];
\[Sigma]2 = Sqrt[(\[Omega]^2+1)] \[CapitalSigma];
\[Sigma]12 = \[Omega] \[ScriptX] \[CapitalSigma]^2;

\[DoubleStruckCapitalE]uNIntVal =((1-\[Rho])^-1)NIntegrate[((Exp[\[ScriptR]Int1](1-\[Stigma])+Exp[\[ScriptR]Int2] \[Stigma])^(1-\[Rho])) PDF[MultinormalDistribution[{\[ScriptR]1,\[ScriptR]2},{{\[Sigma]1^2,\[Sigma]12},{\[Sigma]12,\[Sigma]2^2}}],{\[ScriptR]Int1,\[ScriptR]Int2}],{\[ScriptR]Int1,-Infinity,Infinity},{\[ScriptR]Int2,-Infinity,Infinity}];
Return[\[DoubleStruckCapitalE]uNIntVal];
];
usage::"\[DoubleStruckCapitalE]uNInt[\[Stigma], \[ScriptR]1, \[ScriptR]2, \[ScriptX], \[CapitalSigma], \[Omega], \[Rho]] returns expected utility constructed using numerical integration."

\[Stigma]OptDirect[\[ScriptR]1_?NumericQ, \[ScriptR]2_?NumericQ,\[ScriptX]_?NumericQ, \[CapitalSigma]_?NumericQ, \[Omega]_?NumericQ, \[Rho]_?NumericQ]:=\[Stigma] /. FindMaximum[{
    \[DoubleStruckCapitalE]uNInt[\[Stigma], \[ScriptR]1, \[ScriptR]2, \[ScriptX], \[CapitalSigma], \[Omega],\[Rho]] (*Objective*)
   ,0<\[Stigma]<1 (* Constraint*)
   },{\[Stigma],0.5 (* Starting point for search *)}][[2]];


\[DoubleStruckCapitalE]uEquiSetup[NumOfPoints_]:=Block[{},
CDFMidPoints\[CapitalTheta]1\[CapitalTheta]2={};
{\[CapitalTheta]1Pts,\[CapitalTheta]1Prb,\[CapitalTheta]1EdgesOuter,\[CapitalTheta]1CDFOuter,\[CapitalTheta]1EdgesInner,\[CapitalTheta]1CDFInner} = DiscreteApproxToMeanOneLogNormalWithEdges[\[CapitalSigma] \[ScriptX], NumOfPoints];
{\[CapitalTheta]2Pts,\[CapitalTheta]2Prb,\[CapitalTheta]2EdgesOuter,\[CapitalTheta]2CDFOuter,\[CapitalTheta]2EdgesInner,\[CapitalTheta]2CDFInner} = DiscreteApproxToMeanOneLogNormalWithEdges[\[CapitalSigma]    ,NumOfPoints];
Do[
AppendTo[CDFMidPoints\[CapitalTheta]1\[CapitalTheta]2,{\[CapitalTheta]1Pts[[i]],\[CapitalTheta]2Pts[[j]],\[CapitalTheta]1CDFOuter[[i]]\[CapitalTheta]2CDFOuter[[j]]+\[CapitalTheta]1CDFOuter[[i+1]]\[CapitalTheta]2CDFOuter[[j+1]]-\[CapitalTheta]1CDFOuter[[i+1]]\[CapitalTheta]2CDFOuter[[j]]-\[CapitalTheta]1CDFOuter[[i]]\[CapitalTheta]2CDFOuter[[j+1]]}]
,{i,Length[\[CapitalTheta]1Pts]},{j,Length[\[CapitalTheta]2Pts]}];
];
\[DoubleStruckCapitalE]uEquiSetup::usage = "\[DoubleStruckCapitalE]uEquiSetup[Num] creates environment variables containing an equiprobable approximation to a bivariate lognormal.";

\[DoubleStruckCapitalE]uEqui[\[Stigma]_, \[ScriptR]1_,\[ScriptR]2_,\[ScriptX]_, \[CapitalSigma]_, \[Omega]_, \[Rho]_]:=Block[{l\[ScriptCapitalR]1 ,l\[ScriptCapitalR]2,\[Zeta],\[DoubleStruckCapitalE]uEquiVal},
l\[ScriptCapitalR]1 = \[ScriptR]1+(1/2) (\[ScriptX] \[CapitalSigma])^2;
l\[ScriptCapitalR]2 = \[ScriptR]2+(1/2) (\[Omega]^2+1)(\[CapitalSigma])^2;
\[Zeta] = (1/2) (\[Omega] (\[CapitalSigma] ^2)\[ScriptX]-(\[Omega]^2)(\[CapitalSigma]^2));
\[DoubleStruckCapitalE]uEquiVal = ((1-\[Rho])^-1)Sum[(Exp[l\[ScriptCapitalR]1] CDFMidPoints\[CapitalTheta]1\[CapitalTheta]2[[i]][[1]] (1-\[Stigma])+\[Stigma] Exp[l\[ScriptCapitalR]2+\[Zeta]] (CDFMidPoints\[CapitalTheta]1\[CapitalTheta]2[[i]][[1]])^(\[Omega]/\[ScriptX]) CDFMidPoints\[CapitalTheta]1\[CapitalTheta]2[[i]][[2]])^(1-\[Rho]) (1/Length[CDFMidPoints\[CapitalTheta]1\[CapitalTheta]2]),{i,Length[CDFMidPoints\[CapitalTheta]1\[CapitalTheta]2]}];
Return[\[DoubleStruckCapitalE]uEquiVal]
];
\[DoubleStruckCapitalE]uEqui::usage = "\[DoubleStruckCapitalE]uEqui[\[Stigma], \[ScriptR]1,\[ScriptR]2,\[ScriptX], \[CapitalSigma], \[Omega], \[Rho]] computes expected utility using assumed-to-exist-already environment variables describing a bivariate lognormal.";

\[Stigma]OptEqui[\[ScriptR]1_, \[ScriptR]2_,\[ScriptX]_, \[CapitalSigma]_, \[Omega]_, \[Rho]_]:=\[Stigma] /. FindMaximum[{
    \[DoubleStruckCapitalE]uEqui[\[Stigma], \[ScriptR]1, \[ScriptR]2, \[ScriptX], \[CapitalSigma], \[Omega],\[Rho]] (*Objective*)
   ,0<\[Stigma]<1 (* Constraint*)
   },{\[Stigma],0.5 (* Starting point for search *)}][[2]];
\[Stigma]OptEqui::usage = "\[Stigma]OptEqui[\[Stigma], \[ScriptR]1,\[ScriptR]2,\[ScriptX], \[CapitalSigma], \[Omega], \[Rho]] searches numerically for a value of the portfolio share that maximizes utility using the equiprobable approximation to the bivariate lognormal.";


\[Stigma]OptCVApprox[\[ScriptR]1_, \[ScriptR]2_, \[ScriptX]_, \[CapitalSigma]_, \[Omega]_, \[Rho]_]:=Block[{\[Sigma]1,\[Sigma]2,\[Sigma]12,\[Eta],\[Stigma]},
\[Sigma]1 = \[ScriptX] \[CapitalSigma];
\[Sigma]2 = Sqrt[(\[Omega]^2+1)] \[CapitalSigma];
\[Sigma]12 = \[Omega] \[ScriptX] \[CapitalSigma]^2;
\[Eta] = \[Sigma]1^2+\[Sigma]2^2-2 \[Sigma]12;
\[Stigma] = (\[ScriptR]2-\[ScriptR]1+\[Eta]/2)/(\[Rho] \[Eta])+(1-\[Rho])(\[Sigma]12-\[Sigma]1^2)/(\[Rho] \[Eta]);
If[\[Stigma] >1,\[Stigma] =1];
If[\[Stigma] <0,\[Stigma] =0];
Return[\[Stigma]]
];
\[Stigma]OptCVApprox::usage = "\[Stigma]OptCVApprox[\[Stigma], \[ScriptR]1,\[ScriptR]2,\[ScriptX], \[CapitalSigma], \[Omega], \[Rho]] returns the optimal portfolio share implied by the Campbell-Viceira approximation to the bivariate lognormal";
