module AoC_2025_07
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

# 1638
# 7759107121385

lines = @getinputs(false)
# chmat = lines2bytemat(lines)
chmat = lines2charmat(lines)

idx_start = CartesianIndex((1, findfirst(x->x=='S', lines[1])))

# BFS

b_split = falses(size(chmat))
b_visited = falses(size(chmat))
n_visited = zeros(Int64, size(chmat))

(n_rows, n_cols) = size(chmat)
# q = CircularDeque{CartesianIndex{2}}(n_cols*n_cols*n_cols)
q = CartesianIndex{2}[]
sizehint!(q, n_cols*n_cols*n_cols)
push!(q, idx_start)

step = CartesianIndex((1, 0))
side = CartesianIndex((0, 1))
n_split = 1
max_row = 0
while !isempty(q)
    global n_split, max_row
    idx = popfirst!(q)
    b_visited[idx] && continue

    idx_next = idx + step
    idx_next[1] == n_rows && break
    next = chmat[idx_next]

    if next == '^'
        b_split[idx_next] = true
        n_split += 1
        push!(q, idx_next + side)
        push!(q, idx_next - side)
    else
        push!(q, idx_next)
    end

    b_visited[idx] = true

end
chmat[b_visited] .= '|'
chmat
(count(b_split), n_split)


cur = zeros(Int64, n_cols)
cur[idx_start[2]] = 1
next = zeros(Int64, n_cols)
for ii in 1 : n_rows-1
    global cur, next
    for jj in 1 : n_cols
        global cur, next
        n = cur[jj]
        n == 0 && continue
        ch = chmat[ii, jj]
        if ch == '^'
            next[jj-1] += n
            next[jj+1] += n
        else
            next[jj] += n
        end
        cur[jj] = 0
    end

    (cur, next) = (next, cur)
end
sum(cur)