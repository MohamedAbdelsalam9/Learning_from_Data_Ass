x = [1 0 0 -1 0 0 -2; 0 1 -1 0 2 -2 0];
y = [-1; -1; -1; 1; 1; 1; 1]; 

z = zeros(2,7);
for i = 1:7
	z(1,i) = x(2,i)^2 - 2*x(1,i) - 1;
	z(2,i) = x(1,i)^2 - 2*x(2,i) + 1;
end

#hold all;

for i = 1:7
	if (y(i) == 1)
		#scatter(z(1,i), z(2,i), 'r');
	elseif (y(i) == -1)
		#scatter(z(1,i), x(2,i), 'b');
	end
end

K = zeros(7,7);
for j = 1:7
	for k = 1:7
		K(j,k) = (1 + x(:,j)'*x(:,k))^2;
	end
end

H = y.*K;
H = (y.*H')';
q = zeros(7,1); q(:) = -1;
x0 = zeros(7,1);
lb = zeros(7,1);
ub = zeros(7,1); ub(:) = Inf;
alpha = qp (x0, H, q, y', 0, lb, ub);

#model = svmtrain(y, x', ['-t 1 -d 2 -g 1 -r 1 -c 100000']);

w1 = 1;
w2 = 0;
b = -0.5;
