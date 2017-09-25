C = 1000;
N = 1000;
#vmin = ones(1,N);
#vmin *= 10;
v1 = 0;
vrand = 0;
for k = 1:N
	v = zeros(1,C);
	crand = ceil(rand() * C);
	for i = 1:C
		for j = 1:10
			v(i) += round(rand());
		end
		
		#if v(i) < vmin(k)
		#	vmin(k) = v(i);
		#end
	end
	#v1 += v(1);
	vrand += v(crand);
end
#averMin = sum(vmin)/N;
disp(vrand/N);
