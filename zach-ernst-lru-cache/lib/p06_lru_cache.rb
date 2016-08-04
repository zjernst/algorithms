require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key]
      link = @map[key]
      update_link!(link)
      link.val
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    new_link = @store.insert(key, val)
    @map[key] = new_link

    eject! if count > @max
    val
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    link.prev.next = link.next
    link.next.prev = link.prev

    link.next = @store.last
    link.prev = @store.last.prev
    @store.last.prev = link
  end

  def eject!
    link = @store.first
    link.next.prev = link.prev
    link.prev.next = link.next

    @map.delete(link.key)
    nil
  end
end
