function du = rdtODE(t,u, k,S)

u  = reshape(u, [], 3);
[u1, u2, u3]  = deal(u(:,1), u(:,2), u(:,3));
[k1, k20, k3] = deal(k(1), k(2), k(3));

k2      = (k20 - S.*k1.*t);
fact    = S.*u2;
denom   = (k1.^2 + k3.^2 + k2.^2);
du1     = -fact  .* (1 - 2*k1.^2 ./ denom);
du2     = 2*fact .* k1.*k2 ./ denom;
du3     = 2*fact .* k1.*k3 ./ denom;
du      = [du1(:); du2(:); du3(:)]';

end
