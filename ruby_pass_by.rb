def foo(bar)
  # changes the local reference to 
  # point to a new object 
  # while it is in the method
  # but that change is 
  # not reflected outside the method
  bar = 'reference'
end

def foo2(bar)
  # changes the value that the 
  # local reference points to
  # and is reflected outside the method
  bar.replace 'reference'
end

# Ruby is pass by value as traditionally understood
# because it passages a copy of the object reference for a variable
# to the method
# but the method can use that reference to change the 
# object it points to
x = 'value'
foo(x)
puts "I have the same value I sent in therefore ruby must be pass-by-#{x}"

foo2(x)
puts "but I'm not a fool so clearly ruby is pass-by-#{x}"
