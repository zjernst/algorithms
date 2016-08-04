require 'byebug'

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2
    pivot = array[0]
    left = []
    right = []
    array.each do |el|
      next if pivot == el
      if el < pivot
        left << el
      else
        right << el
      end
    end
    QuickSort.sort1(left) + pivot + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2
    prc ||= Proc.new {|x, y| x <=> y}

    pivot_idx = QuickSort.partition(array, start, length, &prc)

    left_length = pivot_idx - start
    right_length = length - (left_length + 1)

    QuickSort.sort2!(array, start, left_length, &prc)
    QuickSort.sort2!(array, pivot_idx + 1, right_length, &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new {|x, y| x <=> y}
    index = start + 1
    pivot = array[start]
    pivot_idx = start
    (length-1).times do
      if prc.call(pivot, array[index]) >= 0
        array[pivot_idx] = array[index]
        array[index] = array[pivot_idx + 1]
        array[pivot_idx + 1] = pivot
        pivot_idx += 1
      end
      index += 1
    end
    pivot_idx
  end
end
