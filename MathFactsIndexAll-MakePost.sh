#!/bin/sh

# Compile and post both file and archive

cd /Volumes/Data/Courses/Choice/LectureNotes/MathFacts/Handouts/
./MathFactsIndexBoth-MakePost.sh


/Volumes/Data/Tools/open-if-gui-available.sh Safari.app http://www.econ2.jhu.edu/people/ccarroll/public/lecturenotes/MathFacts/
/Volumes/Data/Tools/open-if-gui-available.sh Safari.app http://www.econ2.jhu.edu/people/ccarroll/courses/Choice/LectureNotes/MathFacts/
