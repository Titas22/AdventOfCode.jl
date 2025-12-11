module AoC_2025_07
    using AdventOfCode
    const AoC = AdventOfCode
    
    function solve_common(lines::Vector{String})
        chmat = lines2charmat(lines)
        idx_start = findfirst(x->x=='S', lines[1])

        b_split = falses(size(chmat))
        (n_rows, n_cols) = size(chmat)

        b_split = falses(size(chmat))
        cur = zeros(Int64, n_cols)
        cur[idx_start] = 1
        next = zeros(Int64, n_cols)
        for ii in 1 : n_rows-1
            for jj in 1 : n_cols
                n = cur[jj]
                n == 0 && continue
                ch = chmat[ii, jj]
                if ch == '^'
                    b_split[ii, jj] = true
                    next[jj-1] += n
                    next[jj+1] += n
                else
                    next[jj] += n
                end
                cur[jj] = 0
            end

            (cur, next) = (next, cur)
        end

        return (count(b_split), sum(cur))
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

# 1638
# 7759107121385
