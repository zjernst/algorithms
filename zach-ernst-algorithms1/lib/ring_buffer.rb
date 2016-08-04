require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(@start_idx + index) % capacity]
  end

  # O(1)
  def []=(index, val)
    unless index >= 0 && index <= @length
      raise "index out of bounds"
    end
    @store[(@start_idx + index) % capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    el = self[@length - 1]
    self[@length - 1] = nil
    @length -= 1
    el
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    self[@length] = val
    @length += 1
    nil
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    el = self[0]
    self[0] = nil
    @start_idx = (@start_idx + 1) % @capacity
    @length -= 1
    el
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @capacity == @length
    @start_idx = (@start_idx - 1) % @capacity
    @length += 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    unless (index >= 0) && (index < @length)
      raise "index out of bounds"
    end
  end

  def resize!
    new_capacity = @capacity * 2
    new_store = StaticArray.new(new_capacity)
    index = 0
    while index < @length
      new_store[index] = self[index]
      index += 1
    end
    @capacity = new_capacity
    @store = new_store
    @start_idx = 0
  end
end
