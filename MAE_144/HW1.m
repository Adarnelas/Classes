%% HW1
%% Q1: Github Link below

% Also as a side note, I like using live script because I can read it
% better and I am able to get a better understanding, I can see that github
% doesnt like it though, so I will set up a regular script to do so
%% 
% <https://github.com/Adarnelas/>
%% Q2a

clear; clc;
a = RR_poly([1 0 -46 0 369 0 -324])  % a polynomial set up
b = RR_poly([1 0 -29 0 100])   % b polynomial set up
p1f = RR_poly([1 1]); 
p2f = RR_poly([1 3]);
p3f = RR_poly([1 6]);
f = (p1f^2)*(p2f^2)*(p3f^2)
% parts of f polynomial set up this way because it is easier to do this than to do it by hand,
% I did check up to a point by hand to do a sanity check on the full
% polynomial
[x,y,r,t] = RR_diophantine(a,b,f)

check1 = trim(a*x + b*y) - f
% following what the RR_diophantie equation does in code on it's residual
% check I set up the same to be displayed

%% Q2b

clear; clc;
a = RR_poly([1 0 -46 0 369 0 -324])
b = RR_poly([1 0 -29 0 100])
% They were set up the same as before
p1f = RR_poly([1 20]);
% now this is with f = (s+20)
f = p1f
[x,y,r,t] = RR_diophantine(a,b,f)
% same reason as 2a
check2 = trim(a*x + b*y) - f
% same reason as 2a

%% Q3

function [Dz] = AO_C2D_matched(omega,Ds,h)
num_s = RR_roots(Ds.num); % Get roots for numerator
den_s = RR_roots(Ds.den); % Get roots for denomiator
m=Ds.num.n; n=Ds.den.n;
for u = 1:m  %check for zeros = to infinity
if num_s(u) == 0
    num_s(u) = -1; 
end

end
for j = 0:m 
           b = exp(num_s(m+1-j)*h); % map for numerator 
end
for j=0:n
           a=exp(den_s(m+1-j)*h); % map for denomiator
end
Dz = RR_tf(b,a); % I know I am missing some but I ran out of time
end

% These were here so  idont have to flip between matlab and github






function [Gz]=RR_C2D_zoh(Gs,h)
        % function [Gz]=RR_C2D_zoh(Gs,h)
        % Compute (exactly) the Gz(z) corresponding to a D/A-Gs(s)-A/D cascade with timestep h.
        % TEST: bs=[1]; as=[1 2 1]; h=0.01; Gs=RR_tf(bs,as), [Gz]=RR_C2D_zoh(Gs,h)
        %       disp('Corresponding Matlab solution:'), c2d(tf(bs,as),h,'zoh')
        % Renaissance Robotics codebase, Chapter 9, https://github.com/tbewley/RR
        % Copyright 2023 by Thomas Bewley, distributed under BSD 3-Clause License.
            HATz=RR_tf([1 -1],[1 0]); HATz.h=h;
            STEPs=RR_tf(1,[1 0]);
            Gz=HATz * RR_Z(Gs*STEPs,h);
end % function RR_C2D_zoh



function [Dz]=RR_C2D_tustin(Ds,h,omegac)
        % function [Dz]=RR_C2D_tustin(Ds,h,omegac)
        % Convert Ds(s) to Dz(z) using Tustin's method.  If omegac is specified, prewarping is applied
        % such that the dynamics of Ds(s) in the vicinity of this critical frequency are mapped correctly.
        % TEST: ys=20*[1 1]; xs=[1 10]; h=0.01; Ds=RR_tf(ys,xs); omegac=sqrt(10); [Dz]=RR_C2D_tustin(Ds,h,omegac)
        %       disp('Corresponding Matlab solution:')
        %       opt = c2dOptions('Method','tustin','PrewarpFrequency',omegac); c2d(tf(ys,xs),h,opt)
        % Renaissance Robotics codebase, Chapter 9, https://github.com/tbewley/RR
        % Copyright 2023 by Thomas Bewley, distributed under BSD 3-Clause License. 
            if nargin==2, f=1; 
            else, f=2*(1-cos(omegac*h))/(omegac*h*sin(omegac*h)); end
            c=2/(f*h); m=Ds.num.n; n=Ds.den.n; b=RR_poly(0); a=b;
            fac1=RR_poly([1 1]); fac2=RR_poly([1 -1]);
            for j=0:m; b=b+Ds.num.poly(m+1-j)*c^j*fac1^(n-j)*fac2^j; end
            for j=0:n; a=a+Ds.den.poly(n+1-j)*c^j*fac1^(n-j)*fac2^j; end, Dz=RR_tf(b,a); Dz.h=h;
end % function RR_C2D_tustin