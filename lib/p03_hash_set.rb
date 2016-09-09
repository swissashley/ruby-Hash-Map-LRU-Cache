require_relative 'p02_hashing'

class HashSet
  attr_reader :count, :num_buckets

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(num)
    resize! if count >= @num_buckets
    return false if include?(num.hash)
    self[num.hash] << num.hash
    @count += 1
  end

  def remove(num)
    del = self[num.hash].delete(num.hash)
    @count -= 1 unless del.nil?
  end

  def include?(num)
    self[num.hash].include?(num.hash)
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @num_buckets]
  end

  def resize!
    # we want to expend our size
    new_store = HashSet.new(@num_buckets * 2)
    @num_buckets *= 2
    @store.each do |bucket|
      bucket.each do |num|
        new_store.insert(num)
      end
    end

    @store = new_store
  end
end
