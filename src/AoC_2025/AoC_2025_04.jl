module AoC_2025_04
    using AdventOfCode
    const AoC = AdventOfCode

    function parse_inputs(lines::Vector{String})
        rows = length(lines)
        cols = length(first(lines))
        bpaper = fill(false, rows + 2, cols + 2)
        @inbounds for ii in 1 : rows
            line = codeunits(lines[ii])
            for jj in 1 : cols
                bpaper[ii+1, jj+1] = line[jj] == 0x40
            end
        end
        return bpaper
    end

    const deltas::NTuple{8, CartesianIndex{2}} = CartesianIndex.(((-1,-1), (-1,0), (-1,1), (0,-1), (0,1), (1,-1), (1,0), (1,1)));
    const center::CartesianIndex{2} = CartesianIndex(2, 2)

    @inline @inbounds function is_paper_accessible(block::Matrix{Bool}, idx::CartesianIndex{2})::Bool
        block[idx] || return false
        tot = 0
        for d in deltas
            block[idx + d] || continue
            tot += 1
        end
        return tot < 4
    end

    @inline @inbounds function try_remove_paper!(block::Matrix{Bool}, s::Vector{CartesianIndex{2}}, idx::CartesianIndex{2})
        is_paper_accessible(block, idx) || return
        block[idx] = false
        for d in deltas
            block[idx + d] && push!(s, idx + d)
        end
    end


    function solve_part_1(bpaper::Matrix{Bool})::Tuple{Int64, Vector{CartesianIndex{2}}}
        (n, m) = size(bpaper)

        # Assemble stack for part 2 in same loop
        s = CartesianIndex{2}[]
        sizehint!(s, m*n)
        
        total = 0
        for ii in 2 : n-1, jj in 2 : m-1
            idx = CartesianIndex(ii, jj)
            is_paper_accessible(bpaper, idx) || continue
            total += 1
            push!(s, idx)
        end

        return (total, s)
    end

    function solve_part_2!(bpaper::Matrix{Bool}, s::Vector{CartesianIndex{2}})::Int64
        num_bpaper = sum(bpaper)
        
        while !isempty(s)
            idx = pop!(s)
            @inbounds bpaper[idx] || continue
            try_remove_paper!(bpaper, s, idx)
        end
        
        return num_bpaper - sum(bpaper)
    end

    function solve(btest::Bool = false; use_input_cache::Bool = false)::Tuple{Any, Any}
        lines  = @getinputs(btest, "", use_input_cache)
        bpaper = parse_inputs(lines)

        (part1, s)  = solve_part_1(bpaper)
        part2       = solve_part_2!(bpaper, s)

        return (part1, part2);
    end

    # @time (part1, part2) = solve(true) # Test
    @time (part1, part2) = solve()
    println("\nPart 1 answer: $(part1)")
    println("\nPart 2 answer: $(part2)\n")

end

# 1537
# 8707