def anagram(str1, str2)
    return false if str1 == nil || str2 == nil
    return false if str1.length != str2.length
    result = Hash.new(0)
    
    str1.each_char do |char|
        result[char] += 1
    end
    
    str2.each_char do |char|
        result[char] -= 1
    end
    result.all? { |k,v| v.zero? }
end
# anagram("A", "a") Test for integer, nil, empty
#--------------------------------------------------------------------------------
# Length of Last Word
# Input: "Hello World" 		Output: 5
# Input => "   ", "   abc"
def length_of_last_word(s)
    s = s.lstrip.split(" ")
    return 0 if s.empty?
    s.last.length
end
#--------------------------------------------------------------------------------------------
# Longest Common Prefix
# Write a function to find the longest common prefix string amongst an array of strings.
# Input: ["flower","flow","flight"] 	Output: "fl"
# Input: ["dog","racecar","car"] 		Output: ""
# @param {String[]} strs
# @return {String}
def longest_common_prefix(strs)
    return "" if strs.empty?
    return strs.join("") if strs.length == 1
    index = 2
    common = compare(strs[0], strs[1])
    
    while index < strs.length
        return "" if common == ""
        common = compare(common, strs[index])
        index += 1
    end
    common
end

def compare(str1, str2)
    #return "" if str1.empty? || str2.empty?
    result = [] 
    str1.each_char.with_index do |char, i|
        if char == str2[i]
            result << char 
        else
            return result.join("")
        end
    end
    result.join("")
end

#--------------------------------------------------------------------------------------------
# longest palindrome substring
# @param {String} s
# @return {Integer}
def longest_palindrome(s)
    longest = false
    longest_str = ""
    (0...s.length - 1).each do |i|
        (i + 1...s.length).each do |j|
            curr_str = s[i..j]
            curr_size = curr_str.length
            if is_palindrome?(curr_str)
                longest = curr_size if !longest || longest < curr_size
                longest_str = curr_str if longest_str.length < curr_size
            end
        end
    end
    return longest, longest_str
end

def is_palindrome?(str)
    str == str.reverse
end
#--------------------------------------------------------------------------------------------
# Count and Say
# The count-and-say sequence is the sequence of integers with the first five terms as following:
# 1.     1
# 2.     11
# 3.     21
# 4.     1211
# 5.     111221
# 1 is read off as "one 1" or 11.
# 11 is read off as "two 1s" or 21.
# 21 is read off as "one 2, then one 1" or 1211.
# @param {Integer} n   @return {String}
def count_and_say(n)
    return "1" if n <= 1
    return "11" if n == 2
    result  = "11"

    for i in 3..n
        temp = "" # for adding to term in string
        count = 1
        for j in 1...result.length + 1
            if result[j] != result[j - 1]
                temp += count.to_s
                temp += result[j - 1]
                count = 1
            else
                count += 1
            end
        end
        result = temp
    end
    result
end
#--------------------------------------------------------------------------------------------
# Implement strStr()
# Return the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.
# Input: haystack = "hello", needle = "ll" 	Output: 2
def str_str(haystack, needle)
    return 0 if needle.empty?
    pattern_length = needle.length
    i = 0
    while i <= (haystack.length - pattern_length) do
         return i if needle == haystack.slice(i, pattern_length)
         i += 1
    end
    return -1
end
#--------------------------------------------------------------------------------------------
# String to Integer (atoi)
# Implement atoi which converts a string to an integer.
# Input: "42" 		Output: 42
# Input: "   -42" 	Output: -42
# Input: "4193 with words"   Output: 4193
# Input: "words and 987" 		Output: 0
# Input: "-91283472332"  Output: -2147483648
# @param {String} str
# @return {Integer}
def my_atoi(str)
    return 0 if str.length == 0
    str = str.lstrip #leading white space remove
    sign = 1
    res = 0
    i = 0
    # for -ve
    if str[0] == '-'
        sign = -1
        i += 1
    elsif str[0] == '+'
        i += 1
    end
    while i < str.length
        isDigit =  isNum?(str[i]) 
        return 0 if !isDigit && res == 0 
        return res * sign if !isDigit
        res = res * 10 + str[i].to_i
        i += 1
    end
    res < 2147483648 ? res * sign : 2147483648 * sign
end

def isNum?(num)
   num >= '0' && num <= '9' ? true : false
end
#--------------------------------------------------------------------------------------------
#  Compare Version Numbers
# Compare two version numbers version1 and version2.
# If version1 > version2 return 1; if version1 < version2 return -1;otherwise return 0.
# Input: version1 = "0.1", version2 = "1.1" 			Output: -1
# Input: version1 = "1.0.1", version2 = "1" 			Output: 1
# Input: version1 = "7.5.2.4", version2 = "7.5.3"  	Output: -1
# Input: version1 = "1.01", version2 = "1.001" 		Output: 0
# @param {String} version1
# @param {String} version2
# @return {Integer}
def compare_version(version1, version2)
    num1, num2 = 0, 0
    i, j = 0, 0
    while i < version1.length || j < version2.length
        while i <version1.length && version1[i] != '.'
            num1 = num1 * 10 + version1[i].to_i
            i += 1
        end
        while j < version2.length && version2[j] != '.'
            num2 = num2 * 10 + version2[j].to_i
            j += 1
        end
        return 1 if num1 > num2
        return -1 if num2 > num1
        
        num1 = num2 = 0
        i += 1
        j += 1
    end
    return 0
end
#--------------------------------------------------------------------------------------------
# Reverse String I
# Input: ["h","e","l","l","o"] 	Output: ["o","l","l","e","h"]
# @param {Character[]} s
# @return {Void} Do not return anything, modify s in-place instead.
def reverse_string(str)
    return str if str.length < 1
    i = 0
    while i < (str.length / 2)
        temp = str[i]
        str[i] = str[-1 - i]
        str[-1 - i] = temp
        i += 1
    end
    str
end
# Reverse Words in a String III
# Given a string, you need to reverse the order of characters in each word within a sentence 
# while still preserving whitespace and initial word order.
# Input: "Let's take LeetCode contest"	Output: "s'teL ekat edoCteeL tsetnoc"
# @param {String} s
# @return {String}
def reverse_words(s)
    result = ""
    temp_arr = s.split(" ")
    temp_arr.each do |word|
        result.concat(reverse(word))
        result.concat(" ")
    end
    result.rstrip # ending space remove
end

def reverse(str)
    return str if str.length < 1
    str[-1] + reverse(str[0..-2])
end
#--------------------------------------------------------------------------------------------
# Roman to Integer
# Input: "III" 		Output: 3
# Input: "IV" 		Output: 4
# Input: "IX" 		Output: 9
# Input: "LVIII" 		Output: 58
# @param {String} s
# @return {Integer}
def roman_to_int(s)
    return 0 if s.empty? || s.nil?
    # hash = {"I": 1, 'V': 5, 'X': 10, 'L': 50, 'C': 100, 'D': 500, 'M': 1000} if u do this keys will become symbols when you try to access it use to_sym
    hash = {"I" => 1, 'V' => 5, 'X' => 10, 'L' => 50, 'C' => 100, 'D' => 500, 'M' => 1000}
    sum = hash[s[s.size - 1]]
    for i in (s.length - 2).downto(0)
        curr = hash[s[i]]
        if curr < hash[s[i + 1]]
            sum -= curr
        else
            sum += curr
        end
    end
    sum
end
#--------------------------------------------------------------------------------------------
# Integer to Roman
# @param {Integer} num
# @return {String}
def int_to_roman(num)
    return 0 if num.nil?
    m = ["", "M", "MM", "MMM"]
    c = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"]
    x = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"]
    i = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]
    m[num/1000] + c[(num % 1000) / 100] + x[(num % 100) / 10] + i[num % 10]
end
#--------------------------------------------------------------------------------------------
# Add Binary
# Given two binary strings, return their sum (also a binary string).
# The input strings are both non-empty and contains only characters 1 or 0.
# Input: a = "11", b = "1" 			Output: "100"
# Input: a = "1010", b = "1011" 		Output: "10101"
# @param {String} a
# @param {String} b
# @return {String}
def add_binary(a, b)
    sizeA, sizeB = a.length - 1, b.size - 1
    res = []
    carry = 0
    while sizeA >= 0 || sizeB >= 0
        sum = carry
        sum += a[sizeA].to_i if sizeA >= 0
        sum += b[sizeB].to_i if sizeB >= 0
        res.unshift(sum % 2)
        carry = sum / 2
        sizeA -= 1
        sizeB -= 1
    end
    res.unshift(carry) if carry == 1
    res.join("")
end
#--------------------------------------------------------------------------------------------
# Power of Two
# Given an integer, write a function to determine if it is a power of two.
# Input: 1 		Output: true 
# Input: 16 		Output: true
# Input: 218 		Output: false
def is_power_of_two(n)
    return false if n < 1
    return true if n == 1
    power = 1
    while power <= n
        power *= 2
        return true if power == n
    end
    false
end
#--------------------------------------------------------------------------------------------
# Multiply Strings
# Given two non-negative integers num1 and num2 represented as strings, return the product of num1 and num2, also represented as a string.
# Input: num1 = "2", num2 = "3" 			Output: "6"
# Input: num1 = "123", num2 = "456" 		Output: "56088"
# @param {String} num1
# @param {String} num2
# @return {String}
def multiply(num1, num2)
    carry = count = 0
    res = []
    for i in (num1.size - 1).downto(0)
        temp = []
        for j in (num2.size - 1).downto(0)
            multi = num1[i].to_i * num2[j].to_i
            sum = multi + carry
            carry = (sum / 10)
            temp.unshift(sum % 10)
        end
        c = count
        while c > 0
            temp << 0
            c -= 1
        end
        temp = temp.unshift(carry).join("").to_i
        res << temp
        carry = 0
        count += 1
    end
    res.sum.to_s
end
#--------------------------------------------------------------------------------------------
# ZigZag Conversion
# The string "PAYPALISHIRING" is written in a zigzag pattern on a given number of rows like this: 
# (you may want to display this pattern in a fixed font for better legibility)
# P   A   H   N
# A P L S I I G
# Y   I   R
# And then read line by line: "PAHNAPLSIIGYIR"
# Write the code that will take a string and make this conversion given a number of rows:
# Input: s = "PAYPALISHIRING", numRows = 4
# Output: "PINALSIGYAHRPI"
# Explanation:
# P     I    N
# A   L S  I G
# Y A   H R
# P     I
# @param {String} s
# @param {Integer} num_rows
# @return {String}
def convert(s, num_rows)
    return s if num_rows <= 1
    row = 0
    down = true
    new_arr = Array.new(num_rows) {Array.new}
    
    (0...s.length).each do |i|
        new_arr[row] << s[i]
        down = false if row == num_rows - 1
        down = true if row == 0
        if down
            row += 1
        else
            row -= 1
        end
    end
    new_arr.join("")
end
#--------------------------------------------------------------------------------------------
# Validate IP Address
# Input: "172.16.254.1" 		Output: "IPv4"
# Input: "2001:0db8:85a3:0:0:8A2E:0370:7334" 	Output: "IPv6"
# Input: "256.256.256.256" 		Output: "Neither"
# @param {String} ip
# @return {String}
def valid_ip_address(ip)
    return 0 if ip.empty? || ip.nil?
    return "IPv4" if is_ipv4(ip)
    return "IPv6" if is_ipv6(ip.upcase)
    return "Neither"
end

def is_ipv4(ip)
    dots = ip.count(".")
    return false if dots != 3
    ip = ip.split(".")
    return false if ip.size != 4
    
    ip.each do |num|
        return false if num.empty? || num.length > 3
        (0...num.size).each do |i|
            return false if !is_digit?(num[i])
        end
        return false if num < '0' || num > '255'   
    end
    
    true
end

def is_ipv6(ip)
    dots = ip.count(":")
    return false if dots != 7
    ip = ip.split(":")
    return false if ip.size != 8
    ip.each do |num|
        num.each_char do |char|
            return false if !is_digit?(char) && (char < 'A' || char > 'F')
        end
        #return false if num < '0' || num > '255'   
    end
    
    true
end

def is_digit?(nums)
    nums.each_char do |char|
        return false unless char >= '0' && char <= '9'
    end
    true
end
#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------
v Hard prob
65. Valid Number
68. Text Justification
http://qa.geeksforgeeks.org/3734/qa.geeksforgeeks.org/3734/print-the-pretty-json-strings-facebook-microsoft.html
#--------------------------------------------------------------------------------------------
