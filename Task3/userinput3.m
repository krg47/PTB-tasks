function [subID, repetitions, ISI, ICI] = userinput3
%% -------- DESCRIPTION --------
% Function generates a pop up of parameters that may be changed per
% experimentalist.

%% -------- OUTPUTS --------
% Outputs subID, repetitions, ISI, prob, and emotion associated with
% experimentalist. 

%% -------- FUNCTION --------
validInput = false;
    if nargin < 10
        while ~validInput
            prompt = {'SubjectID:', 'Repetitions:', 'Inter-Stimulus Interval:', 'Inter-Question Interval'};
            dlg_title = 'Configure Task';
            num_lines = 1;
            % Default values       
            def = {'1234','5', '1.25', '0.5', 'NS'}; %Default is Neutral/sad 
            answer = inputdlg(prompt, dlg_title, num_lines, def);
            if isempty(answer), return, end;
            % Input validation
            if str2num(answer{2}) <= 1 %#ok
                uiwait(warndlg('Must have > 1 repetitions')); 
            elseif isnan(str2double(answer{3}))
                uiwait(warndlg('Invalid ITI, ISI or IBI'));
            else
            % Set values
                validInput = true;
                subID = answer{1};
                repetitions = str2num(answer{2}); %#ok
                ISI = str2double(answer{3});
                ICI = str2double(answer{4});   
            end
        end
    end
end