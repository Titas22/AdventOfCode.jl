module AoC_2025_08
    using AdventOfCode
    const AoC = AdventOfCode

    struct JunctionBox
        x::Int64
        y::Int64
        z::Int64
    end

    struct Connection
        distance::Int64
        idxA::Int64
        idxB::Int64
    end

    function JunctionBox(line::AbstractString)::JunctionBox
        (a, b, c) = split(line, ','; limit=3)

        return JunctionBox(parse_int_ascii(a), parse_int_ascii(b), parse_int_ascii(c))
    end

    function distance(a::JunctionBox, b::JunctionBox)::Int64
        return ((a.x - b.x)^2 + (a.y - b.y)^2 + (a.z - b.z)^2)
    end

    function parse_inputs(lines::Vector{String})
        boxes = JunctionBox.(lines)
        n = lastindex(boxes)

        connections = Connection[]
        sizehint!(connections, n * (n-1) ÷ 2)

        idx = 0
        for ii in 1 : n
            a = boxes[ii]
            for jj in (ii+1) : n
                idx += 1
                b = boxes[jj]
                push!(connections, Connection(distance(a, b), ii, jj))
            end
        end

        sort!(connections; by=x->x.distance)

        return (boxes, connections)
    end

    function add_connection!(box_circuit::Vector{Int64}, conn_box_counts::Dict{Int64, Int64}, conn::Connection, next_circuit::Int64)
        idx = conn.idxA
        jdx = conn.idxB
        idx_conn = box_circuit[idx]
        jdx_conn = box_circuit[jdx]

        if idx_conn < 0
            if jdx_conn < 0
                next_circuit += 1
                box_circuit[idx] = next_circuit
                box_circuit[jdx] = next_circuit
                conn_box_counts[next_circuit] = 2
            else
                box_circuit[idx] = jdx_conn
                conn_box_counts[jdx_conn] += 1
            end
        elseif jdx_conn < 0
            box_circuit[jdx] = idx_conn
            conn_box_counts[idx_conn] += 1
        elseif jdx_conn == idx_conn
            # Nothing
        else
            to_replace = jdx_conn
            replace_with = idx_conn
            for jj in eachindex(box_circuit)
                box_circuit[jj] == to_replace || continue
                box_circuit[jj] = replace_with
                conn_box_counts[replace_with] += 1
            end
            pop!(conn_box_counts, to_replace)
        end

        return next_circuit
    end

    function solve_common(boxes::Vector{JunctionBox}, connections::Vector{Connection}, to_connect::Int64)
        box_circuit = collect(1 : lastindex(boxes)) .* -1
        next_circuit = 0

        conn_box_counts = Dict{Int64, Int64}()
        conn_box_counts[2] = 0 # To make it not quit the loop on 1st iteration

        for idx_cur in 1 : to_connect
            conn = connections[idx_cur]
            next_circuit = add_connection!(box_circuit, conn_box_counts, conn, next_circuit)

            length(conn_box_counts) == 1 && break;
        end

        p1 = collect(values(conn_box_counts))
        partialsort!(p1, 1:3; order=Base.Reverse)

        idx_cur = to_connect
        while true
            idx_cur += 1
            conn = connections[idx_cur]
            next_circuit = add_connection!(box_circuit, conn_box_counts, conn, next_circuit)

            if length(conn_box_counts) == 1
                if all(box_circuit .> 0)
                    break;
                end
            end
        end
        last_con = connections[idx_cur]
        p2 = boxes[last_con.idxA].x * boxes[last_con.idxB].x

        return (prod(p1[1:3]), p2)
    end

    function solve(btest::Bool = false; use_input_cache::Bool = false)::Tuple{Any, Any}
        lines  = @getinputs(btest, "", use_input_cache)

        (boxes, connections) = parse_inputs(lines)

        (part1, part2)       = solve_common(boxes, connections, btest ? 10 : 1000)

        return (part1, part2);
    end

    # @time (part1, part2) = solve(true) # Test
    @time (part1, part2) = solve()
    println("\nPart 1 answer: $(part1)")
    println("\nPart 2 answer: $(part2)\n")
end

# 171503
# 9069509600

