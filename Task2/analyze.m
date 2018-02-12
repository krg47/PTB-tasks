function [key, delta] = analyze(responsetime, j, repetitions, k, baseline, reverse)

delta = 0;
starti = (j - 1) * repetitions * 7; %I think we need the +1 here since matlab starts at 1 but im not positive
endi = starti + (7 * repetitions);
totaltime = sum(responsetime(starti : endi));

if j >= 3 %After third block, compare to initial baseline
    
    
    diff = (totaltime - baseline);
    perc = (diff / baseline) * 100;
    if reverse==true
        delta = -2* (floor(perc / 5));
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
    
    if reverse==false
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
    
    
   
    
else %Otherwise, compare to previous block
    
    
    starti = (j - 2) * repetitions * 7;
    endi = starti + 7 * repetitions;
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

timeKey=(totaltime-baseline)
