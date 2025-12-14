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

    function distance(a::JunctionBox, b::JunctionBox)::Int64
        return ((a.x - b.x)^2 + (a.y - b.y)^2 + (a.z - b.z)^2)
        # return sqrt((a.x - b.x)^2 + (a.y - b.y)^2 + (a.z - b.z)^2)
    end

    function parse_inputs(lines::Vector{String})
        boxes = JunctionBox.(lines)
        return boxes
    end

    function solve_common(boxes::Vector{JunctionBox}, to_connect::Int64)
        n = lastindex(boxes)
        distances = zeros(n * (n-1) ÷ 2)
        m = lastindex(distances)

        idx_boxes = Tuple{Int, Int}[]
        sizehint!(idx_boxes, m)

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

        box_circuit = collect(1 : n) .* -1 #zeros(Int64, m)

        next_circuit = 1
        to_subtract = 0

        to_connect = 4792
        idx_cur = 0
        while to_connect > 0
            idx_cur += 1
            ii = idx_sorted[idx_cur]
            idx = idx_boxes[ii][1]
            jdx = idx_boxes[ii][2]
            # println("To connect $(string(boxes[idx])) and $(string(boxes[jdx]))")
            # println("To connect $(idx) and $(jdx). Left: $(to_connect)")
            if box_circuit[idx] < 0
                if box_circuit[jdx] < 0
                    next_circuit += 1
                    box_circuit[idx] = next_circuit
                    box_circuit[jdx] = next_circuit
                else
                    box_circuit[idx] = box_circuit[jdx]
                end
            elseif box_circuit[jdx] < 0
                box_circuit[jdx] = box_circuit[idx]
            else
                to_subtract += 1
                to_replace = box_circuit[jdx]
                replace_with = box_circuit[idx]
                for jj in 1 : n
                    box_circuit[jj] == to_replace || continue
                    box_circuit[jj] = replace_with
                end
            end
            to_connect -= 1
        end

        ii = idx_sorted[idx_cur]
        idx = idx_boxes[ii][1]
        jdx = idx_boxes[ii][2]

        box_circuit

        circuits_box = zeros(Int64, n)
        for ii in 1 : n
            circuit = box_circuit[ii]
            circuit > 0 || continue
            idx = idx_boxes[ii]
            circuits_box[idx[1]] = circuit
            circuits_box[idx[2]] = circuit
        end


        # println("Unique circuits: $(length(unique(box_circuit)))")


        circuit_counts = zeros(Int64, next_circuit)

        for cc in box_circuit
            # println(cc)
            cc > 0 || continue
            circuit_counts[cc] += 1
        end

        a = sort(circuit_counts; order=Base.Reverse)


        return (prod(a[1:3]), $(Int64(boxes[idx].x * boxes[jdx].x)))
    end

    function solve(btest::Bool = false; use_input_cache::Bool = false)::Tuple{Any, Any}
        lines  = @getinputs(btest, "", use_input_cache)

        boxes = parse_inputs(lines)

        (part1, part2)       = solve_common(boxes, btest ? 10 : 1000)

        return (part1, part2);
    end

    # @time (part1, part2) = solve(true) # Test
    @time (part1, part2) = solve()
    println("\nPart 1 answer: $(part1)")
    println("\nPart 2 answer: $(part2)\n")
end

# 171503
# 9069509600
