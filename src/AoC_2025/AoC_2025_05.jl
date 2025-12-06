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

        merge_ranges!(fresh_ranges)

        available_ingredients = Int64[]
        sizehint!(available_ingredients, lastindex(inputs[2]))
        for str_id in inputs[2]
            push!(available_ingredients, parse_int_ascii(str_id))
        end

        return (fresh_ranges, available_ingredients)
    end

    function merge_ranges!(ranges::Vector{UnitRange{Int}})
        sort!(ranges; by = first)

        idx_merged = 1
        r_merged = ranges[1]

        @inbounds for idx in 2:lastindex(ranges)
            r_current = ranges[idx]

            if r_current.start <= r_merged.stop + 1
                r_merged = r_merged.start : max(r_merged.stop, r_current.stop)
            else
                ranges[idx_merged] = r_merged
                idx_merged += 1
                r_merged = r_current
            end
        end
        ranges[idx_merged] = r_merged
        resize!(ranges, idx_merged)
        
        return ranges
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

    function solve_part_2(fresh_ranges)
        tot = 0
        for rng in fresh_ranges
            tot += rng.stop - rng.start + 1
        end

        return tot
    end

    function solve(btest::Bool = false; use_input_cache::Bool = false)::Tuple{Any, Any}
        lines  = @getinputs(btest, "", use_input_cache)
        (fresh_ranges, available_ingredients)      = parse_inputs(lines)

        part1       = solve_part_1(fresh_ranges, available_ingredients)
        part2       = solve_part_2(fresh_ranges)

        return (part1, part2);
    end

    # @time (part1, part2) = solve(true) # Test
    @time (part1, part2) = solve()
    println("\nPart 1 answer: $(part1)")
    println("\nPart 2 answer: $(part2)\n")
end

# 720
# 357608232770687