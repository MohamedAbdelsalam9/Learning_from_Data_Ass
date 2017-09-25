clear;
Probability = zeros(1, 1000);
Probability_ = zeros(1, 1000);
count = 0;
index = zeros(1, 1000);
for j = 1:1000
	N = 100;
	A = 2 * rand(1,2) - 1;
	B = 2 * rand(1,2) - 1;
	x = 2 * rand(3, N) - 1;
	x(1,:) = 1;
	y = zeros(N,1);
	for i=1:N
		if (((B(1) - A(1)) * (x(3,i) - A(2)) - (B(2) - A(2)) * (x(2,i) - A(1))) > 0)
			y(i) = 1;
		elseif (((B(1) - A(1)) * (x(3,i) - A(2)) - (B(2) - A(2)) * (x(2,i) - A(1))) < 0)
			y(i) = -1;
		end
	end

	w = [0 0 0];

	classified = 0;
	while (classified == 0)
		classified = 1;
		for i = 1 : N
			var = ceil(rand()*N);
			if (sign(w * x(:,var)) ~= sign(y(var)))
				w += (y(var) * x(:,var))';
				classified = 0;
			end

		end
	end
	
	M = 100;
	x_ = 2 * rand(3, M) - 1;
	x_(1,:) = 1;
	trueClassified = 0;
	falseClassified = 0;
	for i = 1:M
		y_ = sign((B(1) - A(1)) * (x_(3,i) - A(2)) - (B(2) - A(2)) * (x_(2,i) - A(1)));
		h = sign(w* x_(:,i));
		if (y_ == h) trueClassified +=1;
		else falseClassified += 1;
		end
	end
	Probability(j) = falseClassified/M;
	

	w = [0 0];
	alpha = zeros(N,1);
	H = zeros(N);
	lb = zeros(N,1);
	ub = zeros(N,1);
	for i = 1:N
		for k = 1:N
			H(i,k) = y(i) * y(k) * x(2:3,i)' * x(2:3,k);
		end
		ub(i) = Inf;
	end
	q = zeros(N,1); q -= 1;
	alpha = qp (alpha, H, q, y', 0, lb, ub);
	SVs = zeros(N,1);
	for k = 1:N
		if (abs(alpha(k)) > 0.001)
			index(j) += 1;
			SVs(index(j)) = k;
			w += alpha(k) * y(k) * x(2:3,k)';
		end
	end
	if (index(j) == 0) b = 0;
	else b = 1/y(index(j)) - w*x(2:3,index(j));
	end

	
	#M = 100;
	#x_ = 2 * rand(2, M) - 1;
	trueClassified_ = 0;
	falseClassified_ = 0;
	for i = 1:M
		y_ = sign((B(1) - A(1)) * (x_(3,i) - A(2)) - (B(2) - A(2)) * (x_(2,i) - A(1)));
		h = sign(w* x_(2:3,i) + b);
		if (y_ == h) trueClassified_ +=1;
		else falseClassified_ += 1;
		end
	end
	Probability_(j) = falseClassified_/M;
	

	if (Probability_(j) < Probability(j)) count += 1;
	end
end
averProbability = sum(Probability)/1000;
averProbability_ = sum(Probability_)/1000;
disp(averProbability);
disp(averProbability_);
disp(count/1000*100);

