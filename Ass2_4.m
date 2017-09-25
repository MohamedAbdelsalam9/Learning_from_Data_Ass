N = 10;
counter	= zeros(1,1000);
for j = 1:1000
	A = 2 * rand(1,2) - 1;
	B = 2 * rand(1,2) - 1;
	x = 2 * rand(N, 3) - 1;
	x(:,1) = 1;
	#hold all;
	#xi = [-1,1];
	#yi = interp1 ([A(1) B(1)], [A(2) B(2)], xi, "extrap"); 
	#plot(xi, yi, 'color', 'k');
	y = zeros(N,1);
	for i=1:N
		if (((B(1) - A(1)) * (x(i,3) - A(2)) - (B(2) - A(2)) * (x(i,2) - A(1))) > 0)
			#scatter(x(i,2), x(i,3), 'r');
			y(i) = 1;
		elseif (((B(1) - A(1)) * (x(i,3) - A(2)) - (B(2) - A(2)) * (x(i,2) - A(1))) < 0)
			#scatter(x(i,2), x(i,3), 'b');
			y(i) = -1;
		end
	end


	w = inv(transpose(x)*x)*transpose(x)*y;
	#x1i = [-1, 1];
	#x2i = interp1([-1, 1], [(-w(1) + w(2))/w(3), (-w(1) - w(2))/w(3)], x1i, "extrap");
	#plot(x1i, x2i, 'color', 'g');

	classified = 0;
	while (classified == 0)
		classified = 1;
		for i = 1 : N
			var = ceil(rand()*N);
			if (sign(x(var,:)*w) ~= sign(y(var)))
				w += (y(var) * x(var,:))';
				classified = 0;
				#x1 = -1; 0 = w0 - w1 + x2 * w2; x2 = (-w0 + w1) / w2
				#x1 = 1; x2 = (-w0 - w1) / w2
				#x1i = [-1, 1];
				#x2i = interp1([-1, 1], [(-w(1) + w(2))/w(3), (-w(1) - w(2))/w(3)], x1i, "extrap");
				#plot(x1i, x2i, 'color', 'g');
				counter(j) += 1;
			end

		end
	end


	#x1i = [-1, 1];
	#x2i = interp1([-1, 1], [(-w(1) + w(2))/w(3), (-w(1) - w(2))/w(3)], x1i, "extrap");
	#plot(x1i, x2i, 'color', 'r');
end
disp(sum(counter)/1000);
