require 'byebug'
require_relative "heap"

class Array
  def heap_sort!
    (1).upto(self.length - 1).each do |end_idx|
      self[0..end_idx] = BinaryMinHeap.heapify_up(self[0..end_idx], end_idx)
    end

    (self.length - 2).downto(0).each do |start_idx|
      self[start_idx..-1] = BinaryMinHeap.heapify_down(self[start_idx..-1], 0)
    end
  end
end
