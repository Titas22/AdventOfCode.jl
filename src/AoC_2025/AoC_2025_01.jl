module AoC_2025_01
    using AdventOfCode
    const AoC = AdventOfCode

    parse_line(line::String)::Int64 = (line[1] == 'R' ? 1 : -1) * parse_int_ascii(@view line[2:end])

    function parse_inputs(lines::Vector{String})
        results = Vector{Int64}(undef, length(lines))
        @inbounds @simd for idx in eachindex(lines)
            results[idx] = parse_line(lines[idx])
        end
        return results
    end

    function solve_common(rotations::Vector{Int64})::Tuple{Int64, Int64}
        pos = 50
        zero_count = 0
        zero_crosses = 0
        last_sign = sign(pos)

        for rot in rotations
            new_pos = pos + rot
            new_sign = sign(new_pos)

            zero_crosses += abs(new_pos) ÷ 100

            if (last_sign != 0 && new_sign == -last_sign) || new_pos == 0
                zero_crosses += 1
            end

            pos = new_pos % 100
            if pos == 0
                zero_count += 1
            end
            last_sign = sign(pos)
        end
        
        return (zero_count, zero_crosses)
    end

    function solve(btest::Bool = false; use_input_cache::Bool = false)::Tuple{Any, Any}
        lines  = @getinputs(btest, "", use_input_cache)
        inputs = parse_inputs(lines)

        (part1, part2) = solve_common(inputs)

        return (part1, part2);
    end

    # @time (part1, part2) = solve(true) # Test
    @time (part1, part2) = solve()
    println("\nPart 1 answer: $(part1)")
    println("\nPart 2 answer: $(part2)\n")
end

# 1043
# 5963