using Graphs

"""
Didn't need to use the `Graphs` stuff for this one, in retrospect.
"""

function nobag(s)
    no = [" bags.", " bags", " bag.", " bag"]
    for e in no
        s = replace(s, e => "")
    end
    s
end


function parse_input(fname)
    out = Dict()
    for line in readlines(fname)
        left, right = split(line, " contain ")
        left = nobag(left)
        right = map(nobag, split(right, ", "))
        if length(right) == 1 && startswith(right[1], "no")
            out[left] = nothing
            continue
        end
        out[left] = [
            Dict("count" => parse(Int, split(e)[1]), "bag" => join(split(e)[2:end], " ")) for e in right
        ]
    end
    out
end

ex07 = parse_input("data/ex07")
ex07_1 = parse_input("data/ex07-1")
in07 = parse_input("data/in07")

function day7_1(input)


    label_map = Dict()
    for (ix, e) in enumerate(keys(input))
        label_map[e] = ix
    end

    g = SimpleDiGraph(length(input))
    for (k, v) in pairs(input)
        if isnothing(v)
            # add_edge!(g, k, nothing)
            continue
        end
        for e in v
            add_edge!(g, label_map[k], label_map[e["bag"]])
        end
    end

    can_hold_gold = Set()
    ix_sg = label_map["shiny gold"]
    can_hold_gold = union(can_hold_gold, inneighbors(g, ix_sg))
    process_queue = union([], can_hold_gold)
    while !isempty(process_queue)
        # println("pq ", process_queue)
        node = pop!(process_queue)
        parents = inneighbors(g, node)
        can_hold_gold = union(can_hold_gold, parents)
        process_queue = union(process_queue, parents)
    end
    length(can_hold_gold)
end


function day7_2(input)

    num_bags = 0
    process_queue = [("shiny gold", 1)]
    while !isempty(process_queue)
        # println(">>>")
        # println("pq ", process_queue)
        (node, node_count) = pop!(process_queue)
        # println("node: ", node)
        children = input[node]
        # println("children: ", children)
        if isnothing(children)
            continue
        end
        for child in children
            push!(process_queue, (child["bag"], node_count * child["count"]))
            num_bags += node_count * child["count"]
        end
        # println("current count: ", num_bags)
        # println("<<<\n")
    end
    num_bags
end


[day7_1(ex07), day7_1(in07)]

[day7_2(ex07), day7_2(ex07_1), day7_2(in07)]
