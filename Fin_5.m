correct = 0;
correct_ = 0;

while (correct == 0 || correct_ == 0)
N = 100;
x = 2 * rand(N, 2) - 1;
y = zeros(N,1);

for i = 1 : N
	if (sign(x(i,2) - x(i,1) + 0.25*sin(pi*x(i,1))) == 1)
		y(i) = 1;
	elseif (sign(x(i,2) - x(i,1) + 0.25*sin(pi*x(i,1))) == -1)
		y(i) = -1;
	else
		y(i) = 0;
	end
end

mio = zeros(9,2);
n = zeros(9,1); n(:) = 11; n(1) = 12;
S = zeros(N,1); 
S(1:12) = 1;
for i = 2 : 9
	S((11*(i-1)+2):(11*i)+1) = i;
end
S_old = zeros(N,1);


mio_ = zeros(9,2);
n_ = zeros(9,1); n_(:) = 11; n_(1) = 12;
S_ = zeros(N,1); 
S_(1:12) = 1;
for i = 2 : 9
	S_((11*(i-1)+2):(11*i)+1) = i;
end
S_old_ = zeros(N,1);

while (sum(S_old == S) ~= N)
	S_old = S;
	mio = zeros(9,2);
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
		end
	end
	mio = mio./n;

	for j = 1 : N
		for k = 1 : 9
			temp = mio(S(j),:);
			if (norm(x(j,:) - mio(k,:)) < norm(x(j,:) - temp))
				n(S(j)) -= 1;
				S(j) = k;
				n(S(j)) += 1;
			end
		end
	end
end

while (sum(S_old_ == S_) != N)
	S_old_ = S_;
	mio_ = zeros(9,2);
	for i = 1 : N
		if S_(i) == 1
			mio_(1,:) += x(i,:);
		elseif S_(i) == 2
			mio_(2,:) += x(i,:);
		elseif S_(i) == 3
			mio_(3,:) += x(i,:);
		elseif S_(i) == 4
			mio_(4,:) += x(i,:);
		elseif S_(i) == 5
			mio_(5,:) += x(i,:);
		elseif S_(i) == 6
			mio_(6,:) += x(i,:);
		elseif S_(i) == 7
			mio_(7,:) += x(i,:);
		elseif S_(i) == 8
			mio_(8,:) += x(i,:);
		elseif S_(i) == 9
			mio_(9,:) += x(i,:);
		end
	end
	mio_ = mio_./n_;

	for j = 1 : N
		for k = 1 : 9
			temp = mio_(S_(j),:);
			if (norm(x(j,:) - mio_(k,:)) < norm(x(j,:) - temp))
				n_(S_(j)) -= 1;
				S_(j) = k;
				n_(S_(j)) += 1;
			end
		end
	end
end

phi = zeros(N,9);
for j = 1:N
	for k = 1:9
		phi(j,k) = exp(-2 * norm(x(j,:) - mio(k,:))^2);
	end
end

w = inv(phi' * phi) * phi' * y;

phi_ = zeros(N,9);
for j = 1:N
	for k = 1:9
		phi_(j,k) = exp(-1.5 * norm(x(j,:) - mio_(k,:))^2);
	end
end

w_ = inv(phi_' * phi_) * phi_' * y;


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

phi2 = zeros(N_,9);
for j = 1:N_
	for k = 1:9
		phi2(j,k) = exp(-2 * norm(x_(j,:) - mio(k,:))^2);
	end
end
correct = sum(sign(phi2*w) == y_)/N_*100;
correct2 = sum(sign(phi*w) == y)/N*100;

phi2_ = zeros(N_,9);
for j = 1:N_
	for k = 1:9
		phi2_(j,k) = exp(-1.5 * norm(x_(j,:) - mio_(k,:))^2);
	end
end
correct_ = sum(sign(phi2_*w_) == y_)/N_*100;
correct2_ = sum(sign(phi_*w_) == y)/N*100;

end

disp(correct);
disp(correct2);
disp(correct_);
disp(correct2_);

#Eout2 Ein2 Eout1.5 Ein1.5
#95.4  99   95.5    99
#91.1  93   92.2    95
#96.8  99   96.7    98
#94.1  95   95      96
#			94
			
