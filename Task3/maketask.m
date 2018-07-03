function [task, faces] = maketask(engagedisengage, startingemotion, nextemotion, cogoremo, easyorhard, siderange, faces, allfaces)
%% -------- DESCRIPTION --------
% Function randomizes on which side the first face will appear, randomizes
% the shape, selects faces and displays the faces, and eliminate all used
% faces.

%% -------- FUNCTION --------
 t.engagedisengage = engagedisengage;
 t.startingemotion = startingemotion;
 t.nextemotion = nextemotion;
 t.cogoremo = cogoremo;
 t.easyorhard = easyorhard;
     if length(faces) < 6
        faces = allfaces;
     end
% Randomize which side the first face is on
     tmp = randi(2);
     if tmp == 1
         t.startside = 'R';
     elseif tmp == 2
         t.startside = 'L';
     end
    % Randomize which side the right answer is on
     tmp = randi(2);
     if tmp == 1
         t.answerside = 'R';
     elseif tmp == 2
         t.answerside = 'L';
     end
    % Randomize number of sides on shape
     tmp = randi(2);
     if siderange == '3-4'
         if tmp == 1
             t.numsides = 3;
         elseif tmp == 2
             t.numsides = 4;
         end
     elseif siderange == '5-6'
         if tmp == 1
             t.numsides = 5;
         elseif tmp == 2
             t.numsides = 6;
         end
     end
    % Gets first face
    if startingemotion == 'H'
        idx = randi(length(faces) / 3);
        idx = (idx * 3) - 2;
        t.firstface = faces{idx};
        faces{idx} = ''; % Eliminates the used face
        faces{idx + 1} = '';
        faces{idx + 2} = '';
        faces(cellfun('isempty',faces)) = []; % Clears out used faces
    elseif startingemotion == 'N'
            idx = randi(length(faces)/ 3);
            idx = (idx * 3) - 1;
            t.firstface = faces{idx};
            faces{idx} = ''; % Eliminates the used face
            faces{idx - 1} = '';
            faces{idx + 1} = '';
            faces(cellfun('isempty',faces)) = []; % Clears out used faces
    elseif startingemotion == 'S'
        idx = randi(length(faces)/ 3);
        idx = (idx * 3);
        t.firstface = faces{idx};
        faces{idx} = ''; % Eliminates the used face
        faces{idx - 1} = '';
        faces{idx - 2} = '';
        faces(cellfun('isempty',faces)) = []; % Clears out used faces
    end
% Gets second face
    if nextemotion == 'H'
        idx = randi(length(faces) / 3);
        idx = (idx * 3) - 2;
        t.secondface = faces{idx};
        faces{idx} = ''; % Eliminates the used face
        faces{idx + 1} = '';
        faces{idx + 2} = '';
        faces(cellfun('isempty',faces)) = []; % Clears out used faces    
    elseif nextemotion == 'N'   
        idx = randi(length(faces)/ 3);
        idx = (idx * 3) - 1;
        t.secondface = faces{idx};
        faces{idx} = ''; % Eliminates the used face
        faces{idx + 1} = '';
        faces{idx - 1} = '';
        faces(cellfun('isempty',faces)) = []; % Clears out used faces     
    elseif nextemotion == 'S'   
        idx = randi(length(faces)/ 3);
        idx = (idx * 3);
        t.secondface = faces{idx};
        faces{idx} = ''; % Eliminates the used face
        faces{idx - 1} = '';
        faces{idx - 2} = '';
        faces(cellfun('isempty',faces)) = []; % Clears out used faces
    end  
    if t.cogoremo == 'Cognitive'  
        if t.easyorhard == 'Easy'
        % Chooses number of sides for wrong answer choice
            x = t.numsides;
            while x == t.numsides || x < 3
                x = randi(4);
            end
        % Assuming left = first and right = second
            if t.answerside == 'L'
                t.firstchoice = t.numsides;
                t.secondchoice = x;
            elseif t.answerside == 'R'
                t.firstchoice = x;
                t.secondchoice = t.numsides;                
            end         
        elseif t.easyorhard == 'Hard'          
            t.firstchoice = 'Even';
            t.secondchoice = 'Odd';         
            if t.numsides == 4 || t.numsides == 6
                t.answerside = 'L';
            elseif t.numsides == 3 || t.numsides == 5
                t.answerside = 'R';
            end
        end      
    elseif t.cogoremo == 'Emotional'
        if t.easyorhard == 'Easy'
        % Chooses random face for wrong answer choice
            idx = randi(length(allfaces) / 3);
            if t.answerside == 'L'
                t.firstchoice = t.secondface;
                if t.nextemotion == 'H'
                    t.secondchoice = allfaces{(idx * 3) - 2};
                elseif t.nextemotion == 'S'
                    t.secondchoice = allfaces{idx * 3};
                elseif t.nextemotion == 'N'
                    t.secondchoice = allfaces{(idx * 3) - 1};
                end          
            elseif t.answerside == 'R'
                if t.nextemotion == 'H'
                    t.firstchoice = allfaces{idx * 3 - 2};
                elseif t.nextemotion == 'S'
                    t.firstchoice = allfaces{idx * 3};
                elseif t.nextemotion == 'N'
                    t.firstchoice = allfaces{idx * 3 - 1};
                end 
                t.secondchoice = t.secondface;                
            end    
        elseif t.easyorhard == 'Hard'
           idx = randi(length(allfaces) / 3);
           idx2 = randi(2);
           if t.nextemotion == 'H'
                correct = allfaces{idx * 3 - 2};
                incorrect = allfaces{idx * 3 - 2 + idx2};
            elseif t.nextemotion == 'S'
                correct = allfaces{idx * 3};
                incorrect = allfaces{idx * 3 - idx2};
            elseif t.nextemotion == 'N'
                correct = allfaces{idx * 3 - 1};
                if idx2 == 1     
                    incorrect = allfaces{idx * 3 - 1 + 1};
                elseif idx2 == 2
                    incorrect = allfaces{idx * 3 - 1 - 1};
                end
           end
           if t.answerside == 'L'
               t.firstchoice = correct;
               t.secondchoice = incorrect;
           elseif t.answerside == 'R'
               t.firstchoice = incorrect;
               t.secondchoice = correct;
           end
        end 
    end
    task = t;
end
