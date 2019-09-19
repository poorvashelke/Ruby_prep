#--------------------------------------------------------------------------------------------
# Longest Continous Zero Sum Subarray
# https://www.geeksforgeeks.org/find-the-largest-subarray-with-0-sum/
# Find the length of largest subarray with 0 sum
# Given an array of integers, find length of the largest subarray with sum equals to 0.
# Input: arr[] = {15, -2, 2, -8, 1, 7, 10, 23} 	Output: 5
# The largest subarray with 0 sum is -2, 2, -8, 1, 7
def zero_sum(arr)
    hash = {}
    sum = 0
    max_len  = 0
    res = []
    arr.each_with_index do |ele, i|
        sum += ele
        max_len += 1 if sum == 0
        max_len = 1 if ele == 0 && max_len == 0
        prev_present = hash[sum]
        if prev_present != nil
            max_len = [max_len, i - prev_present].max
            start = i - i + 1
            res << arr[start..i]
        else
            hash[sum] = i
        end
    end
    max_len # if we have to return length
    # if we want to return subarr
    subarr = []
    res.each do |ele|
        subarr = ele if ele.size > subarr.size
    end
    subarr
end
#--------------------------------------------------------------------------------------------
# Two Sum
# Given an array of integers, return indices of the two numbers such that they add up to a specific target.
# You may assume that each input would have exactly one solution, and you may not use the same element twice.
# Given nums = [2, 7, 11, 15], target = 9,
# Because nums[0] + nums[1] = 2 + 7 = 9,  return [0, 1].
def two_sum(nums, target)
    nums.each_with_index do |ele, i|
        check = target - ele
        return i, nums.index(check) if nums.include?(check) && i != nums.index(check)
    end
end
JAVA
class Solution {
    public int[] twoSum(int[] nums, int target) {
        int[] result = new int[2];
        Map<Integer, Integer> sum = new HashMap<>();
        
        for(int i =0; i < nums.length; i++) {
            int index = target - nums[i];   //9-2 =7 so we have to search 7 in array
            
            if(sum.containsKey(index)) {
                    result[0] = sum.get(index); // storing position as value in map
                    result[1] = i;
                    break;
                }
                sum.put(nums[i], i);
            }
        return result;
    }
}
#--------------------------------------------------------------------------------------------
# Given an array S of n integers, are there elements a, b, c, and d in S such that a + b + c + d = target? 
# Find all unique quadruplets in the array which gives the sum of target.
def four_sum(arr, target)
    arr = arr.sort
    size = arr.size
    res = []
    (0...size).each do |i|
        (i + 1...size).each do |j|
            left = j + 1
            right = size - 1
            while left < right
                sum = arr[i] + arr[j] + arr[left] + arr[right]
                res << [arr[i], arr[j], arr[left], arr[right]] if sum == target
                if sum > target
                    right -= 1
                else
                    left += 1
                end
            end
        end
    end
    res
end
p zero_sum([15, 3,5, 2, 8, -1, 7, 10, 23], 19)   => [[-1, 2, 3, 15], [-1, 2, 8, 10], [-1, 3, 7, 10], [-1, 5, 7, 8]]
#--------------------------------------------------------------------------------------------
# Equal
# Given an array A of integers, find the index of values that satisfy A + B = C + D, where A,B,C & D are integers values in the array
def equal(arr)
    size = arr.size
    hash = Hash.new{|h,k| h[k] = []}
    (0...size).each do |i|
       (i + 1...size - 1).each do |j|
           sum = arr[i] + arr[j]
           if hash.has_key?(sum)
               values = hash[sum]
               values << i
               values << j
               return values
            else
                hash[sum] = [i, j]
            end
        end
    end
end
p equal([15, 3,5, 2, 8, 7, 10, 23])  => [1, 6, 2, 4]
#--------------------------------------------------------------------------------------------
# 138. Copy List with Random Pointer
# A linked list is given such that each node contains an additional random pointer which could point to any node in the list or NULL.
# Return a deep copy of the list.
/**
 * Definition for singly-linked list with a random pointer.
 * class RandomListNode {
 *     int label;
 *     RandomListNode next, random;
 *     RandomListNode(int x) { this.label = x; }
 * };
 */
public class Solution {
    public RandomListNode copyRandomList(RandomListNode head) {
        if(head == null) return null;
        
        Map<RandomListNode, RandomListNode> map = new HashMap<>();
  
        // loop 1. copy all the nodes
        RandomListNode node = head;
        while (node != null) {
            map.put(node, new RandomListNode(node.label)); //new Ran.... its for making the deep copy
            node = node.next;
        }

        // loop 2. assign next and random pointers
        node = head;
        while (node != null) {
            map.get(node).next = map.get(node.next);
            map.get(node).random = map.get(node.random);
            node = node.next;
        }

        return map.get(head);
    }
}
#--------------------------------------------------------------------------------------------
# Minimum Window Substring
# Given a string S and a string T, find the minimum window in S which will contain all the characters in T in complexity O(n).
# Input: S = "ADOBECODEBANC", T = "ABC" 	Output: "BANC"
# If there is no such window in S that covers all characters in T, return the empty string "".
# If there is such window, you are guaranteed that there will always be only one unique minimum window in S.
# @param {String} s
# @param {String} t
# @return {String}
def min_window(s, t)
    current_set = {}
    t.each_char do |c|
        current_set[c] ||= 0
        current_set[c] -= 1
    end
    valid_count = current_set.keys.length * -1
    left = 0
    min_window = ""
    s.each_char.with_index do |c, right_index|
        if current_set[c]
            current_set[c] += 1
            valid_count += 1 if current_set[c] == 0
        end
        if valid_count >= 0
            while valid_count >= 0
                if current_set[s[left]]
                    current_set[s[left]] -= 1
                    valid_count -= 1 if current_set[s[left]] == -1
                end
                left += 1
            end
            if min_window.length == 0 || min_window.length >= right_index - left + 2
                min_window = s[left-1..right_index]
            end
        end
    end
    min_window
end
JAVA
class Solution {
    public String minWindow(String s, String t) {
        int[] map = new int[128];
        for (char c : t.toCharArray()) {
            map[c] += 1;
        }
        int begin = 0;
        int len = Integer.MAX_VALUE;
        int count = t.length();
        for (int left=0, right=0; right<s.length(); right++) {
            char c = s.charAt(right);
            map[c]--;
            if(map[c]>=0) count--; 
            while (count == 0) {
                char lc = s.charAt(left);
                map[lc]++;
                if (map[lc]>0) {
                    if (right-left+1<len) {
                        begin = left;
                        len = right-left+1;
                    }
                    count++;
                }
                left++;
            }
        }
        return len==Integer.MAX_VALUE?"":s.substring(begin, begin+len);
    }
}
#--------------------------------------------------------------------------------------------
# Substring with Concatenation of All Words
# https://leetcode.com/problems/substring-with-concatenation-of-all-words/discuss/13733/Accepted-short-Java-solution
# You are given a string, s, and a list of words, words, that are all of the same length. Find all starting indices of substring(s) in s that is a concatenation of each word in words exactly once and without any intervening characters.
# Input:s = "barfoothefoobarman", words = ["foo","bar"] 	Output: [0,9]
# Explanation: Substrings starting at index 0 and 9 are "barfoor" and "foobar" respectively.
# @param {String} s
# @param {String[]} words
# @return {Integer[]}
def find_substring(s, words)
    result = []
    return result if words.empty? || words[0].size == 0 || words.size > s.size
    size = words[0].size
    words_hash = Hash.new{|h,k| h[k] = 0}
    words.each do |word|
        words_hash[word] += 1    
    end
    
    i = j = 0
    while i + size * words.size <= s.size
        if words_hash.has_key?(s[i...i + size])
            curr_hash = Hash.new{|h,k| h[k] = 0}
            while j < words.size
                left = i + j * size
                right = i + (j + 1) * size
                new_word = s[left...right]
                curr_hash[new_word] += 1
                j += 1
            end
            j = 0
            result << i if curr_hash == words_hash
        end
        i += 1
    end
    result
end
#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------
https://www.geeksforgeeks.org/count-maximum-points-on-same-line/
https://www.geeksforgeeks.org/represent-the-fraction-of-two-numbers-in-the-string-format/
#--------------------------------------------------------------------------------------------
def minSum(num, k)
    # max_num = Containers::PriorityQueue.new
    # num.each do |single|
    #     max_num.push(single)
    # end
    i = 1
    while i <= k
        max_num = helper(num)
        index = num.index(max_num)
        new_num = (max_num / 2.0).ceil
        num[index] = new_num.to_i
        i = i + 1
    end
    num.sum
end

def helper(num)
    num.max
end
p minSum([10, 20, 7], 4)


def getMinimumDifference(a, b)
    return -1 if a.size != b.size
    return a if b.size == 0
    return b if a.size == 0

    store = Array.new(a.size + 1){Array.new(b.size + 1)}
    (0...a.size).each do |i|
        store[i][0] = i
    end
    (0...b.size).each do |i|
        store[0][i] = i
    end

    (1...b.size).each do |j|
        (1...a.size).each do |k|
            if a[j - 1] == b[k - 1]
                store[j][k] = store[j - 1][k - 1]
            else
                store[j][k] = [store[j - 1][k] + 1, store[j][k - 1] + 1, store[j - 1][k - 1] + 1].min
            end
        end
    end
    store[a.size][b.size]
end

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------