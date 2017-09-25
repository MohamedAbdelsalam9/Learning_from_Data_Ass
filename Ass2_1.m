C = 1000;
N = 100000;
vmin = ones(1,N);
vmin *= 10;
for k = 1:N
	v = zeros(1,C);
	for i = 1:C
		for j = 1:10
			v(i) += round(rand());
		end
		if v(i) < vmin(k)
			vmin(k) = v(i);
		end
	end
end
averMin = sum(vmin)/N;
disp(averMin);
