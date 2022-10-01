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

function locate_weakness(xs, window)

    invalid_number = first_incompatible(xs, window)

    acc = cumsum(xs)

    for ix = 1:(length(xs)-1)
        for jx = (ix+1):length(xs)
            if ix == 1
                ss = acc[jx]
            else
                ss = acc[jx] - acc[ix-1]
            end
            if ss == invalid_number
                span = xs[ix:jx]
                return minimum(span) + maximum(span)
            elseif ss > invalid_number
                # Numbers are all positive, so once we've gone past
                # invalid_number no longer possible to equal invalid_number.
                continue
            end
        end
    end


end

function day9_1(input)
    first_incompatible(input, 25)
end

function day9_2(input)
    locate_weakness(input, 25)
end

[first_incompatible(ex09, 5), day9_1(in09)]


[locate_weakness(ex09, 5), day9_2(in09)]
