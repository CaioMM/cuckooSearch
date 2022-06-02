function ninhos = initNinhos(numeroNinhos,dimensoes)
    % Autor: Caio Mateus M. Cardoso 31/05/2022
    % Função: initPopulação1.0v
    % Descrição: Inicial a população inicial para o algoritmo cucko search
    % Parâmetros:
    %   numeroNinhos = Número total de ninhos a serem considerados
    %   dimensoes = Número de dimensões do problema
    
    ninhos = rand(numeroNinhos,dimensoes+1);
    
    for n = 1:numeroNinhos
        ninhos(n, dimensoes+1) = fitness(ninhos(n,1:dimensoes));
    end
end