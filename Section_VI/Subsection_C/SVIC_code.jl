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
####################################
function rs_ize(A) #Returns a row stochastic matrix, given a nonnegative matrix A
    rsA = rowsum(A)
    A = inv(diagm(vec(rsA)))*A  #A is row stochastic
    return A
end
####################################
function approx_proj(b,γ) #Returns the approximate projection P_tilde(b_i,gamma_i), b_i a vector, gamma_i a scalar.
    Ptb = (1/(b'*b + γ))*b*b'
    return Ptb
end
####################################
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
function A_cl_J(A,B,Γ) #Returns the closed-loop matrix for the Jacobi procedure
    #A is the n by n agent stochastic matrix, B n by p player influence matrix, Γ a p vector of control weights
    N_a = size(A,1)
    N_p = size(B,2)
    P = zeros(N_a,N_a)
    for i in 1:N_p
        P = P + approx_proj(B[:,i],Γ[i])
    end
    Ac = (I(N_a) - P)*A
    return Ac
end
####################################
function A_cl_G(A,B,Γ,perm) #Returns the closed-loop matrix for the Jacobi procedure
    #A is the n by n agent stochastic matrix, B n by p player influence matrix, Γ a p vector of control weights
    N_a = size(A,1)
    N_p = size(B,2)
    P = A
    for i in 1:N_p
        P = approx_proj(B[:,perm[i]],Γ[perm[i]])*P
    end
    Ac = P
    return Ac
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
function COD_OSA_1p_update(x_os,targ,γ,A,b)
#Initialize arrays
    N_a = length(x_os) #Number of agents
    S = Model(Ipopt.Optimizer)
    set_optimizer_attributes(S, "print_level" => 0 )
    #Define the optimization variables
    @variable(S, v) #v is the scalar value of the control for player p
    @variable(S, xn[1:N_a]) #xn is the new state of agent influenced by p
    #Define the control constraints
    #@constraint(S, u_min <= v <= u_max)
    #Define the dynamics as an equality constraint
    @constraint(S, xn .== A*x_os + b*v)
    #Define the objective function for agent p
    @objective(S, Min, sum((xn - targ).^2) + γ*v*v) #****************************************
    optimize!(S)
    #Retrieve optimal values for current control
    #u_os = JuMP.value.(S[:v])
    x_os = JuMP.value.(S[:xn]) #Next state (without projection)
    u_os = JuMP.value.(S[:v]) #Next control
    return x_os, u_os
end
############################################################
#Gauss-Seidel agent updates, one player at a time
#COD = controlled opinion dynamics, GS = Gauss-Seidel information flow; one player updates at a time
function COD_OSA_GS(x_init,targets,γ,K_f,A,B,proj_flag,perm_flag)
#Initialize arrays
    N_a = length(x_init) #Number of agents
    N_p = size(targets,2) #Number of players: player_targets is an n by p matrix of targets for the p players
    x_os = zeros(N_a,K_f + 1)  #Column j: opinions of N_a agents at instant j, Row i: time evolution of agent i's opinion
    u_os = zeros(N_p,K_f)      #Column j: controls of N_p players at instant j, Row i: time evolution of player i's controls
    x_os[:,1] = x_init         #Initial states (opinions) of each agent
    x_temp = zeros(length(x_init)) #temporary state, as each agent updates and passes on to the next agent
    for k in 1:K_f #Time loop
        x_temp = x_os[:,k] #Temp. state set to current state
        for p in 1:N_p #player loop
            if perm_flag == 1
                p_reord = RandomPermutation(N_p)
            else
                p_reord = 1:1:N_p
            end
            x_temp = COD_OSA_1p_update(x_temp,targets[:,p_reord[p]],γ[p_reord[p]],A,B[:,p_reord[p]])  #This is executed N_p times
            if proj_flag == 1
                x_temp = hyp_proj(x_temp) #If the projection flag is set to one, each new x_temp is cut to size by projection
            end
        end
        x_os[:,k+1] = x_temp #Here the N_p times updated temp state becomes the current state at iteration k+1
    end
    return x_os
end
##########################################################
#Gauss-Seidel agent updates, one player at a time
#COD = controlled opinion dynamics, GS = Gauss-Seidel information flow; one player updates at a time
function COD_OSA_GS_1p(x_init,targets,γ,K_f,A,B,proj_flag,perm_flag)
#Initialize arrays
    N_a = length(x_init) #Number of agents
    N_p = size(targets,2) #Number of players: player_targets is an n by p matrix of targets for the p players
    x_os = zeros(N_a,K_f + 1)  #Column j: opinions of N_a agents at instant j, Row i: time evolution of agent i's opinion
    u_os = zeros(N_p,K_f)      #Column j: controls of N_p players at instant j, Row i: time evolution of player i's controls
    x_os[:,1] = x_init         #Initial states (opinions) of each agent
    x_temp = zeros(length(x_init)) #temporary state, as each agent updates and passes on to the next agent
    for k in 1:K_f #Time loop
        x_temp = x_os[:,k] #Temp. state set to current state
        if perm_flag == 1
            p_reord = RandomPermutation(N_p)
        else
            p_reord = 1:1:N_p
        end
        for p in 1:N_p #player loop
            x_temp, u_os[p,k] = COD_OSA_1p_update(x_temp,targets[:,p_reord[p]],γ[p_reord[p]],A,B[:,p_reord[p]])  #This is executed N_p times
            if proj_flag == 1
                x_temp = hyp_proj(x_temp) #If the projection flag is set to one, each new x_temp is cut to size by projection
            end
        end
        x_os[:,k+1] = x_temp #Here the N_p times updated temp state becomes the current state at iteration k+1
    end
    return x_os, u_os
end
##########################################################
#Control of opinion dynamics control in social network: OSA, DeGroot, Jacobi approach
#COD = controlled opinion dynamics, J = Jacobi information exchange; targets for players are specified
function COD_OSA_J_targets_DeGroot(x_init,targets,γ,K_f,A,B,u_min,u_max,proj_flag)
    #Initialize arrays
    N_a = size(A,1)
    N_p = size(B,2)
    x_os = zeros(N_a,K_f + 1)  #Column j: opinions of N_a agents at instant j, Row i: time evolution of agent i's opinion
    u_os = zeros(N_p,K_f)      #Column j: controls of N_p players at instant j, Row i: time evolution of player i's controls
    x_os[:,1] = x_init         #Initial states (opinions) of each agent
    temp = zeros(N_a,K_f+1)        #Temporary vector to projection
    temp[:,1] = x_init
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
                @constraint(S, xn .== A*x_os[:,k] + B[:,p]*v)
                @constraint(S, 0 .<= xn .<= 1 ) #Restrição nas opiniões
                #Define the objective function for each agent
                @objective(S, Min, sum((xn - targets[:,p]).^2) + γ[p]*v*v)
            
                optimize!(S)
            
                #Retrieve optimal values for k-th iteration (instant)
                u_os[p,k] = JuMP.value.(S[:v])
            end
        if proj_flag == 1
            x_os[:,k+1] = hyp_proj(A*x_os[:,k] + B*u_os[:,k])
        else
            x_os[:,k+1] = A*x_os[:,k] + B*u_os[:,k]
        end
    end
    return x_os, u_os
end