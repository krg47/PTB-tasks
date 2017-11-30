%Make the task 2 folder your present working directory
%Run this program to launch the task
%Insert the subject ID, ISI, ITI, repetitions, and blocks below (do we need
%anything else)?
%After those are inserted, click run
%in the folder will appear data with the name "subject_subID.mat"
%add psychtoolbox path?
% "01F_HA_050_C" is how the images are saved


clear;
subID='1234'; 
blocks = 4;
repetitions=4;
ITI=0; %inter trial interval
ISI=1.25; %inter stimulus interval


task2(subID, blocks, repetitions, ITI, ISI);