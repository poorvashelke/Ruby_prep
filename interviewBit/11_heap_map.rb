#--------------------------------------------------------------------------------------------
# Distinct Numbers in Window
# A=[1, 2, 1, 3, 4, 3] and K = 3
# All windows of size K are
# [1, 2, 1]
# [2, 1, 3]
# [1, 3, 4]
# [3, 4, 3]
# So, we return an array [2, 3, 3, 2].
def dist_windows(arr, k)
   result = []
   (0..arr.size - k).each do |i|
       result << dist_nums_helper(arr[i...i + k], k)
    end
    result
end

def dist_nums_helper(arr, k) 	# Counts distinct elements in window of size k 
   dist_count = 0
   (0...k).each do |i|
  	# Check if element arr[i] exists in arr[0..i-1] 
       j = 0
       while j < i
           break if arr[i] == arr[j]
           j += 1
        end
        dist_count += 1 if i == j
    end
    dist_count
end

p dist_windows([1, 2, 1, 3, 4, 2, 3], 4 )
#--------------------------------------------------------------------------------------------
# Merge k Sorted Lists
# Merge k sorted linked lists and return it as one sorted list. Analyze and describe its complexity.
# Input:[
#   1->4->5,
#   1->3->4,
#   2->6 ] 		Output: 1->1->2->3->4->4->5->6
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end

# @param {ListNode[]} lists
# @return {ListNode}
def merge_k_lists(lists)
    result = ListNode.new(0)
    lists_size = lists.size
    return [] if lists_size == 0
    if lists_size == 1
        return lists[0] 
    else
        result = merge_two_lists(lists[0], lists[1])
    end
    i = 2
    while i < lists_size
        result = merge_two_lists(result, lists[i])
        i += 1
    end
    result
end

def merge_two_lists(one, two)
    if one == nil
        return two
    elsif two == nil
        return one
    end
    merged = ListNode.new(0)
    if one.val > two.val
        merged = ListNode.new(two.val)
        merged.next = merge_two_lists(one, two.next)
    else
        merged = ListNode.new(one.val)
        merged.next = merge_two_lists(one.next, two)
    end
    merged
end
#--------------------------------------------------------------------------------------------
# LRU Cache
# Design and implement a data structure for Least Recently Used (LRU) cache. It should support the following operations: get and put.
# get(key) - Get the value (will always be positive) of the key if the key exists in the cache, otherwise return -1.
# put(key, value) - Set or insert the value if the key is not already present. When the cache reached its capacity, it should invalidate the least recently used item before inserting a new item.
# The cache is initialized with a positive capacity.
# Follow up:
# Could you do both operations in O(1) time complexity?
# LRUCache cache = new LRUCache( 2 /* capacity */ );
# cache.put(1, 1);
# cache.put(2, 2);
# cache.get(1);       // returns 1
# cache.put(3, 3);    // evicts key 2
# cache.get(2);       // returns -1 (not found)
# cache.put(4, 4);    // evicts key 1
# cache.get(1);       // returns -1 (not found)
# cache.get(3);       // returns 3
class LRUCache
  # Initialize your data structure here
  # @param {Integer} capacity
  def initialize(capacity)
    @capacity = capacity
    @elems = {}
  end

  # @param {Integer} key
  # @return {Integer}
  def get(key)
    val = @elems.delete key
    if val
      @elems[key] = val
    else
      -1
    end
  end

  # @param {Integer} key
  # @param {Integer} value
  # @return {Void}
  def put(key, value)
    @elems.delete key
    @elems[key] = value
    @elems.delete @elems.first.first if @elems.size > @capacity 
  end
end
---------------------------


https://gist.github.com/ralbt/1f5e808a32fbe7c3a37b18b99da1982c
 class LRUCache
  attr_reader :dll, :hash, :count, :capacity
  def initialize(capacity)
    @dll = DLL.new
    @hash = Hash.new
    @count = 0
    @capacity = capacity
  end

  def read(key)
    node = hash[key]

    if node.nil?
      nil
    else
      dll.remove(node)
      dll.add(node)
      node.value
    end
  end

  def write(key, value)
    node = hash[key]

    if node.nil?
      node = DLLNode.new(key, value)
      if count >= capacity
        dll.remove(dll.tail)
        dll.add(node)
      else
        node.value = value
        dll.add(node)
      end
      @count += 1
    else
      node.value = value
      dll.remove(node)
      dll.add(node)
    end
    @hash[key] = node
    node
  end

  def print
    @dll.print
  end
end

class DLL
  attr_accessor :head, :tail

  def add(node)
    if @head.nil?
      @head = node
      @tail = node
    else
      temp = @head
      node.nxt = @head
      @head.prev = node
      @head = node
    end
    @head
  end

  def remove(node)
    if node.prev.nil?  #also you can node == head            # Deleting first node
      node.nxt.prev = nil
      @head = node.nxt
    elsif node.nxt.nil? #also you can node == tail          # Deleting last node
      node.prev.nxt = nil
      @tail = node.prev
    else
      node.prev.nxt = node.nxt
      node.nxt.prev = node.prev
    end
    node.prev = nil
    node.nxt = nil
    node.value
  end

  def print
    puts "Cache data:"
    current = @head
    while current != nil do
      puts "|#{current.key} : #{current.value}|"
      current = current.nxt
    end
    puts ""
  end
end

class DLLNode
  attr_reader :key
  attr_accessor :value, :prev, :nxt

  def initialize(key, value)
    @key = key
    @value = value
    @prev, @nxt = nil, nil
  end
end

JAVA
public class LRUCache{
    
    class DLinkedNode {
        int key;
        int value;
        DLinkedNode pre;
        DLinkedNode post;
    }

    private void addNode(DLinkedNode node){
    //   assign pointer for node
        node.pre = head;
        node.post = head.post;
    // 	adding node right after head
        head.post.pre = node;
        head.post = node;
    }

    private void removeNode(DLinkedNode node){
        DLinkedNode pre = node.pre;
        DLinkedNode post = node.post;

        pre.post = post;
        post.pre = pre;
    }

    private void moveToHead(DLinkedNode node){
        this.removeNode(node);
        this.addNode(node);
    }

    private DLinkedNode popTail(){
        DLinkedNode res = tail.pre;
        this.removeNode(res);
        return res;
    }

    Map<Integer, DLinkedNode> map = new HashMap<Integer, DLinkedNode>();
    int count;
    int capacity;
    DLinkedNode head, tail;

    public LRUCache(int capacity) {
        this.count = 0;
        this.capacity = capacity;

        head = new DLinkedNode();
        head.pre = null;

        tail = new DLinkedNode();
        tail.post = null;

        head.post = tail;
        tail.pre = head;
    }

    public int get(int key) {
        DLinkedNode node = map.get(key);
        if(node == null){
            return -1; // should raise exception here.
        }

        // move the accessed node to the head;
        moveToHead(node);

        return node.value;
    }


    public void put(int key, int value) {
        DLinkedNode node = map.get(key);

        if(node == null){

            DLinkedNode newNode = new DLinkedNode();
            newNode.key = key;
            newNode.value = value;

            addNode(newNode);
            map.put(key, newNode);
            ++count;

            if(count > capacity){
                DLinkedNode tail = popTail();
                map.remove(tail.key);
                --count;
            }
        }else{
            // update the value.
            node.value = value;
            moveToHead(node);
        }

    }
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * LRUCache obj = new LRUCache(capacity);
 * int param_1 = obj.get(key);
 * obj.put(key,value);
 */
#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------
