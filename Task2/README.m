% Created by Matthew Rosenblatt
% Last edited by Kristen Gardner 2/16/2018
% Task 2

% Design

% To launch, click "Run" in task2.m or call function task2 as in example below.                                                                                                                                                       the "=" key to start the experiment
% Blocks indicate a group of repetitions
% The valence (% emotion) of the face only changes between blocks
% The number of repetitions is the number of sequences the participant will see per block
% The time between face display is the Interstimulus Interval (ISI)
% The time between sequences is the Intertrial Interval (ITI)
% The time between blocks is the Interblock Interval (IBI)
% The participant will press keys (1-4) corresponding to the location of a face in a randomly generated sequence
% The first two blocks are used to establish a baseline speed, using neutral faces
% The speed of the following blocks is compared to the baseline
% A 5% change in speed will result in a 10% change in face emotion
% Based on the difference in speeds, the valence of the image will become happier or sadder by a percentage relative to the neutral valence in the next block
% Initially, faster speeds result in increasingly negative valences (reverse learning)
% At some point in the experiment, learning is reversed so that faster
% speeds result in increasingly positive valences (forward learning)
% The program records the following data from the task in a file titled "<subect_ID>.mat":
% Image displayed
% Response time
% Valence
% Sequence
% Participant's keypress
% Participant's accuracy

% Adjustable parameters:
% ITI
% ISI
% IBI
% Subject ID
% Repetitions
% Forward learning blocks
% Reverse learning blocks
% Sex
% Race

% File/Directory Descriptions

% Working directory should include these files/folders:
%   task2.m - main body of the program, calls all other functions, responsible for data storage
%   sequences.csv - pre-determined sequences, from which one will be selected randomly
%   sequencer.m - randomly selects sequence
%   waittostart.m - sets up the screen for display, and waits until "=" is pressed to begin the task 
%   squares.m - displays faces and squares in which they appear
%   analyze.m - calculates the percent change in valence based on the response time
%   Faces - folder containing the pool of faces from which the program selects
% The Faces/ folder should store faces at :
% "Faces/<sex>/<race>/<model_no>/<emotion_spectrum>/" with face files as
% .jpg images sorted from happiest faces to saddest faces.


% Example use
subID = '1234'; %subject ID
reverseblocks = 8; %number of blocks where faster times -> unhappy faces
forwardblocks = 4 %number of blocks where faster times -> happy faces
repetitions = 4; %number of times the sequence is shown per block
ITI = 0; %inter-trial interval (between each sequence)
ISI = 1.25; %inter-stimulus interval (between each face)
IBI = 5; %inter-block interval
sex = 'F' %sex of the subject
race = 'W' %race of the subject
emotion = 'NS' % emotion spectrum to be used. NS = neutral - sad; NF = neutral - fear; HS = happy - sad

task2(subID, reverseblocks, forwardblocks, repetitions, ITI, ISI, IBI, sex, race, emotion);
