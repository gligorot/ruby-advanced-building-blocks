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

  def my_all?
    ary_check = Array.new
    ary_org = self.to_a
    self.my_each do |item|
      ary_check.push(item) if yield(item) == true
    end
    puts ary_org.length == ary_check.length ? "true" : "false"
    #STRINGS JUST TO CONFIRM, WILL NEED TO CHANGE SHIT LATER ANYWAY
    return ary_org.length == ary_check.length ? true : false
    #THIS IS THE REAL THING

    #CHANGE ON ANY/NONE TOO

  end

  def my_any?
    #COPIED
    ary_check = Array.new
    self.my_each do |item|
      ary_check.push(item) if yield(item) == true
    end
    puts ary_check.length > 0 ? "true" : "false"
    #STRINGS JUST TO CONFIRM, WILL NEED TO CHANGE SHIT LATER ANYWAY
    return ary_check.length > 0 ? true : false

    #CHANGE ON ALL/NONE TOO
  end

  def my_none?
    #COPIED
    ary_check = Array.new
    ary_org = self.to_a
    self.my_each do |item|
      ary_check.push(item) if yield(item) == true
    end
    puts ary_check.length == 0 ? "true" : "false"
    #STRINGS JUST TO CONFIRM, WILL NEED TO CHANGE SHIT LATER ANYWAY
    return ary_check.length == 0 ? true : false

    #CHANGE ON ALL/ANY TOO
  end


end

#==============TESTS BELOW THIS LINE =============

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

test_array = [1,2,3,4,5]
test_array2 = [1,2,3,4,"string"]

test_array.my_all? do |item|
  item.is_a? Integer
end

test_array2.my_all? do |item|
  item.is_a? Integer
end

test_array.my_any? do |item|
  item.is_a? String
end

test_array2.my_any? do |item|
  item.is_a? String
end

test_array.my_none? do |item|
  item.is_a? String
end

test_array2.my_none? do |item|
  item.is_a? String
end
