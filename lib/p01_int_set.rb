class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num < @store.length && num > 0
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    return false if include?(num)
    self[num] << num
    return true
  end

  def remove(num)
    p "current bucket:#{self[num]}, removing #{num}"
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :num_buckets

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(num)
    resize! if count >= num_buckets
    return false if include?(num)
    self[num] << num
    @count += 1
  end

  def remove(num)
    del = self[num].delete(num)
    @count -= 1 unless del.nil?
  end

  def include?(num)
    self[num].include?(num)
  end

  # private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def resize!
    # we want to expend our size
    new_store = ResizingIntSet.new(@num_buckets * 2)
    @num_buckets *= 2
    @store.each do |bucket|
      bucket.each do |num|
        new_store.insert(num)
      end
    end

    @store = new_store
  end
end
