function [key, delta] = analyze(responsetime, j,repetitions,k, baseline, reverse,sequencelength)
%% -------- DESCRIPTION --------
% Function calculates the percent change in valence based
% on the response time and impliments the appropriate change in emotion.

%% -------- FUNCTION --------
delta = 0;
starti = (j - 1) * repetitions * sequencelength;
endi = starti + (sequencelength * repetitions);
totaltime = sum(responsetime(starti : endi));

if j >= 3 % After third block, compare to initial baseline
    
    diff = (totaltime - baseline);
    perc = (diff / baseline) * 100;
    if reverse == true
        delta = -2 * (floor(perc / 5));
        if totaltime < baseline
            key = 'S';
        end
        if totaltime > baseline
            key = 'H';
        end
        if totaltime == baseline
            key = 'N';
        end
    end
    
    if reverse == false
        delta = 2* (floor(perc / 5));
        if totaltime < baseline
            key = 'H';
        end
        if totaltime > baseline
            key = 'S';
        end
        if totaltime == baseline
            key = 'N';
        end
    end
    
else % Otherwise, compare to previous block
       
    starti = (j - 2) * repetitions * sequencelength;
    endi = starti + sequencelength * repetitions;
    baseline = sum(responsetime(starti : endi));
    
    diff = floor(totaltime - baseline);
    perc = (diff / baseline) * 100;
    delta = 2 * floor(perc / 5);
    
    if totaltime < baseline
        key = 'S';
    end
    if totaltime > baseline
        key = 'H';
    end
    if totaltime == baseline
        key = 'N';
    end
end

timeKey = (totaltime-baseline); %#ok