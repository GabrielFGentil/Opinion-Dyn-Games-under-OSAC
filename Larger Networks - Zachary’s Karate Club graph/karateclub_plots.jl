function plot_opinions(x_os,T)
    figure(figsize=(6,6))
    PyPlot.grid()
    for i in 1:size(x_os,1)
        plot(x_os[i,1:T],".-")
    end
    xlabel("Time")
    ylabel("Opinions \$x_i\$")
    title("Karate Club with Jacobi Procedure")
end

function plot_opinions2(x_os,T)
    figure(figsize=(6,6))
    PyPlot.grid()
    for i in 1:size(x_os,1)
        plot(x_os[i,1:T],".-")
    end
    xlabel("Time")
    ylabel("Opinions \$x_i\$")
    if perm_flag == 0
        title("Karate Club with GS Procedure")
    elseif perm_flag == 1
        title("Karate Club with RGS Procedure")
    end
end

function plot_control(u_os,T)
    figure(figsize=(6,6))
    grid()
    for i in 1:size(u_os,1)
        plot(u_os[i,1:T],".-")
    end
    
    xlabel("Time")
    ylabel("Controls \$u_i\$")
    legend([L"u_1",L"u_2", L"u_3", L"u_4"],loc="best")
    title("Plots for control")
end
