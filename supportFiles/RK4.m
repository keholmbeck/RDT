function x = RK4(F_xy, t,x,h, postFunc)

if nargin == 4
    postFunc = @(x) x;
end

i = 1;
x(i,:) = postFunc(x(i,:), t(i));    % do processing here(e.g. make solenoidal

for i = 1:(length(t)-1)                              % calculation loop
    x(i,:) = postFunc(x(i,:), t(i));
    
    k_1 = F_xy(t(i),        x(i,:));
    k_2 = F_xy(t(i)+0.5*h,  x(i,:)+0.5*h*k_1);
    k_3 = F_xy(t(i)+0.5*h,  x(i,:)+0.5*h*k_2);
    k_4 = F_xy(t(i)+h,      x(i,:)+k_3*h);

    x(i+1,:) = x(i,:) + (h/6)*(k_1 + 2*k_2 + 2*k_3 + k_4);  % main equation
    
%     x(i+1,:) = postFunc(x(i+1,:), t(i+1));
end

end