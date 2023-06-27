function plot_2a_2p(x_os, save)
    plot(x_os[1,:]', "*-",  color = "blue")
    plot(x_os[2,:]', "*-",  color = "red")
    plot(targets[1,1].*ones(K_f+1,1),"--",color = "blue");
    plot(targets[2,2].*ones(K_f+1,1),"--",color = "red");
    grid()
    legend([L"x_{1}", L"x_{2}", L"g_1", L"g_2"], loc="right")
    xlabel("Time")
    ylabel("Opinions \$x_i\$, \$i=1,2\$")
    title("Time plot of opinions")
    if save == 1
        savefig("GS_2a_plot.eps")
        savefig("GS_2a_plot.png")
    end
end
##########################################################################
function scatter_plot(x_plot,save)
    plot(0:0.1:0.8,0.1.*ones(9,1), "--", color = "red")
    plot(0.8.*ones(6,1),0:0.1:0.5, "--", color = "blue")
    for i in 1:20
        if iseven(i) == true
            plot(x_plot[1,i:i+1]',x_plot[2,i:i+1]', "-*", color = "red")
        else
            plot(x_plot[1,i:i+1]',x_plot[2,i:i+1]', "-*", color = "blue")
        end
    end
    xlabel(L"x_1", size=14 )
    ylabel(L"x_2", size=14)
    
    #lot(0.1.*ones(2,1),"--",color = "blue");
    grid()
    legend([L"g_{1}", L"g_{2}", L"P_1", L"P_2"])
    if save == 1
        savefig("GS_2a_scatter.eps")
        savefig("GS_2a_scatter.png")
    end
end

###########################################################################
function extra_plot(x_os,targets,K_f)
    figure(figsize=(6,6))
    grid()
    plot(x_os', "*-")
    plot(targets[1,1].*ones(K_f+1,1),"--",color = "blue");
    plot(targets[2,2].*ones(K_f+1,1),"--",color = "red");
    legend([L"x_1",L"x_2",L"x_3", L"g_1", L"g_2"], loc = "right")
    xlabel(L"Time")
    ylabel("Opinions \$x_i\$, \$i=1,2,3\$")
    title("Time plot of opinions")
end
########################################################################
function extra_3Dplot(x_plot, h, v, T)
    ax = gca(projection="3d")
    for i in 1:T
        k = string("$i")
        if iseven(i) == true 
            PyPlot.plot3D(x_plot[1,i:i+1]',x_plot[2,i:i+1]', x_plot[3,i:i+1]', "-*", color = "red")
        else
            PyPlot.plot3D(x_plot[1,i:i+1]',x_plot[2,i:i+1]', x_plot[3,i:i+1]', "-*", color = "blue")
        end
    end
    xlabel(L"x_1"); ylabel(L"x_2"); zlabel(L"x_3")
    grid()
    legend([L"P_1", L"P_2"])
    ax[:view_init](h, v)
end
###########################################################################
function plot_insider(x_os)
    myfig = gcf()
    clf()

    plot(0.8.*ones(6,1),0:0.1:0.5, "--", color = "blue")
    plot(0:0.1:0.8,0.1.*ones(9,1), "--", color = "red")

    for i in 1:20
        plot(x_os[1,i:i+1]',x_os[2,i:i+1]', "-*")
    end
    xlabel(L"x_1", size = "14")
    ylabel(L"x_2", size = "14")

    grid()
    legend([L"g_1",L"g_2"])
    text(0.46, 0.48, L"x_0", size = "12")
    text(0.6, 0.11, L"x_1", size = "12")
    text(0.805, 0.23, L"x_2", size = "12")
    text(0.75, 0.31, L"x_3", size = "12")
    text(0.68, 0.078, L"x_4", size = "12")
    title("Phase plane plot: 2 players, 2 agents")


    ax2 = myfig.add_axes([0.3,0.4,0.3,0.3])
    grid()
    for i in 1:4
        plot(x_os[1,i:i+1]',x_os[2,i:i+1]', "-*")
    end
    text(0.52, 0.48, L"x_0", size = "12")
    text(0.6, 0.11, L"x_1", size = "12")
    text(0.77, 0.17, L"x_2", size = "12")
    text(0.75, 0.31, L"x_3", size = "12")
    text(0.69, 0.09, L"x_4", size = "12")
end