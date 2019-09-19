def average(num_1, num_2)
    (num_1 + num_2) / 2.0
end

def average(nums)
    nums.sum / nums.length * 1.0
end

def repeat(str, num)
    string = ""
    num.times {string += str }
    string
end

def yell(str)
    str.upcase + "!"
end

def alter(sentence)
    words = sentence.split(" ")
    result = words.map.with_index do |word, i|
        if i % 2 == 0
            word.upcase
        else
            word.downcase
        end
    end
    result.join(" ")
end



def hipsterfy(word)
    vowels = "aeiou"
    last = word.length - 1
    while last >= 0
        if vowels.include?(word[i])
            return word[0...i] + word[i + 1...last]
        end
        i -= 1
    end
    word # no vowels preseent return original word
end


def vowel_counts(str)
    counts = Hash.new(0)
    vowels = "aeiou"
    str.each_char do |char|
        if vowels.include?(char.downcase)
            counts[char.downcase] += 1
        end
    end
    counts
end


def caesar_cipher(msg, num)
    alphabet = ("a".."z"),to_a
    new_msg = ""
    msg.each_char do|char|
        if alphabet.include(char)
            old_index = alphabet.index(char) # get alphabet value
            new_index = old_index + num
            new_msg += alphabet[new_index % 26] # if value goes bigger than 25
        else
            new_msg += char
        end
    end
    new_msg
end