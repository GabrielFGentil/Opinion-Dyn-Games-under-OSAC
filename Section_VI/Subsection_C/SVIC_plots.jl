##########################################################
function plot_opinions(x_os,N,fig_no_x,save_flag_x)
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
    ylabel("Opinions \$x_i\$")
    #legend([L"x_1",L"x_2", L"x_3", L"x_4", L"x_5"],loc="best")
    legend([L"x_1",L"x_2", L"x_3", L"x_4", L"x_5",L"x_6",L"x_7", L"x_8", L"x_9", L"x_{10}",L"x_{11}"],loc="best")
    title("Time plots of opinion")
    if save_flag_x == 1
        savefig("opinions_$fig_no_x.png")
    end
end
##########################################################
function plot_controls(u_os,N,fig_no_u,save_flag_u)
    figure(figsize=(6,6))
    grid()
    N_p = size(u_os,1)
    for i in 1:N_p
        plot(u_os[i,1:N],".-")
    end
#=
plot(x1_hat_4.*ones(K_f_4,1),"--",color = "blue");
plot(x2_hat_4.*ones(K_f_4,1),"--",color = "darkorange");
plot(x3_hat_4.*ones(K_f_4,1),"--",color = "green");
=#
    xlabel("Time")
    ylabel("Opinions \$u_i\$")
    #legend([L"x_1",L"x_2", L"x_3", L"x_4", L"x_5"],loc="best")
    legend([L"u_1",L"u_2", L"u_3", L"u_4", L"u_5",L"u_6",L"u_7", L"u_8", L"u_9", L"u_{10}",L"u_{11}"],loc="best")
    title("Time plots of controls")
    if save_flag_u == 1
        savefig("controls_$fig_no_u.png")
    end
end
##########################################################