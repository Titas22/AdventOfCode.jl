module AoC_2025_04
    using AdventOfCode
    const AoC = AdventOfCode

    function parse_inputs(lines::Vector{String})
        return [lines[i][j] == '@' for i=1:length(lines), j=1:length(first(lines))]
    end

    function is_edge_accessible(edge)::Bool
        edge[2, 1] || return false
        return (sum(edge)-1) < 4
    end

    function is_paper_accessible(block)::Bool
        block[2, 2] || return false
        return (sum(block)-1) < 4
    end

    function try_remove_edge_paper!(edge)
        is_edge_accessible(edge) || return
        edge[2, 1] = false
    end

    function try_remove_paper!(block)
        is_paper_accessible(block) || return
        block[2, 2] = false
    end


    function solve_part_1(bpaper)
        (n, m) = size(bpaper)
        
        accessible = falses(n, m)
        accessible[1, 1] = bpaper[1, 1]
        accessible[1, end] = bpaper[1, end]
        accessible[end, 1] = bpaper[end, 1]
        accessible[end, end] = bpaper[end, end]

        rngRow = 2 : n-1
        rngCol = 2 : m-1
        for ii in rngRow
            accessible[ii, 1] = is_edge_accessible(@view bpaper[ii-1:ii+1, 1:2])
            accessible[ii, m] = is_edge_accessible(@view bpaper[ii-1:ii+1, m:-1:m-1])
            accessible[1, ii] = is_edge_accessible((@view bpaper[1:2, ii-1:ii+1])')
            accessible[n, ii] = is_edge_accessible((@view bpaper[m:-1:m-1, ii-1:ii+1])')
            for jj in rngCol
                accessible[ii, jj] = is_paper_accessible(@view bpaper[ii-1:ii+1, jj-1:jj+1])
            end
        end

        return sum(accessible)
    end

    function solve_part_2(bpaper)
        (n, m) = size(bpaper)
        num_bpaper = sum(bpaper)

        # Can remove corners
        bpaper[1, 1] = false
        bpaper[1, end] = false
        bpaper[end, 1] = false
        bpaper[end, end] = false

        rngRow = 2 : n-1
        rngCol = 2 : m-1
        while true
            num_starting = sum(bpaper)
            for ii in rngRow
                try_remove_edge_paper!(@view bpaper[ii-1:ii+1, 1:2])
                try_remove_edge_paper!(@view bpaper[ii-1:ii+1, m:-1:m-1])
                try_remove_edge_paper!((@view bpaper[1:2, ii-1:ii+1])')
                try_remove_edge_paper!((@view bpaper[m:-1:m-1, ii-1:ii+1])')
                for jj in rngCol
                    try_remove_paper!(@view bpaper[ii-1:ii+1, jj-1:jj+1])
                end
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