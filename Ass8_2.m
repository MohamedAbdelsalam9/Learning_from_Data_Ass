data = load("features.train");

M = 0;
N = length(data);
x = zeros(N,2); y = zeros(N,1);  digit = zeros(N,1);
digit = data(:,1);

for i = 1 : N
	if (digit(i) == 1)
		M += 1;
		x(M,:) = data(i,2:3);
		y(M) = 1;
	elseif (digit(i) == 5)
		M += 1;
		x(M,:) = data(i,2:3);
		y(M) = -1;
	end
end

x_ = x(1:M,2); y_ = y(1:M,1);
model = zeros(100,1);
for j = 1:100
	order = randperm(M);
	for k = 1:M
		x_(k,:) = x(order(k),:);
		y_(k) = y(order(k));
	end
	model(j) = svmtrain(y_, x_, ['-t 1 -d 2 -g 1 -r 1 -c 1 -v 10']);
end
disp(sum(model)/100);

#.0001 99.023
#.001 99.527
#.01 99.530
#.1 99.521
#1 99.513
