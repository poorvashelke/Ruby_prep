# Merge Two Sorted Lists
# Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the nodes of the first two lists.
# Input: 1->2->4, 1->3->4 		Output: 1->1->2->3->4->4

# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end
# @param {ListNode} l1
# @param {ListNode} l2
# @return {ListNode}
def merge_two_lists(l1, l2)
    head = ListNode.new(0)
    curr = head
    while l1 && l2
        if l1.val < l2.val
            curr.next = l1
            l1 = l1.next
        else
            curr.next = l2
            l2 = l2.next
        end
        curr = curr.next
    end
    while l1
        curr.next = l1
        l1 = l1.next
        curr = curr.next
    end
    while l2
        curr.next = l2
        l2 = l2.next
        curr = curr.next
    end
    head.next
end
#--------------------------------------------------------------------------------------------
# Palindrome Linked List
# Given a singly linked list, determine if it is a palindrome.
# Input: 1->2 			Output: false
# Input: 1->2->2->1 		Output: true
def is_palindrome(head)
    slow = fast = head
    while fast && fast.next
        slow = slow.next
        fast = fast.next.next
    end
    slow = reverse(slow)
    fast = head
    while slow
        return false if slow.val != fast.val
        slow = slow.next
        fast = fast.next
    end
    true
end

def reverse(curr)
    prev = nil
    while curr
        next_node = curr.next
        curr.next = prev
        prev = curr
        curr = next_node
    end
    prev
end
#-----------------------------------------------------------------------------------
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
# Remove Duplicates from Sorted List II    -------------------------------------------
# Given a sorted linked list, delete all nodes that have duplicate numbers,
#  leaving only distinct numbers from the original list.
# Input: 1->2->3->3->4->4->5 		Output: 1->2->5
# Input: 1->1->1->2->3 			Output: 2->3
# @param {ListNode} head
# @return {ListNode}
def delete_duplicates(head)
    return nil if head == nil
    curr = head.next
    while head
        while curr && head.val == curr.val
            curr = curr.next
        end
        if head.next != curr
            return nil if curr == nil
            head = curr
            curr = curr.next
        else
            head.next = delete_duplicates(head.next)
            return head     
        end
    end
end
#--------------------------------------------------------------------------------------------
# Rotate List
# Given a linked list, rotate the list to the right by k places, where k is non-negative.
# Input: 1->2->3->4->5->NULL, k = 2 		Output: 4->5->1->2->3->NULL
# rotate 1 steps to the right: 5->1->2->3->4->NULL
# rotate 2 steps to the right: 4->5->1->2->3->NULL
# Input: 0->1->2->NULL, k = 4 		Output: 2->0->1->NULL
# rotate 1 steps to the right: 2->0->1->NULL
# rotate 2 steps to the right: 1->2->0->NULL
# rotate 3 steps to the right: 0->1->2->NULL
# rotate 4 steps to the right: 2->0->1->NULL
def rotate_right(head, k)
    return head if head == nil
    length = 0
    temp = head
    while temp
        length += 1
        temp = temp.next
    end
    slow = fast = head
    k = k % length
    
    while k > 0
        fast = fast.next
        k = k - 1
    end
    
    return head if fast == nil
    
    while fast.next
        fast = fast.next
        slow = slow.next
    end
    fast.next = head
    res = slow.next
    slow.next = nil
    
    res
end
#--------------------------------------------------------------------------------------------
# Remove Nth Node From End of List
# Given a linked list, remove the n-th node from the end of list and return its head.
# Given linked list: 1->2->3->4->5, and n = 2.  op  1->2->3->5.
def remove_nth_from_end(head, n)
    length = 0
    slow = fast = head
    while fast              # get size of LL
        length += 1
        fast = fast.next
    end
    delete_node = length - n
    if delete_node == 0     # delete 1st node
        head = head.next
        return head
    end
    
    for i in (0...delete_node)
       if i == (delete_node - 1)  # delete nth node
           slow.next = slow.next.next
       end
        slow = slow.next
    end
    head
end
#--------------------------------------------------------------------------------------------
# Reverse Linked List II
# Reverse a linked list from position m to n. Do it in one-pass. Note: 1 ≤ m ≤ n ≤ length of list.
# Input: 1->2->3->4->5->NULL, m = 2, n = 4 		Output: 1->4->3->2->5->NULL
# @param {ListNode} head
# @param {Integer} m
# @param {Integer} n
# @return {ListNode}
def reverse_between(head, m, n)
    return nil if head == nil
    return head if m == n
    starting = ending = prev = next_node = nil
    i = 1
    curr = head
    while curr && i <= n
        prev = curr if i < m
        starting = curr if i == m
        if i == n
            ending = curr
            next_node = curr.next
        end
        curr = curr.next
         i += 1
    end
    ending.next = nil
    ending = reverse(starting)
    if prev        # If starting position was not head
        prev.next = ending
    else                # If starting position ID head
        head = ending
    end
    starting.next = next_node
    head
end
def reverse(curr)
    prev = nil
    while curr
        next_node = curr.next
        curr.next = prev
        prev = curr
        curr = next_node
    end
    prev
end
#--------------------------------------------------------------------------------------------
# Reorder List
# Given a singly linked list L: L0→L1→…→Ln-1→Ln,
# reorder it to: L0→Ln→L1→Ln-1→L2→Ln-2→…
# You may not modify the values in the lists nodes, only nodes itself may be changed.
# Given 1->2->3->4, reorder it to 1->4->2->3.
# Given 1->2->3->4->5, reorder it to 1->5->2->4->3.
def reorder_list(head)
	return [] if head == nil
    slow = fast = head
    while fast && fast.next
        slow = slow.next
        fast = fast.next.next
    end
    mid = slow
    mid.next = reverse(mid.next)
    fast = head  # start
    prev = mid
    mid = mid.next
    while mid
        removed = mid
        prev.next = mid.next
        removed.next = fast.next
        fast.next = removed
        fast = removed.next
        mid = prev.next
    end
    head
end

def reverse(curr)
    prev = nil
    while curr
        next_node = curr.next
        curr.next = prev
        prev = curr
        curr = next_node
    end
    prev
end
#--------------------------------------------------------------------------------------------
# Linked List Cycle
def cycle(head)
	return [] if head == nil
	slow = fast = head
	while fast && fast.next
		return true if fast.val == slow.val
		slow = slow.next
		fast = fast.next.next
	end
	false
end
#--------------------------------------------------------------------------------------------
# Swap Nodes in Pairs
# Share
# Given a linked list, swap every two adjacent nodes and return its head.
# You may not modify the values in the lists nodes, only nodes itself may be changed.
# Given 1->2->3->4, you should return the list as 2->1->4->3.

# @param {ListNode} head
# @return {ListNode}
def swap_pairs(head)
    return head if head == nil || head.next == nil
    dummy = ListNode.new(0)
    dummy.next = head
    curr = dummy
    while curr.next != nil && curr.next.next != nil
        slow = curr.next
        fast = curr.next.next
        temp = fast.next
        slow.next = temp
        fast.next = slow
        curr.next = fast
        curr = curr.next.next
    end
    dummy.next
end
#--------------------------------------------------------------------------------------------
# Add Two Numbers II
# You are given two non-empty linked lists representing two non-negative integers. The most significant digit comes first 
# and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.
# Input: (7 -> 2 -> 4 -> 3) + (5 -> 6 -> 4) 		Output: 7 -> 8 -> 0 -> 7
# @param {ListNode} l1
# @param {ListNode} l2
# @return {ListNode}
def add_two_numbers(l1, l2)
    num1 = []
    num2 = []
    until l1 == nil
        num1.push(l1.val)
        l1 = l1.next
    end
    until l2 == nil
        num2.push(l2.val)
        l2 = l2.next
    end
    sum = 0
    res = ListNode.new(0)
    while !num1.empty? || !num2.empty?
        sum += num1.pop() if !num1.empty?
        sum += num2.pop() if !num2.empty?
        res.val = sum % 10
        head = ListNode.new(sum / 10)
        head.next = res
        res = head
        sum = sum / 10
    end
    # if ip [5] [5] =>[1,0] to handle this
    if sum != 0
        head = ListNode.new(sum % 10)
        head.next = res
        res = head
    end
    res.next
end
#--------------------------------------------------------------------------------------------
def insertion_sort(a)
    for i in 1...(a.length)
        j=i
        while j>0
            if a[j-1]>a[j]
                temp=a[j]
                a[j]=a[j-1]
                a[j-1]=temp
            else
              break
            end
            j=j-1
        end
    end
    return a
end
# Insertion Sort List
# Input: 4->2->1->3 			Output: 1->2->3->4
# Input: -1->5->3->4->0 		Output: -1->0->3->4->5
def insertion_sort_list(head)
      cur = head
	  head = nil
	  prev = nil
	  while cur do
	        small_cur = nil
	        small_cur_prev = nil
	        iterator = cur
	        iterator_prev = prev
	    	while iterator do
	              if small_cur.nil? || small_cur.val > iterator.val
	                	small_cur = iterator
	                    small_cur_prev = iterator_prev
	              end
	              iterator_prev = iterator
	              iterator = iterator.next
	    	end

	    if cur != small_cur
	        small_cur_prev.next = small_cur.next
	        if !prev.nil?
	            prev.next = small_cur
	        end
	        small_cur.next = cur
	    end

	    if head.nil?
	        head = small_cur
	    end

	    prev = small_cur
	    cur = small_cur.next
	  end
	  head
end
#--------------------------------------------------------------------------------------------
# Partition List
# Given a linked list and a value x, partition it such that all nodes less than x come before nodes greater than or equal to x.
# You should preserve the original relative order of the nodes in each of the two partitions.
# Input: head = 1->4->3->2->5->2, x = 3 		Output: 1->2->2->4->3->5
def partition(head, x)
    return head if head == nil || head.next == nil
    temp_left = curr_left = ListNode.new(-1)
    temp_right = curr_right = ListNode.new(-1)
    while head
        if head.val < x
            temp_left.next = head
            temp_left = temp_left.next
            prev_left = temp_left  # points to last node of left
        else
            temp_right.next = head
            temp_right = temp_right.next
        end
        head = head.next
    end
    temp_right.next = nil # to make right last node nil
    prev_left.next = curr_right.next # joining right to lefts end point
    curr_left.next    
end
#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------
# K reverse linked list
# Given linked list 1 -> 2 -> 3 -> 4 -> 5 -> 6 and K=2,
# You should return 2 -> 1 -> 4 -> 3 -> 6 -> 5
# Try to solve the problem using constant extra space.
def kAltReverse(head, k)
    current = head
    next_node = nil
    prev = nil
    count = 0
  
    #1) reverse first k nodes of the linked list
    while current != nil && count < k
        next_node = current.next
        current.next = prev
        prev = current
        current = next_node
        count += 1
    end
  
    # 2) Now head points to the kth node.  So change next  of head to (k+1)th node
    if head != nil
        head.next = current
    end
  
    # 3) We do not want to reverse next k nodes. So move the current pointer to skip next k nodes
    count = 0
    while count < k - 1 && current != null
        current = current.next
        count += 1
    end
  
    # 4) Recursively call for the list starting from current->next. And make rest of the list as next of first node
    if current != null
        current.next = kAltReverse(current.next, k)
    end
  
    prev
end
#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------