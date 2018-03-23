 


% 2 choices under 2nd face and instructions
% 
% Always a shape around face 
% 
% Break after question -blank
% 
% Starting face on random side
% 
% Neutral to sad, sad to neutral, neut to fear, fear to neut. neut to happy happy to neutral.
% 
% 
% Match shape, even or odd, match face - same face same emotion and random different face match emotion. Match emotion - same as big face but two images of the same face with different emotions. 
% 
% 
% Random side of right answer. First face can be any emotion. If first is n, next can be anything but n. If first is not neutral, next must be neutral. If second is neutral = disengagement 
% ===
% 
% Don?t use fearful faces actually. Just sad n happy.
% 
% 
% Ask trials per conditions. There are 16 conditions. 4 spectrums x emotion vs cognitive x hard vs easy 
% 
% 
% Choice faces can be pure random. Big faces cycle through before repeating.
% 
%  
% 
% Task1 faces. Any buttons are fine. 
% White outline shape. Same shapes every time. Tilted is fine.
% 
% # of triangle + squares we show is the same as number of pent hex
% 
% 
% 
% Save everything 


% possible functions to make

%     Task2
%     
%     userinput
%     waittostart
%     a function for each task 

% list of data to save
%   subjid
%   vector for each question type

%       time
%       valence of face
%       right or wrong
%       Which shape?
% or just one vector with the question type


% Show a random face, sad, happy, or fearful

% task struct fields:
%     disengage or engage
%     starting emotion
%     starting face left or right
%     starting face
%     next emotion
%     next face
%     shape around face
%     cognitive or emotional
%     hard or easy
%     possible choices
%     right answer left/right
%     subject answer
%     time taken

% sca


% possible task combinations: each line here represents totalnumtasks / 32
% of all tasks. (H -> N = first face happy, second face neutral)
% I'm gonna make a list of tasks with all these things, and at then we'll
% randomize the order before we start the experiment


% every task has these fields:

% 3-16: polygon.m doesn't work for displaying a triangle
function task3(subID, repetitions, ISI, ICI);

[subID, repetitions, ISI, emotion]=userinputt3;
[ screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter]=waittostart;

%     repetitions = 10;
    ICI = .25;
    d = ['Faces' filesep '*.JPG'];
    d = dir(d);
    faces = {d.name};
    allfaces = {d.name};
    
    tasks = {};

    if length(faces) < 6
        faces = allfaces;
    end

% Creates all the tasks and shuffles their order
    for i = 1 : repetitions
        
        % disengage, cognitive, easy, 3-4 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Cognitive', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, cognitive, easy, 3-4 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Cognitive', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, cognitive, easy, 5-6 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Cognitive', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, cognitive, easy, 5-6 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Cognitive', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, cognitive, hard, 3-4 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Cognitive', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, cognitive, hard, 3-4 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Cognitive', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
       
        % disengage, cognitive, hard, 5-6 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Cognitive', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, cognitive, hard, 5-6 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Cognitive', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, emotional, easy, 3-4 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Emotional', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, emotional, easy, 3-4 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Emotional', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, emotional, easy, 5-6 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Emotional', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, emotional, easy, 5-6 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Emotional', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
      
        % disengage, emotional, hard, 3-4 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Emotional', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, emotional, hard, 3-4 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Emotional', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, emotional, hard, 5-6 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Emotional', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, emotional, hard, 5-6 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Emotional', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, cognitive, easy, 3-4 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Cognitive', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, cognitive, easy, 3-4 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Cognitive', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, cognitive, easy, 5-6 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Cognitive', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, cognitive, easy, 5-6 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Cognitive', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, cognitive, hard, 3-4 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Cognitive', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, cognitive, hard, 3-4 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Cognitive', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, cognitive, hard, 5-6 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Cognitive', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, cognitive, hard, 5-6 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Cognitive', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, emotional, easy, 3-4 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Emotional', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, emotional, easy, 3-4 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Emotional', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, emotional, easy, 5-6 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Emotional', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, emotional, easy, 5-6 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Emotional', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, emotional, hard, 3-4 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Emotional', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
       
        % engage, emotional, hard, 3-4 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Emotional', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, emotional, hard, 5-6 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Emotional', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, emotional, hard, 5-6 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Emotional', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];

    end
    
    
    
%   Shuffle order of tasks
    tasks = tasks(randperm(numel(tasks)));
    tasks{1}.startside = 'L';
    for i = 1 : 1
        face1display(tasks{i}, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter, ISI, ICI);
        WaitSecs(ISI);

    end
    
    KbWait;
    sca;
end

%     TODO: waittostart DONE, get user input -in progress, display first face on starting
%     side DONE, display second face on opposite side DONE, display shape around
%     second face DONE, display question DONE and answer choices below the second
%     face (do this in choicedisplay.m), record button presses for answers, wait between questions, save
%     data

%     Tom, if you want to try working on something, try to fill in the if
%     statements in choicedisplay.m, around line 80 it says Tom's stuff. I left some notes to
%     help you. To run the task, go to task3.m and hit run at the top.=
    






         
         
         
         
    
   
        
        
        
        
        


