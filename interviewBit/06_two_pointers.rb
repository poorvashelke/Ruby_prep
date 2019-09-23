# Intersection of Two Arrays II
# Given two arrays, write a function to compute their intersection.
# Input: nums1 = [1,2,2,1], nums2 = [2,2] 		Output: [2,2]
# Input: nums1 = [4,9,5], nums2 = [9,4,9,8,4] 	Output: [4,9]
# @param {Integer[]} nums1
# @param {Integer[]} nums2
# @return {Integer[]}
def intersect(nums1, nums2)
    res = []
    nums1.size >= nums2.size ? res = helper(nums1, nums2) : res = helper(nums2, nums1)
    res
end

def helper(big, small)
#ORRR  small.select {|ele| big.include?(ele)}
    res = []
    small.each do |num|
        res << num if big.include?(num)
    end
    res
end
#--------------------------------------------------------------------------------------------
# Remove Duplicates from Sorted Array
# lGiven a sorted array nums, remove the duplicates in-place such that each element appear only once and return the new length.
# Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.
# Given nums = [1,1,2], op = 2
# Given nums = [0,0,1,1,1,2,2,3,3,4] op = 5
# @param {Integer[]} nums
# @return {Integer}
def remove_duplicates(nums)
    start = 0
    (0...nums.length - 1).each do |i|
        if nums[i] != nums[i + 1]
            nums[start] = nums[i]
            start += 1
        end
    end
    nums[start] = nums[nums.length - 1]
    #nums.take(start + 1)
    start + 1
end
# Remove Duplicates from Sorted Array II
# Given nums = [1,1,1,2,2,3] => 5
# Given nums = [0,0,1,1,1,1,2,3,3] => 7
# @param {Integer[]} nums
# @return {Integer}
def remove_duplicates(nums)
    return 0 if nums.empty?
    store_index = count = 0
    (0...nums.size).each do |i|
    	nums[store_index] = nums[i] if i == 0 # for 1st ele occaring 2 times
        if nums[i] == nums[i - 1] && count < 2 #same ele and count < 2
            nums[store_index] = nums[i]
            store_index += 1
            count += 1
        elsif nums[i] != nums[i - 1] # diff ele
            nums[store_index] = nums[i]
            store_index += 1
            count = 1
        end
    end
    nums = nums.take(store_index)
    store_index
end
#--------------------------------------------------------------------------------------------
# Remove Duplicates from Sorted List
# Given a sorted linked list, delete all duplicates such that each element appear only once.
# Input: 1->1->2 				Output: 1->2
# Input: 1->1->2->3->3 		Output: 1->2->3

# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end
# @param {ListNode} head
# @return {ListNode}
def delete_duplicates(head)
    curr = head
    while curr && curr.next
        if curr.val == curr.next.val
            curr.next = curr.next.next
        else
            curr = curr.next
        end
    end
    head
end
#--------------------------------------------------------------------------------------------
# Remove Element
# Given an array nums and a value val, remove all instances of that value in-place and return the new length.
# Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.
# The order of elements can be changed.
# Given nums = [3,2,2,3], val = 3,
# Your function should return length = 2, with the first two elements of nums being 2.
# Given nums = [0,1,2,2,3,0,4,2], val = 2,
# Your function should return length = 5, nums containing 0, 1, 3, 0, and 4.
# @param {Integer[]} nums
# @param {Integer} val
# @return {Integer}
def remove_element(nums, val)
    start = 0
    nums.each do |ele|
        if ele != val
            nums[start] = ele
            start += 1
        end
    end
    nums = nums.take(start)
    start
end
#--------------------------------------------------------------------------------------------
# K-diff Pairs in an Array
# Given an array of integers and an integer k, you need to find the number of unique k-diff pairs in the array.
# Here a k-diff pair is defined as an integer pair (i, j), where i and j are both numbers in the array and their absolute difference is k.
# Input: [3, 1, 4, 1, 5], k = 2 		Output: 2
# Explanation: There are two 2-diff pairs in the array, (1, 3) and (3, 5).
# Input:[1, 2, 3, 4, 5], k = 1 		Output: 4
# Explanation: There are four 1-diff pairs in the array, (1, 2), (2, 3), (3, 4) and (4, 5).
# Input: [1, 3, 1, 5, 4], k = 0 		Output: 1
# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer}
def find_pairs(nums, k) 		
        return 0 if nums == nil || nums.empty? || k < 0
	pairs, hash = 0, Hash.new(0)
    
	nums.each { |n| hash[n] += 1 }
    
	hash.each do |key, value| 
		if k == 0 then pairs += 1 if value >= 2
		else pairs += 1 if hash.key?(key+k) end
	end
	pairs
 end
#--------------------------------------------------------------------------------------------
# Sort Colors
# Given an array with n objects colored red, white or blue, sort them in-place so that objects of the
#  same color are adjacent, with the colors in the order red, white and blue.
# Here, we will use the integers 0, 1, and 2 to represent the color red, white, and blue respectively.
# Input: [2,0,2,1,1,0] 		Output: [0,0,1,1,2,2]
# @param {Integer[]} nums
# @return {Void} Do not return anything, modify nums in-place instead.
def sort_colors(nums)
    low = mid = 0
    high = nums.size - 1
    while mid <= high
        case nums[mid]
            when 0 then
                nums[low], nums[mid] = nums[mid], nums[low]
                mid += 1
                low += 1
            when 1
                mid += 1
            when 2
                nums[high], nums[mid] = nums[mid], nums[high]
                high -= 1
        end
    end
    nums
end
#--------------------------------------------------------------------------------------------
# 3 sum
# Given an array and a value, find if there is a triplet in array whose sum is equal to the given value.
# If there is such a triplet present in array, then print the triplet and return true. Else return false.
def three_sum(nums, val)
    res = []
    (0...nums.size - 2).each do |i|
        curr_sum = val - nums[i]
        (i + 1...nums.size).each do |j|
            if nums.include?(curr_sum - nums[j])
                temp = [nums[i], nums[j], curr_sum - nums[j]].sort
                res << temp if !res.include?(temp)
            end
        end
    end
    res
end
p three_sum([1,4,6,10,8], 22)  op= [[4, 8, 10], [6, 6, 10], [6, 8, 8]]
#--------------------------------------------------------------------------------------------
# 3 sum zero
# Given an array of distinct elements. The task is to find triplets in array whose sum is zero.
# Input : arr[] = {0, -1, 2, -3, 1}
# Output : 0 -1 1
#          2 -3 1
def sum_zero(nums)
    res = []
    (0...nums.size - 2).each do |i|
        (i + 1...nums.size).each do |j|
            third = nums[i] - nums[j]
            if nums.include?(third) && nums[i] - nums[j] - third == 0
                temp = [nums[i], nums[j], third].sort
                res << temp if !res.include?(temp)
            end
        end
    end
    res
end

p sum_zero([1,2,4,3,6,10,5])  => [[1, 3, 4], [1, 5, 6]]
#--------------------------------------------------------------------------------------------
# Max Consecutive Ones
# Given a binary array, find the maximum number of consecutive 1s in this array.
# Input: [1,1,0,1,1,1] 		Output: 3
# @param {Integer[]} nums
# @return {Integer}
def find_max_consecutive_ones(nums)
    max_count = count = 0
    nums.each do |val|
        if val == 1
            count += 1
        else
            count = 0
        end
        max_count = count if max_count < count
    end
    max_count
end
#--------------------------------------------------------------------------------------------
# Container With Most Water
# Given n non-negative integers a1, a2, ..., an , where each represents a point at coordinate (i, ai). 
# n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0). Find two lines, 
# which together with x-axis forms a container, such that the container contains the most water.
# Note: You may not slant the container and n is at least 2.

def max_area(height)
    first = 0
    last = height.size - 1
    max = 0
  
    while first < last
        # how far apart the first and last are
        diff = last - first
        # the lowest height
        lowest = [height[first], height[last]].min
        # the current area
        current = lowest * diff

        max = [max, current].max
        # whichever side is smaller, we move closer together
        height[first] == lowest ? first += 1 : last -= 1
    end
  
    max
end 
#--------------------------------------------------------------------------------------------
# Find three closest elements from given three sorted arrays
# Given three sorted arrays A[], B[] and C[], find 3 elements i, j and k from A, B and C respectively such that
# max(abs(A[i] – B[j]), abs(B[j] – C[k]), abs(C[k] – A[i])) is minimized. Here abs() indicates absolute value.
# Input: A[] = {1, 4, 10}
#        B[] = {2, 15, 20}
#        C[] = {10, 12}
# Output: 10 15 10 			10 from A, 15 from B and 10 from C
# Input: A[] = {20, 24, 100}
#        B[] = {2, 19, 22, 79, 800}
#        C[] = {10, 12, 23, 24, 119}
# Output: 24 22 23			24 from A, 22 from B and 23 from C
def find_close(a, b, c)
    diff = 20000
    res_i = res_j = res_k = 0
    i = j = k = 0
    while i < a.size && j < b.size && k < c.size
        minimum = [a[i], b[j], c[k]].min
        maximum = [a[i], b[j], c[k]].max
    #Update result if current diff is  less than the min diff so far
        if maximum - minimum < diff
            res_i = a[i]
            res_j = b[j]
            res_k = c[k]
            diff = maximum - minimum
        end
    #We can't get less than 0  as values are absolute
        break if diff == 0
    #Increment index of array with smallest value
        if a[i] == minimum
            i += 1
        elsif b[j] == minimum
            j += 1
        else
            k += 1
        end
    end
    [ res_i, res_j, res_k ]
end
#--------------------------------------------------------------------------------------------
# MinimizeAbsoluteDifference
class Solution
    # @param a : array of integers
    # @param b : array of integers
    # @param c : array of integers
    # @return an integer
    def solve(a, b, c)
        maximum = Float::INFINITY
        x = a.size
        y = b.size
        z = c.size
        res_i = res_j = res_k = 0;
        i = j = k = 0;
        while(i < x && j < y && k < z) do
            min = [a[i],b[j],c[k]].min
            max = [a[i],b[j],c[k]].max
            
            if (max - min).abs < maximum
                maximum = max - min
                #If we also want to find the elements
                res_i = i
                res_j = j
                res_k = k
            end
            # break if maximum == 0 
            if a[i] == min 
                i += 1
            elsif b[j] == min
                j += 1
            else
                k += 1
            end
        end
        maximum
            
    end
end

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------
