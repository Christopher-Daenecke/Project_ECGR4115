%% 
%Names: Christopher Daenecke and Enrique Ramirez

R = 100; %some constant to be determined later, for now 100 seems to be fine

%test case
load playerVectors.mat   % loads Players, Odds, prob

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

y_bets = y(bets);
Payout = 0;
MoneyLoss = 0;

for i = 1:length(x)
    if y_bets(i) == "won"
        Payout = x(i) * O(i) + Payout;
    else
        MoneyLoss = MoneyLoss + x(i);
    end
end

TotalMoneySpent = sum(x)
Payout
MoneyLoss
Profit = Payout - sum(x)
