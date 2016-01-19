% Network Modeling Lab     
% Try to plot E[T] by lambda

% GUO Qiang 19/01/2016
clear all; close all;

tmax = 10000;                    % total simulation arrival
t = ones(1,9);                   % average time in the system 
s = ones(1, tmax);               % serve time
for n = 1:tmax
    if (rand > 0.0200)
        s(n) = 1;
    else
        s(n) = 201;
    end
end
lambda = 0.02:0.02:0.18;

%% M/G/1/FCFS theoretical delay
ES = 0.02*201 + 0.98*1;
ES2 = 0.02*201*201 + 0.98*1*1;
EW = ES + ES2/2/ES;
for j = 1:9
    utile = 5 * lambda(j);
    t(j) = EW*utile/(1-utile)+ES;
end
figure;
plot(lambda, t, 'r');
title('Average system delay under different policies');
ylabel('Mean Delay');
xlabel('lambda');
hold on;

%% M/G/1/FCFS
for j = 1:9      % poission parameter
    utile = 5 * lambda;
    a = -log(rand(1, tmax))/lambda(j);   % arrive interval of the job
    d = zeros(1, tmax);               % serve time of the job
    d(1) = a(1) + s(1);
    for n = 2:tmax
        a(n) = a(n-1) + a(n);         % arrive time of the job
        d(n) = max(d(n-1), a(n)) + s(n);   % depart time of the job
    end
    t(j) = mean(d - a);            % mean wait time
end
plot(lambda, t, 'b');

%% M/G/1/SJF
for j = 1:9           % poission parameter
    utile = 5 * lambda;
    a = -log(rand(1, tmax))/lambda(j);   % arrive interval of the job
    d = zeros(1, tmax);               % depart time of the job
    d(1) = a(1) + s(1);
    tag = zeros(1, tmax);             % tag of the arrive job
    tag(1) = 1;     
    w = zeros(1, tmax);               % waiting time in the system
    w(1) = s(1);
    
    for n = 2:tmax
        a(n) = a(n-1) + a(n);         % arrive time of the job   
    end
    for n = 2:tmax                    % depart time of the job(in processing order)
      location = Search_ShortJob(a, d, n, tag, tmax);
      tag(location) = 1;
      d(n) = max(d(n-1), a(location)) + s(location);
      w(n) = d(n) - a(location);
    end
    t(j) = mean(w);            % mean wait time
end
plot(lambda, t, 'y');
legend('FCFS', 'Theoretical Delay', 'SJF');
hold off;

%% others


