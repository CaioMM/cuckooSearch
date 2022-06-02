function fit = fitness(ninho)
    % Autor: Caio Mateus M. Cardoso 31/05/2022
    % Fun��o: fitness 1.0v
    % Descri��o: Fun��o para c�lculo da fitness de um ninho espec�fico.
    % Par�metros:
    %   ninho = ninho pertencente � um conjunto de ninhos.
     X = ninho(1,1);
     Y = ninho(1,2);
     
     fit = 3 * ( 1 - (X.^2) ) .* exp( -( X.^2 ) - ( ( Y + 1 ).^2 ) ) ...
    - exp( - ( X + 1 ).^2 - ( Y.^2 )) ./ 3 ...
    - 10 .* ( ( X ./ 5 ) - X.^3 - Y.^5 ) .* exp( -( X.^2 ) - (Y.^2) );
     
end 