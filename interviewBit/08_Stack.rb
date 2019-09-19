#--------------------------------------------------------------------------------------------
# Generate Parentheses
# Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.
# given n = 3, a solution set is: ["((()))","(()())","(())()","()(())","()()()"]
# @param {Integer} n
# @return {String[]}
RES = []   # constant
def generate_parenthesis(n)
    helper("", n, n, n)
    RES
end
def helper(str, left, right, size)
    helper(str + '(', left - 1, right, size) if left > 0
    helper( str + ')', left, right - 1, size) if right > left
    RES << str if str.size == size * 2
end
#--------------------------------------------------------------------------------------------
# Valid Parentheses
# Input: "()" 	Output: true
# Input: "()[]{}" Output: true
# Input: "(]" 	Output: false
# @param {String} s
# @return {Boolean}
def is_valid(s)
    stack = []
    s.each_char do |char|
        if char == '(' 
          stack.push(')') 
        elsif char == '{' 
           stack.push('}') 
        elsif char == '['
           stack.push(']') 
        elsif (stack.empty? || stack.pop() != char)
           return false
        end
    end
    stack.empty?
end
#--------------------------------------------------------------------------------------------
# Simplify Path
# Given an absolute path for a file (Unix-style), simplify it. Or in other words, convert it to the canonical path.
# Note that the returned canonical path must always begin with a slash /, and there must be only a single slash / 
# between two directory names. The last directory name (if it exists) must not end with a trailing 
# Input: "/home/" 					Output: "/home"
# Input: "/../" 						Output: "/"
# Input: "/home//foo/" 				Output: "/home/foo"
# Input: "/a/./b/../../c/" 			Output: "/c"
# Input: "/a/../../b/../c//.//" 		Output: "/c"
# Input: "/a//b////c/d//././/.." 		Output: "/a/b/c"
# @param {String} path
# @return {String}
def simplify_path(path)
    stack = []
    path.split("/").each do |ele|
       if ele == ".."
           stack.pop() if !stack.empty?
       elsif ele == "." || ele == ""
           next
       else
           stack.push(ele)
       end
    end
    result = ""
    while !stack.empty?  # last should be at the start
        result = "/" + stack.pop + result
    end
    result.size == 0 ? "/" : result
end
#--------------------------------------------------------------------------------------------
# Find the nearest smaller numbers on left side in an array
# Given an array of integers, find the nearest smaller number for every element such that the smaller element is on left side.
# Input: arr[] = {1, 6, 4, 10, 2, 5} 	Output:   {-1, 1, 1,  4, 1, 2}
# Input: arr[] = {1, 3, 0, 2, 5} 		Output:  {-1, 1, -1, 0, 2}
def small_nearest(nums)
    res = [-1]
    (1...nums.size).each do |i|
        j = i - 1
        while j >= 0
            if nums[j] < nums[i]
                res << nums[j]
                break
            end
            j -= 1
        end
        res << -1 if j < 0
    end
    res
end
p small_nearest([1,6,4,10,2,5])  => [-1, 1, 1, 4, 1, 2]
#--------------------------------------------------------------------------------------------
# Expression contains redundant bracket or not
# Given a string of balanced expression, find if it contains a redundant parenthesis or not. A set of parenthesis are redundant if same sub-expression is surrounded by unnecessary or multiple brackets. Print ‘Yes’ if redundant else ‘No’.
# Note: Expression may contain ‘+‘, ‘*‘, ‘–‘ and ‘/‘ operators. Given expression is valid and there are no white spaces present. /
# Input: ((a+b))  (a+(b)/c)  (a+b*(c-d))
# Output: Yes , Yes, No
def valid(str)
    stack = []
    str = str.split("")
    str.each do |char|
    # if current character is close parenthesis ')'  
        if char == ')'
            top = stack.last
            stack.pop()
    # If immediate pop have open parenthesis '(' duplicate brackets found  
            flag = true
            while top != '('
        # Check for operators in expression
                if top == '+' || top == '-' || top == '*' || top == '/'
                    flag = false
                end
                top = stack.last
                stack.pop()
            end
        # if operation not found
            if flag == true
                return true
            else
                stack.push(char)
            end
        end
    end
    false
end
#-------------------------------------------------------------------------------------------
# 42 Trapping Rain Water
# Input: [0,1,0,2,1,0,1,3,2,1,2,1] 	Output: 6
# look up at leetcode img to understand it better
# @param {Integer[]} height
# @return {Integer}
def trap(height)
    left_max = []
    right_max = []
    max_water = 0
    temp_left_max = temp_right_max = 0
    height.each.with_index do |ele, i|
        temp_left_max = [temp_left_max, ele].max
        left_max[i] = temp_left_max
    end
    for i in (height.size - 1).downto(0)
        temp_right_max = [temp_right_max, height[i]].max
        right_max[i] = temp_right_max
    end
    
    for i in (1...height.size - 1)
        max_water += [left_max[i], right_max[i]].min - height[i]
    end
    max_water
end
#--------------------------------------------------------------------------------------------
# Sliding Window Maximum
# Given an array nums, there is a sliding window of size k which is moving from the very left of the array to the very right. 
# You can only see the k numbers in the window. Each time the sliding window moves right by one position. Return the max sliding window.
# Input: nums = [1,3,-1,-3,5,3,6,7], and k = 3 		Output: [3,3,5,5,6,7] 
# Explanation: 
# Window position                Max
# ---------------               -----
# [1  3  -1] -3  5  3  6  7       3
#  1 [3  -1  -3] 5  3  6  7       3
#  1  3 [-1  -3  5] 3  6  7       5
#  1  3  -1 [-3  5  3] 6  7       5
#  1  3  -1  -3 [5  3  6] 7       6
#  1  3  -1  -3  5 [3  6  7]      7
# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer[]}
def max_sliding_window(nums, k)
    return [] if nums.empty? || k == 0
    max_result = []
    for i in (0..nums.size - k)
        max_num = nums[i...i + k].max
        max_result << max_num
    end
    max_result
end
#-------------------------------------------------------------------------------------------
# Largest Rectangle in Histogram
# Given n non-negative integers representing the histograms bar height where the width of each bar is 1, find the area of largest rectangle in the histogram.
# Input: [2,1,5,6,2,3] 	Output: 10
# @param {Integer[]} heights
# @return {Integer}
def largest_rectangle_area(heights)
    helper(heights, 0, heights.size)
end

def helper(heights, start, ending)
    #return 0 if start < 0 || start > ending || ending > heights.size
    return heights if heights.size < 2
    # find point where index and height is min
    h_min = heights[start]
    i_min = start
    for i in (start + 1...ending)
       if h_min > heights[i]
           h_min = heights[i]
           i_min = i
       end
    end
    left = heights[start...i_min]
    right = heights[i_min + 1...ending]
    left_max = heights[start...i_min].max
    right_max = heights[i_min + 1...ending].max
    if left_max > right_max
        left.delete(left_max)
        max = left.max
        count = left.count(max)
        return max * (count + 1)
    else
        right.delete(right_max)
        max = right.max
        count = right.count(max)
        return max * (count + 1)
    end
    # left_max = helper(heights, start, i_min - 1)
    # right_max = helper(heights, i_min + 1, ending)
    # mid_max = h_min * (ending - start + 1)
    # max_result = [left_max, right_max, mid_max].max
    # max_result
end
#--------------------------------------------------------------------------------------------
# Basic Calculator II
# Implement a basic calculator to evaluate a simple expression string.
# The expression string contains only non-negative integers, +, -, *, / operators and empty spaces . The integer division should truncate toward zero.
# Input: "3+2*2"			Output: 7
# Input: " 3/2 " 			Output: 1
# Input: " 3+5 / 2 " 		Output: 5

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------
Hard
84. Largest Rectangle in Histogram
239. Sliding Window Maximum
42. Trapping Rain Water

#--------------------------------------------------------------------------------------------

