function [location] = Search_ShortJob(a, d, n, tag, tmax)
% find the shortest job in the queue
% [l1, l2] = Search_ShortJob(d, n, a)
% inputs:   a is the arrive timed is the depart time 
%           d is the depart time of the job
%           n is the last processed job number
%           tag is the tag of having been processed of the job
%           tmax is the sampling number
%
% outputs:  location is the shortest job in the queue
%
% GUO Qiang 19/01/2016

minvalue = a(n);     %default next job
minlocation = n;


for i = n:tmax
    if(a(i) < d(n-1))
        continue
    else 
        for j = 1:i-1
            if((a(j) < minvalue)&&(tag(j) ~= 1))
                minvalue = a(j);
                minlocation = j;
                break;
            end
        end
        break;
    end
end

location = minlocation;