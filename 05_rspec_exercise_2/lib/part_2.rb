def palindrome?(str)
    if str.length == 1 || str.length == 0
        true
    end
    str.each_char.with_index do |char, i|
        if str[i] != str[-i-1]
          false
        end
    end
    true
end
# just use str == str.reverse

def substring(str)
    (0...str.length).each do |char|
        p str[char..char]
        if char!= str.length - 1 
            p str[char..str.length]
        end
    end
end


def palindrome_substring(str)
    substring(str).select {|substr| palindrome?(substr)}
end
