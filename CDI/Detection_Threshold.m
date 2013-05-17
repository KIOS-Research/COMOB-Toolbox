function Ey = Detection_Threshold(DA, d, ksi, rho, ksi_d, rho_d, alpha, zita, alpha_d, zita_d, x_hat, t, ns, Ex0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FUNCTION
%Ey = Detection_Threshold(DA, d, ksi, rho, ksi_d, rho_d, alpha, zita, alpha_d, zita_d, x_hat, t, ns, Ex0)
%Give the adaptive threshold for fault Detection
%
%INPUT ARGUMENTS:
%   DA:             A real number that gives the bound for Uncertainties.
%   d:              A real number that gives the bound for noise.
%   ksi,rho:        Choosen real numbers parameters which give the bound for
%                   ||expm(A0*t)|| <= rho*exp(-ksi*t).
%   ksi_d,rho_d:    Choosen real numbers parameters which give the bound
%                   for ||expm(A0*t)*L|| <= rho_d*exp(-ksi_d*t).
%   alpha,zita:     1xns vector with choosen parameters for every zone with
%                   sensor which give the bound for ||Ci*expm(A0*t)|| <= 
%                   alpha(j)*exp(-zita(j)*t) (j corresponds to jth zone 
%                   with sensor). 
%   alpha_d,zita_d: 1xns vector with choosen parameters for every zone with
%                   sensor which give the bound for ||Ci*expm(A0*t)*L|| <=    
%                   alpha_d(j)*exp(-zita_d(j)*t) (j corresponding to jth zone
%                   with sensor).
%   x_hat:          TxN matrix which gives the state of the observer whose 
%                   columns are the number of zones and rows correspond to 
%                   the time. 
%   t:              1xT vector correspond to the time step. 
%   ns:             An integer number for the number of sensors.
%
%OUTPUT ARGUMENTS:
%   Ey:             Txns matrix which gives the adaptive threshold for
%                   Detection for each zone that have sensor. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Find the state estimation error threshold Ex.

for i=1:length(t)
    E1(i) = rho*exp(-ksi*t(i))*Ex0;
end

% find the norm x_hat for every time step.
for i=1:length(t)
    x_hat_norm(i)= norm(x_hat(i,:)');
end

sys1 = tf(rho*DA, [1 ksi]);
E1_DA = lsim(sys1, x_hat_norm, t);


sys2 = tf(rho_d*d, [1 ksi_d]);
inp = ones(1,length(t));
E1_d = lsim(sys2, inp, t);

E1_t = E1' + E1_DA + E1_d;

sys3 = tf(rho*DA, [1 ksi-rho*DA]);

E2_t = lsim(sys3, E1_t, t);

Ex = E1_t + E2_t;

%% Find the output estimation error threshold Ey.

for j=1:ns
    for i=1:length(t)
        Ey1(i,j) = alpha(j)*exp(-zita(j)*t(i))*Ex0;
    end
end

for i = 1:ns
    sys4 = tf(alpha(i)*DA, [1 zita(i)]);
    sys5 = tf(alpha_d(i)*d, [1 zita_d(i)]);
    Ey1DA(:,i) = lsim(sys4, x_hat_norm, t);
    Ey2DA(:,i) = lsim(sys4, Ex, t);
    Ey1d(:,i) = lsim(sys5, inp, t);
end

for i = 1:ns
    Ey(:,i) = Ey1(:,i) + Ey1DA(:,i) + Ey2DA(:,i) + Ey1d(:,i) + d;
end