function [subID, repetitions, ISI, ICI] = userinput

    validInput = false;
    if nargin < 10
        while ~validInput
            prompt = {'SubjectID:', 'Repetitions:', 'Inter-Stimulus Interval:', 'Inter-Question Interval'};
            dlg_title = 'Configure Task';
            num_lines = 1;

            % Default values       
            def = {'1234','5', '1.25', '2.0', 'NS'}; %Default is Neutral/sad 
            answer = inputdlg(prompt, dlg_title, num_lines, def);

            if isempty(answer), return, end;

    %          Input validation
            if str2num(answer{2}) <= 1
                uiwait(warndlg('Must have > 1 repetitions'));
            elseif isnan(str2double(answer{3}))
                uiwait(warndlg('Invalid ITI, ISI or IBI'));

            else
    %           Set values
                validInput = true;
                subID = answer{1};
                repetitions = str2num(answer{2});
                ISI = str2double(answer{3});
                ICI = str2double(answer{4});
                
            end
        end
    end
end