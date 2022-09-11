function parse_input(fname)

    xx = [split(x, "") for x in readlines(fname)]
    nrow = length(xx)
    ncol = length(xx[1])
    # A little pipeline.
    xx = [(xx...)...]
    xx = convert(Array{String}, xx)
    xx = reshape(xx, ncol, nrow)
    xx = permutedims(xx)
    (xx .== "#")
end

ex03 = parse_input("data/ex03")
in03 = parse_input("data/in03")

function wrapped_access(A, m, n)
    M, N = size(A)
    A[1+((m-1)%M), 1+((n-1)%N)]
end

function day3_1(input)
    nrow, ncol = size(input)
    m, n, count = 1, 1, 0
    for i = 1:(nrow-1)
        m += 1
        n += 3
        count += wrapped_access(input, m, n)
    end
    count
end

function day3_2(input)
    nrow, ncol = size(input)

    product = 1
    for (r, d) in [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
        m, n, count = 1, 1, 0
        while true
            m += d
            n += r
            if (m > nrow)
                break
            end
            count += wrapped_access(input, m, n)
        end
        product *= count
    end
    product
end


[day3_1(ex03), day3_1(in03)]


[day3_2(ex03), day3_2(in03)]
