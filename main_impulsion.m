clc,clear;

d0 = 1;
d1 = 100;

trellis = poly2trellis(2,[3 2],3);  %code convolutif systématique
%  trellis = poly2trellis(3,[7 5],7);
% trellis = poly2trellis(4,[15 13],15);
% trellis = poly2trellis(7,[171 133],171); 

s_i = 0;
closed = false;
[d,A_d] = methode_impulsion(d0,d1,trellis,s_i,closed);

EbN0dB_min  = -2; % Minimum de EbN0
EbN0dB_max  = 10; % Maximum de EbN0
EbN0dB_step = 1;  % Pas de EbN0
EbN0dB  = EbN0dB_min:EbN0dB_step:EbN0dB_max;     %Points de EbN0 en dB à simuler
EbN0    = 10.^(EbN0dB/10);    % Points de EbN0 à simuler

memory = log2(trellis.numStates);
output_bits = log2(trellis.numOutputSymbols);


K = 1024; % Nombre de bits de message

if (closed)
    N = K*log2(trellis.numOutputSymbols)+memory*output_bits;
else
    N = K*log2(trellis.numOutputSymbols); % Nombre de bits codés par trame (codée)
end

R = K/N; % Rendement du code

TEP = zeros(1,length(EbN0dB));
for i=1:length(EbN0dB)
    s=0;
    for j=1:length(A_d)
        s=s+1/2 * A_d(j)*erfc(sqrt(d(j)*R*EbN0(i)));
    end
    TEP(i)=s;
end
        
figure(1)
semilogy(EbN0dB,TEP,'LineWidth',1.5,'XDataSource','EbN0dB', 'YDataSource','TEP', 'DisplayName','TEP methode impulsion');
xlabel('Eb/N0');
ylabel('TEP');
title('TEP avec la méthode de l impulsion');
grid on;

save('structures_TEP_IMPULSION/TEP_2_3')