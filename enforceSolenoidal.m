function u = enforceSolenoidal(u,t,k,S)

k     = k(:);
k(2)  = (k(2) - S.*k(1).*t);

extra = u*k / (k'*k);
u     = u - k'*extra;

% k2 = conj(-k);
% extra = u*k2 / (k2'*k2);
% u     = u - k2'*extra;

% u(1)  = u(1) - k(1)*extra;
% u(2)  = u(2) - k(2)*extra;
% u(3)  = u(3) - k(3)*extra;

if abs(u*k) >= 1e-3
    keyboard
end

end
