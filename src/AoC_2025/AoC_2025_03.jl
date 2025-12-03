module AoC_2025_03
    using AdventOfCode
    const AoC = AdventOfCode

    function parse_inputs(lines::Vector{String})

        return lines
    end
    function solve_common(inputs)

        return inputs
    end

    function max_jolts(line::AbstractString)::Int64
        msd = lsd = '0';
        n = length(line)
        for ii = 1 : n - 1
            # println("\nline[ii] = $(line[ii])")
            # line[ii] < msd && continue
            if line[ii] > msd
                msd = line[ii]
                lsd = line[ii+1]
            end
            # println("msd = $msd")
            for jj = ii+1 : n
                # println("msd = $msd | lsd = $lsd")
                line[jj] > lsd || continue
                msd = line[ii]
                lsd = line[jj]
            end
        end
        return (msd - '0') * 10 + lsd - '0'
    end

    solve_part_1(lines) = sum(max_jolts.(lines))

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

# 17694