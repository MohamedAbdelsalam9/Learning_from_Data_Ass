N = 1000;
Eout = zeros(1, 1000);
for j = 1:1000

	x = 2 * rand(N, 3) - 1;
	x(:,1) = 1;
	x(:,4) = x(:,2) .* x(:,3);
	x(:,5) = x(:,2) .^2;
	x(:,6) = x(:,3) .^2;
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

	x = 2 * rand(N, 3) - 1;
	x(:,1) = 1;
	x(:,4) = x(:,2) .* x(:,3);
	x(:,5) = x(:,2) .^2;
	x(:,6) = x(:,3) .^2;
	y = zeros(N,1);
	for i=1:N
		y(i) = sign(x(i,2)^2 + x(i,3)^2 - 0.6);
	end
	for i = 1:(N/10)
		index = randi([1 N]);
		y(index) = -y(index);
	end

	for i = 1:N
		if (sign(y(i)) ~= sign(x(i,:) * w)) Eout(j)++;
		end	
	end
	Eout(j) /= N;
	
	
end
disp(sum(Eout)/1000);
