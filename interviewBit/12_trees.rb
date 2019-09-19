TRAVERSAL tree  problems
# Binary Tree Inorder Traversal
# Given a binary tree, return the inorder traversal of its nodes values.
# Input: [1,null,2,3] 	Output: [1,3,2]
#    1
#     \
#      2
#     /
#    3
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @return {Integer[]}
def inorder_traversal(root)
    inorder = []
    return inorder if root == nil
    inorder_recursion(root, inorder)
end

def inorder_recursion(root, result)
    return root if root == nil
    inorder_recursion(root.left, result)
    result << root.val
    inorder_recursion(root.right, result)
    result
end


def preorder_traversal(root)
    preorder = []
    return preorder if root == nil
    preorder_recursion(root, preorder)
end

def preorder_recursion(root, result)
    return root if root == nil
    result << root.val
    preorder_recursion(root.left, result)
    preorder_recursion(root.right, result)
    result
end

def postorder_traversal(root)
    postorder = []
    return postorder if root == nil
    postorder_recursion(root, postorder)
end

def postorder_recursion(root, result)
    return root if root == nil
    postorder_recursion(root.left, result)
    postorder_recursion(root.right, result)
    result << root.val
    result
end


# level- order
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @return {Integer[][]}
Time complexity: O(n)  Extra memory: O(n)
def zigzag_level_order(root)
    result = []
    return result if root.nil?
    queue = []
    queue << root
    count = 0
    
    until queue.empty?
        level_size = queue.length
        level = []
        count += 1
        level_size.times do
            node = queue.shift
            level << node.val
            queue << node.left unless node.left.nil?
            queue << node.right unless node.right.nil?
        end
        if count % 2 == 0
            result << level.reverse
        else
            result << level
        end
    end
    
    result
end

Recursive:  Time complexity: O(n)   Extra memory: O(1)
def level_order(root, result = [], level = 0)
  return result unless root

  result << [] if result.length == level
  result[level] << root.val
  level_order(root.left, result, level + 1)
  level_order(root.right, result, level + 1)
end
#----------------------------------------------------------------------------------------
# N-ary Tree Preorder Traversal
# Given an n-ary tree, return the preorder traversal of its nodes values.
# 			1
# 		    | \	
# 		3	2	4
# 	   | \
# 	   5  6	
# Return its preorder traversal as: [1,3,5,6,2,4].
JAVA
class Solution {
    public List<Integer> preorder(Node root) {
        List<Integer> list = new ArrayList<>();
        preorder(root, list);
        return list;
    }

    private void preorder(Node node, List<Integer> list) {
        if (node != null) {
            list.add(node.val);
            for (Node n : node.children) {
                preorder(n, list);
            }
        }
    }
}
Time/Space Complexity
Time Complexity: O(n) since we must visit all nodes.
Space Complexity: O(log n) on balanced tree. O(n) otherwise.
#--------------------------------------------------------------------------------------------
# 116. Populating Next Right Pointers in Each Node
# You are given a perfect binary tree where all leaves are on the same level, and every parent has two children. The binary tree has the following definition:
# struct Node {
#   int val;
#   Node *left;
#   Node *right;
#   Node *next; }
# Populate each next pointer to point to its next right node. If there is no next right node, the next pointer should be set to NULL.
# Initially, all next pointers are set to NULL.
# Input: {"$id":"1","left":{"$id":"2","left":{"$id":"3","left":null,"next":null,"right":null,"val":4},"next":null,"right":{"$id":"4","left":null,"next":null,"right":null,"val":5},"val":2},"next":null,"right":{"$id":"5","left":{"$id":"6","left":null,"next":null,"right":null,"val":6},"next":null,"right":{"$id":"7","left":null,"next":null,"right":null,"val":7},"val":3},"val":1}
# Output: {"$id":"1","left":{"$id":"2","left":{"$id":"3","left":null,"next":{"$id":"4","left":null,"next":{"$id":"5","left":null,"next":{"$id":"6","left":null,"next":null,"right":null,"val":7},"right":null,"val":6},"right":null,"val":5},"right":null,"val":4},"next":{"$id":"7","left":{"$ref":"5"},"next":null,"right":{"$ref":"6"},"val":3},"right":{"$ref":"4"},"val":2},"next":null,"right":{"$ref":"7"},"val":1}
# Explanation: Given the above perfect binary tree (Figure A), your function should populate each next pointer to point to its next right node, just like in Figure B.
/**
 * Definition for binary tree with next pointer.
 * public class TreeLinkNode {
 *     int val;
 *     TreeLinkNode left, right, next;
 *     TreeLinkNode(int x) { val = x; }
 * }
 */
public class Solution {
    public void connect(TreeLinkNode root) {
        if(root == null)
            return;
        
        if(root.left != null){
            root.left.next = root.right;
            if(root.next != null)
                root.right.next = root.next.left; // root=2   2->5->6(next) = 2->3(next)->6
         }
        
        connect(root.left);
        connect(root.right);
    }
}
#--------------------------------------------------------------------------------------------
check tree problems
# Balanced Binary Tree
# Given a binary tree, determine if it is height-balanced.For this problem, a height-balanced binary tree is defined as:
# a binary tree in which the depth of the two subtrees of every node never differ by more than 1.
# Given the following tree [3,9,20,null,null,15,7]:  op true
#     3
#    / \
#   9  20
#     /  \
#    15   7
# Given the following tree [1,2,2,3,3,null,null,4,4]:  op false
#        1
#       / \
#      2   2
#     / \
#    3   3
#   / \
#  4   4
 # Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @return {Boolean}
def is_balanced(root)
    return true if root == nil
    return true if root.left == nil && root.right == nil
    left_subtree_height = find_height(root.left)
    right_subtree_height = find_height(root.right)
    
    return ((left_subtree_height - right_subtree_height).abs <= 1 && is_balanced(root.left) && is_balanced(root.right))
end

def find_height(node)
    return 0 if node == nil
    left_height = find_height(node.left)
    right_height = find_height(node.right)
    
    return [left_height, right_height].max + 1
end

# Symmetric Tree
# Given a binary tree, check whether it is a mirror of itself (ie, symmetric around its center).
# For example, this binary tree [1,2,2,3,4,4,3] is symmetric:
#     1
#    / \
#   2   2
#  / \ / \
# 3  4 4  3
# But the following [1,2,2,null,3,null,3] is not:
#     1
#    / \
#   2   2
#    \   \
#    3    3
def is_symmetric(root)
    symmetric_helper(root, root)
end

def symmetric_helper(left, right)
    return true if left == nil && right == nil
    return false if left == nil || right == nil
    return false if left.val != right.val
    symmetric_helper(left.left, right.right) && symmetric_helper(left.right, right.left)
end

# Same Tree
# Given two binary trees, write a function to check if they are the same or not.
# Two binary trees are considered the same if they are structurally identical and the nodes have the same value.
# Input:     1         1
#           / \       / \
#          2   3     2   3
#         [1,2,3],   [1,2,3]          Output: true

# Input:     1         1
#           /           \
#          2             2
#         [1,2],     [1,null,2]       Output: false

# Input:     1         1
#           / \       / \
#          2   1     1   2

#         [1,2,1],   [1,1,2]          Output: false
def is_same_tree(p, q)
    return true if p == nil && q == nil
    return false if p == nil || q == nil
    return false if q.val != p.val
    is_same_tree(p.left, q.left) && is_same_tree(p.right, q.right)
end

# 226. Invert Binary Tree
# Input:

#      4
#    /   \
#   2     7
#  / \   / \
# 1   3 6   9
# Output:

#      4
#    /   \
#   7     2
#  / \   / \
# 9   6 3   1
def invert_tree(root)
    return if root.nil?
    root.left, root.right = root.right, root.left
    invert_tree(root.left)
    invert_tree(root.right)

    root
end
# Approach 2: DFS Iterative
def invert_tree_dfs_iter(root)
    stack = [root]
    while !stack.empty?
        node = stack.pop()
        next if !node
        node.left, node.right = node.right, node.left
        stack += [node.left, node.right]
    end

    root
end
# Approach 3: BFS
def invert_tree_bfs(root)
    q = [root]
    while !q.empty?
        node = q.shift()
        next if !node
        node.left, node.right = node.right, node.left
        q += [node.left, node.right]
    end

    root
end

# 116. Populating Next Right Pointers in Each Node
# https://leetcode.com/problems/populating-next-right-pointers-in-each-node/
# You are given a perfect binary tree where all leaves are on the same level, and every parent has two children. The binary tree has the following definition:
# Populate each next pointer to point to its next right node. If there is no next right node, the next pointer should be set to NULL.
# Initially, all next pointers are set to NULL.
# 1. Retun null when current node is null. Or return the node itself if it has no child.
# 2. Point its left child to its right child(Assign left childs next)
# 3. If currents next is no null. It means current node has next node. So its right child can point to its nexts left.
# 4. Use function calls by its left child and right child.

public Node connect(Node root) {
    if(root == null) return null;
    
    if(root.left == null && root.right == null) return root;
    
    // Point nodes to its right position. While its parent have no next, point to null
    root.left.next = root.right;
    if(root.next != null)
        root.right.next = root.next.left;
    
    connect(root.left);
    connect(root.right);
    
    return root;
}
#--------------------------------------------------------------------------------------------
CONSTRUCT tree problems
https://www.techiedelight.com/construct-cartesian-tree-from-inorder-traversal/

# Convert Sorted Array to Binary Search Tree
# Given an array where elements are sorted in ascending order, convert it to a height balanced BST.
# For this problem, a height-balanced binary tree is defined as a binary tree in which the depth of the two subtrees of every node never differ by more than 1.
# Given the sorted array: [-10,-3,0,5,9], One possible answer is: [0,-3,9,-10,null,5]
def sorted_array_to_bst(nums)
    helper(nums, 0 ,nums.size - 1)
end

def helper(nums,low, high)
    return nil if low > high
    mid = (high + low) / 2
    node = TreeNode.new(nums[mid])
    node.left = helper(nums, low, mid - 1)
    node.right = helper(nums, mid + 1, high)
    node
end

# Construct Binary Tree from Preorder and Inorder Traversal
# Given preorder and inorder traversal of a tree, construct the binary tree.
# You may assume that duplicates do not exist in the tree.
# preorder = [3,9,20,15,7]
# inorder = [9,3,15,20,7]
# Return the following binary tree:
#     3
#    / \
#   9  20
#     /  \
#    15   7
def build_tree(preorder, inorder)
    return nil if preorder.empty? || inorder.empty?
    
    root = TreeNode.new(preorder.first)
    idx = inorder.find_index(preorder.first)
    preorder.shift

    root.left = build_tree(preorder, inorder.slice(0..(idx-1))) unless idx==0
    root.right = build_tree(preorder, inorder.slice((idx+1)..-1)) if idx!=inorder.size-1
    
    return root
end

# Construct Binary Tree from Inorder and Postorder Traversal
# Given inorder and postorder traversal of a tree, construct the binary tree.
# inorder = [9,3,15,20,7]
# postorder = [9,15,7,20,3]
# Return the following binary tree:
#     3
#    / \
#   9  20
#     /  \
#    15   7
def build_tree(inorder, postorder)
    return nil if inorder.empty?
    last_node_val = postorder.last
    last_node_index = inorder.index(last_node_val)
    node = TreeNode.new(last_node_val)
    
    if last_node_index > 0
        node.left = build_tree(inorder[0..last_node_index-1], postorder[0..last_node_index-1])
    end
    
    if last_node_index < inorder.length-1
        node.right = build_tree(inorder[last_node_index+1..-1], postorder[last_node_index..-2])
    end
     node
end
#--------------------------------------------------------------------------------------------
# Two Sum IV - Input is a BST
# Given a Binary Search Tree and a target number, return true if there exist two elements in the BST such that their sum is equal to the given target.
#     5
#    / \
#   3   6
#  / \   \
# 2   4   7
# Target = 9      Output: True
# bfs was used, As we move through the tree, we want to hash "expected value" such that the expected value is the difference between
# k and a previous nodular value, so if we find such an expected value, then we know the tree has a pair of numbers that sums to K.
def find_target(root, k)
    return nil if root == nil
    hash = Set.new([])
    queue = [root]
    
    while !queue.empty?
        node = queue.shift
        
        return true  if hash.include?(node.val)
        
        hash.add(k-node.val)
        
        if node.left; queue.push(node.left) end
        if node.right; queue.push(node.right) end
    end
  
    return false
end

# 230. Kth Smallest Element in a BST
# Given a binary search tree, write a function kthSmallest to find the kth smallest element in it.
# Note: You may assume k is always valid, 1 ≤ k ≤ BST's total elements.
# Input: root = [3,1,4,null,2], k = 1         Output: 1
#    3
#   / \
#  1   4
#   \
#    2
# Input: root = [5,3,6,2,4,null,null,1], k = 3    Output: 3
#        5
#       / \
#      3   6
#     / \
#    2   4
#   /
#  1
def kth_smallest(root, k)
#kth smallest is literally arr[k-1] if arr is sorted, remember what data structure we're working with; a BINARY SEARCH TREE
#the smallest elements are on the left always, and the largest in the right, and the middle in between,
# so in N time you could create a sorted array, and just return arr[k-1]
    @arr = []
    
    def dfs(node)
        return if !node
        dfs(node.left)
        @arr << node.val
        dfs(node.right)
    end

    dfs(root)
    @arr[k-1]
end


# 99.Recover Binary Search Tree
# Two elements of a binary search tree (BST) are swapped by mistake.
# Recover the tree without changing its structure.
# Input: [3,1,4,null,null,2]      Output: [2,1,4,null,null,3]
#   3                                  2
#  / \                                / \
# 1   4                              1   4
#    /                                   /
#   2                                    3

JAVA
https://www.geeksforgeeks.org/fix-two-swapped-nodes-of-bst/
public class Solution {
    
     TreeNode first = null, second = null, pre = null;
    public void recoverTree(TreeNode root) {
        if(root==null)return;
        dfs(root);
        if(first!=null&&second!=null){
            int temp = first.val;
            first.val = second.val;
            second.val = temp;
        }
    }
    public void  dfs(TreeNode root){
        if(root.left!=null)dfs(root.left);
        if(pre!=null&&pre.val>root.val)
            {
                if(first==null) first = pre;
                if(first!=null)second = root;
            }
        pre = root;
        if(root.right!=null)dfs(root.right);
    }
}

# 173. Binary Search Tree Iterator
# Implement an iterator over a binary search tree (BST). Your iterator will be initialized with the root node of a BST.
# Calling next() will return the next smallest number in the BST.
#     7
#    / \
#   3    15
#       /  \
#       9   20
# BSTIterator iterator = new BSTIterator(root);
# iterator.next();    // return 3
# iterator.next();    // return 7
# iterator.hasNext(); // return true
# iterator.next();    // return 9
# iterator.hasNext(); // return true
# iterator.next();    // return 15
class BSTIterator {
    Stack<TreeNode> stack;
    public BSTIterator(TreeNode root) {
        stack = new Stack<TreeNode>();
        while (root != null) {
            stack.push(root);
            root = root.left;
        }
    }
    public boolean hasNext() {
        return !stack.isEmpty();
    }
    public int next() {
        TreeNode node = stack.pop();
        int result = node.val;
        if (node.right != null) {
            node = node.right;
            while (node != null) {
                stack.push(node);
                node = node.left;
            }
        }
        return result;
    }
}

#--------------------------------------------------------------------------------------------
Root To Leaf - problems
# 112. Path Sum
# Given a binary tree and a sum, determine if the tree has a root-to-leaf path such that adding up all the values along the path equals the given sum.
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @param {Integer} sum
# @return {Boolean}
def has_path_sum(root, sum)
    return false if root == nil
    return sum == root.val if !root.left && !root.right
    sum -= root.val
    has_path_sum(root.left, sum) || has_path_sum(root.right, sum)
end

# 113. Path Sum II
# Given the below binary tree and sum = 22,
#       5
#      / \
#     4   8
#    /   / \
#   11  13  4
#  /  \    / \
# 7    2  5   1
# Return: [ [5,4,11,2], [5,8,4,5] ]
def path_sum(root, sum)
    res = []
    dfs(root, res, [], sum)
    res
end

def dfs(node, res, path, target)
    return if node == nil
    path << node.val
    if !node.left && !node.right && target == node.val
    # clone it otherwise every time u pop ele from path it will removed from res as well
        temp = path.clone  
        res << temp
        p res
    else
        dfs(node.left, res, path, target - node.val)
        dfs(node.right, res, path, target - node.val)
    end
    path.pop()
end

# 104. Maximum Depth of Binary Tree
# 111. Minimum Depth of Binary Tree
def max_depth(root)
    return 0 if !root
    [max_depth(root.left), max_depth(root.right)].max + 1
end

# 129. Sum Root to Leaf Numbers
# Given a binary tree containing digits from 0-9 only, each root-to-leaf path could represent a number.
# An example is the root-to-leaf path 1->2->3 which represents the number 123.
# Find the total sum of all root-to-leaf numbers.
# Input: [1,2,3]  Output: 25
#     1
#    / \
#   2   3
# Explanation:
# The root-to-leaf path 1->2 represents the number 12.
# The root-to-leaf path 1->3 represents the number 13.
# Therefore, sum = 12 + 13 = 25.
def sum_numbers(root)
    return 0 if root.nil?
    nums = []
    inner_sum_numbers(root, 0, nums)
    nums.reduce(:+) #OR (&:+)
#(5..10).reduce(:+) => 45
# Same using a block and inject (5..10).inject { |sum, n| sum + n }            => 45
# Multiply some numbers(5..10).reduce(1, :*)  => 151200
end

def inner_sum_numbers(root, num, nums)
    num = num*10 + root.val
    if root.right.nil? and root.left.nil?
        nums << num
    else
        if !root.left.nil?
            inner_sum_numbers(root.left, num, nums)
        end
        if !root.right.nil?
            inner_sum_numbers(root.right, num, nums)
        end
    end
end
#--------------------------------------------------------------------------------------------
# 236. Lowest Common Ancestor of a Binary Tree
# Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.
# According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”
# Given the following binary tree:  root = [3,5,1,6,2,0,8,null,null,7,4]
# Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
# Output: 3
# Explanation: The LCA of nodes 5 and 1 is 3.
def lowest_common_ancestor(root, p, q)
    return nil if root.nil?
    return p if in_node?(p, q)
    return q if in_node?(q, p)
    until root.nil?
        return root if [nil, p, q].index(root)
        if in_node?(root.left, p) && in_node?(root.left, q)
            root = root.left
            next
        end
        if in_node?(root.right, p) && in_node?(root.right, q)
            root = root.right
            next
        end
        return root
    end
end

def in_node?(parent, node)
    return false if parent.nil?
    return true if parent == node
    in_node?(parent.left, node) || in_node?(parent.right, node)
end
#--------------------------------------------------------------------------------------------
# 114. Flatten Binary Tree to Linked List
# Given a binary tree, flatten it to a linked list in-place.
# For example, given the following tree:
#     1
#    / \
#   2   5
#  / \   \
# 3   4   6
# The flattened tree should look like:
# 1
#  \
#   2
#    \
#     3
#      \
#       4
#        \
#         5
#          \
#           6
def flatten(root)
    
    return root if root.nil?
    stack = [root]
    prev_node = nil
    
    while !stack.empty? do
        iterator = stack.pop
        if !prev_node.nil?
          prev_node.right = iterator
          prev_node.left = nil
        end
        stack << iterator.right if iterator.right
        stack << iterator.left if iterator.left
        prev_node = iterator
    end
    root
end

# recursive soln
def flatten(root)
    return root if root.nil?
    
    vals = []
    irt(root,vals)
    
    (0..vals.size-2).step(1) do |i|
        vals[i].left = nil
        vals[i].right = vals[i+1]
    end
    
    vals.last.left = nil
    vals.last.right = nil
    return vals.first
end

def irt(root,vals)
    vals << root
    irt(root.left,vals) unless root.left.nil?
    irt(root.right,vals) unless root.right.nil?
end
#--------------------------------------------------------------------------------------------
https://www.geeksforgeeks.org/find-shortest-unique-prefix-every-word-given-list-set-2-using-sorting/
#--------------------------------------------------------------------------------------------
http://qa.geeksforgeeks.org/3974/qa.geeksforgeeks.org/3974/determine-the-actual-order-heights-google.html
# Order of People Heights
# Google
# A positive number N
# Heights : A list of heights of N persons standing in a queue
# Infronts : A list of numbers corresponding to each person (P) that gives the number of persons who are taller than P and standing in front of P
# You need to return list of actual order of persons’s height
# Consider that heights will be unique
# Input : Heights: 5 3 2 6 1 4   InFronts: 0 1 2 0 3 2
# Output : actual order is: 5 3 2 1 6 4 
public static void orderStandingQueue(int[] heights, int[] infronts) {
    ArrayList<Integer> result = new ArrayList<Integer>();
    TreeMap<Integer,Integer> map = new TreeMap<Integer,Integer>();
    for (int i=0; i<heights.length; i++) {
        map.put(heights[i], infronts[i]);
    }

    boolean sorted = false;
    while(sorted == false) {
        int height = map.lastKey();
        int taller = map.get(height);
        map.remove(height);


        if (result.isEmpty()){
            result.add(height);
        } else if (taller == 0) {
            result.add(0,height);
        } else {
            result.add(taller,height);
        }
        if (map.isEmpty()) sorted = true;
    }
    System.out.println(result.toString());
}
#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------