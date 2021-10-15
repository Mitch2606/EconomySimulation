
currentStockPrice = 0.68;

Pp = 31;
% Pop = 10.25;
Pop = [0:0.01:50];

Pc = 10;
Poc = 10.7;
% Poc = [0:0.01:50];

Cpp = 7;
Cpc = Cpp;

ratioCP = (Cpp * Cpc) / (Cpp + Cpc);

profit1 = ratioCP * ((Pp - Pc) - (Poc + Pop)) * 100;

profit2 = ratioCP * ((Pp - Pc) - (Poc + Pop)) * 100;

if(size(Pop, 2) > 1)
    figure
    plot(Pop(profit1 >= -1), profit1(profit1 >= -1)')
    hold on
    plot(Pop(profit1 >= -1), zeros(size(profit1(profit1 >= -1)')), "color", "black")

    leg = legend(string(Pp));
    title(leg, "Call Amount")

    xlabel("Price of Put Contract")
    ylabel("Profit")
    xticks(Pop(profit1 >= -1))
    grid on
else
    figure
    plot(Poc(profit1 >= -1), profit1(profit1 >= -1)')
    hold on
    plot(Poc(profit1 >= -1), zeros(size(profit1(profit1 >= -1)')), "color", "black")

    leg = legend(string(Pp));
    title(leg, "Put Amount")

    xlabel("Price of Call Contract")
    ylabel("Profit")
    xticks(Poc(profit1 >= -1))
    grid on
end


