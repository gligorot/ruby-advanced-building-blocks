module Enumerable

  def my_each
    return self unless block_given?
    ary = self.to_a
    index = 0
    ary.length.times do
      yield(ary[index])
      index += 1
    end
  end

  def my_each_with_index
    return self unless block_given?
    ary = self.to_a
    index = 0
    ary.length.times do
      yield(ary[index], index)
      index +=1
    end
  end

  def my_select
    result = Array.new
    self.my_each do |item|
      result << item if yield(item)
    end
    result
  end

  def my_all?
    if block_given? #like...whatever?
      ary_check = Array.new
      ary_org = self.to_a
      self.my_each do |item|
        ary_check.push(item) if yield(item)
      end
      puts ary_org.length == ary_check.length ? "true" : "false"
      #STRINGS JUST TO CONFIRM, WILL NEED TO CHANGE SHIT LATER ANYWAY
      return ary_org.length == ary_check.length ? true : false
      #THIS IS THE REAL THING

      #CHANGE ON ANY/NONE TOO
    end
  end

  def my_any?
    #COPIED
    if block_given? #like...whatever?
      ary_check = Array.new
      self.my_each do |item|
        ary_check.push(item) if yield(item)
      end
      puts ary_check.length > 0 ? "true" : "false"
      #STRINGS JUST TO CONFIRM, WILL NEED TO CHANGE SHIT LATER ANYWAY
      return ary_check.length > 0 ? true : false

      #CHANGE ON ALL/NONE TOO
    end
  end

  def my_none?
    #COPIED
    if block_given? #like...whatever?
      ary_check = Array.new
      ary_org = self.to_a
      self.my_each do |item|
        ary_check.push(item) if yield(item)
      end
      puts ary_check.length == 0 ? "true" : "false"
      #STRINGS JUST TO CONFIRM, WILL NEED TO CHANGE SHIT LATER ANYWAY
      return ary_check.length == 0 ? true : false

      #CHANGE ON ALL/ANY TOO
    end
  end

  def my_count(obj=nil) #ona koga go cekas rezultatot dole a go dava gore...
    if block_given?
      counter = 0
      self.my_each { |item| counter += 1 if yield(item) }
       #TRY TO INTEGRATE DIRECTLY THROUGH SELECT LATER
    elsif obj != nil
      counter = 0
      self.my_each { |item| counter += 1 if item == obj }
    else
      counter = self.length
    end
    counter
  end

  def my_map
    return self unless block_given?
    result = Array.new
    self.my_each { |item| result << yield(item) }
    result.pop(1)
    print result
  end


  def my_map_proc(&p)
    return self unless block_given?
    result = Array.new
    self.my_each { |item| result << yield(item) }
    result.pop(1)
    print result
  end

  def my_map_proc_block(prok=nil)
    result = Array.new
    if prok.class == Proc
      self.my_each { |item| result << prok.call(item)}
    elsif block_given?
      self.my_each { |item| result << yield(item)} #PROBLEM lies here, ruyb detects both proc and block as given (2 blocks) and thus returns an error....cant figure it out, fuck this
    else
      self
    end
    result
    print result
  end


  def my_inject(*arg)
    ary = self.to_a
    if block_given?
      if arg.size == 0 #no initial given
        result = 0 #need to make a * or / checker ...i really dont want to spend any more time on this
        ary.my_each do |item|
          result = yield(result, item)
        end
        result
      elsif arg.size == 1 #initial given
        result = arg[0]
        ary.my_each do |item|
          result = yield(result, item)
        end
        result
      end
    else
      if arg.size == 1 #only sym given
        arg[0].to_s == "+" || arg[0].to_s == "-" ? result = 0 : result = 1
        ary.my_each { |item| result = result.send(arg[0], item) }

      elsif arg.size == 2 #initial, sym given
        result = arg[0]
        ary.my_each { |item| result = result.send(arg[1], item) }
      end
      result
    end
  end



end

def multiply_els(ary)
  return ary.my_inject(1) { |product, n| product * n }
end

#2.send(:+.to_s,3)

#==============TESTS BELOW THIS LINE =============

array = [1,2,3,4,5, "string"]

hash = {
  "key1" => "val1",
  "key2" => "val2"
}

puts "---my each---"

puts "--ary--"
array.my_each { |item| puts item }

puts "--hash--"
hash.each { |k,v| puts k.to_s + ".." + v.to_s }

puts "---my each with index---"
array.my_each_with_index { |item, index| puts item.to_s + " " + index.to_s }

puts "---my select---(forced puts for clarity)"
array.my_select { |item| puts item if item.is_a? String }

puts "---my all, any, none---(forced puts for clarity again)"
test_array = [1,2,3,4,5]
test_array2 = [1,2,3,4,"string"]

test_array.my_all? { |item| item.is_a? Integer }

test_array2.my_all? { |item| item.is_a? Integer }

test_array.my_any? { |item| item.is_a? String }

test_array2.my_any? { |item| item.is_a? String }

test_array.my_none? { |item| item.is_a? String }

test_array2.my_none? { |item| item.is_a? String }

puts "---my count---"
puts "--obj=nil--"
puts array.my_count
puts "--obj!=nil--"
puts array.my_count(2)
puts "--block_given? == true--"
puts array.my_count {|item| item%2 == 0}

p = Proc.new {|item| item += 1 if item.is_a? Integer}

puts "---my map---"
puts "--normal--"
puts array.my_map {|item| item += 1 if item.is_a? Integer}
puts "--proc mod--"
puts array.my_map_proc(&p) # p is defined ABOVE MY MAP
puts "--block-proc--"
puts array.my_map_proc_block(&p) {|item| item += 2 if item.is_a? Integer}


puts "---my inject---"

puts "--block given--"
puts "-init given-"
puts (5..10).my_inject(1) { |product, n| product * n }
puts "-init not given-"
puts (5..10).my_inject {|sum, n| sum + n }
puts (5..10).my_inject { |product, n| product * n }
puts "^error"

puts "--block not given--"
puts "-init not given-"
puts (5..10).my_inject(:+)
puts (5..10).my_inject(:*)
puts "-init given-"
puts (5..10).my_inject(10, :+)
puts (5..10).my_inject(10, :*)

puts "---multiply_els---"
puts multiply_els([2,4,5])
