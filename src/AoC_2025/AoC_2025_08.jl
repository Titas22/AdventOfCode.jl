module AoC_2025_08
    using AdventOfCode
    const AoC = AdventOfCode
    using DataStructures: BinaryMaxHeap

    struct JunctionBox
        x::Int64
        y::Int64
        z::Int64
    end

    struct Connection
        distance::Int64
        idxA::Int64
        idxB::Int64
    end
    Base.isless(a::Connection, b::Connection) = a.distance < b.distance

    function JunctionBox(line::AbstractString)::JunctionBox
        idx1 = findfirst(==(','), line)
        idx2 = findnext(==(','), line, idx1 + 1)

        a = SubString(line, firstindex(line), idx1 - 1)
        b = SubString(line, idx1 + 1, idx2 - 1)
        c = SubString(line, idx2 + 1, lastindex(line))

        return JunctionBox(parse_int_ascii(a), parse_int_ascii(b), parse_int_ascii(c))
    end

    @inline function distance(a::JunctionBox, b::JunctionBox)::Int64
        dx = a.x - b.x
        dy = a.y - b.y
        dz = a.z - b.z
        return dx*dx + dy*dy + dz*dz
    end

    function parse_inputs(lines::Vector{String}, to_connect::Int64)
        n = lastindex(lines)

        boxes = JunctionBox[]
        sizehint!(boxes, n)

        for line in lines
            push!(boxes, JunctionBox(line))
        end

        heap = BinaryMaxHeap{Connection}()
        k = to_connect
        heap_count = 0

        @inbounds for ii in 1:n
            a = boxes[ii]
            for jj in (ii+1):n
                conn = Connection(distance(a, boxes[jj]), ii, jj)

                if heap_count < k
                    push!(heap, conn)
                    heap_count += 1
                else
                    if conn.distance < first(heap).distance
                        pop!(heap)
                        push!(heap, conn)
                    end
                end
            end
        end

        connections = Vector{Connection}(undef, heap_count)
        @inbounds for idx in heap_count:-1:1
            connections[idx] = pop!(heap)
        end

        return (boxes, connections)
    end

    function add_connection!(box_circuit::Vector{Int64}, conn_box_counts::Vector{Int64}, conn::Connection, next_circuit::Int64)
        idx = conn.idxA
        jdx = conn.idxB
        idx_conn = box_circuit[idx]
        jdx_conn = box_circuit[jdx]

        if idx_conn < 0
            if jdx_conn < 0
                next_circuit += 1
                box_circuit[idx] = next_circuit
                box_circuit[jdx] = next_circuit
                conn_box_counts[next_circuit] = 2
            else
                box_circuit[idx] = jdx_conn
                conn_box_counts[jdx_conn] += 1
            end
        elseif jdx_conn < 0
            box_circuit[jdx] = idx_conn
            conn_box_counts[idx_conn] += 1
        elseif jdx_conn == idx_conn
            # Nothing
        else
            to_replace = jdx_conn
            replace_with = idx_conn
            for jj in eachindex(box_circuit)
                box_circuit[jj] == to_replace || continue
                box_circuit[jj] = replace_with
                conn_box_counts[replace_with] += 1
            end
            conn_box_counts[to_replace] = 0
        end

        return next_circuit
    end

    function mst_max_edge_prim(boxes::Vector{JunctionBox})::Tuple{Int64, Int64}
        n = lastindex(boxes)

        in_tree = falses(n)
        best    = fill(typemax(Int64), n)
        parent  = zeros(Int64, n)

        best[1] = max_u = max_v = 0
        max_w = -1

        @inbounds for _ in 1 : n
            v = 0
            best_v = typemax(Int64)
            for ii in 1 : n
                (!in_tree[ii] && best[ii] < best_v) || continue
                best_v = best[ii]
                v = ii
            end

            in_tree[v] = true

            if parent[v] != 0 && best_v > max_w
                max_w = best_v
                max_u = v
                max_v = parent[v]
            end

            bv = boxes[v]
            for u in 1 : n
                in_tree[u] && continue
                bu = boxes[u]
                w = distance(bu, bv)
                if w < best[u]
                    best[u] = w
                    parent[u] = v
                end
            end
        end

        return (max_u, max_v)
    end

    function solve_part_1(boxes::Vector{JunctionBox}, connections::Vector{Connection}, to_connect::Int64)
        box_circuit = fill(Int64(-1), lastindex(boxes))
        next_circuit = 0

        conn_box_counts = zeros(Int64, to_connect + 2)
        conn_box_counts[2] = 0

        @inbounds for idx_cur in 1 : to_connect
            conn = connections[idx_cur]
            next_circuit = add_connection!(box_circuit, conn_box_counts, conn, next_circuit)
        end

        best1 = best2 = best3 = 0
        @inbounds for c in conn_box_counts
            c == 0 && continue
            if c > best1
                best3 = best2
                best2 = best1
                best1 = c
            elseif c > best2
                best3 = best2
                best2 = c
            elseif c > best3
                best3 = c
            end
        end

        return best1 * best2 * best3
    end

    function solve_part_2(boxes::Vector{JunctionBox})
        (idxA, idxB) = mst_max_edge_prim(boxes)
        return boxes[idxA].x * boxes[idxB].x
    end

    function solve(btest::Bool = false; use_input_cache::Bool = false)::Tuple{Any, Any}
        to_connect = btest ? 10 : 1000

        lines = @getinputs(btest, "", use_input_cache)
        (boxes, connections) = parse_inputs(lines, to_connect)

        part1 = solve_part_1(boxes, connections, to_connect)
        part2 = solve_part_2(boxes)

        return (part1, part2)
    end

    @time (part1, part2) = solve()
    println("\nPart 1 answer: $(part1)")
    println("\nPart 2 answer: $(part2)\n")
end

# 171503
# 9069509600
