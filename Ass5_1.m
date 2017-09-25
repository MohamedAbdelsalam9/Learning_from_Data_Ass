n = 0;
u = 1;
v = 1;
E = (u*e^v - 2*v*e^-u) ^ 2;
while (E > 10^-14)
	E = (u*e^v - 2*v*e^-u) ^ 2;
	deru_E = 2 * (e^v + 2*v*e^-u) * (u*e^v - 2*v*e^-u);
	derv_E = 2 * (u*e^v - 2*v*e^-u) * (u*e^v - 2*e^-u);
	u = u - 0.1 * deru_E;
	v = v - 0.1 * derv_E;
	n = n + 1;
	disp(E);
end
disp(n);
