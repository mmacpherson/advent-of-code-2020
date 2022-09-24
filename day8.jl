function parse_input(fname)

    out = []
    for line in readlines(fname)
        op, val_str = split(line)
        value = parse(Int, val_str)
        z = Dict("op" => op, "value" => value)
        push!(out, z)
    end
    out
end




ex08 = parse_input("data/ex08")
in08 = parse_input("data/in08")
