class Array
  def my_inject(accumulator = nil, &block)
    i = 0
    if accumulator.nil?
      accumulator = first
      i += 1
    end

    until i == length
      accumulator = block.call(accumulator, self[i])
      i += 1
    end
    accumulator
  end
end

def is_prime?(num)
  (2...num).each do |factor|
    return false if num % factor == 0
  end
  true
end

def primes(count)
  result = []
  n = 2
  until result.length == count
    result << n if is_prime?(n)
    n += 1
  end
  result
end

# the "calls itself recursively" spec may say that there is no method
# named "and_call_original" if you are using an older version of
# rspec. You may ignore this failure.
# Also, be aware that the first factorial number is 0!, which is defined
# to equal 1. So the 2nd factorial is 1!, the 3rd factorial is 2!, etc.
def factorials_rec(num)
  return [1] if num == 1
  prev = factorials_rec(num - 1)
  prev + [(num - 1) * prev.last]
end

class Array
  def dups
    result = Hash.new {|h, k| h[k]=[]}
    self.each_with_index do |el, ind|
      result[el] << ind
    end
    result.select {|k, v| v.length > 1}
  end
end

class String
  def symmetric_substrings
    result = []
    (0...length).each do |idx1|
      (idx1+1...length).each do |idx2|
        result << self[idx1..idx2] if self[idx1..idx2] == self[idx1..idx2].reverse
      end
    end
    result
  end
end

class Array
  def merge_sort(&prc)
    prc ||= Proc.new {|x,y| x <=>y}
    mid =length/2
    left = self.take(mid)
    right = self.drop(mid)

    return self if length <=1
    Array.merge(left.merge_sort(&prc), right.merge_sort(&prc), &prc)
  end

  private
  def self.merge(left, right, &prc)
    result = []
    until left.empty? || right.empty?
      if prc.call(left, right) == 1
        result << right.shift
      else
        result << left.shift
      end
    end
    result += left + right
  end
end
