% Task 1

% Design

    % To launch, click "Run" in task1.m or call function task1 as in 
        % example below. 
    % Press the "=" key to start the experiment
    % A face appears with two randomly selected names
    % The participant will select which name they think matches the face by 
        % clicking the left or right arrow key
    % There is no correct name
    % Each key has a bias for the next face to be a more positive/negative 
        % valence
    % This bias is controlled by the probability of bias parameter
    % The time between the participant's keypress and appearance of the 
        % next face is the Interstimulus Interval (ISI)     
    % The program records the following data from the task in a file titled
    % "<test_ID>.mat" that records:
        % Image numbers
        % Group of image (A or B)
        % Sex of image
        % Valence of image
        % Participant's response
        % Response time

% Adjustable parameters:

    % Subject ID
    % Repetitions
    % ISI
    % Probability of bias
    % Emotions (Neutral/Sad, Neutral/Fearful, or Happy/Sad)

% File/Directory Descriptions

    % Working directory should include these files/folders:
    % task1.m - main body of the task that calls other functions
    % userinput.m - allows for input of adjustable parameters
    % waittostart.m - sets up the screen for display, and waits until "=" is pressed to begin the task
    % experiment.m - selects random faces, random names, and selects the
        % next face based % on the participant's keypress and the 
        % probability of bias
    % displayface.m - displays the face and the selected names
    % test_ID.mat - contains data collected by the task
    % NS - faces for the Neutral/Sad option
    % NF - faces for the Neutral/Fearful option
    % HS - faces for the Happy/Sad option
    % FemaleNames.txt - List of female names from which name is randomly 
        % selected
    % MaleNames.txt - List of male names from which name is randomly 
        % selected

%Example use
    % subID = '1234'
    % repetitions = 20;
    % ISI = 1.25;
    % prob = 1.0;
    % emotion = 'NS'
    % task1(subID, repetitions, ISI, prob, emotion);
    