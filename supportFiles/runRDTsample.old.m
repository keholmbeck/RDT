clear;

%{
kmin = 0.07; kmax = 1.04;

k = linspace(0, 2*sqrt(2), 100);

E = 0.038*k.^4.*exp(-0.14.*k.^2);
E(k<kmin) = 0;
E(k>kmax) = 0;

return
%}
%{
h = 0.1;                                             % step size
t = linspace(0, 1, 100);

%{
F_xy = @(t,r) 3.*exp(-t)-0.4*r;
x = zeros(length(t),1); 
x(1) = 5;               % initial condition
x = RK4(F_xy, t, x, h);
%}

nx = 10;
ny = 10;
nz = 10;

x = linspace(-0.2,0.2, nx);
y = linspace(-0.3,0.3, ny);
z = linspace(0, 1, nz);

% x = 1:nx;
% y = 1:ny;
% z = 1:nz;

xmin = min(x(:));
xmax = max(x(:));
ymax = max(y(:));
zmin = min(z(:));

[X,Y,Z] = meshgrid(x,y,z);

rng(1028);
k       = [1;1;0] .* abs(randn);
du      = @(t,u) rdtODE(t,u,k,1);

npts= nx*ny*nz;
U   = zeros(npts, length(t));
IC  = randn(npts, 3);
PTS = [Y(:), X(:), Z(:)];

fprintf('Starting RK4 \n');
totU = zeros(npts, length(t));
siz = size(totU);

for ii = 1:npts
    U      = zeros(length(t), 4);
    U(1,:) = [IC(ii,:), k(2)];
    U      = RK4(du, t, U, h);
    
    % need mode + conjugate mode for real field
    U      = (exp(1i * PTS(ii,:) * k) + exp(-1i * PTS(ii,:) * k))*U;
    totU(ii,:) = sum(U(:,1:3), 2);
end
fprintf('Finished RK4 \n');

% save totU.mat; return;
%}

load totU.mat


figure(gcf);
totU = reshape(totU, [ny,nx,nz,length(t)]);
CAX = [min(totU(:)), max(totU(:))];

xmin = min(x(:));
xmax = max(x(:));
ymax = max(y(:));
ymin = min(y(:));
zmin = min(z(:));


for ii = 1:length(t)
    u = totU(:,:,:,ii);

    fh = plotField(X,Y,Z,u);
    title(sprintf('t = %0.3f', t(ii)), 'FontW', 'B');
    caxis(CAX);
    pause(0.1);
    mov(ii) = getframe(gca);
end


tmp = VideoWriter('example.avi');
open(tmp);
writeVideo(tmp, mov);
close(tmp);

