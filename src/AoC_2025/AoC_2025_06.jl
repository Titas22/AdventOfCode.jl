module AoC_2025_06
    using AdventOfCode
    const AoC = AdventOfCode

    function solve_common(lines::Vector{String}, max_terms::Int64 = 4)
        op_str = codeunits(pop!(lines))
        chmat = lines2bytemat(lines)
        n = length(lines)

        terms_1 = zeros(Int64, n)
        terms_2 = zeros(Int64, max_terms)
        tot_1 = tot_2 = op_offset = 0
        b_multiply = false

        for idx in eachindex(op_str)
            op = op_str[idx]

            if op != UInt8(' ')
                last_term = idx - op_offset - 2
                tot_1 += b_multiply ? prod(terms_1) : sum(terms_1)
                tot_2 += b_multiply ? prod(terms_2[1:last_term]) : sum(terms_2[1:last_term])
                op_offset = idx - 1
                b_multiply = op == UInt8('*')
                terms_1 .= 0
                terms_2 .= 0
            end

            idx_cur = idx - op_offset
            for ii in 1 : n
                ch = chmat[ii, idx]
                ch == UInt8(' ') && continue
                val = ch - UInt8('0')
                terms_2[idx_cur] *= 10
                terms_2[idx_cur] += val

                terms_1[ii] *= 10
                terms_1[ii] += val
            end
        end

        last_term = length(op_str) - op_offset
        tot_1 += b_multiply ? prod(terms_1) : sum(terms_1)
        tot_2 += b_multiply ? prod(terms_2[1:last_term]) : sum(terms_2[1:last_term])

        return (tot_1, tot_2)
    end

    function solve(btest::Bool = false; use_input_cache::Bool = false)::Tuple{Any, Any}
        lines  = @getinputs(btest, "", use_input_cache)

        (part1, part2) = solve_common(lines)

        return (part1, part2);
    end

    # @time (part1, part2) = solve(true) # Test
    @time (part1, part2) = solve()
    println("\nPart 1 answer: $(part1)")
    println("\nPart 2 answer: $(part2)\n")
end

# 4722948564882
# 9581313737063