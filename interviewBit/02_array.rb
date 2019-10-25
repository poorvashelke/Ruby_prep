# Flipping an Image
# Input: [[1,1,0],[1,0,1],[0,0,0]]
# Output: [[1,0,0],[0,1,0],[1,1,1]]
# Explanation: First reverse each row: [[0,1,1],[1,0,1],[0,0,0]].
# Then, invert the image: [[1,0,0],[0,1,0],[1,1,1]]

# @param {Integer[][]} a
# @return {Integer[][]}
def flip_and_invert_image(a)
    fliped = []
    a.each do |ele|
        temp = ele.reverse
        temp.map!{|ele| ele.zero? ? 1 : 0}
        fliped << temp
    end  
    fliped
end
#-----------------------------------------------------------------------------------
# Sort Array By Parity
# return an array consisting of all the even elements of A, followed by all the odd elements of A
# Input: [3,1,2,4]
# Output: [2,4,3,1]
# The outputs [4,2,3,1], [2,4,1,3], and [4,2,1,3] would also be accepted.

def sort_array_by_parity(a)
    result = []
    a.each do |ele|
        if ele.even?
            result.unshift(ele)
        else
            result << ele
        end
    end
    result
end
#-------------------------------------------------------------------------------------
# Min Steps in Infinite Grid
# Given two integer arrays A and B, where A[i] is x coordinate and B[i] is y coordinate of ith point respectively.
# Output : Return an Integer, i.e minimum number of steps.
# Input : [(0, 0), (1, 1), (1, 2)]      Output : 2

	def coverPoints(a, b)
        x, y = 0, 0
        distance = 0
        (1...a.length).each do |i|
            x = (a[i] - a[i -1]).abs
            y = (b[i] - b[i -1]).abs
            distance += [x, y].min
        end
        distance
    end
#-------------------------------------------------------------------------------------
# Height Checker
# Input: [1,1,4,2,1,3]      Output: 3
# Students with heights 4, 3 and the last 1 are not standing in the right positions

def height_checker(heights)
    sorted = heights.sort
    count = 0
    (0...heights.length).each do |i|
        count += 1 if heights[i] != sorted[i]
    end   
    count
end
#-------------------------------------------------------------------------------------
# Max Sum Contiguous Subarray
# Given the array [-2,1,-3,4,-1,2,1,-5,4],
# the contiguous subarray [4,-1,2,1] has the largest sum = 6.
def maxSubArray(a)
    return nil if a.empty?
    curr_sum = a[0]
    max_sum = a[0]
    (1...a.length).each do |i|    
        if curr_sum <= 0
            curr_sum = a[i]
        else
            curr_sum += a[i]
        end
        max_sum = curr_sum if max_sum < curr_sum
    end
    max_sum
end
#-------------------------------------------------------------------------------------
# Maximum Absolute Difference
# You are given an array of N integers, A1, A2 ,…, AN. Return maximum value of f(i, j) for all 1 ≤ i, j ≤ N.
# f(i, j) is defined as |A[i] - A[j]| + |i - j|, where |x| denotes absolute value of x.
# For example, A=[1, 3, -1]
# f(1, 1) = f(2, 2) = f(3, 3) = 0
# f(1, 2) = f(2, 1) = |1 - 3| + |1 - 2| = 3
# f(1, 3) = f(3, 1) = |1 - (-1)| + |1 - 3| = 4
# f(2, 3) = f(3, 2) = |3 - (-1)| + |2 - 3| = 5
# So, we return 5.
def maxArr(a)
    temp = []
    (0...a.length).each do |i|
        (i...a.length).each do |j|
            dist = (a[i] - a[j]).abs + (i - j).abs
            temp << dist
        end
    end
    temp.max
end
#-------------------------------------------------------------------------------------
# Repeat and Missing Number Array
# Input:[3 1 2 5 3 7] 
# Output:[3, 4, 6] 
def repeatedNumber(a)
    new_arr = Array.new(a.length, false)
    result = []
    (0...a.length).each do |i|
        result << a[i] if new_arr[a[i] - 1] == true 
        new_arr[a[i] - 1] = true 
    end
    false_idx = new_arr.index(false)
    (false_idx...a.size).each do |i|
       result << i+1 if new_arr[i] == false
    end
    result
end
#-------------------------------------------------------------------------------------
# 66. Plus One
# Input: [4,3,2,1]
# Output: [4,3,2,2]
def plus_one(a)
    return nil if a.empty?
        i = a.length - 1
        while i >= 0
            if a[i] < 9 
               a[i] = a[i] + 1 
               return a
            else
            # case 199, 49
                a[i] = 0
                i -= 1
            end
        end
    # for case 999
    result = Array.new(a.length, 0)
    result.unshift(1)
end
#-------------------------------------------------------------------------------------
# Find All Duplicates in an Array
# Input: [4,3,2,7,8,2,3,1]
# Output: [2,3]
def find_duplicates(nums)
    res = []
    i = 0
    while i < nums.length
        idx = (nums[i]).abs - 1
        res << idx+1 if idx >= 0 && nums[idx] < 0
        nums[idx] = -nums[idx]
        i += 1
    end
    res
end
#__________________________________________________________________________________
  def subsets(array)
    return [[]] if array.length == 0
    last = array.pop
    prev_subs = subsets(array)
    prev_subs + prev_subs.map {|el| el + [last]}
  end
#-------------------------------------------------------------------------------------
# Pascal Triangle
# Given numRows = 5,
# Return
# [
#      [1],
#      [1,1],
#      [1,2,1],
#      [1,3,3,1],
#      [1,4,6,4,1]
# ]
def solve(a)
    return [[1]] if a == 1
    prev = solve(a - 1)
    last = prev.last
    new_row = [1]
    (0..last.length - 2).each do |i|
        new_row << last[i] + last[i + 1]
    end
    new_row << 1
    prev << new_row
end
#-------------------------------------------------------------------------------------
# Maximum Absolute Difference
# You are given an array of N integers, A1, A2 ,…, AN. Return maximum value of f(i, j) for all 1 ≤ i, j ≤ N.
# f(i, j) is defined as |A[i] - A[j]| + |i - j|, where |x| denotes absolute value of x
# A=[1, 3, -1]
# f(1, 1) = f(2, 2) = f(3, 3) = 0
# f(1, 2) = f(2, 1) = |1 - 3| + |1 - 2| = 3
# f(1, 3) = f(3, 1) = |1 - (-1)| + |1 - 3| = 4
# f(2, 3) = f(3, 2) = |3 - (-1)| + |2 - 3| = 5
# So, we return 5.
def maxArr(a)
    temp = []
    (0...a.length).each do |i|
        (i...a.length).each do |j|
            dist = (a[i] - a[j]).abs + (i - j).abs
            temp << dist
        end
    end
    temp.max
end
#-------------------------------------------------------------------------------------
#Max Non Negative SubArray
# A : [1, 2, 5, -7, 2, 3]
# The two sub-arrays are [1, 2, 5] [2, 3].
# The answer is [1, 2, 5] as its sum is larger than [2, 3]
def maxset(a)
    maximum = [-1]
    (0...a.length).each do |i|
       a[i] > 0 ? maximum.push(maximum[i] + a[i]) : maximum.push(-1)
    end
    max_num = maximum.max 
    index = maximum.index(max_num)
    result = []
    while maximum[index] != -1
        result.unshift(a[index - 1])
        index -= 1
    end
    result.length == 0 ? nil : result
end
    # def zeros(a)
    #   max_here = 0
    #   max_sofar = 0
    #   a.each do |ele|
    #       max_here = max_here + ele
    #       max_here = 0 if max_here < 0
    #       max_sofar = max_here if max_here > max_sofar
    #     end
    #     max_sofar
    # end
#-------------------------------------------------------------------------------------
# Spiral Matrix
# Input:
# [
#  [ 1, 2, 3 ],
#  [ 4, 5, 6 ],
#  [ 7, 8, 9 ]
# ]
# Output: [1,2,3,6,9,8,7,4,5]
def spiral_order(a)
    return [] if a.empty?
    res = []
    left, top = 0, 0
    bottom, right = a.length - 1, a[0].length - 1

    while left <= right && top <= bottom
        for i in (left..right)
            res << a[top][i]
        end
        top += 1
        for i in (top..bottom)
            res << a[i][right]
        end
        right -= 1
        if top <= bottom
            # decreament for loop
            for i in (right).downto(left)
                res << a[bottom][i] 
            end
            bottom -= 1
        end
        if left <= right
            for i in (bottom).downto(top)
                res << a[i][left]
            end
            left += 1
        end
    end
    res
end
#-------------------------------------------------------------------------------------
# Spiral Matrix II
# Input: 3
# Output:
# [
#  [ 1, 2, 3 ],
#  [ 8, 9, 4 ],
#  [ 7, 6, 5 ]
def generate_matrix(n)
    return [] if n == 0
    res = Array.new(n){Array.new(n, 0)}
    num = 1
    left, top = 0, 0
    bottom, right = n - 1, n -1

    while left <= right && top <= bottom
        for i in (left..right)
            res[top][i] = num
            num += 1
        end
        top += 1
        for i in (top..bottom)
            res[i][right] = num
            num += 1
        end
        right -= 1
        # decreament for loop
        for i in (right).downto(left)
            res[bottom][i] = num
            num += 1
        end
        bottom -= 1
        for i in (bottom).downto(top)
            res[i][left] = num
            num += 1
        end
        left += 1
    end
    res
end
#-------------------------------------------------------------------------------------
# Set Matrix Zeroes
# Input: 
# [
#   [1,1,1],
#   [1,0,1],
#   [1,1,1]
# ]
# Output: 
# [
#   [1,0,1],
#   [0,0,0],
#   [1,0,1]
def set_zeroes(matrix)
    row = Array.new(matrix.length, false)
    col = Array.new(matrix[0].length, false)
    
    (0...matrix.length).each do |i|
        (0...matrix[0].length).each do |j|
           if matrix[i][j] == 0
               row[i] = true
               col[j] = true
           end
        end
    end
    (0...matrix.length).each do |i|
        (0...matrix[0].length).each do |j|
           if row[i] || col[j]
               matrix[i][j] = 0
           end
        end
    end
    matrix
end
#-------------------------------------------------------------------------------------
48. Rotate Image  Rotate the image by 90 degrees (clockwise).
# You have to rotate the image in-place, which means you have to modify the input 2D matrix directly. DO NOT allocate another 2D matrix and do the rotation.
#   [1,2,3],
#   [4,5,6],
#   [7,8,9]
# rotate the input matrix in-place such that it becomes:
#   [7,4,1],
#   [8,5,2],
#   [9,6,3]

def rotate(matrix)
    size = matrix.size - 1
    (0...size/2 + 1).each do |i|
        (i...size - i).each do |j|
            temp = matrix[i][j]
            matrix[i][j] = matrix[size - j][i]
            matrix[size - j][i] = matrix[size - i][size - j]
            matrix[size - i][size - j] = matrix[j][size - i]
            matrix[j][size - i] = temp
        end
    end
end
#-------------------------------------------------------------------------------------
# Anti Diagonals || Zig-Zag
# Input : 1 2
#         3 4
#   [[1],
#   [2, 3],
#   [4]]
def diagonal(a)
        rows = a.length
        cols = a[0].length
        result = []
        i, j = 0, 0
    # traverse from right to left on col
        while j < cols
            i = 0
            result << diagonalAt(a, i, j, rows)
            j += 1
        end
    # start from 1 we don't want repeatation
        i = 1
        while i < rows
            j = cols - 1
            result << diagonalAt(a, i, j, rows)
            i += 1
        end
        result
    end
def diagonalAt(a, i, j, rows)
    result = []
    result << a[i][j]
    nextCol = j - 1
    nextRow = i + 1
    while nextCol > -1 && nextRow < rows
        result << a[nextRow][nextCol]
        nextRow += 1
        nextCol -= 1
    end
    result
end
#-------------------------------------------------------------------------------------
# v imp && HARD  refer geeksforgeeks
# https://www.geeksforgeeks.org/0-1-knapsack-problem-dp-10/
# To consider all subsets of items, there can be two cases for every item: 
# (1) the item is included in the optimal subset, (2) not included in the optimal set.
# Therefore, the maximum value that can be obtained from n items is max of following two values.
# 1) Maximum value obtained by n-1 items and W weight (excluding nth item).
# 2) Value of nth item plus maximum value obtained by n-1 items and W minus weight of the nth item (including nth item).
# If weight of nth item is greater than W, then the nth item cannot be included and case 1 is the only possibility.
def knapSack(wt, val, capacity)
    row = wt.length + 1
    col = capacity + 1
    res = Array.new(row) {Array.new(col)}
    
    for i in 0...row
        for w in 0...col
            if i == 0 || w == 0
                res[i][w] = 0
            elsif wt[i - 1] <= w
                temp = val[i - 1] + res[i - 1][w - wt[i - 1]]
                res[i][w] = [temp, res[i - 1][w]].max
            else
                res[i][w] = res[i - 1][w]
            end
        end
    end
    res[i][w]
end

val = [6, 10, 12]
wt = [1,2,3]
c = 5       op => 22
p knapSack(wt, val, c)
#-------------------------------------------------------------------------------------


#-------------------------------------------------------------------------------------


