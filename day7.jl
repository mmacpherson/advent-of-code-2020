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
        out[left] = [Dict("count" => parse(Int, split(e)[1]), "bag" => join(split(e)[2:end], " ")) for e = right]
    end
    out
end

ex07 = parse_input("data/ex07")
in07 = parse_input("data/in07")
