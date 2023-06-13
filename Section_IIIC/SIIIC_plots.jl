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