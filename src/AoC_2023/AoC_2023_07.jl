module AoC_2023_07
    using AdventOfCode;
    import Base.isless;

    const AoC = AdventOfCode;

    # Define the custom ordering
    const card_strength = Dict('A' => 14, 'K' => 13, 'Q' => 12, 'J' => 11, 'T'=>10);

    struct Card
        value::Int
    end
    function Card(card::Char)::Card
        return Card(isdigit(card) ? Int(card)-48 : card_strength[card]);
    end
    const Joker::Card   = Card('J');

    struct Hand
        cards::Vector{Card}
        bid::Int
        power::Int
        power_joker::Int
    end

    function Hand(line::AbstractString)::Hand
        bid = parse(Int, line[7:end]);

        cards = [Card(x) for x in line[1:5]];
        
        (power, power_joker) = calculate_hand_power(cards);
        return Hand(cards, bid, power, power_joker);
    end

    function get_card_counts(cards::Vector{Card})::Dict{Int, Int}
        counts = Dict{Int, Int}()
        for card in cards
            counts[card.value] = haskey(counts, card.value) ? counts[card.value] + 1 : 1
        end
        return counts
    end

    function get_power(counts::Dict{Int, Int}, njoker::Int = 0):Int
        n = length(counts)
        if n == 5 # high card
            return 0;
        elseif n == 4 # one pair
            return 1;
        elseif n == 1 || njoker == 5 # 5 of kind
            return 6;
        else
            m = values(counts);
            nmax = maximum(m) + njoker;
            if nmax == 4 # 4 of kind
                return 5;
            elseif nmax == 3
                nmin = minimum(m);
                if nmin == 1 # 3 of kind
                    return 3; 
                else # full house
                    return 4;
                end
            else # 2 pair
                return 2;
            end
        end
    end

    function calculate_hand_power(cards::Vector{Card})::Tuple{Int, Int}
        counts      = get_card_counts(cards);

        power       = get_power(counts);
        haskey(counts, Joker.value) || return(power, power)

        njoker = counts[Joker.value]
        delete!(counts, Joker.value)
        power_joker = get_power(counts, njoker);
        return (power, power_joker);
    end  
    

    function Base.isless(a::Hand, b::Hand)::Bool
        a.power == b.power || return isless(a.power, b.power);

        for idx in eachindex(a.cards)
            aval = a.cards[idx].value
            bval = b.cards[idx].value
            aval == bval || return isless(aval, bval);
        end
        return false;
    end

    function isless_joker(a::Hand, b::Hand)::Bool
        a.power_joker == b.power_joker || return isless(a.power_joker, b.power_joker);

        for idx in eachindex(a.cards)
            aval = a.cards[idx].value
            bval = b.cards[idx].value
            aval == bval || return isless(aval == Joker.value ? 1 : aval, bval == Joker.value ? 1 : bval);
        end
        return false;
    end

    parse_inputs(lines::Vector{String})::Vector{Hand} = Hand.(lines);
    function count_total_winnings(sorted_hands::Vector{Hand})::Int
        tot = 0;
        for idx in eachindex(sorted_hands)
            tot += idx * sorted_hands[idx].bid;
        end
        return tot;
    end

    function solve_part_1(hands::Vector{Hand})::Int
        sort!(hands)
        return count_total_winnings(hands);
    end

    function solve_part_2(hands::Vector{Hand})::Int
        sort!(hands; lt=isless_joker)
        return count_total_winnings(hands);
    end

    function solve(btest::Bool = false)::Tuple{Any, Any};
        lines       = @getinputs(btest);

        hands      = parse_inputs(lines);

        part1       = solve_part_1(hands);
        part2       = solve_part_2(hands);
        
        return (part1, part2);
    end

    # @time (part1, part2) = solve(true); # Test
    @time (part1, part2) = solve();
    println("\nPart 1 answer: $(part1)");
    println("\nPart 2 answer: $(part2)\n");
end