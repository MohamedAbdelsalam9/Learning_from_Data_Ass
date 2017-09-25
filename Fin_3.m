correct = 0;

while (correct == 0)
N = 100;
x = 2 * rand(N, 2) - 1;
y = zeros(N,1);
#hold all;

for i = 1 : N
	if (sign(x(i,2) - x(i,1) + 0.25*sin(pi*x(i,1))) == 1)
		#scatter(x(i,1), x(i,2), 'r');
		y(i) = 1;
	elseif (sign(x(i,2) - x(i,1) + 0.25*sin(pi*x(i,1))) == -1)
		#scatter(x(i,1), x(i,2), 'b');
		y(i) = -1;
	else
		y(i) = 0;
	end
end

model = svmtrain(y, x, ['-g 1.5 -c 1000000']);

#ezplot('y- x + 0.25*sin(pi*x)', [-1,1]);

mio = zeros(12,2);
n = zeros(12,1); n(:) = 8; n(1) = 12;
S = zeros(N,1); 
S(1:12) = 1;
for i = 2 : 12
	S((8*(i-1)+5):(8*i)+4) = i;
end
S_old = zeros(N,1);

while (sum(S_old == S) != N)
	S_old = S;
	mio = zeros(12,2);
	for i = 1 : N
		if S(i) == 1
			mio(1,:) += x(i,:);
		elseif S(i) == 2
			mio(2,:) += x(i,:);
		elseif S(i) == 3
			mio(3,:) += x(i,:);
		elseif S(i) == 4
			mio(4,:) += x(i,:);
		elseif S(i) == 5
			mio(5,:) += x(i,:);
		elseif S(i) == 6
			mio(6,:) += x(i,:);
		elseif S(i) == 7
			mio(7,:) += x(i,:);
		elseif S(i) == 8
			mio(8,:) += x(i,:);
		elseif S(i) == 9
			mio(9,:) += x(i,:);
		elseif S(i) == 10
			mio(10,:) += x(i,:);
		elseif S(i) == 11
			mio(11,:) += x(i,:);
		elseif S(i) == 12
			mio(12,:) += x(i,:);
		end
	end
	mio = mio./n;

	for j = 1 : N
		for k = 1 : 12
			temp = mio(S(j),:);
			if (norm(x(j,:) - mio(k,:)) < norm(x(j,:) - temp))
				n(S(j)) -= 1;
				S(j) = k;
				n(S(j)) += 1;
			end
		end
	end
end

phi = zeros(N,12);
for j = 1:N
	for k = 1:12
		phi(j,k) = exp(-1.5 * norm(x(j,:) - mio(k,:))^2);
	end
end

w = inv(phi' * phi) * phi' * y;


N_ = 1000;
x_ = 2 * rand(N_, 2) - 1;
y_ = zeros(N_,1);

for i = 1 : N_
	if (sign(x_(i,2) - x_(i,1) + 0.25*sin(pi*x_(i,1))) == 1)
		y_(i) = 1;
	elseif (sign(x_(i,2) - x_(i,1) + 0.25*sin(pi*x_(i,1))) == -1)
		y_(i) = -1;
	else
		y_(i) = 0;
	end
end

predict = svmpredict(y_, x_, model);


phi_ = zeros(N_,12);
for j = 1:N_
	for k = 1:12
		phi_(j,k) = exp(-1.5 * norm(x_(j,:) - mio(k,:))^2);
	end
end
correct = sum(sign(phi_*w) == y_)/N_*100;
end
disp(correct);
disp(mio);



#hold all;
#for i = 1 : N
#	if S(i) == 1
#		scatter(x(i,1), x(i,2), 8, [0,0,1]);
#		scatter(mio(1,1), mio(1,2), 8, [0,0,1], 'filled');
#	elseif S(i) == 2
#		scatter(x(i,1), x(i,2), 8, [0,1,0]);
#		scatter(mio(2,1), mio(2,2), 8, [0,1,0], 'filled');
#	elseif S(i) == 3
#		scatter(x(i,1), x(i,2), 8, [1 0 0]);
#		scatter(mio(3,1), mio(3,2), 8, [1 0 0], 'filled');
#	elseif S(i) == 4
#		scatter(x(i,1), x(i,2), 8, [1 0.8 0.8]);
#		scatter(mio(4,1), mio(4,2), 8, [1 0.5 0.5], 'filled');
#	elseif S(i) == 5
#		scatter(x(i,1), x(i,2), 8, [0.5 1 0.5]);
#		scatter(mio(5,1), mio(5,2), 8, [0.5 1 0.5], 'filled');
#	elseif S(i) == 6
#		scatter(x(i,1), x(i,2), 8, [0.6 0.6 1]);
#		scatter(mio(6,1), mio(6,2), 8, [0.6 0.6 1], 'filled');
#	elseif S(i) == 7
#		scatter(x(i,1), x(i,2), 8, [0.6 0.6 0.6]);
#		scatter(mio(7,1), mio(7,2), 8, [0.6 0.6 0.6], 'filled');
#	elseif S(i) == 8
#		scatter(x(i,1), x(i,2), 8, [0.4 0.8 0.4]);
#		scatter(mio(8,1), mio(8,2), 8, [0.4 0.8 0.4], 'filled');
#	elseif S(i) == 9
#		scatter(x(i,1), x(i,2), 8, [0.8 0.8 0.2]);
#		scatter(mio(9,1), mio(9,2), 8, [0.8 0.8 0.2], 'filled');
#	end
#end
