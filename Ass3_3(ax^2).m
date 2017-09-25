N = 10000;
#hold all;
#ezplot('sin(x*pi)', [-1,1]);
a = zeros(1,N);
for i = 1:N
	x = (rand(2,1) * 2) - 1;
	y = sin(x * pi);
	#scatter(x,y,'r');
	#a(i) = sum(y)/2;	
	#xi = [-1,1];
	#ai = interp1 ([-1 1], [a(i) a(i)], xi, "extrap");
	#plot(xi,ai,'k')

	a(i) = inv(x' * x) * x' * y;
	#xi = [-1,1];
	#ai = interp1 ([x(1) x(2)], [a(i)*x(1) a(i)*x(2)], xi, "extrap");
	#plot(xi,ai,'k');


end
a_exp = sum(a)/N;
#xi = [-1,1];
#ai = interp1 ([-1 1], [-a_exp a_exp], xi, "extrap");
#plot(xi,ai,'r');
disp(a_exp);

error = zeros(1,N);
for j = 1:N
	x = rand() * 2 - 1;
	y = sin(x * pi);
	error(j) = (a_exp * x - y)^2;
end
bias = sum(error) / N;
disp(bias);

error_var = zeros(1,N);
for k = 1:N
	x = (rand(2,1) * 2) - 1;
	y = sin(x * pi);
	a = inv(x' * x) * x' * y;
	error_var(k) = (a * x(1) - a_exp * x(1)) ^ 2;
end
variance = sum(error_var) / N;
disp(variance);

