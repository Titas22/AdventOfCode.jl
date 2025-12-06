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
# 9581313737063
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



op_str = pop!(lines)

n_ops = length(op_str) - count(x->x==' ', op_str)

chmat = lines2charmat(lines)

tot2 = 0

n = length(lines)
terms = zeros(Int64, 4)
tot2 = 0
b_multiply = false
op_offset = 0

for idx in eachindex(op_str)
    global tot2, op_str, terms, b_multiply, chmat, op_offset
    op = op_str[idx]

    if op != ' '
        last_term = idx - op_offset - 2
        println("idx: $idx   op_offset $op_offset   last_term: $last_term")
        println("Calculating: $(string(terms)) -> $(b_multiply ? prod(terms[1:last_term]) : sum(terms[1:last_term]))")
        tot2 += b_multiply ? prod(terms[1:last_term]) : sum(terms[1:last_term])
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

    println("Terms: $(string(terms))")
end

last_term = length(op_str) - op_offset
println("idx: $(length(op_str)+1)   op_offset $op_offset   last_term: $last_term")
println("Calculating: $(string(terms)) -> $(b_multiply ? prod(terms[1:last_term]) : sum(terms[1:last_term]))")
tot2 += b_multiply ? prod(terms[1:last_term]) : sum(terms[1:last_term])
