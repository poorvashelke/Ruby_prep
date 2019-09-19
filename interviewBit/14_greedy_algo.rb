# 169. Majority Element
# Given an array of size n, find the majority element. The majority element is the element that appears more than ⌊ n/2 ⌋ times.
# You may assume that the array is non-empty and the majority element always exist in the array.
# Input: [3,2,3] 		Output: 3
# Input: [2,2,1,1,1,2,2] 		Output: 2
def majority_element(nums)
    major = nums.length/2
    h = {}

    nums.each do |i|
        h[i] = h[i].nil? ? 1 : h[i] + 1
        return i if h[i] > major
    end
    nil
end

# 229. Majority Element II
# Given an integer array of size n, find all elements that appear more than ⌊ n/3 ⌋ times
# Input: [3,2,3] 			Output: [3]
# Input: [1,1,1,3,3,2,2,2] 	Output: [1,2]
# https://leetcode.com/problems/majority-element-ii/discuss/63537/My-understanding-of-Boyer-Moore-Majority-Vote
def majority_element(nums)
    h = Hash.new(0)
    solution = []
    nums.each do |num|
        h[num] += 1
    end
    
    h.each do |k,v|
        if v > (nums.size/3)
            solution << k
        end
    end
    solution
end
#--------------------------------------------------------------------------------------------
# 575. Distribute Candies
# Given an integer array with even length, where different numbers in this array represent different kinds of candies. Each number means one candy of the corresponding kind. You need to distribute these candies equally in number to brother and sister. Return the maximum number of kinds of candies the sister could gain.
# Input: candies = [1,1,2,2,3,3] 		Output: 3
# Explanation:There are three different kinds of candies (1, 2 and 3), and two candies for each kind.
# Optimal distribution: The sister has candies [1,2,3] and the brother has candies [1,2,3], too. 
# The sister has three different kinds of candies. 
# Input: candies = [1,1,2,3] 		Output: 2
# Explanation: For example, the sister has candies [2,3] and the brother has candies [1,1].
def distribute_candies(candies)
   [candies.uniq.size, candies.size / 2].min
end

# 1103. Distribute Candies to People
# We distribute some number of candies, to a row of n = num_people people in the following way:
# We then give 1 candy to the first person, 2 candies to the second person, and so on until we give n candies to the last person.
# Then, we go back to the start of the row, giving n + 1 candies to the first person, n + 2 candies to the second person, and so on until we give 2 * n candies to the last person.
# This process repeats (with us giving one more candy each time, and moving to the start of the row after we reach the end) until we run out of candies.  The last person will receive all of our remaining candies (not necessarily one more than the previous gift).
# Return an array (of length num_people and sum candies) that represents the final distribution of candies.
# Input: candies = 7, num_people = 4 		Output: [1,2,3,1]
# Explanation:
# On the first turn, ans[0] += 1, and the array is [1,0,0,0].
# On the second turn, ans[1] += 2, and the array is [1,2,0,0].
# On the third turn, ans[2] += 3, and the array is [1,2,3,0].
# On the fourth turn, ans[3] += 1 (because there is only one candy left), and the final array is [1,2,3,1].
def distribute_candies(candies, num_people)
    people = Array.new(num_people, 0)
    give = 0
    
    while candies > 0
        people[give % num_people] += [candies, give += 1].min
        candies -= give
    end
    people
end
#--------------------------------------------------------------------------------------------
# 134. Gas Station
# There are N gas stations along a circular route, where the amount of gas at station i is gas[i].
# You have a car with an unlimited gas tank and it costs cost[i] of gas to travel from station i to its next station (i+1). You begin the journey with an empty tank at one of the gas stations.
# Return the starting gas station's index if you can travel around the circuit once in the clockwise direction, otherwise return -1.
# Note:If there exists a solution, it is guaranteed to be unique.
# Both input arrays are non-empty and have the same length.
# Each element in the input arrays is a non-negative integer.
# gas  = [1,2,3,4,5]  cost = [3,4,5,1,2]  Output: 3
# Explanation:Start at station 3 (index 3) and fill up with 4 unit of gas. Your tank = 0 + 4 = 4
# Travel to station 4. Your tank = 4 - 1 + 5 = 8
# Travel to station 0. Your tank = 8 - 2 + 1 = 7
# Travel to station 1. Your tank = 7 - 3 + 2 = 6
# Travel to station 2. Your tank = 6 - 4 + 3 = 5
# Travel to station 3. The cost is 5. Your gas is just enough to travel back to station 3.
# Therefore, return 3 as the starting index.
# gas  = [2,3,4]  cost = [3,4,3]      Output: -1
def can_complete_circuit(gas, cost)
    sum, total, start = 0, 0, 0
    
    for i in (0...gas.size)
        sum += gas[i] - cost[i]
        total += gas[i] - cost[i]
        if sum < 0
            sum = 0
            start = i + 1
        end
    end
    
    total >= 0 ? start : -1
end
#--------------------------------------------------------------------------------------------
# 152. Maximum Product Subarray
# Given an integer array nums, find the contiguous subarray within an array (containing at least one number) which has the largest product.
# Input: [2,3,-2,4]   Output: 6
# Explanation: [2,3] has the largest product 6.
# Input: [-2,0,-1]    Output: 0
# Explanation: The result cannot be 2, because [-2,-1] is not a subarray.
def max_product(nums)
    min = max = 1
    max_product = nums[0]
    nums.each do |num|
        min, max = [num, min * num, max * num].minmax
        max_product = [max, max_product].max
    end
    max_product
end
#--------------------------------------------------------------------------------------------
# 673. Number of Longest Increasing Subsequence
# Given an unsorted array of integers, find the number of longest increasing subsequence.
# Input: [1,3,5,4,7]      Output: 2
# Explanation: The two longest increasing subsequence are [1, 3, 4, 7] and [1, 3, 5, 7].
# Input: [2,2,2,2,2]      Output: 5
def find_number_of_lis(nums)
    return 0 if nums.empty?
    lengths = Array.new(nums.size, 1)
    counts = Array.new(nums.size, 1)

    for i in 1...nums.size
        for j in 0...i
            if nums[i] > nums[j]
                if lengths[j] + 1 == lengths[i]
                    counts[i] += counts[j]
                elsif lengths[j] + 1 > lengths[i]
                    counts[i] = counts[j]
                    lengths[i] = lengths[j] + 1
                end
            end
        end
    end

     max_length = lengths.max
     result = 0
    
     counts.each_with_index do |count, i|
        result += count if lengths[i] == max_length
    end
    result
end
#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------
To Do
https://www.geeksforgeeks.org/assign-mice-holes/
https://www.interviewbit.com/problems/seats/
#--------------------------------------------------------------------------------------------


https://practice.geeksforgeeks.org/problems/assign-mice-holes/0