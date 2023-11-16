HW 3
clear; clc; clf;
% Q1-Q3
ao = 0.1
bo = ao
d = 6;
num = [bo];
den = [1 ao];
eh = tf(num,den,'InputDelay',d)
beh = tf(num,den)
[NUM DEN] = pade(6,2)

sure = tf(NUM,DEN)
ehbeh = sure*beh

figure(1);
hold on;
bode(eh)
grid on;
title('With delay')
hold off;

figure(2);
hold on;
bode(beh)
grid on;
title('Without delay')
hold off;



figure(3);
rlocus(ehbeh)
%grid on;


%% Q4
clear; clc;

ao = 0.1
bo = ao
d = 6;
Ku = 3.26;
wu = 0.316;
Tu = 1/0.3;
a = 0.6;
b = 0.5;
c = 0.125;

% Q4a

Kp = a*Ku
Ti = b*Tu
Td = c*Tu

num = [bo];
den = [1 ao];
beh = tf(num,den)
[NUM DEN] = pade(6,2)

sure = tf(NUM,DEN)
ehbeh = sure*beh

num = [Kp*Td Kp Kp/Ti]
den = [1 0]
Ds = tf(num,den)
ew = Ds*ehbeh

figure(4);
bode(ew) 
grid on;

% Q4b

num = [0.0815 0.1141 -0.05108 -0.05216 0.03912]
den = [1 1.1 0.4333 0.0333 0]
recon = tf(num,den)
figure(5)
stepplot(recon) %stuck again idk what to do
grid on


% This part below still stands. I really don't think that I can finsih it
% and get a full and proper answer to all of it.

% I hadn't touched this until yesterday since I took the weekend off for myself. I
% just had a lot to deal with during the previous week that getting to this
% wasn't a big priority. I think if I  had started it on the weekend I
% would've been able to get further and probably finish it. But I really don't want to frustrate
% myslef with this so I am just gonna leave it as is.











