module Enumerable

  def my_each
    ary = self.to_a
    index = 0
    ary.length.times do
      yield(ary[index])
      index += 1
    end
  end

  def my_each_with_index
    ary = self.to_a
    index = 0
    ary.length.times do
      yield(ary[index], index)
      index +=1
    end
  end

  def my_select
    self.my_each do |item|
      puts item if yield(item) == true
    end
  end


end

array = [1,2,3,4,5, "string"]

array.my_each do |item|
  puts item
end

array.my_each_with_index do |item, index|
  puts item.to_s + " " + index.to_s
end

array.my_select do |item|
  item.is_a? String
end
