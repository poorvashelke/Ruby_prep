BFS - Level order - Queue
# 102. Binary Tree Level Order Traversal
# Given a binary tree, return the level order traversal of its nodes' values. (ie, from left to right, level by level).
# Given binary tree [3,9,20,null,null,15,7],
#     3
#    / \
#   9  20
#     /  \
#    15   7
# return its level order traversal as: [[3], [9,20],15,7]]
def level_order(root)
    return [] unless root
    result = {}
    level(root,0,result)
    return result.values
end
def level(root,level,result)
    
    if result.has_key?(level)
        result[level] = (result[level]<<root.val)
    else
        result[level] = [root.val]
    end
    
    level(root.left,level+1,result) if root.left
    level(root.right,level+1,result) if root.right
    
end
# return its bottom-up level order traversal as:  [[15,7],[9,20],[3]]
def level_order_bottom(root)
    return [] if root.nil?
    node_queue = [ root ]
    result = []

    until node_queue.empty?
        tmp = []
        children = []

        until node_queue.empty?
            node = node_queue.shift
            children.push(node.left) if node.left
            children.push(node.right) if node.right
            tmp.push(node.val)
        end

        node_queue = children
        result.unshift(tmp)
    end
    result
end
# ORRRR  recursive
def level_order_bottom(root)
    dfs(root).reverse
end

def dfs(root, level = 0, levels = [])
    return [] if root.nil?
    dfs(root.left, level + 1, levels)
    levels[level] = [] if levels[level].nil?
    levels[level] << root.val
    dfs(root.right, level + 1, levels)
    levels
end

#--------------------------------------------------------------------------------------------
DFS - Stack
https://leetcode.com/problems/clone-graph/
#--------------------------------------------------------------------------------------------
# 127. Word Ladder
# Given two words (beginWord and endWord), and a dictionary's word list, find the length of shortest transformation sequence from beginWord to endWord, such that:
# Only one letter can be changed at a time.
# Each transformed word must exist in the word list. Note that beginWord is not a transformed word.
# Note:Return 0 if there is no such transformation sequence.
# All words have the same length.
# All words contain only lowercase alphabetic characters.
# You may assume no duplicates in the word list.
# You may assume beginWord and endWord are non-empty and are not the same.
# beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log","cog"]
# Output: 5
# Explanation: As one shortest transformation is "hit" -> "hot" -> "dot" -> "dog" -> "cog",
# return its length 5.
def ladder_length(begin_word, end_word, word_list)
    word_set = Set.new(word_list)
    return 0 unless word_set.member?(end_word) # member alis of include
    queue = [[begin_word, 1]]
    
    while !queue.empty? do 
        s = queue[0][0]
        l = queue[0][1]
        return l if s == end_word
        queue.delete_at(0)
        s.size.times do |i|
            left = s[0...i]
            right = s[(i + 1)...s.size]
#on word trying all combination's change single letter 'a'..'z' each time
            for c in "a".ord.."z".ord do
# "agh".ord => 97 returns codepoint of 1st char in str
                next if c == s[i].ord
                combined = left + c.chr + right
                if word_set.member?(combined) then
                    word_set.delete(combined)
                    queue << [combined, l + 1]
                end
            end
                
        end
    end
        
    0
end
https://leetcode.com/problems/word-ladder-ii/discuss/168187/Ruby-level-BFS-%2B-DFS
https://leetcode.com/problems/word-ladder-ii/discuss/111173/Ruby-Only-accepted-Ruby-solution-Simple-and-efficient.
#--------------------------------------------------------------------------------------------
# 109. Convert Sorted List to Binary Search Tree
# Given a singly linked list where elements are sorted in ascending order, convert it to a height balanced BST.
# For this problem, a height-balanced binary tree is defined as a binary tree in which the depth of the two subtrees of every node never differ by more than 1.
# Given the sorted linked list: [-10,-3,0,5,9],
# One possible answer is: [0,-3,9,-10,null,5], which represents the following height balanced BST:
#       0
#      / \
#    -3   9
#    /   /
#  -10  5
def sorted_list_to_bst(head)
    nums = list_to_arr(head)
    sorted_array_to_bst(nums)
end
# getting all the values of Tree Node's
def list_to_arr(head)
    arr = []
    iterator = head
    while iterator do
        arr << iterator.val
        iterator = iterator.next
    end
    arr
end
# creating BST using binary search
def sorted_array_to_bst(nums)
    return nil if nums.empty?
    mid = nums.length/2
    node = TreeNode.new(nums[mid])
    node.left = sorted_array_to_bst(nums[0..mid-1]) if mid-1 >= 0
    node.right = sorted_array_to_bst(nums[mid+1..-1]) if mid+1 <= nums.length-1
    return node
end
#--------------------------------------------------------------------------------------------
# 79. Word Search
# Given a 2D board and a word, find if the word exists in the grid.
# The word can be constructed from letters of sequentially adjacent cell, where "adjacent" cells are those horizontally or vertically neighboring. The same letter cell may not be used more than once.
# board =[['A','B','C','E'],
#   		['S','F','C','S'],
#   		['A','D','E','E']]
# Given word = "ABCCED", return true.
# Given word = "SEE", return true.
# Given word = "ABCB", return false.
def exist(board, word)
    board.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          return true if dfs(board, i, j, word)
        end
    end
    false
end

def dfs(board, row, col, word)
    return true if word.length == 0
    if row < 0 || row >= board.length || col < 0 || col >= board[0].length || board[row]        [col] != word[0]
        return false
    end

    temp = board[row][col]
    board[row][col] = ''

    result = dfs(board, row + 1, col, word[1..-1]) ||
           dfs(board, row - 1, col, word[1..-1]) ||
           dfs(board, row, col + 1, word[1..-1]) ||
           dfs(board, row, col - 1, word[1..-1])

     board[row][col] = temp

    return result
end
#--------------------------------------------------------------------------------------------
# 130. Surrounded Regions
# Given a 2D board containing 'X' and 'O' (the letter O), capture all regions surrounded by 'X'.
# A region is captured by flipping all 'O's into 'X's in that surrounded region.
# X X X X
# X O O X
# X X O X
# X O X X
# After running your function, the board should be:
# X X X X
# X X X X
# X X X X
# X O X X
def solve(board)
    return if board == nil || board.empty?
    row, col = board.size, board.first.size
    for i in (0...row)
        for j in 0...col
            if board[i][j] == 'O' && !on_board(board, i, j, row, col, Array.new(row){Array.new(col, false)})
                flood_fill(board, i, j, row, col)
            end
        end
    end
end

def on_board(board, i, j, m, n, v)
    return false if board[i][j] == 'X' || v[i][j]
	return true	if (i == 0 || i == m - 1 || j == 0 || j == n - 1)
	v[i][j] = true;
	return on_board(board, i + 1, j, m, n, v) || on_board(board, i - 1, j, m, n, v) || on_board(board, i, j + 1, m, n, v) || on_board(board, i, j - 1, m, n, v)
end

def flood_fill(board, i, j, m, n)
    return if i < 0 || j < 0 || i > m || j > n || board[i][j] == 'X'
    board[i][j] = 'X'
    flood_fill(board, i - 1, j, m, n)
    flood_fill(board, i + 1, j, m, n)
    flood_fill(board, i, j + 1, m, n)
    flood_fill(board,i, j - 1, m, n)
end
#--------------------------------------------------------------------------------------------
# 3. Longest Substring Without Repeating Characters
# Given a string, find the length of the longest substring without repeating characters.
# Input: "abcabcbb"   Output: 3 
# Explanation: The answer is "abc", with the length of 3. 
# Input: "pwwkew"     Output: 3
# Explanation: The answer is "wke", with the length of 3. Note that the answer must be a substring, "pwke" is a subsequence and not a substring.
def length_of_longest_substring(s, acc = "")
    # iterative soln
#     n = s.size-1
#     h = {}
#     count, start = 0, 0
    
#     for i in (0..n)
#         cur = s[i]
#         start = [start, h[cur]+1].max if h[cur]
#         h[cur] = i
#         count = [count, i-start+1].max
#     end
#     count
    
    return acc.length if s.empty?
    if acc.include?(s[0])
        rest_acc = acc[(acc.index(s[0]) + 1)..-1]
        return acc.length if acc.length >= rest_acc.length + s.length
        
        [acc.length, length_of_longest_substring(s, rest_acc)].max
    else
        length_of_longest_substring(s[1..-1], acc << s[0])
    end
end
#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------
https://algorithms.tutorialhorizon.com/graph-detect-cycle-in-a-directed-graph-using-colors/
https://www.geeksforgeeks.org/detect-cycle-in-a-graph/
https://www.geeksforgeeks.org/detect-cycle-direct-graph-using-colors/
https://www.geeksforgeeks.org/count-possible-paths-top-left-bottom-right-nxm-matrix/
#--------------------------------------------------------------------------------------------
https://leetcode.com/problems/maximum-difference-between-node-and-ancestor/
#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------