module AoC_2025_06
    using AdventOfCode
    const AoC = AdventOfCode

    function solve_part_1(lines::Vector{String})
        inputs = (line->parse_int_ascii.(split(strip(line), r"\s+"))).(lines[1:end-1])
        ops = (line->split(strip(line), r"\s+")).(lines[end])

        n = length(inputs)
        terms = zeros(Int64, n)
        tot = 0
        for idx in eachindex(ops)
            for ii in 1 : n
                terms[ii] = inputs[ii][idx]
            end

            if ops[idx] == "*"
                tot += prod(terms)
            else #if ops[idx] == "+"
                tot += sum(terms)
            end
        end

        return tot
    end

    function solve_part_2(lines::Vector{String}, max_terms::Int64 = 4)
        op_str = pop!(lines)
        chmat = lines2charmat(lines)
        n = length(lines)

        terms = zeros(Int64, max_terms)
        tot = op_offset = 0
        b_multiply = false

        for idx in eachindex(op_str)
            op = op_str[idx]

            if op != ' '
                last_term = idx - op_offset - 2
                tot += b_multiply ? prod(terms[1:last_term]) : sum(terms[1:last_term])
                op_offset = idx - 1
                b_multiply = op == '*'   
                terms .= 0
            end

            idx_cur = idx - op_offset
            for ii in 1 : n
                ch = chmat[ii, idx]
                ch == ' ' && continue
                terms[idx_cur] *= 10
                terms[idx_cur] += ch - '0'
            end
        end

        last_term = length(op_str) - op_offset
        tot += b_multiply ? prod(terms[1:last_term]) : sum(terms[1:last_term])

        return tot
    end

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

# 4722948564882
# 9581313737063