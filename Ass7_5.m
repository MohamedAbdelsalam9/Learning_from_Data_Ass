e1 = zeros(10000,1);
e2 = zeros(10000,1);
e = zeros(10000,1);
for i = 1:10000
	e1(i) = rand();
	e2(i) = rand();
	e(i) = min(e1(i),e2(i));
end
disp(sum(e1)/10000);
disp(sum(e2)/10000);
disp(sum(e)/10000);
