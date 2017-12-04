
people_len = 1000000;
moves_len = 100;
p = 0.5;

moves = rand(people_len, moves_len);
% Converts the doulbe to either 0 or 1.
% Since p is 0.5, no further adjustment is needed
moves = round(moves);

people_moves = sum(moves');

histogram(people_moves);
print('moves.png', '-dpng')

mean = p * moves_len;
variance = p * moves_len * (1 - p);
