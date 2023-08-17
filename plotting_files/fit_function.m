function y = fit_function(x,A,v,tau_c,B)


y = A*(1-exp(cos(2*pi*v*x))).*exp(x/tau_c)+B;
% y = A*(1-cos(2*pi*v*x)).*exp(x/tau_c)+B;
% y = A*(1-cos(2*pi*v*x))+B;

end

