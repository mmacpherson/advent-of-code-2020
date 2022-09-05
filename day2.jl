function parse_input(fname)
	out = []
	for line in readlines(fname)
		counts, letter, password = split(line) 
		low, high = map(e -> parse(Int, e), split(counts, "-"))
		letter = only(replace(letter, ":" => ""))
		data = Dict("letter"=>letter, "low"=>low, "high"=>high, "password"=>password)
		push!(out, data)
	end
	out
end

ex02 = parse_input("data/ex02")
in02 = parse_input("data/in02")

function char_counts(s)
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


function day2_1(input)
	count = 0
	for data in input
		cc = char_counts(data["password"])
		if data["low"] <= get(cc, data["letter"], 0) <= data["high"]
			count += 1
		end
	end
	count
end

function day2_2(input)
	count = 0
	for data in input
		l = data["letter"]
		m1 = data["password"][data["low"]] == l
		m2 = data["password"][data["high"]] == l
		if xor(m1, m2)
			count += 1
		end
	end
	count
end


[day2_1(ex02), day2_1(in02)]

[day2_2(ex02), day2_2(in02)]
