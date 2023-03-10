#!/bin/sh

# Compile and post both file and archive

cd /Volumes/Data/Courses/Choice/LectureNotes/makePost 


courseName=Choice
topicName=MathFacts
handoutName=Aggregation

/Volumes/Data/Courses/Tools/makePost/Handouts/makePostAll.sh $courseName $topicName $handoutName
