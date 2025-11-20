
%Names: Christopher Daenecke and Enrique Ramirez

R = 100; %some constant to be determined later, for now 100 seems to be fine

%test case
p = [0.4, 0.55, 0.5, 0.45, 0.6]; %still in process of obtaining data, these are just test values
O = [2.5, 3.0, 2.0, 4.0, 1.8];  %still in process of obtaining data, these are just test values

%Will implement user input to choose players, we will dislay players and
%user will input who they want to bet on, then the program will optimize
%based on chosen players

cvx_begin

variable x(5) 

objective = x(1)*(p(1)*O(1)-1) + x(2)*(p(2)*O(2)-1) + x(3)*(p(3)*O(3)-1) + x(4)*(p(4)*O(4)-1) + x(5)*(p(5)*O(5)-1);

maximize(objective)

subject to

x(1) + x(2) + x(3) + x(4) + x(5) <= 1000;
(1-p(1))*x(1) <= R;
(1-p(2))*x(2) <= R;
(1-p(3))*x(3) <= R;
(1-p(4))*x(4) <= R;
(1-p(5))*x(5) <= R;
x(1) >= 0;
x(2) >= 0;
x(3) >= 0;
x(4) >= 0;
x(5) >= 0;


cvx_end