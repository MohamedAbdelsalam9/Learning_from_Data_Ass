u = 1;
v = 1;
E = (u*e^v - 2*v*e^-u) ^ 2;
for i = 1:15
	E = (u*e^v - 2*v*e^-u) ^ 2;
	deru_E = 2 * (e^v + 2*v*e^-u) * (u*e^v - 2*v*e^-u);
	u = u - 0.1 * deru_E;
	derv_E = 2 * (u*e^v - 2*v*e^-u) * (u*e^v - 2*e^-u);
	v = v - 0.1 * derv_E;
end
E = (u*e^v - 2*v*e^-u) ^ 2;
disp(E);
