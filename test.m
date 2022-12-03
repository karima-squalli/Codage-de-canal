%% Introduction to the workspace
clear;
clc;
close all;


%% Signal processing

trellis = poly2trellis(2,[2 3]);
% trellis = poly2trellis(3,[5 7]);
% trellis = poly2trellis(4,[13 15]);
% trellis = poly2trellis(7,[133 171]); 
% trellis = poly2trellis(7,[171 133],171); % Code systématique

memory = log2(trellis.numStates);
bit_streams = log2(trellis.numOutputSymbols);

distancespec = distspec(trellis);

distance_minimale = distancespec.dfree;
s_i = 1;
closed = true;

K = 2048; % Nombre de bits de message
if (closed)
    N = K*log2(trellis.numOutputSymbols)+memory*bit_streams;
else
    N = K*log2(trellis.numOutputSymbols); % Nombre de bits codés par trame (codée)
end

R = K/N; % Rendement de la communication

u = randi([0,1],K,1);

[c, s_f] = cc_encode(u, trellis, 0, closed);

rendement = length(u)/length(c);
y = 1-2*c;
v = viterbi_decode(y, trellis, 0, closed);

correct = 0;
if isequal(u,v') && rendement == R
    correct = 1;
end

error = 0;
for ii=1:length(u)
    if u(ii) ~=v(ii)
        error = error +1;
    end
end

error
correct