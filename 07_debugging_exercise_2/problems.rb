def prime?(num)
    return false if num < 2
    (2...num).none? {|i| num % i == 0}
end

def largest_prime_factor(num)
    num.downto(2) do |i|
        if num % i == 0 && prime?(i)
            return i
        end
    end
end

def unique_chars?(string)
    already_seen = []

    string.each_char do |char|
        return false if already_seen.include?(char)
        already_seen << char
    end
    true 
end

def dupe_indices(array)
    indices = Hash.new {|h, k| h[k] = [] }
    array.each_with_index do |ele, i|
        indices[ele] << i
    end
    indices.select { |k, v| v.length > 1}
end

# helper for ana_array
def ele_count(arr)
    count = Hash.new(0) # default value 0
    arr.each {|ele| count[ele] += 1}
    count
end

def ana_array(arr_1, arr_2)
    count_1 = ele_count(arr_1)
    count_2 = ele_count(arr_2)
    count_1 == count_2
end