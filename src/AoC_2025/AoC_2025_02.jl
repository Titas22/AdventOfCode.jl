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

    function solve_common(ranges::Vector{UnitRange{Int64}})

        return ranges
    end

    function solve_part_1(ranges::Vector{UnitRange{Int64}})
        count = 0
        for range in ranges
            for ii in range
                ndigits = number_of_digits(ii)
                ndigits % 2 == 1 && continue
                half = ndigits ÷ 2
                
                (first, second) = divrem(ii, 10^half)
                first == second || continue

                count += ii

            end
        end

        return count
    end

    function solve_part_2(ranges::Vector{UnitRange{Int64}})
        total = 0;
        for rng in ranges
            ndig = number_of_digits(rng.start)

            invalid_ids = Set{Int}()

            println("$(rng.start) -> $(rng.stop)\n")
            dig_range = 1 : ndig-1
            for n in dig_range
                ndig % n == 0 || continue



                reps = ndig ÷ n

                d = 10^(ndig-n)
                from = rng.start ÷ d
                to = rng.stop ÷ d

                p = 10^n
                println("d: $d")
                println("$from -> $to")
                for pattern in from : to
                    val = pattern
                    for rep = 2 : reps
                        val *= p
                        val += pattern
                    end

                    val in rng || continue
                    val in invalid_ids && continue

                    push!(invalid_ids, val)
                    
                    total += val
                end
            end

        end

        return total
    end

    function solve(btest::Bool = false; use_input_cache::Bool = false)::Tuple{Any, Any}
        lines  = @getinputs(btest, "", use_input_cache)
        
        inputs = parse_inputs(lines)

        # (part1, part2) = solve_common(inputs)

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
