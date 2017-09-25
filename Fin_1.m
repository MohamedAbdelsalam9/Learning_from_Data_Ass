data = load("features.train");
test = load("features.test");

M = 0;
N = length(data);
x = zeros(N,3); y = zeros(N,1);  digit = zeros(N,1);
digit = data(:,1);
x(:,1) = 1;
for i = 1 : N
	if (digit(i) == 1)
		M += 1;
		x(M,2:3) = data(i,2:3);
		y(M) = 1;
	elseif (digit(i) == 5)
		M += 1;
		x(M,2:3) = data(i,2:3);
		y(M) = -1;
	end
end
x = x(1:M,:); y = y(1:M,:);

z = zeros(M,6);
z(:,1) = 1;
for k = 1 : M
	z(k,2) = x(k,2);
	z(k,3) = x(k,3);
	z(k,4) = x(k,2) * x(k,3);
	z(k,5) = x(k,2)^2;
	z(k,6) = x(k,3)^2;
end

M_ = 0;
N_ = length(test);
x_ = zeros(N_,3); y_ = zeros(N_,1);  digit_ = zeros(N_,1);
digit_ = test(:,1);
x_(:,1) = 1;
for i = 1 : N_
	if (digit_(i) == 1)
		M_ += 1;
		x_(M_,2:3) = test(i,2:3);
		y_(M_) = 1;
	elseif (digit_(i) == 5)
		M_ += 1;
		x_(M_,2:3) = test(i,2:3);
		y_(M_) = -1;
	end
end
x_ = x_(1:M_,:); y_ = y_(1:M_);

z_ = zeros(M_,6);
z_(:,1) = 1;
for k = 1 : M_
	z_(k,2) = x_(k,2);
	z_(k,3) = x_(k,3);
	z_(k,4) = x_(k,2) * x_(k,3);
	z_(k,5) = x_(k,2)^2;
	z_(k,6) = x_(k,3)^2;
end


lamda = 1;
w = inv(z'*z + lamda*eye(6))*z'*y;

uncorrect = 0;
for j = 1:M
	if (sign(z(j,:)*w) ~= y(j))
		uncorrect += 1;
	end
end
disp(uncorrect/M);

uncorrect_ = 0;
for j = 1:M_
	if (sign(z_(j,:)*w) ~= y_(j))
		uncorrect_ += 1;
	end
end
disp(uncorrect_/M_);
