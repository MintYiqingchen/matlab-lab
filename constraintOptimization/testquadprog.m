opts = optimoptions('quadprog',...
    'Algorithm','active-set','Display','iter');

[x fval eflag output lambda] = quadprog(G,h,-Agt,-bgt,[],[],[],[],[],opts)