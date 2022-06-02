% Autor: Caio Mateus M. Cardoso 31/05/2022
% cuckoo_search 1.0v

% Regras:
% 1 - Cada cuco deposita apenas um ovo por vez em um ninho selecionado de
% forma aleatória.
%   - Cada ovo representa uma solução e é armazenado em um ninho
% 2 - Os melhores ninhos com ovos de qualidade seguirão para a próxima
% geração.
%   - Ovos de qualidade são as melhores soluções, soluções ótimas.
% 3 - O número de ninhos hospedeiros é fixo, os hospedeiros podem
% descobrir os ovos cuco com uma probabilidade no intervalo (0,1).
%   - Número de ninhos = População
% 4 - O pássaro hospedeiro pode jogar fora o ovo cuco ou abandonar o ninho
% e criar um novo.
%   - Ovo descoberto = Solução ruim, longe do ótimo.

clc, clear, close all
addpath Utils
rng(2);
% ---------- Define espaço de busca do problema

max_x = 3;
min_x = -3;

% ---------- Inicialização dos Parâmetros da Busca Cuco

dimensoes = 2;           % Número de dimensões do problema 
numeroNinhos = 1000;     % quantidade de Ninhos hospedeiros
discProbability = 0.2;   %probabilidade de descoberta de um ovo cuco
epocas = 20;          % Número total de iterações

% ---------- Inicialização dos Ninhos (População)

ninhos = initNinhos(numeroNinhos,dimensoes); % Restrições População inicial:
                                             % sum(populacao) == 1
                                             % 0 <= população(1,1) <= 1                                             
ninhos = sortrows(ninhos,dimensoes+1,'descend');

tamanhoNinhos = [numeroNinhos, dimensoes];                                                   
                                                   
% ---------- Levy Flight Parameters

alpha=0.5; %1.0
beta=1.5; % beta = 3/2

sigma=(gamma(1.0+beta)*sin(pi*beta/2.0)/(gamma((1.0+beta)/2.0)* ...
       beta*2.0^((beta-1.0)/2.0)))^(1.0/beta);

   
u=sigma*randn(tamanhoNinhos);

v = randn(tamanhoNinhos);

% ---------- Cálculo do Step size
stepSize = sigma .* u ./ (abs(v) .^ (1/beta)); 

bestNinho = ninhos(1,:);
bestFitness = bestNinho(1,dimensoes+1);
disp(bestFitness)

x = min_x:0.1:max_x;
y = x;
[X,Y] = meshgrid(x);
z = 3 * ( 1 - (X.^2) ) .* exp( -( X.^2 ) - ( ( Y + 1 ).^2 ) ) ...
- exp( - ( X + 1 ).^2 - ( Y.^2 )) ./ 3 ...
- 10 .* ( ( X ./ 5 ) - X.^3 - Y.^5 ) .* exp( -( X.^2 ) - (Y.^2) );

figure
for e=1:epocas
    
    surf(X,Y,z);
    hold on
    plot3(bestNinho(1),bestNinho(2),bestNinho(3),'or','MarkerSize',5,'LineWidth',3,'MarkerFaceColor','#FF0000');
    grid on
    box on
    
    drawnow
    % ---------- Atualização dos Ninhos
    ninhos_atualizado = ninhos(:,1:dimensoes) + alpha * stepSize .* ( ninhos(:,1:dimensoes) - bestNinho(:,1:dimensoes) );
    
    for n = 1:numeroNinhos
        
        for d=1:dimensoes
          while (  ninhos_atualizado(n,d) > max_x || ninhos_atualizado(n,d) < min_x ) 
            ninhos_atualizado(n,d) = ninhos(n,d) + alpha*randn(1)*( sigma*randn(1) )/abs(randn(1))^(1.0/beta);
          end
        end
        
        ninhos_atualizado(n,dimensoes+1) = fitness(ninhos_atualizado(n,1:dimensoes));

    % ---------- Substiuição de ovos    
        if ninhos_atualizado(n,dimensoes+1) > ninhos(n,dimensoes+1)
            ninhos(n,:) = ninhos_atualizado(n,:);
        end
    end

    % ---------- Verifica se o ovo cuco foi descoberto
    if discProbability > rand
        % ---------- Se ovo descoberto, abandonar o ninho e criar um novo
        ninhoAleatorio = randi([1,numeroNinhos]);
        
        % ---------- Adicionar elitismo
        if ninhoAleatorio == 1
            while ninhoAleatorio == 1
                ninhoAleatorio = randi([1,numeroNinhos]);
            end
        end
        ninhos(ninhoAleatorio,:) = initNinhos(1,dimensoes);
    end
    
    % ---------- Organiza os ninhos de acordo com a melhor Fitness
    ninhos = sortrows(ninhos,dimensoes+1,'descend');
    bestNinho = ninhos(1,:);
    bestFitness = bestNinho(1,dimensoes+1);

    disp(bestFitness)
    
end
