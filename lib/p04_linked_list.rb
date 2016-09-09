
class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.prev = nil
    @head.next = @tail
    @tail.prev = @head
    @tail.next = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    curr_link = @head
    until curr_link.next == @tail
      curr_link = curr_link.next
      return curr_link.val if curr_link.key == key
    end
    nil
  end

  def include?(key)
    return true unless get(key).nil?
    false
  end

  def insert(key, val)
    if include?(key)
      curr_link = @head
      until curr_link == @tail
        if curr_link.key == key
          curr_link.val = val
          break
        end
        curr_link = curr_link.next
      end
    else
      curr_link = Link.new(key,val)
      curr_link.prev = @tail.prev
      curr_link.next = @tail
      @tail.prev.next = curr_link
      @tail.prev = curr_link
    end
  end

  def remove(key)
    curr_link = @head.next
    until curr_link == @tail
      p "Curr key:  #{curr_link.key}"
      if curr_link.key == key
        curr_link.prev.next = curr_link.next
        curr_link.next.prev = curr_link.prev
        break
      end
      curr_link = curr_link.next
    end

  end

  def each(&prc)
    curr_link = @head
    until curr_link.next == @tail
      curr_link = curr_link.next
      prc.call(curr_link)
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
