N = 1000;
Ein = zeros(1, 1000);
for j = 1:1000

	x = 2 * rand(N, 3) - 1;
	x(:,1) = 1;
	#hold all;
	y = zeros(N,1);
	for i=1:N
		y(i) = sign(x(i,2)^2 + x(i,3)^2 - 0.6);
	end

	for i = 1:(N/10)
		index = randi([1 N]);
		y(index) = -y(index);
	end

	#for i = 1:N
	#	if (y(i) == 1)	scatter(x(i,2), x(i,3), 'r');
	#	else	scatter(x(i,2), x(i,3), 'b');
	#	end
	#end


	w = inv(transpose(x)*x)*transpose(x)*y;

	for i = 1:N
		if (sign(y(i)) ~= sign(x(i,:) * w)) Ein(j)++;
		end	
	end
	Ein(j) /= N;
	#Ein(j) = 1/N * transpose(x*w - y) * (x*w - y);

	#x1i = [-1, 1];
	#x2i = interp1([-1, 1], [(-w(1) + w(2))/w(3), (-w(1) - w(2))/w(3)], x1i, "extrap");
	#plot(x1i, x2i, 'color', 'r');
end
disp(sum(Ein)/1000);
