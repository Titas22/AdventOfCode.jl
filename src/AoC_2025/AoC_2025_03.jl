module AoC_2025_03
    using AdventOfCode
    const AoC = AdventOfCode

    function max_jolts(line::String, num_batteries::Int64)
        input = codeunits(line)
        bank_length = lastindex(input)
        jolts = 0
        idx_max = 1
        
        @inbounds for idx_battery in 1 : num_batteries
            max_digit = input[idx_max]
            
            if max_digit != UInt8('9')
                idx_end = bank_length - num_batteries + idx_battery
                
                for idx in idx_max + 1 : idx_end
                    cur_digit = input[idx]
                    
                    cur_digit > max_digit || continue
                    
                    max_digit = cur_digit
                    idx_max = idx

                    max_digit == UInt8('9') && break
                end
            end
            
            idx_max += 1
            jolts *= 10
            jolts += max_digit - UInt8('0')
        end

        return jolts
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