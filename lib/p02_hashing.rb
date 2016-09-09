class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_num = 0
    each_with_index do |el, idx|
      hash_num += ((el.hash + idx.hash) ^ hash_num)
    end
    hash_num
  end
end

class String
  def hash
    split("").map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_num = 0

    self.sort.map(&:to_s).each do |k,v|
      hash_num += (k.hash + v.hash) ^ hash_num
    end
    hash_num
  end
end
