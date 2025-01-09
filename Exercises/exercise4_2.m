clear;

W=500;
L=300;
s_A=W*L*sqrt((5/W)^2+(5/L)^2);
syms x y
eq=x*y*sqrt((5/x)^2+(5/y)^2)-s_A == 0;
xsol=solve(eq,x);
disp(xsol);

[X,Y]=meshgrid(0:100:10000);
graph=X.*Y.*sqrt((5./X).^2+(5./Y).^2);
surf(X,Y,graph);