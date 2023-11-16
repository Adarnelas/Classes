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
bode(ew) % I do not know what is wrong with this so I really don't know how to fix it. I have looked up stuff online and it was not much help. 

% I hadn't touched this until yesterday since I took the weekend off for myself. I
% just had a lot to deal with during the previous week that getting to this
% wasn't a big priority. I think if I  had started it on the weekend I
% would've been able to get further and probably finish it. But I really don't want to frustrate
% myslef with this so I am just gonna leave it as is.












