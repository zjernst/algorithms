require 'byebug'

class BinaryMinHeap
  def initialize(&prc)
    @store = []
    @prc ||= Proc.new {|el1, el2| el1 <=> el2}
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    item = @store.pop()
    BinaryMinHeap.heapify_down(@store, 0)
    item
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, @store.length - 1)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    child1 = parent_index * 2 + 1
    child2 = parent_index * 2 + 2
    [child1, child2].select{|el| el < len}
  end

  def self.parent_index(child_index)
    parent = (child_index-1) / 2
    raise "root has no parent" if parent < 0
    parent
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new {|el1, el2| el1 <=> el2}
    children = child_indices(len, parent_idx)
    return array if children.nil?
    return array if children.all?{|i| prc.call(array[parent_idx], array[i]) <= 0}
    if children.length > 1
      if prc.call(array[children[0]], array[children[1]]) <= 0
        child = children[0]
      else
        child = children[1]
      end
    else
      child = children[0]
    end
    array[parent_idx], array[child] = array[child], array[parent_idx]
    heapify_down(array, child, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new {|el1, el2| el1 <=> el2}
    return array if child_idx == 0
    parent = parent_index(child_idx)
    return array if prc.call(array[parent], array[child_idx]) <= 0

    array[parent], array[child_idx] = array[child_idx], array[parent]
    heapify_up(array, parent, len, &prc)
  end
end
