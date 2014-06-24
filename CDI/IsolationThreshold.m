function [Eyj Initial] = IsolationThreshold(DA, d, ksi, rho, ksi_d, rho_d, alpha, zita, alpha_d, zita_d, t, Dt, DetectionTime, ns, C, Theta, Ez0, ZITA, Omega, Initial)
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
    
    [ass2 bss2 css2 dss2] = tf2ss(rho_d*d, [1 ksi_d]);
    sys2 = ss(ass2, bss2, css2, dss2);

    % sys2 = tf(rho_d*d, [1 ksi_d]);
    Ezj3 = lsim(sys2, inp, Dt, Initial.Ezj30);
    Initial.Ezj30 = Ezj3(length(t))/rho_d*d;

    parfor j = 1:zn
        Ejt(j,:) = Omega_abs(j,:)*Theta + Ezj1 + Ezj2(j,:) + Ezj3';
    end


    [ass3 bss3 css3 dss3] = tf2ss(rho*DA, [1 ksi-rho*DA]);
    sys3 = ss(ass3, bss3, css3, dss3);
%     sys3 = tf(rho*DA, [1 ksi-(rho*DA)]);
    parfor j = 1:zn 
        Ejda(j,:) = lsim(sys3, Ejt(j,:), Dt, Initial.Ejda0(j));        
    end
    Initial.Ejda0 = Ejda(:,length(t))/rho*DA;
    
    Ezj_th = Ejt + Ejda;

    % Ey
    for j=1:ns
        for k=1:length(t)
            Eyj1(j,k)=alpha(j)*exp(-zita(j)*(t(k)-DetectionTime))*Ez0;
            C_Omega(j,k)= norm(C(j,:)*Omega(k,:)');
        end
    end
    
    parfor j=1:ns
        [ass4 bss4 css4 dss4] = tf2ss(alpha(j)*DA, [1 zita(j)]);
        sys4 = ss(ass4, bss4, css4, dss4);
        [ass5 bss5 css5 dss5] = tf2ss(alpha_d(j)*d, [1 zita_d(j)]);
        sys5 = ss(ass5, bss5, css5, dss5);
%         sys4= tf(alpha(j)*DA, [1 zita(j)]);
%         sys5= tf(alpha_d(j)*d, [1 zita_d(j)]);

        Eyj2(j,:)= lsim(sys4, Ezj_th(j,:), Dt, Initial.Eyj20(j));        
        Eyj3(j,:)= lsim(sys4, abs(ZITA(j,:)), Dt, Initial.Eyj30(j));        
        Eyj4(j,:)= lsim(sys5, inp, Dt, Initial.Eyj40(j));        
        Eyj(j,:) = C_Omega(j,:)*Theta + Eyj1(j,:) + Eyj2(j,:) + Eyj3(j,:) + Eyj4(j,:) + d;

    end
    
    Initial.Eyj20 = Eyj2(:,length(t))./(alpha.*DA)';
    Initial.Eyj30 = Eyj3(:,length(t))./(alpha.*DA)';
    Initial.Eyj40 = Eyj4(:,length(t))./(alpha_d.*d)';
%         Eyj = Eyj';
    warning on all
