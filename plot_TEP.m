clc,clear,close all;

load ('structures_TEP_IMPULSION/TEP_2_3');  %structure dont un des éléments est le TEP du code systématique[2 3] de la méthode d'impulsion
semilogy(EbN0dB,TEP,'LineWidth',1.5, 'DisplayName','TEP IMP cod\''ee (2,3)'  );

hold all

load ('structures_MONTECARLO/MC_2_3');  %structure dont un des éléments est le TEP du code systématique[2 3] codé par le prof
semilogy(EbN0dB,TEP,'*-','LineWidth',1.5, 'DisplayName','TEP MC cod\''ee (2,3)'  );


load ('structures_TEP_IMPULSION/TEP_5_7');  %structure dont un des éléments est le TEP du code [5 7] de la méthode IMP
semilogy(EbN0dB,TEP,'LineWidth',1.5, 'DisplayName','TEP IMP cod\''ee (5,7)'  );
 
load ('structures_MONTECARLO/MC_5_7');  %structure dont un des éléments est le TEP du code systématique[5 7] codé par le prof
semilogy(EbN0dB,TEP,'*-','LineWidth',1.5, 'DisplayName','TEP MC cod\''ee (5,7)'  );

load ('structures_TEP_IMPULSION/TEP_13_15'); %structure dont un des éléments est le TEB du code [13 15] de la méthode IMP
semilogy(EbN0dB,TEP,'LineWidth',1.5, 'DisplayName','TEP IMP cod\''ee (13,15)'  );

load ('structures_MONTECARLO/MC_13_15');  %structure dont un des éléments est le TEP du code systématique[13 15] codé par le prof
semilogy(EbN0dB,TEP,'*-','LineWidth',1.5, 'DisplayName','TEP MC cod\''ee (13,15)'  );

load ('structures_TEP_IMPULSION/TEP_133_171'); %structure dont un des éléments est le TEB du code [133 171] de la méthode IMP
semilogy(EbN0dB,TEP,'LineWidth',1.5, 'DisplayName','TEP IMP cod\''ee (133,171)'  );

load ('structures_MONTECARLO/MC_133_171');  %structure dont un des éléments est le TEP du code systématique[133 171] codé par le prof
semilogy(EbN0dB,TEP,'*-','LineWidth',1.5, 'DisplayName','TEP MC cod\''ee (133,171)'  );


ylim([1e-6 1])
xlim([-2 15])
grid on
xlabel('$\frac{E_b}{N_0}$ en dB','Interpreter', 'latex', 'FontSize',14)
ylabel('TEB','Interpreter', 'latex', 'FontSize',14)
legend('Interpreter', 'latex', 'FontSize',14);
title('Représentation des TEP par les méthodes de l''impulsion et de Monte Carlo de chacun des codes étudiés');