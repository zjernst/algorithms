require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](index)
    if index > @length - 1
      raise "index out of bounds"
    end
    @store[index]
  end

  # O(1)
  def []=(index, value)
    if index > @length - 1
      raise "index out of bounds"
    end
    @store[index] = value
  end

  # O(1)
  def pop
    if @length == 0
      raise "index out of bounds"
    end
    @length -= 1
    el = @store[@length]
    @store[@length] = nil
    el
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @length == @capacity
      resize!
    end
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    if @length == 0
      raise "index out of bounds"
    end
    el = self[0]
    (1...length).each { |i| self[i-1] = self[i]}
    @length -= 1
    el
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if @length == @capacity
      resize!
    end
    @length += 1
    index = @length - 1
    while index > 0
      @store[index] = @store[index - 1]
      index -= 1
    end
    @store[0] = val
    nil
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    oldArray = @store

    @capacity *= 2
    @store = StaticArray.new(@capacity)
    @length.times {|i| @store[i] = oldArray[i]}
  end
end
