function plot_opinions(x_os,N)
    figure(figsize=(6,6))
    grid()
    for i in 1:size(x_os,1)
        plot(x_os[i,1:N],".-")
    end
    #=
    plot(x1_hat_4.*ones(K_f_4,1),"--",color = "blue");
    plot(x2_hat_4.*ones(K_f_4,1),"--",color = "darkorange");
    plot(x3_hat_4.*ones(K_f_4,1),"--",color = "green");
    =#
    xlabel("Time")
    ylabel("Opinions \$x_i\$, \$i=1,...,5\$")
    #legend([L"x_1",L"x_2", L"x_3", L"x_4", L"x_5"],loc="best")
    legend([L"x_1",L"x_2", L"x_3", L"x_4", L"x_5",L"x_6",L"x_7", L"x_8", L"x_9", L"x_{10}"],loc="best")
    title("Time plots of opinion: DeGroot+Control model, Gauss-Seidel proc.")
end

###########################################################
function plot_targ_5a3p(x_plot, target, T, model, save)
    figure(figsize=(6,6))
    grid()
    if model == 1
        for i in 1:5
            plot(x_plot[i,1:T],".-")
        end
    elseif model == 2
        for i in 6:10
            plot(x_plot[i,1:T],".-")
        end
    elseif model == 3
        for i in 11:15
            plot(x_plot[i,1:T],".-")
        end
    end
    plot(target[1].*ones(T,1),"--",color = "blue");
    plot(target[2].*ones(T,1),"--",color = "darkorange");
    plot(target[3].*ones(T,1),"--",color = "green");
    xlabel("Time")
    ylabel("Opinions \$x_i\$")
    legend([L"x_1",L"x_2", L"x_3", L"x_4", L"x_5",L"goal_1",L"goal_2", L"goal_3"],loc="right")
    
    if model == 1
        title("Time plots of opinion: dGc, Jacobi procedure")
        if save == 1
            savefig("DeGroot_Jacobi_5players.png")
            savefig("DeGroot_Jacobi_5players.eps")
        end
    elseif model == 2
        title("Time plots of opinion: FJc, Jacobi procedure")
        if save == 1
            savefig("FJ_Jacobi_5players.png")
            savefig("FJ_Jacobi_5players.eps")
        end
    elseif model == 3
        title("Time plots of opinion: HKc, Jacobi procedure")
        if save == 1
            savefig("HK_GS_5players.png")
            savefig("HK_GS_5players.eps")
        end
    end 
end
#############################################################
function plot_targ_10a(x_plot, T, model, save)
    figure(figsize=(6,6))
    grid()
    if model == 1
        for i in 1:10
            plot(x_plot[i,1:T],".-")
        end
    elseif model == 2
        for i in 11:20
            plot(x_plot[i,1:T],".-")
        end
    elseif model == 3
        for i in 21:30
            plot(x_plot[i,1:T],".-")
        end
    end
    xlabel("Time")
    ylabel("Opinions \$x_i\$")
    legend([L"x_1",L"x_2", L"x_3", L"x_4", L"x_5", L"x_6", L"x_7", L"x_8", L"x_9", L"x_{10}"],loc="right")
    
    if model == 1
        title("Time plots of opinion: dGc, Jacobi procedure")
        if save == 1
            savefig("DeGroot_Jacobi_10a.png")
            savefig("DeGroot_Jacobi_10a.eps")
        end
    elseif model == 2
        title("Time plots of opinion: FJc, Jacobi procedure")
        if save == 1
            savefig("FJ_Jacobi_10a.png")
            savefig("FJ_Jacobi_10a.eps")
        end
    elseif model == 3
        title("Time plots of opinion: HKc, Jacobi procedure")
        if save == 1
            savefig("HK_Jacobi_10a.png")
            savefig("HK_Jacobi_10a.eps")
        end
    end 
end