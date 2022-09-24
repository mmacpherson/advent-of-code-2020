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

function run_program(program)

    accumulator = 0
    pointer_history = [1]
    while true

        pointer = pointer_history[end]
        instruction = program[pointer]
        if instruction["op"] == "nop"
            ptr_increment = 1
            acc_increment = 0
        elseif instruction["op"] == "jmp"
            ptr_increment = instruction["value"]
            acc_increment = 0
        elseif instruction["op"] == "acc"
            ptr_increment = 1
            acc_increment = instruction["value"]
        else
            @assert false, "Unknown op"
        end

        new_pointer = pointer + ptr_increment

        # Check for infinite loop, for Part 1.
        if new_pointer in pointer_history
            return Dict("value" => accumulator, "status" => "infinite")
        end

        # If not inf loop, update and move on.
        push!(pointer_history, new_pointer)
        accumulator += acc_increment

        # If attempting to exec instruction immediately after end, terminate
        # with success.
        if new_pointer == length(program) + 1
            return Dict("value" => accumulator, "status" => "success")
        end

    end

    return Dict("value" => accumulator, "status" => "unexpected-exit")

end

function day8_1(input)
    run_program(input)["value"]
end


function make_programs(program)

    programs = []
    for ix in range(1, length(program))

        instruction = program[ix]
        if instruction["op"] == "acc"
            continue
        end

        new_program = deepcopy(program)

        if instruction["op"] == "nop"
            new_program[ix]["op"] = "jmp"
        elseif instruction["op"] == "jmp"
            new_program[ix]["op"] = "nop"
        end

        push!(programs, new_program)
    end

    programs
end

function day8_2(program)

    for program_variant in make_programs(program)
        result = run_program(program_variant)
        if result["status"] == "success"
            return result["value"]
        end
    end
end

[day8_1(ex08), day8_1(in08)]

[day8_2(ex08), day8_2(in08)]
