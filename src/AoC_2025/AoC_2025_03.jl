module AoC_2025_03
    using AdventOfCode
    const AoC = AdventOfCode

    function max_jolts!(batteries::Vector{UInt8}, line::String)
        input = codeunits(line)
        num_batteries = lastindex(batteries)
        min_dig = batteries[1] = input[1]
        idx_min = cur_len= 1
        len = lastindex(input)

        @inbounds for idx = 2 : len
            dig = input[idx]

            if dig <= min_dig
                if cur_len < num_batteries
                    cur_len += 1
                    batteries[cur_len] = dig
                    
                    if dig != min_dig
                        min_dig = dig
                        idx_min = cur_len
                    end
                end
                
                continue
            end

            down_to = num_batteries - len + idx
            down_to = down_to < 1 ? 1 : down_to
            idx_min = idx_min < down_to ? down_to : idx_min

            for jj = idx_min-1 : -1 : down_to
                batteries[jj] < dig || break
                idx_min = jj
            end

            batteries[idx_min] = dig
            cur_len = idx_min
            min_dig = dig

            for jj = idx_min : -1 : 1
                batteries[jj] == min_dig || break
                idx_min = jj
            end
        end

        p = 1
        tot = 0
        for val in Iterators.reverse(batteries)
            tot += (val - 0x30) * p
            p *= 10
        end
        return tot
    end

    function solve_common(lines::Vector{String}, num_batteries::Int64)
        batteries = fill(0x30, num_batteries)
        jolts = 0
        for line in lines
            jolts += max_jolts!(batteries, line)
        end
        return jolts
    end

    solve_part_1(lines) = solve_common(lines, 2)
    solve_part_2(lines) = solve_common(lines, 12)

    function solve(btest::Bool = false; use_input_cache::Bool = false)::Tuple{Any, Any}
        lines  = @getinputs(btest, "", use_input_cache)

        part1       = solve_part_1(lines)
        part2       = solve_part_2(lines)

        return (part1, part2);
    end

    # @time (part1, part2) = solve(true) # Test
    @time (part1, part2) = solve()
    println("\nPart 1 answer: $(part1)")
    println("\nPart 2 answer: $(part2)\n")
end

# 17694
# 175659236361660