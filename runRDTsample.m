clear;

plotSavedData = 1; % if 0, do RDT simulation

fname = 'data/finalRuns/run3.mat';
if plotSavedData

    load(fname);

    k2t     = (k(2) - S.*k(1).*t);      % ODE for k2
    kt      = {k(1), k2t, k(3)};
    [U,V,W] = convert_uhat_to_u(U,V,W, kt, t, PTS);

    save tmp
    plotFieldOverTime('tmp');

else
    rng(1028);

    h           = 0.05;                      % step size
    t           = linspace(0, 1, 100);
    n           = 10;
    grid        = 2*pi/n * [-1, 1];

    [X,Y,Z]     = makeGrid(grid, n);
    [UI,VI,WI]  = initialCondition(X,Y,Z);
    PTS         = [Y(:), X(:), Z(:)];
    IC          = [UI(:), VI(:), WI(:)];
    % IC = ones(size(IC));
    npts        = numel(X);

    L  = 2*pi;
    K0 = 2*pi / L;
    n  = [4,-2,-2; -1,1,0; -10,4,6]';   % sum of n's must be zero for solenoid

    n  = n(:,1);
    K  = K0 .* n;

    k       = K(:,1);
    k = abs(randn(3,1)) .* [1; 1; 1];
    S       = 100;
    du      = @(t,u) rdtODE(t,u,k,S);

    fprintf('Starting RK4 \n');
    totU = zeros(npts*3, length(t));
    siz = size(totU);

    pdisp = npts/10;
    pflag = 1;

    for ii = 1:npts
        U      = zeros(length(t), 3);
        U(1,:) = IC(ii,:);
        U      = RK4(du, t, U, h, @(x,t) enforceSolenoidal(x,t,k,S));

        totU(ii+[0,npts,2*npts],:) = U';

        if ii >= pflag*pdisp
            fprintf('..%0.0f%s', ceil(100*ii/npts),'%');
            pflag = pflag + 1;
        end
    end
    fprintf('\n Finished RK4 \n');

    U = totU(1:npts,:);
    V = totU(npts+1:2*npts,:);
    W = totU(2*npts+1:end,:);

    U = reshape(U, [size(X), length(t)]);
    V = reshape(V, [size(X), length(t)]);
    W = reshape(W, [size(X), length(t)]);
    
    kt = zeros(length(t), 3);
    kt(:,1) = k(1);
    kt(:,3) = k(3);
    kt(:,2) = k(2) - S.*k(1).*t;
    div = computeFieldDivergence(X,Y,Z,U,V,W, kt);

    save(fname)
    return
    
    k2t     = (k(2) - S.*k(1).*t);      % ODE for k2
    kt      = {k(1), k2t, k(3)};
    [U,V,W] = convert_uhat_to_u(U,V,W, kt, t, PTS);
    
end
