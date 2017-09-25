Eout = zeros(1,100);
count = zeros(1,100);
for j = 1:100
	N = 100;
	A = 2 * rand(1,2) - 1;
	B = 2 * rand(1,2) - 1;
	x = 2 * rand(3,N) - 1;
	x(1,:) = 1;
	y = zeros(N,1);
	eta = 0.01;
	h = zeros(N,1);
	
	#hold all;	
	#xi = [-1,1];
	#yi = interp1 ([A(1) B(1)], [A(2) B(2)], xi, "extrap");
	#plot(xi, yi, 'color', 'k');

	w = [0;0;0];
	w_old = [1;1;1];
	delta_w = w - w_old;
	delta_w_mag = sqrt(delta_w(1)^2 + delta_w(2)^2 + delta_w(3)^2);

	for i=1:N
		if (((B(1) - A(1)) * (x(3,i) - A(2)) - (B(2) - A(2)) * (x(2,i) - A(1))) > 0)
			#scatter(x(2,i), x(3,i), 'r');
			y(i) = 1;
		elseif (((B(1) - A(1)) * (x(3,i) - A(2)) - (B(2) - A(2)) * (x(2,i) - A(1))) < 0)
			#scatter(x(2,i), x(3,i), 'b');
			y(i) = -1;
		end
	end

	while (delta_w_mag > 0.01)
		order = randperm(N);
		w_old = w;
		for i = 1:N
			n = order(i);
			w = w + eta * (y(n)*x(:,n) / (1 + e^(y(n)*w'*x(:,n))));
		end
		delta_w = w_old - w;
		delta_w_mag = sqrt(delta_w(1)^2 + delta_w(2)^2 + delta_w(3)^2);
		count(j) += 1;
	end
	
	
	#x1i = [-1, 1];
	#x2i = interp1([-1, 1], [(-w(1) + w(2))/w(3), (-w(1) - w(2))/w(3)], x1i, "extrap");
	#plot(x1i, x2i, 'color', 'r');

	#for l = 1:N
	#	h(l) = 1 / (1 + e^(-w'*x(:,l)));
	#end	

	x = 2 * rand(3,1000) - 1;
	x(1,:) = 1;
	y = zeros(1000,1);
	for k=1:1000
		if (((B(1) - A(1)) * (x(3,k) - A(2)) - (B(2) - A(2)) * (x(2,k) - A(1))) > 0)
			y(k) = 1;
		elseif (((B(1) - A(1)) * (x(3,k) - A(2)) - (B(2) - A(2)) * (x(2,k) - A(1))) < 0)
			y(k) = -1;
		end
		Eout(j) += log(1 + e^(-y(k)*w'*x(:,k)));
	end
	Eout(j) = Eout(j) / 1000;
end
disp(sum(Eout)/100);
disp(sum(count)/100);
