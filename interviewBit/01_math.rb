# Prime sum
# Input : 4
# Output: 2 + 2 = 4
def primesum(a)
    primes = []
    i = 2
    while i <= a
        primes << i if is_prime?(i)
        i += 1
    end
    start = 0
    last = primes.length - 1
    while start <= last
        sum = primes[start] + primes[last]
        if sum == a
            return primes[start], primes[last]
        elsif sum > a
            last -= 1
        else 
            start += 1
        end
    end
        
end

def is_prime?(num)
    (2...num).none? {|i| num % i == 0}
end
#----------------------------------------------------------------------------------
# Power Of Two Integers
# Given a positive integer which fits in a 32 bit signed integer, find if it can be 
# expressed as A^P where P > 1 and A > 0. A and P both should be integers.
# Input : 4   Output : True   as 2^2 = 4. 
    def isPower(a)
        half = a / 2
        while half > 1
            square = half * half
            if square == a
                return true
            end
            half -= 1
        end
        false
    end
#----------------------------------------------------------------------------------
# Excel Column Number
# Given a column title as appears in an Excel sheet, return its corresponding column number.
    A -> 1      B -> 2      Z -> 26
    AA -> 27    AB -> 28 
    def titleToNumber(a)
        alphabet = ('a'..'z').to_a
        str = a.split("")
        sum = 0
        str.each do |char|
            sum *= 26
            sum += alphabet.index(char.downcase) + 1
        end
        sum
    end
#----------------------------------------------------------------------------------
# Excel Column Title
#     1 -> A      2 -> B      3 -> C
#     26 -> Z     27 -> AA    28 -> AB 
    def convertToTitle(a)
        alphabet = ('A'..'Z').to_a
        title = []
        while a > 0
            remainder = a % 26
            if remainder == 0
                title.unshift('Z')
                a = (a / 26) - 1
            else
                title.unshift(alphabet[remainder - 1])
                a = a / 26
            end
        end
        title.join("")
    end
#----------------------------------------------------------------------------------
#Reverse integer        x = -123,  return -321
# @param a : integer
    # @return an integer  
    def reverse(a)
        num = a.to_s
        result = 0
        negative = 0
        if num[0] == '-'
            negative = '-'
            result = helper(num[1..-1])
            return negative.concat(result)
        else
            result = helper(num)
            return result
        end
     end
    
    def helper(a)
        return "" if a.empty?
        a[-1] + helper(a[0...-1])
    end
#----------------------------------------------------------------------------------
# Greatest Common Divisor
# m : 6  n : 9    GCD(m, n) : 3 
    def gcd(a, b)
        return 1 if a == 1 || b == 1
        return a if b == 0
        return b if a == 0
        i = a * b
        while i >= 2 
            return i if a % i == 0 && b % i == 0
            i -= 1
        end
    end   

#----------------------------------------------------------------------------------
# Trailing Zeros in Factorial
# Given an integer n, return the number of trailing zeroes in n!.
# n = 5
# n! = 120 
# Number of trailing zeros = 1 So, return 1
    def trailingZeroes(a)
        num = factorial(a).to_s
        count = 0
        for i in (num.length - 1).downto(0)
            if num[i] == '0'
                count += 1
            else
                return count
            end
        end
    end
    
    def factorial(num)
       return 1 if num == 1
       num * factorial(num - 1)
    end
#----------------------------------------------------------------------------------
# Grid Unique Paths
# A robot is located at the top-left corner of an A x B grid (marked ‘Start’ in the diagram below).
# The robot can only move either down or right at any point in time. The robot is trying to reach the bottom-right corner of the grid (marked ‘Finish’ in the diagram below).
# How many possible unique paths are there?
# Input : A = 2, B = 2    Output : 2
# 2 possible routes : (0, 0) -> (0, 1) -> (1, 1) 
#               OR  : (0, 0) -> (1, 0) -> (1, 1)
    def uniquePaths(a, b)
        return 1 if a == 1 || b == 1
        uniquePaths(a - 1, b) + uniquePaths(a, b - 1)
    end
#----------------------------------------------------------------------------------
# Rearrange Array
# Rearrange a given array so that Arr[i] becomes Arr[Arr[i]] with O(1) extra space.
# {3, 2, 0, 1} In first step, every value is incremented by (arr[arr[i]] % n)*n
# After first step array becomes {7, 2, 12, 9}. 
# The important thing is, after the increment operation
# of first step, every element holds both old values and new values. 
# Old value can be obtained by arr[i]%n and new value can be obtained
# by arr[i]/n.
# In second step, all elements are updated to new or output values 
# by doing arr[i] = arr[i]/n.
# After second step, array becomes {1, 0, 3, 2}

# Input: arr[]  = {3, 2, 0, 1}      Output: {1, 0, 3, 2}
# Input: arr[] = {4, 0, 2, 1, 3}    Output: {3, 4, 2, 0, 1}
# Input: arr[] = {0, 1, 2, 3}       Output: {0, 1, 2, 3}
def rearrange(arr)
    size = arr.length
   (0...size).each do |i|
        arr[i] = arr[i] + (arr[arr[i]] % size) * size  
    end
    
    (0...size).each do |i|
       arr[i] = arr[i] / size
    end
    arr
end
