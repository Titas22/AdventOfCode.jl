module AoC_2025_03
    using AdventOfCode
    const AoC = AdventOfCode

    function parse_inputs(lines::Vector{String})

        return lines
    end

    function max_jolts(line::AbstractString, num_batteries::Int64)
        
        batteries = fill('0', num_batteries)
        min_dig = batteries[1] = line[1]
        len = length(line)
        idx_min = 1
        cur_len = 1;

        # println("Line: $line")
        for idx = 2 : len
            dig = line[idx]
            # println("$(string(batteries))   cur_len: $cur_len   min_dig: $min_dig   idx_min: $idx_min   dig: $dig")

            if dig <= min_dig
                # println("=== 0.0 ===")
                if cur_len < num_batteries
                    # println("=== 0.0.1 ===")
                    cur_len += 1
                    batteries[cur_len] = dig
                    
                    if dig != min_dig
                        min_dig = dig
                        idx_min = cur_len
                    end
                end
                # println("=== 0.1 ===")
                continue
            end

            # println("=== 1 ===")
            down_to = num_batteries - len + idx
            down_to = down_to < 1 ? 1 : down_to
            idx_min = idx_min < down_to ? down_to : idx_min

            # println("=== 1 ===   idx: $idx/$len   idx_min: $idx_min   down to $(down_to))")
            for jj = idx_min-1 : -1 : down_to
                batteries[jj] < dig || break
                idx_min = jj
            end
            # if idx_min < idx

            # else
            # end

            # println("=== 2 ===   idx: $idx/$len   idx_min: $idx_min   down to $(down_to))")
            batteries[idx_min] = dig
            cur_len = idx_min
            min_dig = dig

            # println("=== 3 ===")
            for jj = idx_min : -1 : 1
                batteries[jj] == min_dig || break
                idx_min = jj
            end

            # idx_min = n

            # Do some replacements

        end
        # println(string(batteries))
        # for ii = cur_len+1 : num_batteries
        #     batteries[ii] = ' ' 
        # end
        # println(string(batteries))
        # println("['8', '8', '8', '9', '1', '1', '1', '1', '2', '1', '1', '1']")

        p = 1
        tot = 0
        for val in Iterators.reverse(batteries)
            tot += (val - '0') * p
            p *= 10
        end
        return tot
    end

    function solve_common(lines::Vector{String}, num_batteries::Int64)
        jolts = 0
        for line in lines
            jolts += max_jolts(line, num_batteries)
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