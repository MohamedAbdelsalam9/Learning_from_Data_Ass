N = 50;
hold all;
ezplot('sin(x*pi)', [-1,1]);
a_exp = zeros(2,1);
a = zeros(2,N);
for i = 1:N
	x = (rand(2,2) * 2) - 1;
	x(:,1) = 1;
	y = sin(x(:,2) * pi);

	a(:,i) = inv(x' * x) * x' * y;
	xi = [-1,1];
	ai = interp1 ([-1 1], [-a(2,i)+a(1,i) a(2,i)+a(1,i)], xi, "extrap");
	plot(xi,ai,'k');


end
#a_exp(1,1) = sum(a(1,:))/N;
#a_exp(2,1) = sum(a(2,:))/N;
a_exp = [0.003; 0.78];
xi = [-1,1];
ai = interp1 ([-1 1], [-a_exp(2)+a_exp(1) a_exp(2)+a_exp(1)], xi, "extrap");
plot(xi,ai,'r');
disp(a_exp);

error = zeros(1,N);
for j = 1:N
	x = (rand(1,2) * 2) - 1;
	x(1) = 1;
	y = sin(x(2) * pi);
	error(j) = (x * a_exp - y)^2;
end
bias = sum(error) / N;
disp(bias);

error_var = zeros(1,N);
for k = 1:(N)
	x = (rand(2,2) * 2) - 1;
	x(:,1) = 1;
	y = sin(x(:,2) * pi);
	a = inv(x' * x) * x' * y;
	error_var(k) = ((x(1,:) * a - x(1,:) * a_exp)^2 + (x(2,:) * a - x(2,:) * a_exp)^2) / 2;
	#error_var(2*k) = (x(2,:) * a - x(2,:) * a_exp)^2;
end
variance = sum(error_var) / N;
disp(variance);
