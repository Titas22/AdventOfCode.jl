module AoC_2025_08
    using AdventOfCode
    const AoC = AdventOfCode

    struct JunctionBox
        x::Float64
        y::Float64
        z::Float64
    end

    function JunctionBox(line::AbstractString)::JunctionBox
        (a, b, c) = split(line, ','; limit=3)

        return JunctionBox(parse_int_ascii(a), parse_int_ascii(b), parse_int_ascii(c))
    end


    function parse_inputs(lines::Vector{String})

        return lines
    end
    function solve_common(inputs)

        return inputs
    end

    function solve_part_1(inputs)

        return nothing
    end

    function solve_part_2(inputs)

        return nothing
    end

    function solve(btest::Bool = false; use_input_cache::Bool = false)::Tuple{Any, Any}
        lines  = @getinputs(btest, "", use_input_cache)
        # lines2      = @getinputs(btest, "_2") # Use if 2nd problem test case inputs are different
        inputs      = parse_inputs(lines)

        solution    = solve_common(inputs)
        part1       = solve_part_1(solution)
        part2       = solve_part_2(solution)

        return (part1, part2);
    end

    @time (part1, part2) = solve(true) # Test
    # @time (part1, part2) = solve()
    println("\nPart 1 answer: $(part1)")
    println("\nPart 2 answer: $(part2)\n")
end

# 171503

lines = @getinputs(false)
JunctionBox = AoC_2025_08.JunctionBox

function p1(lines)

    boxes = JunctionBox.(lines)

    function distance(a::JunctionBox, b::JunctionBox)::Float64
        return sqrt((a.x - b.x)^2 + (a.y - b.y)^2 + (a.z - b.z)^2)
    end

    n = lastindex(boxes)
    distances = zeros(n * (n-1) ÷ 2)
    m = lastindex(distances)
    idx_boxes = Tuple{Int, Int}[]
    sizehint!(idx_boxes, size(distances))


    idx = 0
    for ii in 1 : n
        a = boxes[ii]
        for jj in (ii+1) : n
            idx += 1
            b = boxes[jj]
            distances[idx] = distance(a, b)
            push!(idx_boxes, (ii, jj))
        end
    end

    idx_sorted = sortperm(distances)

    circuits_conn = collect(1 : m) .* -1 #zeros(Int64, m)

    circuit_sizes = Dict{Int64, Int64}()

    next_circuit = 1
    to_subtract = 0

    to_connect = 1000

    idx_cur = 0
    while to_connect > 0
        idx_cur += 1
        ii = idx_sorted[idx_cur]
        idx = idx_boxes[ii][1]
        jdx = idx_boxes[ii][2]
        # println("To connect $(string(boxes[idx])) and $(string(boxes[jdx]))")
        println("To connect $(idx) and $(jdx). Left: $(to_connect)")
        if circuits_conn[idx] < 0
            if circuits_conn[jdx] < 0
                next_circuit += 1
                circuits_conn[idx] = next_circuit
                circuits_conn[jdx] = next_circuit
            else
                circuits_conn[idx] = circuits_conn[jdx]
            end
        elseif circuits_conn[jdx] < 0
            circuits_conn[jdx] = circuits_conn[idx]
        # elseif circuits_conn[jdx] == circuits_conn[idx]
        #     println("Skipping")
        #     continue
        else
            to_subtract += 1
            to_replace = circuits_conn[jdx]
            replace_with = circuits_conn[idx]
            for jj in 1 : m
                circuits_conn[jj] == to_replace || continue
                circuits_conn[jj] = replace_with
            end
        end
        to_connect -= 1
    end

    circuits_conn

    circuits_box = zeros(Int64, n)
    for ii in 1 : m
        circuit = circuits_conn[ii]
        circuit > 0 || continue
        idx = idx_boxes[ii]
        circuits_box[idx[1]] = circuit
        circuits_box[idx[2]] = circuit
    end



    circuit_counts = zeros(Int64, next_circuit)

    for ii in 1 : next_circuit
        circuit_counts[ii] = count(x->x==ii, circuits_conn)
    end

    a = sort(circuit_counts; order=Base.Reverse)

    return prod(a[1:3])
end

p1(lines)








