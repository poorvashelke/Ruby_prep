# Find First and Last Position of Element in Sorted Array
# Given an array of integers nums sorted in ascending order, find the starting and ending position of a given target value.
# Your algorithm's runtime complexity must be in the order of O(log n).
# If the target is not found in the array, return [-1, -1].
# Input: nums = [5,7,7,8,8,10], target = 8       Output: [3,4]
# Input: nums = [5,7,7,8,8,10], target = 6          Output: [-1,-1]
def search_range(nums, target)
    range_helper(nums, target, 0, nums.length)
end

def range_helper(nums, target, start, ending)    
    return -1, -1 if ending <= start || start < 0 || ending > nums.length 
    mid = (start + ending) / 2
    if nums[mid] == target
        i, j = mid, mid
        while i >= 0 && nums[i] == target
            i -= 1
        end
        while j < nums.length && nums[j] == target
            j += 1
        end
        return i + 1, j - 1
    elsif nums[mid] > target
        return range_helper(nums, target, start, mid)
    else
        return range_helper(nums, target, mid + 1, ending)
    end
end
#----------------------------------------------------------------------------------
#find sqrt of a number ex: 8 => 2
def my_sqrt(x)
# low should be one 
    low, high = 1, x
    ans = 0
    while low <= high
        mid = low + high / 2
        return mid if mid * mid == x
        if mid * mid > x
            high = mid - 1
        else
#Since we need floor, we update ans when mid*mid is smaller than x, and move closer to sqrt(x)
            low = mid + 1
            ans = mid
        end
    end
    ans
end
#----------------------------------------------------------------------------------
# Sorted Insert Position
# Given a sorted array and a target value, return the index if the target is found.
# If not, return the index where it would be if it were inserted in order.
# You may assume no duplicates in the array.
# [1,3,5,6], 5 → 2
# [1,3,5,6], 2 → 1
# [1,3,5,6], 7 → 4
# [1,3,5,6], 0 → 0
def search_insert(nums, target)
    helper(nums, target, 0, nums.length)
end

def helper(nums, target, low, high)
    return high if low >= high
    mid = (low + high) / 2
    return mid if target == nums[mid]
    if target < nums[mid]
        return helper(nums, target, low, mid)
    else
        return helper(nums, target, mid + 1, high)
    end   
end
#----------------------------------------------------------------------------------
# Search in Rotated Sorted Array
# Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.
# (i.e., [0,1,2,4,5,6,7] might become [4,5,6,7,0,1,2]).
# You are given a target value to search. If found in the array return its index, otherwise return -1.
# Input: nums = [4,5,6,7,0,1,2], target = 0       Output: 4
# Input: nums = [4,5,6,7,0,1,2], target = 3       Output: -1
def search(nums, target)
    helper(nums, target, 0, nums.length - 1)
end

def helper(nums, target, low, high)
    return -1 if low > high
    mid = (low + high) / 2
    return mid if nums[mid] == target
    
    if nums[low] <= nums[mid]
        if nums[low] <= target && target <= nums[mid]
            return helper(nums, target, low, mid - 1)
        end
        return helper(nums, target, mid + 1, high)
    end
    
    if nums[mid] <= target && target <= nums[high]
        return helper(nums, target, mid + 1, high)
    end
    return helper(nums, target, low, mid - 1)
end

#----------------------------------------------------------------------------------
# Implement Power Function
# Implement pow(x, n) % d.
# In other words, given x, n and d,
# find (xn % d)
# Note that remainders on division cannot be negative. 
# In other words, make sure the answer you return is non negative.
# Input : x = 2, n = 3, d = 3     Output : 2
# 2^3 % 3 = 8 % 3 = 2.
def pow(a, b, c)
    return false if c.negative?
    multi = 1
    (0...b).each do |i|
        multi = multi * a
    end
    result = multi % c
    result
end

#----------------------------------------------------------------------------------
# vv HARD PROB's
# Median of Two Sorted Arrays
# There are two sorted arrays nums1 and nums2 of size m and n respectively.
# Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).
# You may assume nums1 and nums2 cannot be both empty.
# nums1 = [1, 3]  nums2 = [2]     The median is 2.0
# nums1 = [1, 2]  nums2 = [3, 4]  The median is (2 + 3)/2 = 2.5
# @param {Integer[]} nums1
# @param {Integer[]} nums2
# @return {Float}
def find_median_sorted_arrays(nums1, nums2)
    return nums2[nums2.length / 2] * 1.0 if nums1.empty?
    return nums1[nums1.length / 2] * 1.0 if nums2.empty?
    x = nums1.length
    y = nums2.length
    low = 0
    high = x
    minInteger = -1 << 40
    maxInteger = 1 << 40
    
    while low <= high
        positionX = (low + high) / 2
        positionY = ((x + y + 1) / 2) - positionX
        
        leftX = (positionX == 0) ? minInteger : nums1[positionX - 1]
        rightX = (positionX == x) ? maxInteger : nums1[positionX]
        leftY = (positionY == 0) ? minInteger : nums2[positionY - 1]
        rightY = (positionY == y) ? maxInteger : nums2[positionY]
        p "#{positionX}:#{leftX} , #{positionY}: #{leftY} : "
        if leftX <= rightY && leftY <= rightX
            # for even , odd
            if (x + y) % 2 == 0
                return ([leftX, leftY].max + [rightX, rightY].min) / 2.0
            else
                return [leftX, leftY].max * 1.0
            end
        elsif leftX > rightY
            high = positionX - 1
        else
            low = positionX + 1
        end
    end
end
#----------------------------------------------------------------------------------

#----------------------------------------------------------------------------------
# Allocate minimum number of pages of Book
# The idea is to use Binary Search. We fix a value for the number of pages as mid of current minimum 
# and maximum. We initialize minimum and maximum as 0 and sum-of-all-pages respectively. If a current mid can be a solution, 
# then we search on the lower half, else we search in higher half.
# Now the question arises, how to check if a mid value is feasible or not? Basically, we need to check 
# if we can assign pages to all students in a way that the maximum number doesn’t exceed current value. 
# To do this, we sequentially assign pages to every student while the current number of assigned pages doesn’t exceed the value. 
# In this process, if the number of students becomes more than m, then the solution is not feasible. Else feasible.
def isPossible(arr, stds, curr_min)
    std_require, sum = 1, 0
    (0...arr.length).each do |i|
        return false if arr[i] > curr_min
        if sum + arr[i] > curr_min
            std_require += 1
            sum = arr[i]
            return false if std_require > stds
        else
            sum += arr[i]
        end
    end
    true
end
def books(a, b)
    return -1 if a.length < b
    start = 0 #initialize start as 0 pages
    total_pages = a.sum
    result = total_pages
    while start <= total_pages
        mid = (start + total_pages) / 2
        if isPossible(a, b, mid)
            result = [result, mid].min
            total_pages = mid - 1
        else
            start = mid + 1
        end
    end
    result
end
p books([12, 34, 67, 90], 2)  => 113
# There are 2 number of students. Books can be distributed 
# in following fashion : 
#   1) [12] and [34, 67, 90]
#       Max number of pages is allocated to student 
#       2 with 34 + 67 + 90 = 191 pages
#   2) [12, 34] and [67, 90]
#       Max number of pages is allocated to student
#       2 with 67 + 90 = 157 pages 
#   3) [12, 34, 67] and [90]
#       Max number of pages is allocated to student 
#       1 with 12 + 34 + 67 = 113 pages

# Of the 3 cases, Option 3 has the minimum pages = 113.
