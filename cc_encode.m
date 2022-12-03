function [c, s_f] = cc_encode(u, trellis, s_i, closed)

%CC_ENCODE possède 4 arguments en entrée :
% — u : un vecteur de K symboles d’entrées.
% — trellis : une structure représentant le treillis.
% — s_i : un état initial.
% — closed : un booléen indiquant si le treillis doit être fermé ou pas.
% Cette fonction renvoie 2 arguments en sortie :
% — c : le mot de code.
% — s_f : l’état final de l’encodeur.
% Elle prend en compte la fermeture du treillis avec le booléen closed

numStates = trellis.numStates;                  % nombre d'états du code
nextStates = trellis.nextStates;                % tableau des états suivants à partir des états courants et des symboles en entrée
numOutputSymbols = trellis.numOutputSymbols;    %nombre de symboles en sortie
outputs = trellis.outputs;                      %tableau des sorties à partir des états courants et des symboles en entrée

memory = log2(numStates);   % mémoire du code convolutif
N = log2(numOutputSymbols); % nombre de bits codés en sortie

c = zeros(1,length(u));

for ii=1:length(u)
    c(ii) = outputs(s_i+1,u(ii)+1);
    s_i = nextStates(s_i+1, u(ii)+1); % état suivant
end

if closed
    size = length(c);
    c = [c zeros(1,memory)]; % si le treillis est fermé, on ajoute à c un nombre de bits égal à la mémoire du code
    for jj=1:memory
        s_i = floor(s_i/2);  % l'état suivant permet de remonter le treillis à l'état 0
        c(jj+size) = outputs(s_i+1,1);
    end
end

s_f = s_i;
d = de2bi(c, 'left-msb',N);
c = reshape(d', 1, []);
end

