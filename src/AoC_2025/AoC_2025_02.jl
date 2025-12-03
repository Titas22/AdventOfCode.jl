module AoC_2025_02
    using AdventOfCode
    const AoC = AdventOfCode

    function parse_inputs(lines::Vector{String})::Vector{UnitRange{Int64}}
        str_ranges = split(lines[1], ',')
        ranges = UnitRange{Int64}[]
        sizehint!(ranges, length(str_ranges) * 2)

        for str_range in str_ranges
            (str_from, str_to) = split(str_range, '-')

            from = parse_int_ascii(str_from)
            to = parse_int_ascii(str_to)

            min_dig = number_of_digits(from)
            max_dig = number_of_digits(to)

            if min_dig == max_dig
                push!(ranges, from : to)
                continue
            end

            # If original range spans through different orders of magnitude - split them

            mid = 10^min_dig
            push!(ranges, from : mid-1)

            # In case there's input with more than 1 digit difference through the range
            for ndig in (min_dig+1) : (max_dig-1)
                from = mid
                mid = 10^ndig
                push!(ranges, from : mid-1)
            end

            push!(ranges, mid : to)
        end

        return ranges
    end

    function solve_common(ranges::Vector{UnitRange{Int64}}, is_part1::Bool)
        total = 0;
        invalid_ids = Set{Int64}()
        
        for rng in ranges
            ndig = number_of_digits(rng.start)
            ndig > 1 || continue
            empty!(invalid_ids)

            if is_part1
                ndig % 2 == 0 || continue
                dig_range = range(stop=ndig÷2, length=1)
            else
                dig_range = 1 : ndig÷2
            end

            # Loop through number of digits that could form a repeated sequence
            for n in dig_range
                ndig % n == 0 || continue

                # Get first n digits of the range ends to form min/max
                d = 10^(ndig-n)
                from = rng.start ÷ d
                to = rng.stop ÷ d

                # power to multiply value by to repeat the pattern, and how many repetitions
                p = 10^n
                reps = ndig ÷ n

                # Loop through all sensible patterns that could be repeated
                for pattern in from : to
                    # Assemble repeated value
                    val = pattern
                    for _ = 2 : reps
                        val *= p
                        val += pattern
                    end

                    val in rng || continue # Make sure still in range
                    val in invalid_ids && continue # Make sure not added yet (from different pattern length e.g. 1111 from 11 11 or from 1 1 1 1)

                    push!(invalid_ids, val) # Store invalid id to not repeat
                    
                    total += val
                end
            end
        end

        return total
    end

    solve_part_1(ranges::Vector{UnitRange{Int64}})::Int64 = solve_common(ranges, true)
    solve_part_2(ranges::Vector{UnitRange{Int64}})::Int64 = solve_common(ranges, false)

    function solve(btest::Bool = false; use_input_cache::Bool = false)::Tuple{Any, Any}
        lines  = @getinputs(btest, "", use_input_cache)
        
        inputs = parse_inputs(lines)

        part1 = solve_part_1(inputs)
        part2 = solve_part_2(inputs)

        return (part1, part2);
    end

    # @time (part1, part2) = solve(true) # Test
    @time (part1, part2) = solve()
    println("\nPart 1 answer: $(part1)")
    println("\nPart 2 answer: $(part2)\n")
end

# 35367539282
# 45814076230
