#BUBBLE SORT ALGORITHM

def bubble_sort(ary)
  n = ary.length - 1
  while n > 0 do
    index = 0

    n.times do
      first = ary[index]
      second = ary[index+1]

      if first > second
        ary[index+1] = first
        ary[index] = second
      end

      index += 1
    end
    n -= 1
  end
  print ary.to_s + "\n" # .to_s + "\n" IS OPTIONAL
end

bubble_sort([4,3,78,2,0,2])

#DONE


#BUBBLE SORT BY ALGORITHM

def bubble_sort_by(ary)
  #copied from upstairs at bubble_sort
  n = ary.length - 1
  while n > 0 do
    index = 0

    n.times do
      first = ary[index] #first = left
      second = ary[index+1] # second = right practically

       if yield(first, second) > 0 #ONLY LINE THAT IS CHANGED
         ary[index+1] = first
         ary[index] = second
       end

      index += 1
    end
    n -= 1
  end
  print ary
end

bubble_sort_by(["hi","hello","hey"]) do |left,right|
  left.length - right.length
end
