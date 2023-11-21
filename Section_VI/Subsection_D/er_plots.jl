###############################################################################################
function plot_targ(x_plot, T, perm_flag, model, save)
    figure(figsize=(6,6))
    PyPlot.grid()
    plot(x_plot',".-")
    xlabel("Time")
    ylabel("Opinions \$x_i\$")
    #legend([L"x_1",L"x_2", L"x_3", L"x_4", L"x_5", L"x_6", L"x_7", L"x_8", L"x_9", L"x_{10}"],loc="right")
    
    if model == 1
        if perm_flag == 0
            title("Time plots of opinion: dGc, GS procedure")
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
            title("Time plots of opinion: FJc, GS procedure")
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
            title("Time plots of opinion: HKc, GS procedure")
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