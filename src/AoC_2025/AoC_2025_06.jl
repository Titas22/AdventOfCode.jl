module AoC_2025_06
    using AdventOfCode
    const AoC = AdventOfCode

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

# 4722948564882
lines = @getinputs(false)

inputs = (line->parse_int_ascii.(split(strip(line), r"\s+"))).(lines[1:end-1])
ops = (line->split(strip(line), r"\s+")).(lines[end])

n = length(inputs)
terms = zeros(Int64, n)
tot = 0
for idx in eachindex(ops)
    global tot, terms, ops, inputs
    for ii in 1 : n
        terms[ii] = inputs[ii][idx]
    end



    if ops[idx] == "*"
        tot += prod(terms)
    elseif ops[idx] == "+"
        tot += sum(terms)
    else
        error("no idea")
    end
    println(terms)
end
tot