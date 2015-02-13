# p 5
# p "5" # note the difference
# puts "5"


# array = [41, 19, 39, 49]
# p "the first item in the array is #{array[0]}"

# # practice loops
# puts ""
# array.each do |item|
#   double = item * 2
#   puts "item is #{item}"
#   puts "now double: #{double}"
# end


# # practice input and conditionals
# print "enter your age: "
# input = Integer(gets().chomp())

# if input >= 30
#   puts "Welcome to the Club!"
# elsif input >= 20
#   puts "So close"
# # else 
# # puts "In due time..."  # still works!
# end


# practice functions/methods
def letter_grade (pct_grade)
  if pct_grade >= 90
    return "A"
  elsif pct_grade >= 80
    return "B"
  elsif pct_grade >= 70
    return "C"
  elsif pct_grade >= 60
    return "D"
  else
    return "F"
end

print "enter your grade percentage: "
input2 = Integer(gets().chomp())
puts letter_grade(input2)