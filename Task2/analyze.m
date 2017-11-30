function key=analyze(responsetime, j, repetitions, k, baseline)

starti = (j - 1) * repetitions * 7; %I think we need the +1 here since matlab starts at 1 but im not positive
endi = starti + (7 * repetitions);
totaltime = sum(responsetime(starti : endi))

if j == 3 %After third block, compare to initial baseline
    
    if totaltime < baseline
        key = 'S';
    end
    if totaltime > baseline
        key = 'H';
    end
    if totaltime == baseline
        key = 'N';
    end
    
else %Otherwise, compare to previous block
    
    starti = (j - 2) * repetitions * 7;
    endi = starti + 7 * repetitions;
    baseline = sum(responsetime(starti : endi));
    
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
