hold all;
epsilon = 0;
for N = 1 : 5
	epsilon(N) = sqrt(8/N*log(4*(2*N)^50/0.05));
end
plot(1:5,epsilon,'k');

for N = 1:5
	epsilon(N) = sqrt(2 * log(2 * N * N^50) / N) + sqrt(2 / N * log(1 / 0.05)) + 1/N;
end
plot(1:5,epsilon,'r');

#for N = 1:5
#	fun2 = sqrt(1/N * (2*epsilon + log(6*(2*N)^50/0.05))) - epsilon;
#end

ezplot(@(x,y) sqrt(1./x * (2*y + 50*log(2.2*x))) - y, [1,5,0,100]);


#ezplot(@(x,y) sqrt(1./(2*x).*(4.*y*(1+y)+log(4.*x.^100/0.05))) - y, [1,100000,0,20]);
