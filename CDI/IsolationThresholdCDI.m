function [Eyj Initial] = IsolationThresholdCDI(DA, DH, d, ksi, rho, ksi_d, rho_d, ksi_z, rho_z, alpha, zita, alpha_d, zita_d, alpha_z, zita_z, t, Dt, DetectionTime, ns, C, Theta, Ez0, ZITA, Omega, zd, z, inzone, Initial)
    warning off all
    clear inp
    inp = ones(1,length(t));

    [zn tm] = size(ZITA);
    % Ez
    for k = 1:length(t)
        for j = 1:zn
            Omega_abs(j,k) = norm(Omega(k,j));
        end
%         Omega_abs(k) = norm(Omega(k,:));
%         ZITA_abs(k)= norm(ZITA(:,k));
        Ezj1(k)=rho*exp(-ksi*(t(k)-DetectionTime))*Ez0;
    end

    [ass1 bss1 css1 dss1] = tf2ss(rho*DA, [1 ksi]);
    sys1 = ss(ass1, bss1, css1, dss1);

    % sys1 = tf(rho*DA, [1 ksi]);
    parfor j = 1:zn
        Ezj2(j,:) = lsim(sys1, abs(ZITA(j,:)), Dt, Initial.Ezj20(j));        
    end
    
    Initial.Ezj20 = Ezj2(:,length(t))/rho*DA;
    Initial.Ezj20(isnan(Initial.Ezj20)) = 0;
    
    [ass2 bss2 css2 dss2] = tf2ss(rho_d*d, [1 ksi_d]);
    sys2 = ss(ass2, bss2, css2, dss2);

    % sys2 = tf(rho_d*d, [1 ksi_d]);
    Ezj3 = lsim(sys2, inp, Dt, Initial.Ezj30);
    Initial.Ezj30 = Ezj3(length(t))/rho_d*d;
    Initial.Ezj30(isnan(Initial.Ezj30)) = 0;
    
    
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

    parfor j = 1:zn
        Ejt(j,:) = Omega_abs(j,:)*Theta + Ezj1 + Ezj2(j,:) + Ezj3';
    end
    
    for j = inzone 
        Ejt(j,:) = Ejt(j,:) + E1z' + E1zd';
    end
    
    
    [ass5 bss5 css5 dss5] = tf2ss(rho*DA, [1 ksi-rho*DA]);
    sys5 = ss(ass5, bss5, css5, dss5);

    parfor j = 1:zn 
        Ejda(j,:) = lsim(sys5, Ejt(j,:), Dt, Initial.Ejda0(j));        
    end
    Initial.Ejda0 = Ejda(:,length(t))/rho*DA;
    Initial.Ejda0(isnan(Initial.Ejda0)) = 0;

    Ezj_th = Ejt + Ejda;
   
% Ey
    for j=1:ns
        for k=1:length(t)
            Eyj1(j,k)=alpha(j)*exp(-zita(j)*(t(k)-DetectionTime))*Ez0;
            C_Omega(j,k)= norm(C(j,:)*Omega(k,:)');
        end
    end

    parfor j=1:ns
        [ass6 bss6 css6 dss6] = tf2ss(alpha(j)*DA, [1 zita(j)]);
        sys6 = ss(ass6, bss6, css6, dss6);
        [ass7 bss7 css7 dss7] = tf2ss(alpha_d(j)*d, [1 zita_d(j)]);
        sys7 = ss(ass7, bss7, css7, dss7);
        [ass8 bss8 css8 dss8] = tf2ss(alpha_z(j), [1 zita_z(j)]);
        sys8 = ss(ass8, bss8, css8, dss8);
        [ass9 bss9 css9 dss9] = tf2ss(alpha(j)*DH, [1 zita(j)]);
        sys9 = ss(ass9, bss9, css9, dss9);

        Eyj2(j,:)= lsim(sys6, C(j,:)*Ezj_th, Dt, Initial.Eyj20(j));        
        Eyj3(j,:)= lsim(sys6, abs(C(j,:)*ZITA), Dt, Initial.Eyj30(j));        
        Eyj4(j,:)= lsim(sys7, inp, Dt, Initial.Eyj40(j));
        Eyj5(j,:) = lsim(sys8, zd, Dt, Initial.Eyj50(j));
        Eyj6(j,:)= lsim(sys9, z, Dt, Initial.Eyj60(j));         

    end
    
    Initial.Eyj20 = Eyj2(:,length(t))./(alpha.*DA)';
    Initial.Eyj20(isnan(Initial.Eyj20)) = 0;
    Initial.Eyj30 = Eyj3(:,length(t))./(alpha.*DA)';
    Initial.Eyj30(isnan(Initial.Eyj30)) = 0;
    Initial.Eyj40 = Eyj4(:,length(t))./(alpha_d.*d)';
    Initial.Eyj40(isnan(Initial.Eyj40)) = 0;
    Initial.Eyj50 = Eyj5(:,length(t))./(alpha_z)';
    Initial.Eyj50(isnan(Initial.Eyj50)) = 0;
    Initial.Eyj60 = Eyj6(:,length(t))./(alpha.*DH)';
    Initial.Eyj60(isnan(Initial.Eyj60)) = 0;
    
    
    parfor j = 1:ns
        Eyj(j,:) = C_Omega(j,:)*Theta + Eyj1(j,:) + Eyj2(j,:) + Eyj3(j,:) + Eyj4(j,:) + Eyj5(j,:) + Eyj6(j,:) + d;
    end
%         Eyj(inzone,:) = Eyj(inzone,:) + Eyj6(inzone,:) + Eyj5(inzone,:);
    warning on all
