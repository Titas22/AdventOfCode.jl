module AoC_2025_05
    using AdventOfCode
    const AoC = AdventOfCode

    function parse_inputs(lines::Vector{String})

        inputs = split_at_empty_lines(lines)

        fresh_ranges = UnitRange{Int64}[]
        sizehint!(fresh_ranges, length(inputs[1]))

        for str_range in inputs[1]
            (str_from, str_to) = split(str_range, '-')

            from = parse_int_ascii(str_from)
            to = parse_int_ascii(str_to)

            push!(fresh_ranges, from : to)
        end

        available_ingredients = parse_int_ascii.(inputs[2])

        return (fresh_ranges, available_ingredients)
    end
    function solve_common(inputs)

        return inputs
    end

    function solve_part_1(fresh_ranges, available_ingredients)
        tot = 0
        for id in available_ingredients
            for range in fresh_ranges
                id in range || continue
                tot += 1
                break
            end
        end
        return tot
    end

    function solve_part_2(fresh_ranges, available_ingredients)

        return nothing
    end

    function solve(btest::Bool = false; use_input_cache::Bool = false)::Tuple{Any, Any}
        lines  = @getinputs(btest, "", use_input_cache)
        # lines2      = @getinputs(btest, "_2") # Use if 2nd problem test case inputs are different
        (fresh_ranges, available_ingredients)      = parse_inputs(lines)

        part1       = solve_part_1(fresh_ranges, available_ingredients)
        part2       = solve_part_2(fresh_ranges, available_ingredients)

        return (part1, part2);
    end

    # @time (part1, part2) = solve(true) # Test
    @time (part1, part2) = solve()
    println("\nPart 1 answer: $(part1)")
    println("\nPart 2 answer: $(part2)\n")
end

# 720