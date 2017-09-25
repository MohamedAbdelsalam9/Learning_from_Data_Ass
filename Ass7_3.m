data = load("in.dta");
#test = load("out.dta");
N = 10;
x = zeros(N,2); y = zeros(N,1); error = zeros(N,1); 
x(:,1) = data(26:35,1);
x(:,2) = data(26:35,2);
y = data(26:35,3);

N_ = 25;
x_ = zeros(N_,2); y_ = zeros(N_,1); error = zeros(N_,1);
x_(:,1) = data(1:25,1);
x_(:,2) = data(1:25,2);
y_ = data(1:25,3);

k = 6;
phi = zeros(N,k+1);
phi(:,1) = 1;
phi(:,2) = x(:,1);
phi(:,3) = x(:,2);
phi(:,4) = x(:,1) .* x(:,1);
phi(:,5) = x(:,2) .* x(:,2);
phi(:,6) = x(:,1) .* x(:,2);
phi(:,7) = abs(x(:,1) - x(:,2));
#phi(:,8) = abs(x(:,1) + x(:,2));
w = inv(phi' * phi) * phi' * y;

phi_ = zeros(N_,k+1);
phi_(:,1) = 1;
phi_(:,2) = x_(:,1);
phi_(:,3) = x_(:,2);
phi_(:,4) = x_(:,1) .* x_(:,1);
phi_(:,5) = x_(:,2) .* x_(:,2);
phi_(:,6) = x_(:,1) .* x_(:,2);
phi_(:,7) = abs(x_(:,1) - x_(:,2));
#phi_(:,8) = abs(x_(:,1) + x_(:,2));

error = sum(sign(phi * w) ~= y) / N;
error_ = sum(sign(phi_ * w) ~= y_) / N_;
disp(error);
disp(error_);
