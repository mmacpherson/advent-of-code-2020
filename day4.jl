function parse_input(fname)

    out = []
    current = Dict()
    for line in readlines(fname)
        if line == ""
            push!(out, current)
            current = Dict()
            continue
        end

        for kv in split(line)
            key, value = split(kv, ":")
            current[key] = value
        end

    end

    if !isempty(current)
        push!(out, current)
    end

    out
end

required = Set([
    "byr",
    # "cid"
    "ecl",
    "eyr",
    "hcl",
    "hgt",
    "iyr",
    "pid",
])

ex04 = parse_input("data/ex04")
ex04_1 = parse_input("data/ex04-1")
ex04_2 = parse_input("data/ex04-2")
in04 = parse_input("data/in04")

function day4_1(input)
    num_valid = 0
    for passport in input

        if length(intersect(required, Set(keys(passport)))) >= 7
            num_valid += 1
        end

    end
    num_valid
end

function p_s_num_range(s, lo, hi)
    try
        n = parse(Int, s)
        return lo <= n <= hi
    catch ArgumentError
        return false
    end

end

function valid_height(s)
    if endswith(s, "cm")
        return p_s_num_range(replace(s, "cm" => ""), 150, 193)
    elseif endswith(s, "in")
        return p_s_num_range(replace(s, "in" => ""), 59, 76)
    end
    false
end

function day4_2(input)

    num_valid = 0

    for passport in input

        if length(intersect(required, Set(keys(passport)))) < 7
            continue
        end

        # byr (Birth Year) - four digits; at least 1920 and at most 2002.
        # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
        # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
        # hgt (Height) - a number followed by either cm or in:
        #     If cm, the number must be at least 150 and at most 193.
        #     If in, the number must be at least 59 and at most 76.
        # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
        # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
        # pid (Passport ID) - a nine-digit number, including leading zeroes.
        # cid (Country ID) - ignored, missing or not.

        if (&)(
            p_s_num_range(passport["byr"], 1920, 2002),
            p_s_num_range(passport["iyr"], 2010, 2020),
            p_s_num_range(passport["eyr"], 2020, 2030),
            valid_height(passport["hgt"]),
            !isnothing(match(r"^#[0-9a-f]{6}$", passport["hcl"])),
            passport["ecl"] in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"],
            !isnothing(match(r"^[0-9]{9}$", passport["pid"])),
        )
            num_valid += 1
        end
    end

    num_valid
end

[day4_1(ex04), day4_1(in04)]

[day4_2(ex04), day4_2(in04)]
