# 29. Divide Two Integers
# Given two integers dividend and divisor, divide two integers without using multiplication, division and mod operator.
# Return the quotient after dividing dividend by divisor.
# The integer division should truncate toward zero.
# Input: dividend = 10, divisor = 3     Output: 3
# Input: dividend = 7, divisor = -3     Output: -2
def divide(dividend, divisor)
    sign = (dividend < 0) ^ (divisor < 0) ? -1 : 1
    dividend, divisor, quotient = dividend.abs, divisor.abs, 0

    while dividend >= divisor
        temp, i = divisor, 1

        while dividend >= temp
            dividend -= temp
            quotient += i

            i <<= 1  # i = i << 1
            temp <<= 1
        end
    end

    [[-2147483648, sign * quotient].max, 2147483647].min
end
#--------------------------------------------------------------------------------------------
# 40. Combination Sum II
# Given a collection of candidate numbers (candidates) and a target number (target), find all unique combinations in candidates where the candidate numbers sums to target.
# Each number in candidates may only be used once in the combination.
# Note:All numbers (including target) will be positive integers.
# The solution set must not contain duplicate combinations.
# Input: candidates = [10,1,2,7,6,1,5], target = 8,
#   [[1, 7],
#   [1, 2, 5],
#   [2, 6],
#   [1, 1, 6]]
def combination_sum2(candidates, target)
    candidates.sort!
    results = []
    generate_combination_sum(results, [], candidates, target, 0)
    results
end
  
def generate_combination_sum(res, tmp, nums, target, index)
    if target == 0
        res << tmp.clone 
        return
    end
    return if nums[index].nil? || target < nums[index]
  
     (index...nums.length).each do |i|
        next if (nums[i] == nums[i-1]) && (i > index)
        break if nums[i] > target

        tmp << nums[i]
        generate_combination_sum(res, tmp, nums, target - nums[i], i+1)  

        tmp.pop
    end
end
#--------------------------------------------------------------------------------------------
# 86. Partition List
# Given a linked list and a value x, partition it such that all nodes less than x come before nodes greater than or equal to x.
# You should preserve the original relative order of the nodes in each of the two partitions.
# Input: head = 1->4->3->2->5->2, x = 3
# Output: 1->2->2->4->3->5
def partition(head, x)
    return head if head == nil || head.next == nil
    tmp_head = tmp_tail = nil
    tmp_head_node = tmp_tail_node = nil
    node = head
    while (node.nil? == false)
        tmp_next = node.next
        node.next = nil
        if node.val < x
            if tmp_head.nil?
              tmp_head = node
              tmp_head_node = node
            else
              tmp_head_node.next = node
              tmp_head_node = node
            end
        else
            if tmp_tail.nil?
              tmp_tail = node
              tmp_tail_node = node
            else
              tmp_tail_node.next = node
              tmp_tail_node = node
            end
         end
         node = tmp_next
    end
    tmp_head_node.next = tmp_tail if tmp_head.nil? == false
    tmp_head = tmp_tail if tmp_head.nil?
    node = tmp_head
end
#--------------------------------------------------------------------------------------------
# 179. Largest Number
# Given a list of non negative integers, arrange them such that they form the largest number.
# Input: [10,2]       Output: "210"
# Input: [3,30,34,5,9]    Output: "9534330"
def largest_number(a)
    numbers_in_str = a.map(&:to_s) # convert number to string
    sorted_numbers = numbers_in_str.sort do |number1, number2|
        (number2 + number1) <=> (number1 + number2)
    end
    return "0" if sorted_numbers[0] == '0'
    sorted_numbers.join
# nums.map(&:to_s).sort { |a, b| b + a <=> a + b }.join.to_i.to_s
end
#--------------------------------------------------------------------------------------------
# 468. Validate IP Address
# Write a function to check whether an input string is a valid IPv4 address or IPv6 address or neither.
# IPv4 addresses are canonically represented in dot-decimal notation, which consists of four decimal numbers, each ranging from 0 to 255, separated by dots ("."), e.g.,172.16.254.1;
# Besides, leading zeros in the IPv4 is invalid. For example, the address 172.16.254.01 is invalid.
# IPv6 addresses are represented as eight groups of four hexadecimal digits, each group representing 16 bits. The groups are separated by colons (":"). For example, the address 2001:0db8:85a3:0000:0000:8a2e:0370:7334 is a valid one. Also, we could omit some leading zeros among four hexadecimal digits and some low-case characters in the address to upper-case ones, so 2001:db8:85a3:0:0:8A2E:0370:7334 is also a valid IPv6 address(Omit leading zeros and using upper cases).
# However, we don't replace a consecutive group of zero value with a single empty group using two consecutive colons (::) to pursue simplicity. For example, 2001:0db8:85a3::8A2E:0370:7334 is an invalid IPv6 address.
# Besides, extra leading zeros in the IPv6 is also invalid. For example, the address 02001:0db8:85a3:0000:0000:8a2e:0370:7334 is invalid.
# Note: You may assume there is no extra space or special characters in the input string.
# Input: "172.16.254.1"     Output: "IPv4"
# Input: "2001:0db8:85a3:0:0:8A2E:0370:7334"    Output: "IPv6"
# Input: "256.256.256.256"    Output: "Neither"
def valid_ip_address(ip)
    tryIP4 = ip.split(".")
    tryIP6 = ip.split(":")
    if tryIP4.length == 4 && ip[0] != "." && ip[-1] != "."
        valid = validateIPv4(tryIP4)
        return "IPv4" if valid
    elsif tryIP6.length == 8 && ip[0] != ":" && ip[-1] != ":"
        valid = validateIPv6(tryIP6)
        return "IPv6" if valid
    end
    return "Neither"
end

def validateIPv4(groups)
    groups.each do |group|
        return false if group[0] == '0' && group != '0'
        return false if group.length < 1
        return false if group.to_i > 255
        digits = '1234567890'.chars
        group.each_char {|char| return false if !digits.include?(char)}
    end
    true
end

def validateIPv6(groups)
    groups.each do |group|
        return false if group.length < 1 || group.length > 4
        chars = "1234567890abcdefABCDEF".chars
        group.each_char {|char| return false if !chars.include?(char)}
    end
    true
end

#--------------------------------------------------------------------------------------------
# 4. Median of Two Sorted Arrays
# There are two sorted arrays nums1 and nums2 of size m and n respectively.
# Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).
# You may assume nums1 and nums2 cannot be both empty.
# nums1 = [1, 3] nums2 = [2]     The median is 2.0
# nums1 = [1, 2] nums2 = [3, 4]   The median is (2 + 3)/2 = 2.5
def find_median_sorted_arrays(nums1, nums2)
    combined_arr = []
    while !nums1.empty? && !nums2.empty?
        if nums1[0] <= nums2[0]
            combined_arr << nums1.shift
        else
            combined_arr << nums2.shift
        end
    end
    done = nums1.length <= nums2.length ? 1 : 2
    if done == 1
        combined_arr += nums2
    else
        combined_arr += nums1
    end
    median(combined_arr) * 1.0
end


def median(combined_arr)
    l = combined_arr.length - 1
    half_i = l / 2
    if l % 2 == 0 
        combined_arr[half_i]
    else 
        (combined_arr[half_i] + combined_arr[half_i + 1]) / 2.0  
    end
end
# 3 line solution
# total_nums = (nums1 + nums2).sort!
# length = total_nums.length
# length % 2 == 0 ? (total_nums[length / 2 - 1] + total_nums[length / 2]) / 2.0 : total_nums[length / 2] / 1.0


#--------------------------------------------------------------------------------------------
# 8. String to Integer (atoi)
# Implement atoi which converts a string to an integer.
# Input: "42"                 Output: 42
# Input: "   -42"             Output: -42
# Input: "4193 with words"    Output: 4193
# Input: "words and 987"      Output: 0
# Input: "-91283472332"       Output: -2147483648

# gettin error on input
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

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------