# Write a method, swapper(arr, idx_1, idx_2), that accepts an array and two indices as args.
# The method should swap the elements at the given indices and return the array.
# The method should modify the existing array and not create a new array.

def swapper(arr, idx_1, idx_2)
    arr[idx_1], arr[idx_2] = arr[idx_2], arr[idx_1]
    arr
end

p swapper(["a", "b", "c", "d"], 0, 2)               # => ["c", "b", "a", "d"]
p swapper(["a", "b", "c", "d"], 3, 1)               # => ["a", "d", "c", "b"]
p swapper(["canal", "broadway", "madison"], 1, 0)   # => ["broadway", "canal", "madison"]

# Write a method, is_sorted(arr), that accepts an array of numbers as an arg.
# The method should return true if the elements are in increasing order, false otherwise.
# Do not use the built-in Array#sort in your solution :)

def is_sorted(arr)
    (0...arr.length - 1).each do |i|
        if arr[i] > arr[i + 1]
            return false
        end
    end
    true
end

p is_sorted([1, 4, 10, 13, 15])       # => true
p is_sorted([1, 4, 10, 10, 13, 15])   # => true
p is_sorted([1, 2, 5, 3, 4 ])         # => false

# Reimplement the bubble sort outlined in the preceding lecture.
# The bubble_sort method should accept an array of numbers and arrange the elements in increasing order.
# The method should return the array.
# Do not use the built-in Array#sort

def bubble_sort(arr)
    (0...arr.length - 1).each do |i|
        (0...arr.length - i - 1).each do |j|
            if arr[j] > arr[j + 1]
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
            end
        end
    end
    arr
end

def bubble_sort(array)
    sorted = false  # when this var is false, that means the array is not fully sorted yet
    while !sorted       # while the array is not sorted...
        sorted = true       # reset the sorted flag to true 

        # the each below will perform a single 'pass' of bubble sort
        (0...array.length - 1).each do |i|
            if array[i] > array[i + 1]                              # if adjacent elements are out of order...
                array[i], array[i + 1] = array[i + 1], array[i]     #   then swap their positions
                sorted = false                                      # since we just made a swap, we may need to perform
            end                                                     # an additional 'pass', so set the flag to false
        end
    end
    array
end

p bubble_sort([2, 8, 5, 2, 6])      # => [2, 2, 5, 6, 8]
p bubble_sort([10, 8, 7, 1, 2, 3])  # => [1, 2, 3, 7, 8, 10]

# Write a method, peak_finder(arr), that accepts an array of numbers as an arg.
# The method should return an array containing all of "peaks" of the array.
# An element is considered a "peak" if it is greater than both it's left and right neighbor.
# The first or last element of the array is considered a "peak" if it is greater than it's one neighbor.

def peak_finder(arr)
    peaks =[]
    arr.each_with_index do |curr, i|
        left = arr[i - 1]
        right = arr[i + 1]
        
        if i == 0 && curr >  right
            peaks << curr
        elsif i == arr.length - 1 && left < curr
            peaks << curr
        elsif left < curr && curr > right
            peaks << curr
        end
    end     

    peaks
end
p peak_finder([1, 3, 5, 4])         # => [5]
p peak_finder([4, 2, 3, 6, 10])     # => [4, 10]
p peak_finder([4, 2, 11, 6, 10])    # => [4, 11, 10]

# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".

def compress_str(str)
    compress = ""
    i = 0
    while i < str.length
        char = str[i]
        count = 0
        while char == str[i]
            count += 1
            i += 1
        end
        if count < 2
            compress += char
        else
            compress += count.to_s + char
        end
    end

    compress
end

p compress_str("aaabbc")        # => "3a2bc"
p compress_str("xxyyyyzz")      # => "2x4y2z"
p compress_str("qqqqq")         # => "5q"
p compress_str("mississippi")   # => "mi2si2si2pi"
