clear

N = 20; % number of data points in each direction

xi = 2*pi/N * [0:(N-1)];

[X,Y,Z] = meshgrid(xi, xi, xi);

% space of each wavevector k, k = [l, m, n]
li = (-1/2*N+1) : (1/2 * N);
[L,M,N] = meshgrid(li, li, li);

