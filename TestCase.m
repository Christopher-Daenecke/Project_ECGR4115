%Test case
%Names: Christopher Daenecke and Enrique Ramirez

R = 100; %some constant to be determined later, for now 100 seems to be fine

%test case
Players = ["P1", "P2", "P3", "P4", "P5", "P6", "P7", "P8", "P9", "P10"]
prob = [0.4, 0.55, 0.5, 0.45, 0.6, 0.43, 0.3, 0.6, 0.24, 0.54]; %these are just test values
Odds = [2.5, 3.0, 2.0, 4.0, 1.8, 3.3, 2.1, 1.3, 2.1, 1.5];  %these are just test values
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

maximize(objective)

subject to

sum(x) <= 1000;
(1-p).*x <= R;
x >= 0;
cvx_end

fprintf("Bet made on each player:\n")
for i = 1:N
    fprintf("%d. %s: $%.2f\n", i, Players{bets(i)}, x(i))
end

fprintf("Expected Profit: $%.2f\n",cvx_optval)
