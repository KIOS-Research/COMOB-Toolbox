function [Ey Initial] = DetectionThresholdCDI(DA, DH, d, ksi, rho, ksi_d, rho_d, ksi_z, rho_z, alpha, zita, alpha_d, zita_d, alpha_z, zita_z, x_hat, t, Dt, ns, Ex0, zd, z , Initial)
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
%                   Detection of each zone that have sensor. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Find the state estimation error threshold Ex.
    warning off all

    parfor j=1:length(t)
        E1(j) = rho*exp(-ksi*t(j))*Ex0;
    end

    [ass1 bss1 css1 dss1] = tf2ss(rho*DA, [1 ksi]);
    sys1 = ss(ass1, bss1, css1, dss1);

    % find the norm x_hat for every time step.
%     for i=1:length(t)
%         x_hat_norm(i)= norm(x_hat(i,:)');
%     %     fnorm(i) = norm(B*f(:,i));
%     end
    parfor j=1:ns 
        E1_DA(j,:) = lsim(sys1, abs(x_hat(:,j)), Dt, Initial.E1_DA0(j));        
    end
    Initial.E1_DA0 = E1_DA(:,2)/(rho*DA);
    Initial.E1_DA0(isnan(Initial.E1_DA0)) = 0;
    
    [ass2 bss2 css2 dss2] = tf2ss(rho_d*d, [1 ksi_d]);
    sys2 = ss(ass2, bss2, css2, dss2);
    
    inp = ones(1,2);

    E1_d = lsim(sys2, inp, Dt, Initial.E1_d0);
    Initial.E1_d0 = E1_d(2)/(rho_d*d);
    Initial.E1_d0(isnan(Initial.E1_d0)) = 0;
    
    [ass3 bss3 css3 dss3] = tf2ss(rho_z, [1 ksi_z]);
    sys3 = ss(ass3, bss3, css3, dss3);
    
    E1zd = lsim(sys3, zd, Dt, Initial.E1zd0);
    Initial.E1zd0 = E1zd(2)/(rho_z);
    Initial.E1zd0(isnan(Initial.E1zd0)) = 0;
    
   
    [ass4 bss4 css4 dss4] = tf2ss(rho*DH, [1 ksi]);
    sys4 = ss(ass4, bss4, css4, dss4);
    
    E1z = lsim(sys4, z, Dt, Initial.E1z0);
    Initial.E1z0 = E1z(2)/(rho*DH);
    Initial.E1z0(isnan(Initial.E1z0)) = 0;   
    
    parfor j=1:ns
        E1_t(j,:) = E1 + E1_DA(j,:) + E1_d' + E1zd' + E1z';
    end
        
    [ass5 bss5 css5 dss5] = tf2ss(rho*DA, [1 ksi-rho*DA]);
    sys5 = ss(ass5, bss5, css5, dss5);
    
    parfor j=1:ns
        E2_t(j,:) = lsim(sys5, E1_t(j,:), Dt, Initial.E2_t0(j));         
    end
    
    Initial.E2_t0 = E2_t(:,2)/(rho*DA);
    Initial.E2_t0(isnan(Initial.E2_t0)) = 0;   
    
    Ex = E1_t + E2_t;
    %% Find the output estimation error threshold Ey.
    
    parfor k=1:ns
            Ey1(k,:) = alpha(k)*exp(-zita(k).*t)*Ex0;
    end
    
    parfor j = 1:ns
        [ass6 bss6 css6 dss6] = tf2ss(alpha(j)*DA, [1 zita(j)]);
        sys6 = ss(ass6, bss6, css6, dss6);
        [ass7 bss7 css7 dss7] = tf2ss(alpha_d(j)*d, [1 zita_d(j)]);
        sys7 = ss(ass7, bss7, css7, dss7);
        [ass8 bss8 css8 dss8] = tf2ss(alpha_z(j), [1 zita_z(j)]);
        sys8 = ss(ass8, bss8, css8, dss8);
        [ass9 bss9 css9 dss9] = tf2ss(alpha(j)*DH, [1 zita(j)]);
        sys9 = ss(ass9, bss9, css9, dss9);        
        Ey1DA(j,:) = lsim(sys6, abs(x_hat(:,j)), Dt, Initial.Ey1DA0(j));        
        Ey2DA(j,:) = lsim(sys6, abs(Ex(j,:)), Dt, Initial.Ey2DA0(j));        
        Ey1d(j,:) = lsim(sys7, inp, Dt, Initial.Ey1d0(j));
        Ey2d(j,:) = lsim(sys8, zd, Dt, Initial.Ey2d0(j));
        Ey1DH(j,:)= lsim(sys9, z, Dt, Initial.Ey1DH0(j));       
    end
    
    Initial.Ey1DA0 = Ey1DA(:,2)./(alpha.*DA)';
    Initial.Ey1DA0(isnan(Initial.Ey1DA0)) = 0;
    Initial.Ey2DA0 = Ey2DA(:,2)./(alpha.*DA)';
    Initial.Ey2DA0(isnan(Initial.Ey2DA0)) = 0;
    Initial.Ey1d0 = Ey1d(:,2)./(alpha_d.*d)';
    Initial.Ey1d0(isnan(Initial.Ey1d0)) = 0;
    Initial.Ey2d0 = Ey2d(:,2)./(alpha_z)';
    Initial.Ey2d0(isnan(Initial.Ey2d0)) = 0;
    Initial.Ey1DH0 = Ey1DH(:,2)./(alpha.*DH)';
    Initial.Ey1DH0(isnan(Initial.Ey1DH0)) = 0;
    
    
    parfor j = 1:ns
        Ey(j,:) = Ey1(j,:) + Ey1DA(j,:) + Ey2DA(j,:) + Ey1d(j,:) + Ey2d(j,:) + Ey1DH(j,:) + ones(1,2)*d; 
    end
        
    warning on all
    