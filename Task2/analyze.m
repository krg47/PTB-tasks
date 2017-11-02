function key=analyze(responsetime, i, neutralreps, totalResponseTime)
avgResponseTime= sum(totalResponseTime)/i;
if i<(neutralreps+1) %start neutral to get initial reaction times
    key='N'
end
if i>1
    if (totalResponseTime(i) - avgResponseTime)>0
        key = 'H' %goes to happy
    end
    if (totalResponseTime(i) - avgResponseTime)<0
        key = 'S' %goes to sad
    end
    if (totalResponseTime(i) - avgResponseTime)==0  %what to do if equal?
        key = 'N' %goes to neutral
    end
end

