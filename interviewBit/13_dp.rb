# 70. Climbing Stairs
# You are climbing a stair case. It takes n steps to reach to the top.
# Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
# Input: 2 	Output: 2
# Explanation: There are two ways to climb to the top.
# 1. 1 step + 1 step 		2. 2 steps
# Input: 3 	Output: 3
# Explanation: There are three ways to climb to the top.
# 1. 1 step + 1 step + 1 step 	2. 1 step + 2 steps 	3. 2 steps + 1 step
def climb_stairs(n)
    prev_count = curr_count = 1
    (n - 1).times do
        temp = curr_count
        curr_count += prev_count
        prev_count = temp
    end
    curr_count
end

# 121. Best Time to Buy and Sell Stock
# Input: [7,1,5,3,6,4] 	Output: 5
# Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
def max_profit(prices)
    sum = max = 0
    (0...prices.size - 1).each do |i|
        sum = [0, sum += prices[i + 1] - prices[i]].max
        max = [max, sum].max
    end
    max
end

# 122. Best Time to Buy and Sell Stock II
# Input: [7,1,5,3,6,4] 	Output: 7
# Explanation: Buy on day 2 (price = 1) and sell on day 3 (price = 5), profit = 5-1 = 4.
#              Then buy on day 4 (price = 3) and sell on day 5 (price = 6), profit = 6-3 = 3.
def max_profit(prices)
    total = 0
    (0...prices.size - 1).each do |i|
        total += prices[i + 1] - prices[i] if prices[i + 1] > prices[i]
    end
    total
end

# 695. Max Area of Island
# Given a non-empty 2D array grid of 0's and 1's, an island is a group of 1's (representing land) connected 4-directionally (horizontal or vertical.) You may assume all four edges of the grid are surrounded by water.
# Find the maximum area of an island in the given 2D array. (If there is no island, the maximum area is 0.)
# [[0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
#  [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
#  [0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
#  [0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0],
#  [0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0],
#  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
#  [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
#  [0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0]]Given the above grid, return 6. 
def max_area_of_island(grid)
    area = 0
    (0...grid.size).each do |i|
        (0...grid[0].size).each do |j|
            area = [area, island_area(grid, i, j)].max if grid[i][j] == 1
        end
    end
    area
end

def island_area(grid, i, j)
    if i >= 0 && j >= 0 && i < grid.size && j < grid[0].size && grid[i][j] == 1
        grid[i][j] = 0
        return 1 + island_area(grid, i - 1, j) + island_area(grid, i + 1, j) + island_area(grid, i, j - 1) + island_area(grid, i, j + 1)
    end
    return 0
end

# 91. Decode Ways
# A message containing letters from A-Z is being encoded to numbers using the following mapping:
# 'A' -> 1
# 'B' -> 2
# ...
# 'Z' -> 26
# Given a non-empty string containing only digits, determine the total number of ways to decode it.
# Input: "12" 		Output: 2
# Explanation: It could be decoded as "AB" (1 2) or "L" (12).
# Input: "226" 		Output: 3
# Explanation: It could be decoded as "BZ" (2 26), "VF" (22 6), or "BBF" (2 2 6).
def num_decodings(s)
    i1, i2 = 1
    count = 0
    (1..s.size).each do |i|
# s[i-1, 1] i- 1 is position & 1 is how many ele's you want 
        count = s[i-1,1] != '0' ? i1 : 0 # if previous was not 0 set to i1
        count += i2 if s[i - 2, 2].between?('10', '26') && i > 1
        i2 = i1
        i1 = count
    end
    count
end
#--------------------------------------------------------------------------------------------
# 322. Coin Change
# You are given coins of different denominations and a total amount of money amount. Write a function to compute the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return -1.
# Input: coins = [1, 2, 5], amount = 11	Output: 3 Explanation: 11 = 5 + 5 + 1
def coin_change(coins, amount)
    dp = Array.new(amount + 1, -1)
    dp[0] = 0
    
    coins.each do |coin|
        # puts "dp: #{dp}"
        1.upto(amount) do |i|
            next if i < coin || dp[i - coin] == -1
            dp[i] = dp[i - coin] + 1 if dp[i] == -1 || dp[i - coin] + 1 < dp[i]
            puts "\ti: #{i} dp: #{dp} dp[i - coin]: #{dp[i - coin]}"
        end
    end
    dp[amount]
end
# Another soln
def coin_change(coins, amount)
    return 0 if amount == 0
    dp = Array.new(amount + 1, Float::INFINITY) # default value to infinity
    dp[0] = 0

    coins.each do |coin|
        1.upto(amount).each do |i|
            next if i < coin
            dp[i] = [dp[i], dp[i - coin] + 1].min
        end
    end

    dp[amount] == Float::INFINITY ? -1 : dp[amount]
end

# 518. Coin Change 2
# You are given coins of different denominations and a total amount of money. Write a function to compute the number of combinations that make up that amount. You may assume that you have infinite number of each kind of coin.
# Input: amount = 5, coins = [1, 2, 5] 	Output: 4
# Explanation: there are four ways to make up the amount:
# 5=5
# 5=2+2+1
# 5=2+1+1+1
# 5=1+1+1+1+1


# 152. Maximum Product Subarray
# Given an integer array nums, find the contiguous subarray within an array (containing at least one number) which has the largest product.
# Input: [2,3,-2,4] 	Output: 6 	Explanation: [2,3] has the largest product 6.
def max_product(nums)
    min = max = 1
    max_product = nums[0]
    nums.each do |num|
        min, max = [num, min * num, max * num].minmax
        max_product = [max, max_product].max
    end
    max_product
end

# 1074. Number of Submatrices That Sum to Target
# Given a matrix, and a target, return the number of non-empty submatrices that sum to target.
# A submatrix x1, y1, x2, y2 is the set of all cells matrix[x][y] with x1 <= x <= x2 and y1 <= y <= y2.
# Two submatrices (x1, y1, x2, y2) and (x1', y1', x2', y2') are different if they have some coordinate that is different: for example, if x1 != x1'.
# Input: matrix = [[0,1,0],[1,1,1],[0,1,0]], target = 0 	Output: 4
# Explanation: The four 1x1 submatrices that only contain 0.
def num_submatrix_sum_target(matrix, target)
    row = matrix.size
    col = matrix[0].size
    (0...row).each do |i|
        (1...col).each do |j|
            matrix[i][j] += matrix[i][j - 1]
        end
    end
    res= 0
    (0...col).each do |i|
        (i...col).each do |j|
            counter = {}
            counter[0] = 1
            curr  = 0
            (0...row).each do |k|
                curr += matrix[k][j] - (i > 0 ? matrix[k][i -1] : 0)
                res += counter.fetch(curr - target, 0) #getOrDefault
                counter[curr] = counter.fetch(curr, 0) + 1
            end
        end
    end
    res
end
#--------------------------------------------------------------------------------------------
# 139. Word Break
# Given a non-empty string s and a dictionary wordDict containing a list of non-empty words, determine if s can be segmented into a space-separated sequence of one or more dictionary words.
# The same word in the dictionary may be reused multiple times in the segmentation.
# You may assume the dictionary does not contain duplicate words.
# Input: s = "leetcode", wordDict = ["leet", "code"] 			Output: true
# Input: s = "applepenapple", wordDict = ["apple", "pen"] 	Output: true
https://leetcode.com/problems/word-break/discuss/214119/Ruby
def word_break(s, word_dict)
# use 1 of 2 loops min to max || max to min to get result
    word_dict = word_dict.sort_by { |x| x.length }.reverse
    dupli_str = s.dup
# maximun to min traverse
    word_dict.each do |word|
        s.gsub!(word, "*")
    # all the words in the string will become * only if all of them are present in dict 
        return true if s.gsub("*", "").empty?
    end
# min to max traverse    
    word_dict.reverse.each do |word|
        dupli_str.gsub!(word, "*")
        return true if dupli_str.gsub("*", "").empty?
    end
    
    false
end
# recursive soln
def word_break(s, word_dict, index_end = s.length, cache = {})
    return cache[index_end] unless cache[index_end].nil?
    return true if index_end == 0

    for word in word_dict
        if s[0...index_end].end_with?(word)
            new_index = index_end - word.length
            
            if word_break(s, word_dict, new_index, cache)
                cache[index_end] = true
                return true
            end
        end
    end
    
    cache[index_end] = false 
    false
end
# 132. Palindrome Partitioning II
# Given a string s, partition s such that every substring of the partition is a palindrome.
# Return the minimum cuts needed for a palindrome partitioning of s.
# Input: "aab" 	Output: 1
# Explanation: The palindrome partitioning ["aa","b"] could be produced using 1 cut.
def min_cut(s)
    is_pali = Array.new(s.size){Array.new(s.size, false)}
    min_cuts = Array.new(s.size)
    (0...s.size).each do |i|
        min_num = Float::INFINITY # store max val
        (0..i).each do |j|
            if s[i] == s[j] && (j + 1 >= i || is_pali[j + 1][i - 1])
                is_pali[j][i] = true
                min_num = j == 0 ? 0 : [min_num, min_cuts[j - 1] + 1].min
            end
        end
        min_cuts[i] = min_num
    end
    min_cuts[s.size - 1]
end
#--------------------------------------------------------------------------------------------
#Matrix DP problems
https://www.geeksforgeeks.org/matrix-chain-multiplication-dp-8/
https://www.youtube.com/watch?v=vgLJZMUfnsU
https://www.youtube.com/watch?v=IRwVmTmN6go
# 64. Minimum Path Sum
# Given a m x n grid filled with non-negative numbers, find a path from top left to bottom right which minimizes the sum of all numbers along its path.
# Note: You can only move either down or right at any point in time.
# [ [1,3,1],
#   [1,5,1],
#   [4,2,1]] 		Output: 7
# Explanation: Because the path 1→3→1→1→1 minimizes the sum.
def min_path_sum(grid)
    row = grid.size
    col = grid.first.size
    (0...row).each do |i|
        (0...col).each do |j|
            next if i == 0 && j == 0
            row_val = (i - 1) < 0 ? grid[i][j - 1] : grid[i - 1][j]
            col_val = (j - 1) < 0 ? grid[i - 1][j] : grid[i][j - 1]
            grid[i][j] += [row_val, col_val].min
        end
    end
    grid.last.last
end

# 63. Unique Paths II
# A robot is located at the top-left corner of a m x n grid (marked 'Start' in the diagram below).
# The robot can only move either down or right at any point in time. The robot is trying to reach the bottom-right corner of the grid (marked 'Finish' in the diagram below).
# Now consider if some obstacles are added to the grids. How many unique paths would there be?
# An obstacle and empty space is marked as 1 and 0 respectively in the grid.
# Note: m and n will be at most 100.
# [[0,0,0],
#   [0,1,0],
#   [0,0,0]] 	Output: 2
# Explanation:
# There is one obstacle in the middle of the 3x3 grid above.
# There are two ways to reach the bottom-right corner:
# 1. Right -> Right -> Down -> Down
# 2. Down -> Down -> Right -> Right
def unique_paths_with_obstacles(obstacle_grid)
    row = obstacle_grid.size
    col = obstacle_grid.first.size
    result = Array.new(col + 1, 0)
    result[0] = 1 if obstacle_grid[0][0] == 0
    for i in 0...row
        for j in 0...col
            result[j] += result[j - 1]
            result[j] = 0 if obstacle_grid[i][j] == 1
        end
    end
    result[col - 1]
end


# 85. Maximal Rectangle
# Given a 2D binary matrix filled with 0's and 1's, find the largest rectangle containing only 1's and return its area.
# [ ["1","0","1","0","0"],
#   ["1","0","1","1","1"],
#   ["1","1","1","1","1"],
#   ["1","0","0","1","0"]]	Output: 6
def maximal_rectangle(matrix)
    return 0 if !matrix || matrix.length == 0 || matrix.first.length == 0
    row = matrix.size
    col = matrix.first.size
    count = Array.new(col + 1, 0)
    res = 0
    
    for i in 0...row
        
        for j in 0...col
            num = matrix[i][j].to_i
            count[j] = count[j] * num + num
        end
        
        for j in 0...col
            min_count = count[j]
            index = j
            
            while index < col && count[index] > 0
                min_count = [min_count, count[index]].min
                res = [res, min_count *(index - j + 1)].max
                index += 1
            end
        end
    end
    
    res
end
#--------------------------------------------------------------------------------------------
# DP tricky
https://www.geeksforgeeks.org/ways-color-3n-board-using-4-colors/
https://www.geeksforgeeks.org/expression-evaluation/

https://leetcode.com/problems/longest-arithmetic-sequence/submissions/

# 32. Longest Valid Parentheses
# Given a string containing just the characters '(' and ')', find the length of the longest valid (well-formed) parentheses substring.
# Input: "(()" 	Output: 2 	Explanation: The longest valid parentheses substring is "()"
# Input: ")()())" Output: 4 Explanation: The longest valid parentheses substring is "()()"
def longest_valid_parentheses(s)
    stack, max_len = [-1], 0
    
    s.size.times do |i|
        top = stack.last
        if top != -1 && s[top] == '(' && s[i] == ')'
            stack.pop
            max_len = [max_len, i - stack.last ].max
        else
            stack << i
        end
    end
    
    max_len
end

# 123. Best Time to Buy and Sell Stock III
# Say you have an array for which the ith element is the price of a given stock on day i.
# Design an algorithm to find the maximum profit. You may complete at most two transactions.
# Input: [3,3,5,0,0,3,1,4] 	Output: 6
# Explanation: Buy on day 4 (price = 0) and sell on day 6 (price = 3), profit = 3-0 = 3.
#              Then buy on day 7 (price = 1) and sell on day 8 (price = 4), profit = 4-1 = 3.
# Input: [1,2,3,4,5] 	Output: 4
def max_profit(prices)
    sell_one, sell_two = 0, 0
    buy_one, buy_two = Float::INFINITY, Float::INFINITY
    
    prices.each do |price|
        buy_one = [buy_one, price].min
        sell_one = [sell_one, price - buy_one].max
        buy_two = [buy_two, price - sell_one].min
        sell_two = [sell_two, price - buy_two].max
    end
    sell_two
end


# 1092. Shortest Common Supersequence
# Given two strings str1 and str2, return the shortest string that has both str1 and str2 as subsequences.  If multiple answers exist, you may return any of them.
# (A string S is a subsequence of string T if deleting some number of characters from T (possibly 0, and the characters are chosen anywhere from T) results in the string S.)
# Input: str1 = "abac", str2 = "cab" 		Output: "cabac"
def shortest_common_supersequence(str1, str2)
    dp = Array.new(str1.size + 1){Array.new(str2.size + 1, 0)}
# build the minimum length matrix for all sub-problems, 2D-dp means minimum length of the substring for str1's prefix of length L1 and str2's prefix of length L2
#  fill 1st row & col
    for i in 0...str2.size
        dp[0][i] = i
    end
    for i in 0...str1.size
        dp[i][0] = i
    end
    
    for i in 1..str1.size
        for j in 1..str2.size
           if str2[j - 1] == str1[i - 1]
               dp[i][j] = dp[i - 1][j - 1] + 1
           else
               dp[i][j] = [dp[i - 1][j], dp[i][j - 1]].min + 1
           end
        end
    end
    
    new_str = ""
    len_str1 = str1.size
    len_str2 = str2.size
    
    while len_str1 != 0 || len_str2 != 0
        if len_str1 == 0  && len_str2 != 0
            new_str << str2[len_str2 - 1]
            len_str2 -= 1
        end
        if len_str2 == 0 && len_str1 != 0
            new_str << str1[len_str1 - 1]
            len_str1 -= 1
        end
        
        if str1[len_str1 - 1] == str2[len_str2 - 1] && len_str1 != 0
            new_str << str1[len_str1 - 1]
            len_str1 -= 1
            len_str2 -= 1
        elsif dp[len_str1 - 1][len_str2] < dp[len_str1][len_str2 - 1] && len_str1 != 0
            new_str << str1[len_str1 - 1]
            len_str1 -= 1
        elsif len_str2 != 0
            new_str << str2[len_str2 - 1]
            len_str2 -= 1
        end
    end
    new_str
end
#--------------------------------------------------------------------------------------------
2D string DP problems
# 72. Edit Distance
# Given two words word1 and word2, find the minimum number of operations required to convert word1 to word2.
# You have the following 3 operations permitted on a word:
# Insert a character, Delete a character, Replace a character
# Input: word1 = "horse", word2 = "ros"Output: 3
# horse -> rorse (replace 'h' with 'r')
# rorse -> rose (remove 'r')
# rose -> ros (remove 'e')
def min_distance(word1, word2)
    dp = Array.new(word1.size + 1) { Array.new(word2.size + 1) }
    
    for i in 0...dp.size
       dp[i][0] = i 
    end
    for j in 0...dp[0].size
        dp[0][j] = j
    end
    
    for i in 1...dp.size
        for j in 1...dp[0].size
            if word1[i - 1] == word2[j - 1]
                dp[i][j] = dp[i-1][j-1]
            else
                dp[i][j] = [
                    dp[i - 1][j],
                    dp[i][j - 1],
                    dp[i - 1][j - 1],
                ].min + 1
            end
        end
    end
    
    dp[-1][-1]
end


# 673. Number of Longest Increasing Subsequence
# Given an unsorted array of integers, find the number of longest increasing subsequence.
# Input: [1,3,5,4,7] 		Output: 2
# Explanation: The two longest increasing subsequence are [1, 3, 4, 7] and [1, 3, 5, 7].
# Input: [2,2,2,2,2] 		Output: 5
# Explanation: The length of longest continuous increasing subsequence is 1, and there are 5 subsequences' length is 1, so output 5.
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

# 115. Distinct Subsequences
# Given a string S and a string T, count the number of distinct subsequences of S which equals T.
# A subsequence of a string is a new string which is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (ie, "ACE" is a subsequence of "ABCDE" while "AEC" is not).
# Input: S = "rabbbit", T = "rabbit" 		Output: 3 
# Explanation:As shown below, there are 3 ways you can generate "rabbit" from S.
def num_distinct(s, t)
    len = t.size
    prefix = [1] + [0]*len # => [1, 0, 0, 0, 0, 0, 0] will happen
    s.chars.each do |char|
        len.downto(1) {|i| prefix[i]=prefix[i-1]+prefix[i] if t[i-1]==char}
    end
    p prefix
    prefix[-1]
end


https://leetcode.com/problems/regular-expression-matching/discuss/231360/Ruby-version-with-thought-process
# 10. Regular Expression Matching
# Given an input string (s) and a pattern (p), implement regular expression matching with support for '.' and '*'.
# '.' Matches any single character. '*' Matches zero or more of the preceding element.
# The matching should cover the entire input string (not partial).
# Note:s could be empty and contains only lowercase letters a-z.
# p could be empty and contains only lowercase letters a-z, and characters like . or *.
# Input: s = "aa"  p = "a" 	Output: false
# Explanation: "a" does not match the entire string "aa".
def is_match(s, p)
# '.' single chr, '*' is empty or reapetation of same char
    #     recursive sol
    # return s.empty? if p.empty?
    # first = !s.empty? && [s[0], '.'].include?(p[0])
    # if p[1] == '*'
    #     is_match(s, p[2..-1]) || (first && is_match(s[1..-1], p))
    # else
    #     first && is_match(s[1..-1], p[1..-1])
    # end
    
    #       DP solution
    s = s.bytes
    p = p.bytes
    dp = Array.new(s.length+1) { Array.new(p.length+1, false) }
    m, n = s.length, p.length
    dp[m][n] = true
    
    m.downto(0) do |i| 
        (n-1).downto(0) do |j| 
            first = i < m && (s[i] == p[j] || p[j] == 46)
            if p[j+1] == 42
                dp[i][j] = dp[i][j+2] || (first && dp[i+1][j])
            else
                dp[i][j] = first && dp[i+1][j+1]
            end
        end
    end
    dp[0][0]
end
# Similar prob 10. up
# 44. Wildcard Matching
# Given an input string (s) and a pattern (p), implement wildcard pattern matching with support for '?' and '*'.
# '?' Matches any single character.
# '*' Matches any sequence of characters (including the empty sequence).
# The matching should cover the entire input string (not partial).
# Input:s = "aa"  p = "a"         Output: false
# Explanation: "a" does not match the entire string "aa".
def is_match(s, p)
    m, n = s.length, p.length
    dp = Array.new(m + 1) { Array.new(n + 1, false) }
    dp[0][0] = true

    1.upto(n) do |j|
        dp[0][j] = dp[0][j - 1] if p[j - 1] == '*'
    end

    1.upto(m) do |i|
        1.upto(n) do |j|
            dp[i][j] = dp[i - 1][j - 1] if p[j - 1] == s[i - 1] || p[j - 1] == '?'
            dp[i][j] = dp[i - 1][j] || dp[i][j - 1] if p[j - 1] == '*'
        end
    end

    dp[m][n]
end

# 940. Distinct Subsequences II
# Given a string S, count the number of distinct, non-empty subsequences of S .
# Since the result may be large, return the answer modulo 10^9 + 7.
# Input: "abc" 	Output: 7
# Explanation: The 7 distinct subsequences are "a", "b", "c", "ab", "ac", "bc", and "abc".
def distinct_subseq_ii(s)
    alphabets = ('a'..'z').to_a
    dict = Array.new(27, 0)
    mod = 10 ** 9 + 7
    total = 1
    s.chars.each do |char|
        index = alphabets.index(char) + 1
        combo = total * 2 - dict[index]
        dict[index] = total # if 'c' ever appears again, it will clash with the current combos.
        total = combo < 0 ? 0 + mod : combo % mod
    end
    total - 1 # subtract empty string
end
#--------------------------------------------------------------------------------------------
# 124. Binary Tree Maximum Path Sum
# Given a non-empty binary tree, find the maximum path sum.
# For this problem, a path is defined as any sequence of nodes from some starting node to any node in the tree along the parent-child connections. The path must contain at least one node and does not need to go through the root.
# Input: [1,2,3]
#        1
#       / \
#      2   3 		Output: 6
# Input: [-10,9,20,null,null,15,7]
#    -10
#    / \
#   9  20
#     /  \
#    15   7 		Output: 42

# Points to solution:
# an instance variable to maintain the current max @max
# visit left
# visit right
# check max of node, node + left and node +right - gives the max path
# check the max path against the sum at current node: node + left + right
# return the max path from traversal which is either node, node + left, or node + right
def max_path_sum(root)
    @max = -999999
    max_path_recursive(root)
    return @max
end

def max_path_recursive(node)
    if node == nil
        return 0
    else
        # possibilities
        # 1. self
        # 2. left + self
        # 3. right + self
        # 4 self + left + right
        left = max_path_recursive(node.left)
        right = max_path_recursive(node.right)
        max_path = [node.val, node.val+left, node.val+right].max
        @max = [max_path, @max, node.val + left + right].max
        return max_path
    end
end
#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------
#  To do
https://www.interviewbit.com/problems/repeating-subsequence/

# https://leetcode.com/problems/unique-binary-search-trees-ii/
# https://leetcode.com/problems/interleaving-string/
# https://leetcode.com/problems/scramble-string/
#https://www.geeksforgeeks.org/maximum-sum-such-that-no-two-elements-are-adjacent/
