(* ::Package:: *)

(*
The key result on which the approximation rests is the solution to the integral 
which calculates the expectation of the value of a lognormally distributed variable z
in the interval from zMin to zMax.  The solution to this can be obtained analytically 
from the Mathematica command

Integrate[z PDF[LogNormalDistribution[\[Mu],\[Sigma]],z],{z,zMin,zMax},Assumptions->{zMax-zMin>0&&zMax>0&&zMin>0}]

and that solution
-1/2 E^(\[Mu]+\[Sigma]^2/2) (Erf[(\[Mu]+\[Sigma]^2-Log[zMax])/(Sqrt[2] \[Sigma])]-Erf[(\[Mu]+\[Sigma]^2-Log[zMin])/(Sqrt[2] \[Sigma])])

is directly incorporated into the function.
*)

ClearAll[DiscreteApproxToMeanOneLogNormal,DiscreteApproxToMeanOneLogNormalWithEdges];

DiscreteApproxToMeanOneLogNormalWithEdges[StdDev_,NumOfPoints_] := Block[
{\[Mu],\[Sigma],\[Sharp]Inner,\[Sharp]Outer,CDFOuter,CDFInner,MeanPointsProb,MeanPointsVals,zMin,zMax},
   \[Sigma]=StdDev;
   \[Mu]=-(1/2) \[Sigma]^2;  (* This is the value necessary to make the mean in levels = 1 *)
   \[Sharp]Inner = Table[Quantile[LogNormalDistribution[\[Mu],\[Sigma]],(i/NumOfPoints)],{i,NumOfPoints-1}];
   \[Sharp]Outer = Flatten[{{0}, \[Sharp]Inner,{Infinity}}];
   CDFOuter    = Table[CDF[LogNormalDistribution[\[Mu],\[Sigma]],\[Sharp]Outer[[i]]],{i,1,Length[\[Sharp]Outer]}];
   CDFInner    = Most[Rest[CDFOuter]];
   MeanPointsProb = Table[CDFOuter[[i]]-CDFOuter[[i-1]],{i,2,Length[\[Sharp]Outer]}];
   MeanPointsVals = Table[
     {zMin,zMax}= {\[Sharp]Outer[[i-1]], \[Sharp]Outer[[i]]};
      -(1/2) E^(\[Mu]+\[Sigma]^2/2) (Erf[(\[Mu]+\[Sigma]^2-Log[zMax])/(Sqrt[2] \[Sigma])]-Erf[(\[Mu]+\[Sigma]^2-Log[zMin])/(Sqrt[2] \[Sigma])]) //N
     ,{i,2,Length[\[Sharp]Outer]}]/MeanPointsProb;
   Return[{MeanPointsVals,MeanPointsProb,\[Sharp]Outer,CDFOuter,\[Sharp]Inner,CDFInner}]
];

DiscreteApproxToMeanOneLogNormal[StdDev_,NumOfPoints_] := Take[DiscreteApproxToMeanOneLogNormalWithEdges[StdDev,NumOfPoints],2];
