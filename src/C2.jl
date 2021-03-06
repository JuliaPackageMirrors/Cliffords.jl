# 2-qubit Clifford group

import Iterators: product

function fullC2()
    C2 = Clifford[]
    C2dict = @compat Dict{Clifford, Int}()
    iSWAP = CZ*kron(S,S)*SWAP

    ct = 1

    # parallel C1 class
    for i = 1:24, j = 1:24
        C = kron(C1[i],C1[j])
        push!(C2, C)
        C2dict[C] = ct
        ct += 1
    end

    # CNOT class
    for i = 1:24, j = 1:24
        for (u1,u2) in product([RI, C1[17], C1[18]], [RI, C1[17], C1[18]])
            C = kron(u1,u2) * CNOT * kron(C1[i],C1[j])
            push!(C2, C)
            C2dict[C] = ct
            ct += 1
        end
    end

    # iSWAP class
    for i = 1:24, j = 1:24
        for (u1,u2) in product([RI, C1[17], C1[18]], [RI, C1[17], C1[18]])
            C = kron(u1,u2) * iSWAP * kron(C1[i],C1[j])
            push!(C2, C)
            C2dict[C] = ct
            ct += 1
        end
    end

    # SWAP class
    for i = 1:24, j = 1:24
        C = SWAP * kron(C1[i],C1[j])
        push!(C2, C)
        C2dict[C] = ct
        ct += 1
    end

    return C2, C2dict
end
