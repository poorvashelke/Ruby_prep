#--------------------------------------------------------------------------------------------
# Single number
# Input: [4,1,2,1,2]		Output: 4
# @param {Integer[]} nums
# @return {Integer}
def single_number(nums)
    sum = 0
    nums.each do |num|
        sum ^= num
    end
    sum
end
#--------------------------------------------------------------------------------------------
# Single Number II
# Given a non-empty array of integers, every element appears three times except for one, which appears exactly once. Find that single one.
# Your algorithm should have a linear runtime complexity. Could you implement it without using extra memory?
# Input: [2,2,3,2]  	Output: 3
# Input: [0,1,0,1,0,1,99]  	Output: 99
# @param {Integer[]} nums
# @return {Integer}
def single_number(nums)
    first = second = 0
    nums.each do |num|
        first ^= num & ~second
        second ^= num & ~first
    end
    first
end
#--------------------------------------------------------------------------------------------
# Number of 1 Bits
# Write a function that takes an unsigned integer and return the number of '1' bits it has (also known as the Hamming weight).
# Input: 00000000000000000000000000001011 	Output: 3
# Input: 11111111111111111111111111111101 	Output: 31
# @param {Integer} n, a positive integer
# @return {Integer}
def hamming_weight(n)
    count = 0
    while n > 0
        count += 1 if n & 1 == 1
        n >>= 1
    end
    count
end
#--------------------------------------------------------------------------------------------
# 1-bit and 2-bit Characters
# We have two special characters. The first character can be represented by one bit 0. The second character can be represented by two bits (10 or 11).
# Now given a string represented by several bits. Return whether the last character must be a one-bit character or not. The given string will always end with a zero.
# Input: bits = [1, 0, 0] 	Output: True
# Explanation: The only way to decode it is two-bit character and one-bit character. So the last character is one-bit character.
# Input:  bits = [1, 1, 1, 0] 	Output: False
# Explanation: The only way to decode it is two-bit character and two-bit character. So the last character is NOT one-bit character.
# @param {Integer[]} bits
# @return {Boolean}
def is_one_bit_character(bits)
    i = 0
    while i < bits.size - 1
    # 0 is 1-bit, 1 is 2-bit
        if bits[i] == 0
            i += 1
        else
            i += 2
        end
    end
    i == bits.size - 1
end
#--------------------------------------------------------------------------------------------
# Reverse Bits
# Reverse bits of a given 32 bits unsigned integer.
# Input: 00000010100101000001111010011100 	Output: 00111001011110000010100101000000
# Explanation: The input binary string 00000010100101000001111010011100 represents the unsigned integer 43261596, 
# so return 964176192 which its binary representation is 00111001011110000010100101000000.
# Input: 11111111111111111111111111111101		Output: 10111111111111111111111111111111
# @param {Integer} n, a positive integer
# @return {Integer}
def reverse_bits(n)
    count = 0
    for i in (0...32)
        count = (count << 1) | (n & 1)
		n = n >> 1
    end
    count
end
#--------------------------------------------------------------------------------------
# Divide Two Integers
# Given two integers dividend and divisor, divide two integers without using multiplication, division and mod operator.
# Return the quotient after dividing dividend by divisor.The integer division should truncate toward zero.
# Input: dividend = 10, divisor = 3 		Output: 3
# Input: dividend = 7, divisor = -3 		Output: -2
	# Determine the most significant bit in the quotient. This can easily be calculated by iterating on the bit position i from 31 to 1.
	# Find the first bit for which divisor << i is less than dividend and keep updating the ith bit position for which it is true.
	# Add the result in temp variable for checking the next position such that (temp + (divisor << i) ) is less than dividend.
	# Return the value
# @param {Integer} dividend
# @param {Integer} divisor
# @return {Integer}
def divide(dividend, divisor)
    sign = (dividend < 0) ^ (divisor < 0) ? -1 : 1
    dividend = dividend.abs
    divisor = divisor.abs
    quotient = temp = 0
    
    for i in (31).downto(0)
        if (temp + (divisor << i) <= dividend)
            temp += divisor << i  
            quotient |= 1 << i
        end
    end
    sign * quotient
end
#--------------------------------------------------------------------------------------------
# Different bit sum pairwise
# Input: arr[] = {1, 2}		Output: 4
# All pairs in array are (1, 1), (1, 2)
#                        (2, 1), (2, 2)
# Sum of bit differences = 0 + 2 +
#                          2 + 0
#                       = 4

# Input:  arr[] = {1, 3, 5} 	Output: 8
# All pairs in array are (1, 1), (1, 3), (1, 5)
#                        (3, 1), (3, 3) (3, 5),
#                        (5, 1), (5, 3), (5, 5)
# Sum of bit differences =  0 + 1 + 1 +
#                           1 + 0 + 2 +
#                           1 + 2 + 0 
#                        = 8
def sumBitDifferences(arr) 
    ans = 0  
    n = arr.size
    #traverse over all bits 
    for i in (0...32) 
        #count number of elements with i'th bit set 
        count = 0; 
        for j in (0...n) 
            if (arr[j] & (1 << i)) == 0
                count += 1
            end
        end
        #Add "count * (n - count) * 2" to the answer 
        ans += (count * (n - count) * 2)
    end 
    return ans; 
end
#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------
