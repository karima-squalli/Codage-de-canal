function [d,A_d] = methode_impulsion(d0,d1,trellis,s_i,closed)
%METHODE_IMPULSION implémente de l'algorithme de la méthode de l'impulsion. 
% Cette fonction prend en entrée 5 arguments: 
%-treillis, s_i(état initial), booléen closed qui caractérisent notre
%encodeur.
%-d0 le pas avec lequel on augmente l'impulsion.
%-d1 valeur maximale de l'impulsion.

K = 1024;
memory = log2(trellis.numStates);   %mémoire du code convolutif 
output_bits = log2(trellis.numOutputSymbols);  % nombre de bits codés en sortie 

if (closed)
    N = K*output_bits+memory*output_bits;
else
    N = K*output_bits; % Nombre de bits codés par trame (codée)
end

v = zeros(1,K);
x_u = zeros(1,K);
y = ones(1,N);

for l=1:K
    A = d0 - 0.5;
    x = x_u;
    while ( isequal(x,x_u) && (A<=d1))
        A = A+1;
        y(2*(l-1) + 1) = 1-A;   % mise à jour des bits systématiques (qui sont d'indice impair) de y
        x=viterbi_decode(y,trellis, s_i, closed);
        
    end
    v(l) = floor(A);
        
end

A_d=unique(v);   %vecteur de l'ensemble des entiers contenus dans v
d=hist(v,A_d);   %vecteur d'occurences de ces entiers dans v



end

