function rowsum(A) #Returns a column vector containing the row sums of square matrix A
    m = size(A,1)
    rowsum = zeros(m,1)
    for i in 1:m
        rowsum[i] = sum(A[i,:])
    end
    return rowsum
end
####################################
function colsum(A) #Returns a column vector containing the column sums of square matrix A
    n = size(A,2)
    colsum = zeros(n,1)
    for i in 1:n
        colsum[i] = sum(A[:,i])
    end
    return colsum
end
########################################
function rs_ize(A) #Returns a row stochastic matrix, given a nonnegative matrix A
    rsA = rowsum(A)
    A = inv(diagm(vec(rsA)))*A  #A is row stochastic
    return A
end
############################################
# Φ cal with sigmoid
function Φ(dif,F,W)
    sig1 = 1-(1+exp(F*(dif+W)))^(-1)
    sig2 = (1+exp(F*(dif-W))).^(-1)
    return sig1 .* sig2
end
######################################
# HK model (for update)
function HK_update(A,x_os_up,F,W)
    N_a = size(A,2)
    xup = zeros(N_a,1)
    confi = 0;
    update = 0;
    for i in 1:N_a
        confi = sum(A[i,j]*Φ(x_os_up[j,1]-x_os_up[i,1],F,W) for j in 1:N_a)
        update = sum(A[i,j]*(Φ(x_os_up[j,1]-x_os_up[i,1],F,W)*(x_os_up[j,1]-x_os_up[i,1])) for j in 1:N_a)
        xup[i,1] = x_os_up[i,1] + (1/confi)*(update)
        update = 0
        confi = 0
    end 
    return xup
end
###################################
#Projection of vector x_os onto the hypercube [-1,1]^n
function hyp_proj(x_os)
    for i in 1:length(x_os)
        if x_os[i] >= 1
            x_os[i] = 1
        end
        if x_os[i] <= -1
            x_os[i] = -1
        end
    end
    return x_os
end
####################################
#Control of opinion dynamics control in social network
####################################
#COD = controlled opinion dynamics
#OSA = one step ahead
#x_os = current state 
#targ = vector of targets for 1 player
#b = input coupling vector for 1 player
#This function is set up to update agent states under the action of one player
#Written for the case of one player at a time, OSA, Gauss-Seidel updates
function COD_OSA_J_DeGroot(x_init,player_targets,γ,K_f,A,B,N_a,N_p,proj_flag)
#Initialize arrays
    #N_a = length(x_init) #Number of agents
    #N_p = length(player_targets) #Number of players
    x_os = zeros(N_a,K_f + 1)  #Column j: opinions of N_a agents at instant j, Row i: time evolution of agent i's opinion
    u_os = zeros(N_p,K_f)      #Column j: controls of N_p players at instant j, Row i: time evolution of player i's controls
    x_os[:,1] = x_init         #Initial states (opinions) of each agent
    temp = zeros(N_a,1)        #Temporary vector to projection  
    for k in 1:K_f #Time loop
            for p in 1:N_p #player loop
            
                #Name the model, define the solver and set its attributes
                S = "$p"
                S = Model(Ipopt.Optimizer)
                set_optimizer_attributes(S, "print_level" => 0 )
            
                #Define the optimization variables
                @variable(S, v) #v is the scalar value of the control for player p
                @variable(S, xn[1:N_a,1:1]) #xn is the new state of agent influenced by p
            
                #Define the control constraints
                #@constraint(S, u_min <= v <= u_max)
            
                #Define the dynamical constraint
                @constraint(S, xn .== A*x_os[:,k] + B[:,p]*v)
                #@constraint(S, 0 .<= xn .<= 1 )
                #Define the objective function for each agent
                @objective(S, Min, sum((xn - player_targets[:,p]).^2) + γ[p]*v*v)
            
                optimize!(S)
            
                #Retrieve optimal values for k-th iteration (instant)
                u_os[p,k] = JuMP.value.(S[:v])
            end
        temp[:,1] = A*x_os[:,k] + B*u_os[:,k]
        
        if proj_flag == 1
            x_os[:,k+1] = hyp_proj(temp[:,1])
        else
            x_os[:,k+1] = temp[:,1]
        end
    end
    return x_os, u_os
end
############################################################
#COD = controlled opinion dynamics, J = Jacobi information exchange; targets for players are specified
function COD_OSA_J_targets_FJ(x_init,player_targets,γ,K_f,A,B,Θ,N_a,N_p,proj_flag)
#Initialize arrays
    #N_a = length(x_init) #Number of agents
    #N_p = length(player_targets) #Number of players
    x_os = zeros(N_a,K_f + 1)  #Column j: opinions of N_a agents at instant j, Row i: time evolution of agent i's opinion
    u_os = zeros(N_p,K_f)      #Column j: controls of N_p players at instant j, Row i: time evolution of player i's controls
    x_os[:,1] = x_init         #Initial states (opinions) of each agent
    temp = zeros(N_a,1)        #Temporary vector to projection  
    for k in 1:K_f #Time loop
            for p in 1:N_p #player loop
            
                #Name the model, define the solver and set its attributes
                S = "$p"
                S = Model(Ipopt.Optimizer)
                set_optimizer_attributes(S, "print_level" => 0 )
            
                #Define the optimization variables
                @variable(S, v) #v is the scalar value of the control for player p
                @variable(S, xn[1:N_a,1:1]) #xn is the new state of agent influenced by p
            
                #Define the control constraints
                #@constraint(S, u_min <= v <= u_max)
            
                #Define the dynamical constraint
                @constraint(S, xn .== A*x_os[:,k] + Θ*x_init + B[:,p]*v)
                #@constraint(S, 0 .<= xn .<= 1 )
                #Define the objective function for each agent
                @objective(S, Min, sum((xn - player_targets[:,p]).^2) + γ[p]*v*v)
            
                optimize!(S)
            
                #Retrieve optimal values for k-th iteration (instant)
                u_os[p,k] = JuMP.value.(S[:v])
            end
        temp[:,1] = A*x_os[:,k] + Θ*x_init + B*u_os[:,k]
        
        if proj_flag == 1
            x_os[:,k+1] = hyp_proj(temp[:,1])
        else
            x_os[:,k+1] = temp[:,1]
        end
    end
    return x_os, u_os
end

############################################################
# HK with control using Jacobi update
function COD_OSA_J_targets_HK(x_init,targets,γ,K_f,A,B,u_min,u_max,F,W,flag_proj)
    #Initialize arrays
    N_a = size(A,1)
    N_p = size(B,2)
    x_os = zeros(N_a,K_f + 1)  #Column j: opinions of N_a agents at instant j, Row i: time evolution of agent i's opinion
    x_os[:,1] = x_init         #Initial states (opinions) of each 
    u_os = zeros(N_p,K_f)      #Column j: controls of N_p players at instant j, Row i: time evolution of player i's controls    
    
    for k in 1:K_f #Time loop
            for p in 1:N_p #player loop
                #Name the model, define the solver and set its attributes
                S = "$p"
                S = Model(Ipopt.Optimizer)
                set_optimizer_attributes(S, "print_level" => 0 )
            
                #Define the optimization variables
                @variable(S, v) #v is the scalar value of the control for player p
                @variable(S, xn[1:N_a,1:1]) #xn is the new state of agent influenced by p
            
                #Define the control constraints
                @constraint(S, u_min <= v <= u_max)
            
                #Define the dynamical constraint
                @constraint(S, xn .== HK_update(A,x_os[:,k],F,W) + B[:,p]*v)
                #@constraint(S, 0 .<= xn .<= 1 ) #Restrição nas opiniões
                #Define the objective function for each agent
                @objective(S, Min, sum((xn - targets[:,p]).^2) + γ[p]*v*v)
            
                optimize!(S)
            
                #Retrieve optimal values for k-th iteration (instant)
                u_os[p,k] = JuMP.value.(S[:v])
            end
        
        x_int = HK_update(A,x_os[:,k],F,W) + B*u_os[:,k]
        
        if flag_proj == 1
            x_os[:,k+1] = hyp_proj(x_int)
        else
            x_os[:,k+1] = x_int
        end
    end
    
    return x_os, u_os
end