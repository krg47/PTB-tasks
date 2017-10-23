function key=analyze(responsetime, i, neutralreps)
if i<2 %start neutral to get initial reaction times
    key='N'
end
if i>1
    if (responsetime(i) - responsetime(i-1))>0
        key = 'H' %goes to happy
    end
    if (responsetime(i) - responsetime(i-1))<0
        key = 'S' %goes to sad
    end
    if (responsetime(i) - responsetime(i-1))==0  %what to do if equal?
        key = 'N' %goes to neutral
    end
end

    