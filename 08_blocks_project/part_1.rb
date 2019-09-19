def select_even_nums(nums)
    nums.select {|num| num.even? }
# OR nums.select(&:even?) parameter and call single method we can use this pattern 
end

def reject_puppies(dogs)
    dogs.reject {|dog| dog["age"] <= 2 }
end

def count_positive_subarray(arr)
    arr.count {|subarray| subarray.sum > 0 }
end

def aba_translate(word)
    vowels = "aeiou"
    new_words = ""
    words.each_char do |char|
        if vowels.include?(char)
            new_words += char + "b" + char
        else
            new_words += char
        end
    end
    new_words
end

def aba-array(words)
    words.map { |word| aba_translate(word)}
end