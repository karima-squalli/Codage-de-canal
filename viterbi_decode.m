function u = viterbi_decode(y, trellis, s_i, closed)
%VITERBI_DECODE  possède 4 arguments en entrée :
% — y : un vecteur de ns*L observations du canal.
% — trellis : une structure représentant le treillis.
% — s_i : un état initial.
% — closed : un booléen indiquant si le treillis doit être fermé ou pas.
% Cette fonction renvoie u un vecteur de taille K représentant le mot de code.


numOutputSymbols = trellis.numOutputSymbols;
numStates = trellis.numStates;
nextStates = trellis.nextStates;
outputs = trellis.outputs; 

memory = log2(numStates);
N = log2(numOutputSymbols); 
L = length(y)/N;

u = zeros(1, L);

aux = inf; 
metrique = aux*ones(numStates, L+1);    %matrice contenant les métriques de branches
inputs_mat = aux*ones(numStates, L+1);  %matrice qui stocke dans chaque indice (i,j) la valeur de l'entrée menant à l'état actuel (i,j)
chemin_mat = aux*ones(numStates, L+1);  %matrice qui stocke les états précédents correspondants aux métriques
metrique(1+s_i,1) = 0;

for jj=1:L
    for ii=1:numStates
        if metrique(ii,jj) < aux 
            for kk=1:size(outputs,2)
                k = nextStates(ii, kk);
                l = outputs(ii,kk);    
                
                output = de2bi(l,'left-msb',N)';  
                metrique_etatcourant = metrique(k+1,jj+1);
                metrique(k+1,jj+1) = min(metrique(k+1,jj+1),metrique(ii,jj)+ y(1+N*(jj-1):N*jj)*output); % définition de la métrique en chaque fois
                if metrique_etatcourant ~= metrique(k+1,jj+1) % si la métrique à un état change, le chemin et l'entrée doivent être mis à jour
                    chemin_mat(k+1,jj+1) = ii;
                    inputs_mat(k+1,jj+1) = kk-1;
                end
            end
        end
    end
end

[~,i] = min(metrique(:,L+1));

for ii=1:L
    u(L-ii+1) = inputs_mat(i,L+2-ii);
    i = chemin_mat(i,L+2-ii);  % état précédent
end

if (closed)
    u = u(1:length(u)-memory); % si le treillis est fermé, on supprime les bits ajoutés à l'encodage
end

end

