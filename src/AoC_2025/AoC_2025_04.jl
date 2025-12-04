module AoC_2025_04
    using AdventOfCode
    const AoC = AdventOfCode

    function parse_inputs(lines::Vector{String})
        rows = length(lines)
        cols = length(first(lines))
        bpaper = falses(rows + 2, cols + 2)
        for ii in 1 : rows
            line = codeunits(lines[ii])
            for jj in 1 : cols
                bpaper[ii+1, jj+1] = line[jj] == 0x40
            end
        end
        return bpaper
    end

    function is_paper_accessible(block)::Bool
        block[2, 2] || return false
        return (sum(block)-1) < 4
    end

    function try_remove_paper!(block)
        is_paper_accessible(block) || return
        block[2, 2] = false
    end


    function solve_part_1(bpaper)
        (n, m) = size(bpaper)

        accessible = falses(n, m)
        for ii in 2 : n-1, jj in 2 : m-1
            @inbounds block = @view bpaper[ii-1:ii+1, jj-1:jj+1]
            accessible[ii, jj] = is_paper_accessible(block)
        end

        return sum(accessible)
    end

    function solve_part_2(bpaper)
        (n, m) = size(bpaper)
        num_bpaper = sum(bpaper)

        rngRow = 2 : n-1
        rngCol = 2 : m-1
        while true
            num_starting = sum(bpaper)
            for ii in rngRow, jj in rngCol
                @inbounds block = @view bpaper[ii-1:ii+1, jj-1:jj+1]
                try_remove_paper!(block)
            end
            sum(bpaper) == num_starting && break
        end

        return num_bpaper - sum(bpaper)
    end

    function solve(btest::Bool = false; use_input_cache::Bool = false)::Tuple{Any, Any}
        lines  = @getinputs(btest, "", use_input_cache)
        bpaper = parse_inputs(lines)

        part1       = solve_part_1(bpaper)
        part2       = solve_part_2(bpaper)

        return (part1, part2);
    end

    # @time (part1, part2) = solve(true) # Test
    @time (part1, part2) = solve()
    println("\nPart 1 answer: $(part1)")
    println("\nPart 2 answer: $(part2)\n")

end

# 1537
# 8707