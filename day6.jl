function parse_input(fname)

    out = []
    current = []
    for line in readlines(fname)
        if line == ""
            push!(out, current)
            current = []
            continue
        end

        push!(current, line)

    end

    if !isempty(current)
        push!(out, current)
    end

    out
end


ex06 = parse_input("data/ex06")
in06 = parse_input("data/in06")

count_distinct(xs) = length(reduce(union, [Set(collect(x)) for x = xs]))
day6_1(input) = sum(map(count_distinct, input))

function counts(s)
    out = Dict()
    for e in s
        if haskey(out, e)
            out[e] += 1
        else
            out[e] = 1
        end
    end
    out
end

function count_unanimous(xs)
    denom = length(xs)
    sum([v == denom for v = values(counts(join(xs)))])
end

day6_2(input) = sum(map(count_unanimous, input))

[day6_1(ex06), day6_1(in06)]

[day6_2(ex06), day6_2(in06)]
