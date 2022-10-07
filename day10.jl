function parse_input(fname)

    out = []
    for line in readlines(fname)
        value = parse(Int, line)
        push!(out, value)
    end
    out
end

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

ex10 = parse_input("data/ex10")
ex10_1 = parse_input("data/ex10-1")
in10 = parse_input("data/in10")

function count_runs(xs)

    out = Dict()
    current = nothing
    run_length = 0
    for e in xs

        if isnothing(current)
            current = e
            run_length = 1
        elseif (e == current)
            run_length += 1
        else
            if haskey(out, current)
                out[current] = vcat(out[current], run_length)
            else
                out[current] = [run_length]
            end
            current = e
            run_length = 1
        end

    end
    out

end

function day10_1(xs)

    jolt_diffs = counts(diff(sort(vcat([0], xs, [maximum(xs) + 3]))))

    return jolt_diffs[1] * jolt_diffs[3]

end

function day10_2(xs)

    run_map = Dict(1 => 1, 2 => 2, 3 => 4, 4 => 7)

    jolt_diffs = diff(sort(vcat([0], xs, [maximum(xs) + 3])))

    jolt_runs = count_runs(jolt_diffs)

    reduce(*, [run_map[e] for e in jolt_runs[1]])

end

[day10_1(ex10), day10_1(ex10_1), day10_1(in10)]

[day10_2(ex10), day10_2(ex10_1), day10_2(in10)]
