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
  print ary
end

bubble_sort([4,3,78,2,0,2])

#DONE
