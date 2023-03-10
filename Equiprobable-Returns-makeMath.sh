#!/bin/sh


cd /Volumes/Data/Courses/Choice/LectureNotes/MathFacts/Handouts/Equiprobable-Returns/Code/Mathematica/

alias math="/Applications/Mathematica.app/Contents/MacOS/MathKernel"
math < doAll.m > doAll.out 

cat doAll.out
