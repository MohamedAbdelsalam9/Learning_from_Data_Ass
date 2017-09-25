data = load("features.train");
test = load("features.test");

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
x = x(1:M,:); y = y(1:M,:);

M_ = 0;
N_ = length(test);
x_ = zeros(N_,2); y_ = zeros(N_,1);  digit_ = zeros(N_,1);
digit_ = test(:,1);
for i = 1 : N_
	if (digit_(i) == 1)
		M_ += 1;
		x_(M_,:) = test(i,2:3);
		y_(M) = 1;
	elseif (digit_(i) == 5)
		M_ += 1;
		x_(M_,:) = test(i,2:3);
		y_(M_) = -1;
	end
end
x_ = x_(1:M_,:); y_ = y_(1:M_);

model = svmtrain(y, x , ['-s 0 -t 1 -d 2 -c .0001 -r 1 -g 1']);

Ein = svmpredict(y, x, model);
Eout = svmpredict(y_, x_, model);
