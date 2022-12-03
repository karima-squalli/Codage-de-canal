close all
clear
clc;

load ('structures_MONTECARLO/MC_2_3');  %structure dont un des éléments est le TEB du code systématique[2 3]
semilogy(EbN0dB,Pb_u,'--', 'LineWidth',1.5,'DisplayName','$P_b$ (BPSK th\''eorique)');
hold all
semilogy(EbN0dB,TEB,'LineWidth',1.5, 'DisplayName','TEB MC cod\''ee (2,3)'  );

load ('structures_MONTECARLO/MC_5_7');   %structure dont un des éléments est le TEB du code [5 7]
semilogy(EbN0dB,TEB,'LineWidth',1.5, 'DisplayName','TEB MC cod\''ee (5,7)'  );
 
load ('structures_MONTECARLO/MC_13_15'); %structure dont un des éléments est le TEB du code [13 15]
semilogy(EbN0dB,TEB,'LineWidth',1.5, 'DisplayName','TEB MC cod\''ee (13,15)'  );

load ('structures_MONTECARLO/MC_133_171') %structure dont un des éléments est le TEB du code [133 171]
semilogy(EbN0dB,TEB,'LineWidth',1.5, 'DisplayName','TEB MC cod\''ee (133,171)'  );


ylim([1e-6 1])
xlim([-2 15])
grid on
xlabel('$\frac{E_b}{N_0}$ en dB','Interpreter', 'latex', 'FontSize',14)
ylabel('TEB','Interpreter', 'latex', 'FontSize',14)
legend('Interpreter', 'latex', 'FontSize',14);
title('Représentation des TEB de chacun des codes étudiés');