def partition(arr, num)
    less = []
    greater = []

    arr.each do |ele|
        if ele < num
            less << ele
        else
            greater << ele
    end
    [less, greater]
end


def merge(hash_1, hash_2)
    new_hash = {}
    hash_1.each { |k,v| new_hash[k] = v} # all keys from hash_1 to new_hash
    hash_2.each { |k,v| new_hash[k] = v} # doing same, if same key is present it will override prev

    new_hash
end
# instead of creating new_hash you can just modify given hash and return that
# hash_2.each { |k,v| hash_1[k] = v} putting all ele of hash_2 in hash_1
# hash_1  returning modified hash_1

def censor(sentance, curse_words)
    words = sentence.split(" ")

    new_words = words.map do |word|
        if curse_words.include?(word)
            star_vowel(word)
        else
            word
        end
    end
    new_words.join(" ")
end

def star_vowel(word)
    vowels = "aeiou"
    new_word = ""
    word.each do |char|
        if vowels.include?(char)
            new_word += *
        else
            new_word += char
        end
    end
    new_word
end



def power_of(num)
    product = 1
    while product < num
        product *= 2
    end
    product == num
end