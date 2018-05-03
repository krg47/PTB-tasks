% Task 2

% Design:

    % To launch the task, click "Run" in task2.m or call the function "task2" as in the example below. 
    % Press the "=" key to start the experiment, as prompted.
    % A face will appear in one of the fours squares on the screen.
    % Select the corresponding number (1,2,3,or 4) in relation to what square the face appears.
        % 1 is the left most square.
        % 2 is the left center square.
        % 3 is the right center square.
        % 4 is the right most square.
    % Once the key is pressed, the face will disappear, after a short Interstimulus Interval, 
    % the same face will appear elsewhere.
        % Interstimulus Interval (ISI) is a moderate (0.1 - 0.4 seconds) pause between two displayed faces.
    % After a certain number of faces have been shown, there will be a pause (Intertrial Interval). 
    % The number of faces shown between Intertrial Intervals is considered a sequence. 
        % Intertrial Interval (ITI) is a brief (0 - 0.1 seconds) pause between sequences.
        % A group of sequences is considered a block.
    % After a certain number of sequences have been presented, the Interblock Interval will pass.
        % Interblock Interval (IBI) is a lengthy (4 - 6 seconds) pause between two groups of sequences.  
    % At least two blocks must be presented before the faces change emotion and the valence only changes between blocks.
        % The valence is the percentage of emotion on each face.
        % The first two blocks use neutral faces to establish a baseline speed.
    % The speed that it takes each block (the average of sequence speeds) will be
    % recorded and used to determine the valence of the next block.
    % A 5% change in speed will result in a 10% change in face emotion.
    % Initially, faster speeds result in increasingly negative valences (reverse learning).
    % At some point in the experiment, learning is reversed so that faster
    % speeds result in increasingly positive valences (forward learning).
    % All of the sequences are generated randomly, but they all must abide by these parameters:
        % The sequences cannot have consecutive, repeating numbers.
        % The sequences cannot have the same number at the beginning and end (due to cycling).
        % The sequences must contain every number - each must contain 1,2,3,and 4.
    % At random, the sequence will cycle. For example, the last number in the sequence
        % may be move to the first position. (i.e.(1,2,3,4,1,2,3) -> (3,1,2,3,4,1,2))
    % To model Markov Chains, a violation rate (a percentage) can be added. Another
    % sequence will be inserted at random. In other words, subjects must
    % learn the sequence so well that they can identify when the
    % sequence is altered. 
    % The test subject must obtain a certain accuracy to be considered for
    % analysis. 
    % The program records the following data from the task in a file titled "<subect_ID>.mat":
        % Image displayed
        % Response time
        % Valence
        % Sequence
        % Participant's keypress
        % Participant's accuracy

% Adjustable parameters:
    % subID
    % reverseblocks
    % forwardblocks
    % repetitions
    % ITI
    % ISI
    % IBI
    % Sex
    % Race
    % Emotion
    % Violation Rate
    % Sequence Length

% File/Directory Descriptions

    % Working directory should include these files/folders:
        % task2.m - This is the main body of the program, and it calls all
            % of the other functions. It is responsible for data storage as well.
        % waittostart.m - This sets up the screen for display, and waits until "=" is pressed to begin the task 
        % sequencer.m - This randomly generates sequences following the aformentioned parameters.
        % squares.m - This displays the squares where the faces are positioned as well as the faces. 
        % analyze.m - This calculates the percent change in valence based
            % on the response time and impliments the appropriate change in emotion.
        % Faces - this is a folder of morphed and cropped faces from which the program selects.
            % The Faces folder should store faces at :
                % "Faces/<sex>/<race>/<model_no>/<emotion_spectrum>/" with face files as
                % .jpg images sorted sequentially from one emotion to the other. (i.e. the Happy to Sad folder should
                % have their faces stored from most happy to most sad)


% Example use
subID = '1234'; %subject ID
reverseblocks = 8; %number of blocks where faster times -> unhappy faces
forwardblocks = 4; %number of blocks where faster times -> happy faces
repetitions = 4; %number of times the sequence is shown per block
ITI = 0; %inter-trial interval (between each sequence)
ISI = 1.25; %inter-stimulus interval (between each face)
IBI = 5; %inter-block interval
sex = 'F'; %sex of the subject
race = 'W'; %race of the subject
emotion = 'NS'; % emotion spectrum to be used. NS = neutral - sad; NF = neutral - fear; HS = happy - sad
violationrate = 0; 
sequencelength = 7; 

task2(subID, reverseblocks, forwardblocks, repetitions, ITI, ISI, IBI, sex, race, emotion, violationrate, sequencelength);

