using Base: bitshow
function parse_input(fname)
    readlines(fname)
end

fb2bin(s) = parse(Int, join(Dict('B' => '1', 'F' => '0')[e] for e in s), base = 2)
lr2bin(s) = parse(Int, join(Dict('R' => '1', 'L' => '0')[e] for e in s), base = 2)

parse_boarding_pass(s) = Dict("row" => fb2bin(s[1:7]), "col" => lr2bin(s[8:end]))

function day5_1(input)

    seat_ids = [e["row"] * 8 + e["col"] for e in map(parse_boarding_pass, input)]

    maximum(seat_ids)
end

ex05 = parse_input("data/ex05")
in05 = parse_input("data/in05")


bin2fb(s) = join(Dict('1' => 'B', '0' => 'F')[e] for e in bitstring(s)[end-6:end])
bin2lr(s) = join(Dict('1' => 'R', '0' => 'L')[e] for e in bitstring(s)[end-2:end])

function day5_2(input)

    seat_ids = sort([e["row"] * 8 + e["col"] for e in map(parse_boarding_pass, input)])

    my_seat = nothing
    for ix in range(1, length(seat_ids))
        if seat_ids[ix+1] - seat_ids[ix] > 1
            my_seat = seat_ids[ix] + 1
            break
        end
    end

    my_seat
end

[day5_1(ex05), day5_1(in05)]


day5_2(in05)
