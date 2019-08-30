function [X,Y,Z] = makeGrid(x,y,z, n)

if nargin == 2
    n = y;
    [y,z] = deal(x);
end

x = linspace(x(1), x(2), n);
y = linspace(y(1), y(2), n);
z = linspace(z(1), z(2), n);

[X,Y,Z] = meshgrid(x,y,z);

end
