% Task 1

% Design:

    % To launch the task, click "Run" in task1.m or call the function "task1" as in the example below. 
    % Press the "=" key to start the experiment, as prompted.
    % A face will appear, and two randomly selected names will appear underneath the face.
        % Names are pulled from a list.
    % The participant will select which name they think matches the face by 
    % clicking the left or right arrow key.
        % The left arrow key corresponds to the left name and the right key
        % arrow key corresponds to the right name.
        % NOTE: There is no correct answer; the names that appear underneath each face are random.
    % When a key is selected, the face and names will disappear. After a short Interstimulus Interval, another
    % face and two more names will appear.
        % The Interstimulus Interval (ISI) is the time between the disappearance
        % of one face and the appearance of another.
    % Depending on what key was selected, the next face that appears should
    % have a certain valence (e.g., more sad, fearful, happy, etc.).
        % The valence is the emotion of the face.
    % For example, the left key may produce a neutral face while the
    % right key produces a sad face. The side that produces this effect is
    % random and is switched half-way through. 
        % There is a bias that can control the likelihood that this will
        % occur. This is encoded by Probability of Bias parameter. For
        % example, if you set this parameter to 0.8 then 80% of the time
        % when you click the left arrow it will be sad. 
    % The pairs of valence can be changed in the pop up before the task. 
    % The three options for valence pairs are:
        % Neutral to Sad (NS)
        % Neutral to Fearful (NF)
        % Happy to Sad (HS)
    % The program records the following data from the task in a file titled "<test_ID>.mat":
        % Image numbers (i.e., which image was shown)
        % Group of image (A or B)
            % NOTE: Originally, we had two sets of images, but we
            % eliminated one set of images.
        % Sex of individual in the image
        % Valence of individual's face in the image
        % Participant's response (left or right)
        % Reaction time
        % Which side produces a more positive face

% Adjustable parameters:

    % Subject ID
    % Repetitions
    % ISI
    % Probability of bias
    % Valence (Neutral/Sad, Neutral/Fearful, or Happy/Sad)

% File/Directory Descriptions:

    % The working directory should include these files/folders:
        % README.m - This is the README. Its purpose is to guide
            % laboratories through the process of using this task.
        % task1.m - This is the main body of the program, and it calls all of the other functions.
        % userinput.m - This allows for the input of adjustable parameters.
        % experiment.m - This selects random faces, random names, and selects the next face 
            % based on the participant's keypress and the probability of bias.
        % displayface.m - This displays the faces and the names.
        % NS - This is a folder that contains the faces for the Neutral to Sad option.
        % NF - This is a folder that contains the faces for the Neutral to Fearful option.
        % HS - This is a folder that contains the faces for the Happy to Sad option.
        % FemaleNames.txt - This is a list of female names where a name is randomly selected.
        % MaleNames.txt - This is a list of male names where a name is randomly selected.

% Example Use:
    % subID = '1234'
    % repetitions = 20;
    % ISI = 1.25;
    % prob = 1.0;
    % emotion = 'NS'
    % task1(subID, repetitions, ISI, prob, emotion);
    
