https://github.com/kanai0618/Competitive-Programming/tree/master/src   Solutions
https://github.com/architsingla13/InterviewBit-Solutions/tree/master/Programming
https://github.com/royalpranjal/Interview-Bit
https://github.com/SrGrace/InterviewBit
https://github.com/SKantar/InterviewBit in python
https://github.com/lanhhoang/interviewbit-challenges in Ruby
https://www.sitepoint.com/ruby-interview-questions-lru-cache-and-binary-trees/
#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------
https://ginxh.io/2018-04-18/high-performance-priority-queues-and-ruby/
https://www.brianstorti.com/implementing-a-priority-queue-in-ruby/
class PriorityQueue
  def initialize
    @heap = []
  end

  def add!(x)
    @heap << x
    sift_up(@heap.length - 1)
    self
  end

  def peek
    @heap[0]
  end

  def remove!()
    raise RuntimeError, "Empty Queue" if @heap.length == 0
    if @heap.length == 1
      @heap = []
    else
      @heap[0] = @heap.pop
      sift_down(0)
    end
    self
  end

  def to_s
    @heap.to_s
  end

  private

  # Sift up the element at index i
  def sift_up(i)
    parent = (i - 1) / 2
    if parent >= 0 and @heap[parent] > @heap[i]
      @heap[parent], @heap[i] = @heap[i], @heap[parent]
      sift_up(parent)
    end
  end

  # Sift down the element at index i
  def sift_down(i)
    child = (i * 2) + 1
    return if child >= @heap.length
    child += 1 if child + 1 < @heap.length and @heap[child] > @heap[child+1]
    if @heap[i] > @heap[child]
      @heap[child], @heap[i] = @heap[i], @heap[child]
      sift_down(child)
    end
  end
end
Exercise: Add methods heapify, empty?, and size.
And here’s a starter unit test (it only tests that add and remove work; it does not test any low-level details of sifting.

priorityqueuetest.rb
require 'minitest/autorun'
require './priorityqueue.rb'

class PriorityQueueTest < MiniTest::Test

  def test_new
    q = PriorityQueue.new
    assert_equal(q.peek, nil)
    assert_raises(RuntimeError) {q.remove!}
  end

  # Add 1..100 in at random, they should come out in order
  def test_adds_and_removes
    q = PriorityQueue.new
    (1..100).to_a.sort_by {rand}.each {|x| q.add!(x)}
    1.upto(100) do |i|
      assert_equal(q.peek, i)
      q.remove!
    end
  end
end
#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------