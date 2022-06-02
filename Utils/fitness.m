function fit = fitness(ninho)
    % Autor: Caio Mateus M. Cardoso 31/05/2022
    % Função: fitness 1.0v
    % Descrição: Função para cálculo da fitness de um ninho específico.
    % Parâmetros:
    %   ninho = ninho pertencente à um conjunto de ninhos.
     X = ninho(1,1);
     Y = ninho(1,2);
     
     fit = 3 * ( 1 - (X.^2) ) .* exp( -( X.^2 ) - ( ( Y + 1 ).^2 ) ) ...
    - exp( - ( X + 1 ).^2 - ( Y.^2 )) ./ 3 ...
    - 10 .* ( ( X ./ 5 ) - X.^3 - Y.^5 ) .* exp( -( X.^2 ) - (Y.^2) );
     
end 