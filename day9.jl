using Combinatorics: combinations

function parse_input(fname)

    out = []
    for line in readlines(fname)
        value = parse(Int, line)
        push!(out, value)
    end
    out
end


ex09 = parse_input("data/ex09")
in09 = parse_input("data/in09")

function is_compatible(xs, a)
    for combo in combinations(xs, 2)
        if sum(combo) == a
            return true
        end
    end
    false
end

function first_incompatible(xs, window)

    for ix = (window+1):length(xs)
        if !is_compatible(xs[ix-window:(ix-1)], xs[ix])
            return xs[ix]
        end
    end
    nothing
end

function day9_1(input)
    first_incompatible(input, 25)
end

[first_incompatible(ex09, 5), day9_1(in09)]
