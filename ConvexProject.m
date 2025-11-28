
%Names: Christopher Daenecke and Enrique Ramirez

R = 100; %some constant to be determined later, for now 100 seems to be fine

%test case
Players = ["Player1", "Player2", "Player3", "Player4", "Player5"];
prob = [0.44, 0.55, 0.5, 0.45, 0.6]; %still in process of obtaining data, these are just test values
Odds = [2.5, 3.0, 2.0, 4.0, 1.8];  %still in process of obtaining data, these are just test values

%Will implement user input to choose players, we will dislay players and
%user will input who they want to bet on, then the program will optimize
%based on chosen players
N = 0;
ask = true;
bets = [];
p = [];
O = [];
while(N < 5 & ask)
    %print players
    for i = 1:length(Players)
        fprintf("%d. %s\n", i, Players{i})
    end

    fprintf("Enter the number next to the player you would like to bet on.\n")
    if(N>=1)
        fprintf("If you are done, type 0\n")
    end
    userInput = input("Enter Number: ");
    
    if(userInput == 0)
        ask = false;
        %account for repeats also
    elseif(ismember(userInput, bets))
        fprintf("Already entered this bet. Enter in a bet not already chosen\n")
    elseif(userInput > length(Players) || userInput < 0)
        fprintf("Input out of range. Try again.\n")
    else
        bets = [bets userInput]
        p = [p prob(userInput)]
        O = [O Odds(userInput)]
        N = N + 1;
    end
end

p = p(:); %make column vector
O = O(:);


cvx_begin

variable x(N) 

objective = sum(x.*(p.*O-1));
%objective = x(1)*(p(1)*O(1)-1) + x(2)*(p(2)*O(2)-1) + x(3)*(p(3)*O(3)-1) + x(4)*(p(4)*O(4)-1) + x(5)*(p(5)*O(5)-1);

maximize(objective)

subject to

sum(x) <= 1000;
(1-p).*x <= R;
x >= 0;

%{
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
%}

cvx_end
