def subsets(array)
    return [[]] if array.length == 0
    last = array.pop
    prev_subs = subsets(array)
    prev_subs + prev_subs.map {|el| el + [last]}
end
#--------------------------------------------------------------------------------------------
# Combinations
# Given two integers n and k, return all possible combinations of k numbers out of 1 ... n.
# Input: n = 4, k = 2
# Output:
#   [2,4],
#   [3,4],
#   [2,3],
#   [1,2],
#   [1,3],
#   [1,4],
# @param {Integer} n
# @param {Integer} k
# @return {Integer[][]}
def combine(n, k)
    all_combi = combinations((1..n).to_a)
    res = all_combi.select! {|ele| ele.size == k}
    res
end

def combinations(arr)
    return [[]] if arr.size == 0
    last = arr.pop()
    prev = combinations(arr)
    prev + prev.map {|ele| ele + [last]}
end
#--------------------------------------------------------------------------------------------
# Generate Parentheses
# Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.
# For example, given n = 3, a solution set is:
#   "((()))",
#   "(()())",
#   "(())()",
#   "()(())",
#   "()()()"
# @param {Integer} n
# @return {String[]}
RES = []
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
# Gray Code
# The gray code is a binary numeral system where two successive values differ in only one bit.
# Given a non-negative integer n representing the total number of bits in the code, print the sequence of gray code. A gray code sequence must begin with 0.
# Input: 2
# Output: [0,1,3,2]
# Explanation:
# 00 - 0
# 01 - 1
# 11 - 3
# 10 - 2
# @param {Integer} n
# @return {Integer[]}
def gray_code(n)
    r1 = ["0"]
    res = ["0", "1"]
    return [r1[0].to_i] if n == 0
    return [0, 1] if n == 1
    
    while n > 1
        r1 = res[0..-1].reverse
        (0...res.size).each do |i|
            res[i] = "0" + res[i]
        end
        (0...r1.size).each do |i|
            r1[i] = "1" + r1[i]
            res << r1[i]
        end
        n -= 1
    end
    
    (0...res.size).each do |i|
        res[i] = Integer(res[i], 2)  #convert binary to int
    end
    res
end
#--------------------------------------------------------------------------------------------
# Combination Sum
# Given a set of candidate numbers (candidates) (without duplicates) and a target number (target), find all unique combinations in candidates where the candidate numbers sums to target.
# The same repeated number may be chosen from candidates unlimited number of times.
# All numbers (including target) will be positive integers.
# The solution set must not contain duplicate combinations.
# Input: candidates = [2,3,6,7], target = 7,
#   [7],
#   [2,2,3]
# Input: candidates = [2,3,5], target = 8,
#   [2,2,2,2],
#   [2,3,3],
#   [3,5]
# @param {Integer[]} candidates
# @param {Integer} target
# @return {Integer[][]}
RES = []
def combination_sum(candidates, target)
    candidates = candidates.sort
    dfs_helper(candidates, target, 0, [])
end

def dfs_helper(nums, target, index, path)
    return if target < 0
    if target == 0
        RES << path
        return
    end
    (index...nums.size).each do |i|
        break if nums[i] > target
        dfs_helper(nums, target - nums[i], i, path + [nums[i]])
    end
    RES
end
#--------------------------------------------------------------------------------------------
# Combination Sum II
# Given a collection of candidate numbers (candidates) and a target number (target), find all unique combinations in candidates where the candidate numbers sums to target.
# Each number in candidates may only be used once in the combination.
# Note:All numbers (including target) will be positive integers. The solution set must not contain duplicate combinations.
# Input: candidates = [10,1,2,7,6,1,5], target = 8,
#   [1, 7], [1, 2, 5], [2, 6], [1, 1, 6]
# Input: candidates = [2,5,2,1,2], target = 5,
#   [1,2,2], [5]
# @param {Integer[]} candidates
# @param {Integer} target
# @return {Integer[][]}
RES = []
def combination_sum2(candidates, target)
    candidates = candidates.sort
    helper(candidates, target, 0, 0, [])
end

def helper(nums, target, start, sum, arr)
    return if start >= nums.size
    (start...nums.size).each do |i|
       if i > start && nums[i] == nums[i - 1]
           next
       end
        if sum + nums[i] == target
            arr << nums[i]
            RES << arr
        else
            helper(nums, target, i + 1, sum + nums[i], arr + [nums[i]])
        end
    end
    RES
end
#--------------------------------------------------------------------------------------------
# Valid Sudoku
# Determine if a 9x9 Sudoku board is valid. Only the filled cells need to be validated according to the following rules:
# Each row must contain the digits 1-9 without repetition.
# Each column must contain the digits 1-9 without repetition.
# Each of the 9 3x3 sub-boxes of the grid must contain the digits 1-9 without repetition.
https://leetcode.com/problems/valid-sudoku/discuss/316148/99.82-time-83-space.-Python-solution-using-three-lists.
# @param {Character[][]} board
# @return {Boolean}
# @param {Character[][]} board
# @return {Boolean}
def is_valid_sudoku(board)
    rows = Array.new(9){Array.new(9, false)}
    cols = Array.new(9){Array.new(9, false)}
    grids = Array.new(9){Array.new(9, false)}
    for row in (0...9)
       for col in (0...9)
           next if board[row][col] == '.' 
           value = board[row][col].to_i - 1
           curr_grid = col / 3 + (row / 3) * 3
           return false if rows[row][value] || cols[col][value] || grids[curr_grid][value]
           rows[row][value] = cols[col][value] = grids[curr_grid][value] = true
       end
    end
    true
end
#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------
# Kth Permutation Sequence
# The set [1,2,3,…,n] contains a total of n! unique permutations.
# By listing and labeling all of the permutations in order,We get the following sequence (ie, for n = 3 ) :
# 1. "123"
# 2. "132"
# 3. "213"
# 4. "231"
# 5. "312"
# 6. "321"
# Given n and k, return the kth permutation sequence.
# For example, given n = 3, k = 4, ans = "231"

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------
def permutations(array)
    return [array] if array.length <= 1


    # Similar to the subsets problem, we observe that to get the permutations
    # of [1, 2, 3] we can look at the permutations of [1, 2] which are
    # [1, 2] and [2, 1] and add the last element to every possible index getting
    # [3, 1, 2], [1, 3, 2], [1, 2, 3], [3, 2, 1], [2, 3, 1], [2, 1, 3]

    # pop off the last element
    first = array.shift
    # make the recursive call
    perms = permutations(array)
    # we will need an array to store all our different permutations
    total_permutations = []


    # Now we iterate over the result of our recusive call say [[1, 2], [2, 1]]
    # and for each permutation add first into every index. This new subarray
    # gets added to total_permutations.
    perms.each do |perm|
      (0..perm.length).to_a.each do |i|
        total_permutations << perm[0...i] + [first] + perm[i..-1]
      end
    end
    total_permutations
  end
 #___________________________________________________________________________________
  # Write a recursive method that generates the number of possible unique ways to
  # place eight queens on a chess board such that no two queens are in
  # the row, column, or diagonal. A skeleton for a possible solution is 
  # provided. Feel free to create your own solution from scratch.
  #  8-queens = n-queens
  class EightQueens
    attr_accessor :rows, :diags1, :diags2

    def initialize
      @rows = Array.new(8, false)
      @diags1 = Array.new(14, false)
      @diags2 = Array.new(14, false)
    end

    def backtrack(row = 0, count = 0)
      (0...8).each do |col|
        if is_not_under_attack(row, col)
          place_queen(row, col)
          if row + 1 == 8
            count += 1
          else 
            count = backtrack(row + 1, count)
          end
          remove_queen(row, col)
        end
      end 
      count
    end

    def is_not_under_attack(row, col)
      return !(rows[col] || diags1[row - col] || diags2[row + col])
    end

    def place_queen(row, col)
      rows[col] = true
      diags1[row - col] = true
      diags2[row + col] = true
    end

    def remove_queen(row, col)
      rows[col] = false
      diags1[row - col] = false
      diags2[row + col] = false 
    end
  end

#--------------------------------------------------------------------------------------------