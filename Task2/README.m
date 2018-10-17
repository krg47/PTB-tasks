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
    % sequence will be inserted at random. In other words, participants must
    % learn the sequence so well that they can identify when the
    % sequence is altered. 
    % The participant must obtain a certain accuracy to be considered for
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
    % reverseblocks - number of blocks (sets of repetitions) where
    %   increased speed leads to more negative valences
    % forwardblocks - number of blocks (sets of repetitions) where
    %   increased speed leads to more positive valences
    % repetitions - number of sequences per block
    % ITI - pause between sequences
    % ISI - pause between two displayed faces
    % IBI - pause between two groups of sequences
    % Sex - Male or Female
    % Race - Black or White
    % Emotion - Neutral/Sad, Neutral/Fearful, or Happy/Sad
    % Violation Rate - probability any given position in the sequence is
    %   violated
    % Sequence Length

% File/Directory Descriptions:

    % The working directory should include these files/folders:
        % README.m - This is the README. It's purpose is to guide
            % laboratories through the process of using this task.
        % task2.m - This is the main body of the program, and it calls all
            % of the other functions. It is responsible for data storage as well.
        % waittostart.m - This sets up the screen for display, and waits until "=" is pressed to begin the task. 
        % sequencer.m - This randomly generates sequences following the aformentioned parameters.
        % squares.m - This displays the squares where the faces are positioned as well as the faces. 
        % analyze.m - This calculates the percent change in valence based
            % on the response time and impliments the appropriate change in emotion.
        % facedisplay.m - This determines the next face to be shown and
            % appropriately displays it.
        % Faces - this is a folder of morphed and cropped faces from which the program selects.
            % The Faces folder should store faces at :
                % "Faces/<sex>/<race>/<model_no>/<emotion_spectrum>/" with face files as
                % .jpg images sorted sequentially from one emotion to the other. (i.e. the Happy to Sad folder should
                % have their faces stored from most happy to most sad)


% Example Use:
%     subID = '1234'; 
%     reverseblocks = 10;
%     forwardblocks = 5; 
%     repetitions = 7; 
%     ITI = 0.75; 
%     ISI = 0.15;
%     IBI = 1.5; 
%     sex = 'F'; 
%     race = 'W'; 
%     emotion = 'NS'; 
%     violationrate = 0.1; 
%     sequencelength = 5; 
% 1234','10', '5', '7', '0.75', '0.15', '1.5', 'F', 'W', 'NS', '0.1','5'
% task2(subID, reverseblocks, forwardblocks, repetitions, ITI, ISI, IBI, sex, race, emotion, violationrate)
