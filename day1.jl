function read_numbers(fname, dtype = Int)
    map(e -> parse(dtype, e), readlines(fname))
end


function day1_1(input)
    [a * b for a = input, b = input if (a < b) && (a + b == 2020)]
end

function day1_2(input)
    [
        a * b * c for
        a = input, b = input, c = input if (a < b) && (b < c) && (a + b + c == 2020)
    ]
end

ex01 = read_numbers("data/ex01")
in01 = read_numbers("data/in01")


[day1_1(ex01), day1_2(ex01)]

[day1_1(in01), day1_2(in01)]
