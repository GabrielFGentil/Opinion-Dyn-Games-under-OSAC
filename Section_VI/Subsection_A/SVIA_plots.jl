function plot_opinions(x_os,T,save)
    figure(figsize=(6,6))
    grid()
    for i in 1:size(x_os,1)
        plot(x_os[i,1:T],".-")
    end
    xlabel("Time")
    ylabel("Opinions \$x_i\$")
    legend([L"x_1",L"x_2", L"x_3", L"x_4", L"x_5",L"x_6",L"x_7", L"x_8", L"x_9", L"x_{10}"],loc="best")
    title("Time plots of opinion: dGc, Jacobi procedure")
    if save == 1
        savefig("DeGroot_Jacobi_Mazalov_opinions.png")
        savefig("DeGroot_Jacobi_Mazalov_opinions.eps")
    end
end

function plot_control(u_os,T,save)
    figure(figsize=(6,6))
    grid()
    for i in 1:size(u_os,1)
        plot(u_os[i,1:T],".-")
    end
    
    xlabel("Time")
    ylabel("Controls \$u_i\$")
    legend([L"u_1",L"u_2", L"u_3", L"u_4"],loc="best")
    title("Time plots of controls: dGc, Jacobi procedure")
    if save == 1
        savefig("DeGroot_Jacobi_Mazalov_controls.png")
        savefig("DeGroot_Jacobi_Mazalov_controls.eps")
    end
end

function plot_exII(x_os,T,save)
    figure(figsize=(6,6))
    grid()
    for i in 1:size(x_os,1)
        plot(x_os[i,1:T],".-")
    end
    
    plot(x1_hat_2.*ones(T,1),"--",color = "blue");
    plot(x2_hat_2.*ones(T,1),"--",color = "darkorange");
    
    xlabel("Time")
    ylabel("Opinions \$x_i\$, \$i=1,...,5\$")
    legend([L"x_1",L"x_2", L"x_3", L"x_4", L"goal_1",L"goal_2"],loc="right")
    title("Time plots of opinion: dGc, Jacobi procedure")
    if save == 1
        savefig("DeGroot_Jacobi_Mazalov_ex2.png")
        savefig("DeGroot_Jacobi_Mazalov_ex2.eps")
    end
end