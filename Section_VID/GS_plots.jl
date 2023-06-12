function plot_targ_5a3p(x_plot, target, T, perm_flag, model, save)
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
    ylabel("Opinions \$x_i\$, \$i=1,...,5\$")
    legend([L"x_1",L"x_2", L"x_3", L"x_4", L"x_5",L"goal_1",L"goal_2", L"goal_3"],loc="right")
    
    if model == 1
        if perm_flag == 0
            title("Time plots of opinion: dGc, Gauss-Seidel procedure")
            if save == 1
                savefig("DeGroot_GS_5players_noperm.png")
                savefig("DeGroot_GS_5players_noperm.eps")
            end
        elseif perm_flag == 1
            title("Time plots of opinion: dGc, RGS procedure")
            if save == 1
                savefig("DeGroot_GS_5players_perm.png")
                savefig("DeGroot_GS_5players_perm.eps")
            end
        end
    elseif model == 2
        if perm_flag == 0
            title("Time plots of opinion: FJc, Gauss-Seidel procedure")
            if save == 1
                savefig("FJ_GS_5players_noperm.png")
                savefig("FJ_GS_5players_noperm.eps")
            end
        elseif perm_flag == 1
            title("Time plots of opinion: FJc, RGS procedure")
            if save == 1
                savefig("FJ_GS_5players_perm.png")
                savefig("FJ_GS_5players_perm.eps")
            end
        end
    elseif model == 3
        if perm_flag == 0
            title("Time plots of opinion: HKc, Gauss-Seidel procedure")
            if save == 1
                savefig("HK_GS_5players_noperm.png")
                savefig("HK_GS_5players_noperm.eps")
            end
        elseif perm_flag == 1
            title("Time plots of opinion: HKc, RGS procedure")
            if save == 1
                savefig("HK_GS_5players_perm.png")
                savefig("HK_GS_5players_perm.eps")
            end
        end
    end 
end
###############################################################################################
function plot_targ_10a(x_plot, T, perm_flag, model, save)
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
        if perm_flag == 0
            title("Time plots of opinion: dGc, Gauss-Seidel procedure, no perm")
            if save == 1
                savefig("DeGroot_GS_10a_noperm.png")
                savefig("DeGroot_GS_10a_noperm.eps")
            end
        elseif perm_flag == 1
            title("Time plots of opinion: dGc, RGS procedure")
            if save == 1
                savefig("DeGroot_GS_10a_perm.png")
                savefig("DeGroot_GS_10a_perm.eps")
            end
        end
    elseif model == 2
        if perm_flag == 0
            title("Time plots of opinion: FJc, Gauss-Seidel procedure, no perm")
            if save == 1
                savefig("FJ_GS_10a_noperm.png")
                savefig("FJ_GS_10a_noperm.eps")
            end
        elseif perm_flag == 1
            title("Time plots of opinion: FJc, RGS procedure")
            if save == 1
                savefig("FJ_GS_10a_perm.png")
                savefig("FJ_GS_10a_perm.eps")
            end
        end
    elseif model == 3
        if perm_flag == 0
            title("Time plots of opinion: HKc, Gauss-Seidel procedure, no perm")
            if save == 1
                savefig("HK_GS_10a_noperm.png")
                savefig("HK_GS_10a_noperm.eps")
            end
        elseif perm_flag == 1
            title("Time plots of opinion: HKc, RGS procedure")
            if save == 1
                savefig("HK_GS_10a_perm.png")
                savefig("HK_GS_10a_perm.eps")
            end
        end
    end 
end